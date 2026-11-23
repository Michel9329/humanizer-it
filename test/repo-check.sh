#!/usr/bin/env bash
# Structural checks for the repository:
#   - the front matter of SKILL.md is valid for a Claude Code skill;
#   - the counts that README.md and SKILL.md state match the sections;
#   - every file and relative link named in the Markdown files exists;
#   - no path or file name from a private workspace is left in the text
#     (this skill was extracted from one), plus an optional list of private
#     names kept outside the repository: HUMANIZER_IT_PRIVATE_TERMS=<file>;
#   - the install path: the repository is cloned (or, with uncommitted changes,
#     copied) into a temporary ~/.claude/skills/<name> and checked there.
#
# Needs bash 4+, grep, sed, awk, find, and git for the install check.
# Writes only to a temporary directory, makes no network calls.
set -euo pipefail
export LC_ALL=C

here=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
root=$(cd -- "$here/.." && pwd)

tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT

failures=0
ok() { printf 'ok    %s\n' "$*"; }
fail() { printf 'FAIL  %s\n' "$*"; failures=$((failures + 1)); }
skip() { printf 'skip  %s\n' "$*"; }

# --- front matter --------------------------------------------------------------

# fm_value FILE KEY: the value of a one-line KEY in the front matter of FILE.
fm_value() {
  tr -d '\r' < "$1" | awk -v key="$2" '
    NR == 1 { next }
    /^---$/ { exit }
    index($0, key ": ") == 1 { print substr($0, length(key) + 3) }'
}

# check_front_matter FILE LABEL
check_front_matter() {
  local file=$1 label=$2 first close name desc chars keys k
  first=$(head -n 1 "$file" | tr -d '\r')
  close=$(tr -d '\r' < "$file" | awk 'NR > 1 && /^---$/ { print NR; exit }')
  if [[ $first != '---' || -z $close ]]; then
    fail "$label: no front matter between two '---' lines at the top"
    return
  fi
  keys=$(tr -d '\r' < "$file" | awk -v end="$close" 'NR > 1 && NR < end')
  if grep -q '^[[:space:]]' <<< "$keys"; then
    fail "$label: front matter values must stay on one line"
  fi
  for k in name description; do
    if [[ $(grep -c "^$k:" <<< "$keys" || true) != 1 ]]; then
      fail "$label: front matter must have exactly one '$k:' line"
      return
    fi
  done

  name=$(fm_value "$file" name)
  if [[ $name =~ ^[a-z0-9]+(-[a-z0-9]+)*$ && ${#name} -le 64 ]]; then
    ok "$label: name '$name' (lowercase, digits and hyphens, at most 64 characters)"
  else
    fail "$label: name '$name' must be lowercase letters, digits and hyphens, at most 64 characters"
  fi

  desc=$(fm_value "$file" description)
  chars=$(printf '%s' "$desc" | LC_ALL=C.UTF-8 wc -m)
  if [[ -z $desc ]]; then
    fail "$label: description is empty"
  elif (( chars > 1024 )); then
    fail "$label: description has $chars characters, the limit is 1024"
  else
    ok "$label: description of $chars characters (limit 1024)"
  fi

  # The value is an unquoted YAML scalar. ": " or " #" inside it, or certain
  # first characters, make the YAML invalid or change its meaning. Claude Code
  # still loads a skill whose front matter does not parse, but with no fields.
  local bad='' indicators='-?:,[]{}#&*!|>%@`'\''"'
  if [[ $desc == *': '* || $desc == *' #'* || $desc == *':' ]]; then
    bad='contains ": " or " #", or ends with ":"'
  elif [[ $indicators == *"${desc:0:1}"* ]]; then
    bad="starts with the YAML indicator '${desc:0:1}'"
  elif [[ $desc == ' '* || $desc == *' ' ]]; then
    bad='starts or ends with a space'
  fi
  if [[ -n $bad ]]; then
    fail "$label: description is not a valid unquoted YAML value: $bad"
  else
    ok "$label: description is a valid unquoted YAML value"
  fi

  # A second opinion from a real YAML parser, when one is installed.
  if command -v python3 > /dev/null 2>&1 && python3 -c 'import yaml' > /dev/null 2>&1; then
    if python3 -I - "$file" << 'PY'
import sys
import yaml
text = open(sys.argv[1], encoding="utf-8").read().replace("\r\n", "\n")
block = text.split("\n---\n", 1)[0].split("---\n", 1)[1]
data = yaml.safe_load(block)
ok = isinstance(data, dict) and all(isinstance(data.get(k), str) for k in ("name", "description"))
sys.exit(0 if ok else 1)
PY
    then
      ok "$label: front matter parses with PyYAML"
    else
      fail "$label: front matter does not parse with PyYAML"
    fi
  else
    skip "$label: PyYAML not installed, strict YAML parse skipped"
  fi
}

check_front_matter "$root/SKILL.md" "SKILL.md"
name=$(fm_value "$root/SKILL.md" name)
if [[ -z $name ]]; then
  fail "cannot read the skill name from SKILL.md; stopping"
  exit 1
fi

# --- counts stated in the text -----------------------------------------------------

# section_body FILE HEADING_REGEX: the lines after a '## ' heading, up to the next one.
section_body() {
  tr -d '\r' < "$1" | awk -v re="$2" '
    /^## / { inside = ($0 ~ re); next }
    inside'
}

families=$(section_body "$root/SKILL.md" '^## Le [0-9]+ famiglie' | grep -c '^### [0-9]*\. ' || true)
stated=$(tr -d '\r' < "$root/SKILL.md" | sed -n 's/^## Le \([0-9]*\) famiglie.*/\1/p')
if [[ -n $stated && $families == "$stated" ]] && grep -q "^- $families families of tells" "$root/README.md"; then
  ok "SKILL.md has $families families of tells, as its heading and README.md say"
else
  fail "family count: heading says '${stated:-?}', SKILL.md has $families, README.md must say '- $families families of tells'"
fi

signals=$(section_body "$root/SKILL.md" '^## Sei segnali' | grep -c '^- \*\*' || true)
if [[ $signals == 6 ]] && grep -q '^- Six more signals' "$root/README.md"; then
  ok "SKILL.md has 6 signals from blader/humanizer, as its heading and README.md say"
else
  fail "the six-signals section of SKILL.md has $signals items; its heading and README.md say six"
fi

# --- files and links named in the Markdown files ---------------------------------

# refs FILE: relative link targets and backticked repository paths in FILE.
refs() {
  { grep -oE ']\([^)[:space:]]+\)' "$1" || true; } | sed -E 's/^]\(//; s/\)$//; s/#.*$//' \
    | { grep -vE '^(https?:|mailto:|$)' || true; }
  { grep -oE '`[A-Za-z0-9_.-]+(/[A-Za-z0-9_.-]+)*`' "$1" || true; } | tr -d '`' \
    | { grep -E '(\.(md|sh|txt|yml)|^LICENSE|^NOTICE)$' || true; }
}

# check_refs BASE LABEL: every reference in every Markdown file under BASE
# resolves against the file's own folder or against BASE.
check_refs() {
  local base=$1 label=$2 md dir ref count=0 broken=0
  while IFS= read -r -d '' md; do
    dir=$(dirname -- "$md")
    while IFS= read -r ref; do
      count=$((count + 1))
      if [[ ! -e $dir/$ref && ! -e $base/$ref ]]; then
        fail "$label: ${md#"$base"/} names '$ref', which does not exist"
        broken=$((broken + 1))
      fi
    done < <(refs "$md")
  done < <(find "$base" -name '*.md' -not -path '*/.git/*' -print0)
  if (( broken == 0 )); then ok "$label: all $count file references and relative links in the Markdown files resolve"; fi
}

check_refs "$root" "repository"

# --- leftovers from the private workspace -------------------------------------------

# Shapes of paths and file names from a private working folder: planning notes,
# memory files, internal research and tool scripts, client folders, home
# directories, commit hashes. The test scripts themselves are not scanned.
leak_patterns=(
  '\.planning/'
  'memory/[A-Za-z0-9_-]+\.md'
  '(feedback|project|reference|user)_[a-z0-9]+_[a-z0-9_]+'
  'research/[A-Za-z0-9_-]+\.md'
  'tools/[A-Za-z0-9_-]+/[A-Za-z0-9_.-]+\.(mjs|js|ts|py)'
  'clients/[A-Za-z0-9_-]+/'
  '\.claude/(hooks|agents|commands)/'
  'skills/humanizer/'
  'registro-incidenti'
  '[A-Za-z]:(/|\\)Users(/|\\)'
  '/(home|Users)/[a-z][a-z0-9_-]*/'
  '[Cc]ommit [0-9a-f]{7,40}'
)
mapfile -d '' scanned < <(cd "$root" && find . -type f -not -path './.git/*' -not -path './test/*.sh' -print0)
leaks=0
for p in "${leak_patterns[@]}"; do
  hits=$(cd "$root" && grep -nE -e "$p" -- "${scanned[@]}" | cut -d: -f1,2 || true)
  if [[ -n $hits ]]; then
    while IFS= read -r h; do fail "private-workspace path shape /$p/ at ${h#./}"; done <<< "$hits"
    leaks=$((leaks + 1))
  fi
done
if (( leaks == 0 )); then ok "no private-workspace paths or file names in ${#scanned[@]} files"; fi

if [[ -n ${HUMANIZER_IT_PRIVATE_TERMS:-} ]]; then
  if [[ ! -r $HUMANIZER_IT_PRIVATE_TERMS ]]; then
    fail "HUMANIZER_IT_PRIVATE_TERMS is set but not readable: $HUMANIZER_IT_PRIVATE_TERMS"
  else
    { grep -v -e '^#' -e '^[[:space:]]*$' "$HUMANIZER_IT_PRIVATE_TERMS" || true; } | tr -d '\r' > "$tmp/terms"
    # Whole words, case-sensitive. Only file:line is printed, never the term.
    hits=$(cd "$root" && grep -rnwF --exclude-dir=.git -f "$tmp/terms" . | cut -d: -f1,2 || true)
    if [[ -z $hits ]]; then
      ok "none of the $(wc -l < "$tmp/terms") private terms appears in the repository"
    else
      while IFS= read -r h; do fail "private term at ${h#./}"; done <<< "$hits"
    fi
  fi
else
  skip "private-term guard: set HUMANIZER_IT_PRIVATE_TERMS to a file with one term per line"
fi

# --- install path -------------------------------------------------------------------

clone_line=$(tr -d '\r' < "$root/README.md" | grep -E '^git clone https://[^ ]+ ~/\.claude/skills/[A-Za-z0-9_-]+$' | head -n 1 || true)
target=${clone_line##* }
if [[ -z $clone_line ]]; then
  fail "README.md has no 'git clone <url> ~/.claude/skills/<folder>' line"
elif [[ ${target##*/} != "$name" ]]; then
  fail "README.md installs into '${target##*/}', but the skill name is '$name'"
else
  ok "README.md installs into ~/.claude/skills/$name, the folder name matches the skill name"
fi

home=$tmp/home
dest=$home/.claude/skills/$name
mkdir -p "$home/.claude/skills"
how=''
if command -v git > /dev/null 2>&1 && git -C "$root" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  if [[ -z $(git -C "$root" status --porcelain) ]]; then
    git clone --quiet --no-local -- "$root" "$dest"
    how='git clone of HEAD'
  else
    # Uncommitted changes: copy what a commit of the working tree would hold.
    while IFS= read -r -d '' f; do
      [[ -f $root/$f ]] || continue
      mkdir -p -- "$dest/$(dirname -- "$f")"
      cp -p -- "$root/$f" "$dest/$f"
    done < <(git -C "$root" ls-files -z --cached --others --exclude-standard)
    how='copy of the working tree (there are uncommitted changes)'
  fi
else
  mkdir -p -- "$dest"
  (cd "$root" && find . -type f -not -path './.git/*' -print0) | while IFS= read -r -d '' f; do
    mkdir -p -- "$dest/$(dirname -- "$f")"
    cp -p -- "$root/$f" "$dest/$f"
  done
  how='copy (not a git checkout)'
fi
ok "install: $how into a temporary ~/.claude/skills/$name"

if [[ -f $dest/SKILL.md ]]; then
  ok "install: SKILL.md is at the root of the skill folder"
  check_front_matter "$dest/SKILL.md" "installed SKILL.md"
  check_refs "$dest" "installed copy"

  # Counted with tr: grep under Git Bash hides CRs at the end of lines.
  crlf=0
  while IFS= read -r -d '' f; do
    if [[ $(tr -cd '\r' < "$dest/$f" | wc -c) -gt 0 ]]; then
      fail "install: CR characters (CRLF line endings) in ${f#./}"
      crlf=$((crlf + 1))
    fi
  done < <(cd "$dest" && find . -type f \( -name '*.md' -o -name '*.sh' -o -name '*.txt' -o -name '*.yml' \) -not -path './.git/*' -print0)
  if (( crlf == 0 )); then ok "install: no CRLF line endings in text files"; fi

  links=$(cd "$dest" && find . -type l -not -path './.git/*')
  if [[ -z $links ]]; then ok "install: no symbolic links"
  else fail "install: symbolic links in the skill folder: $links"; fi

  # The pattern suite must also pass from the installed copy, run from another
  # directory: this checks that it does not depend on the working directory.
  if [[ -f $dest/test/done-check.sh ]] && (cd "$home" && bash "$dest/test/done-check.sh" > "$tmp/installed-done-check.log" 2>&1); then
    ok "install: test/done-check.sh passes in the installed copy, run from another directory"
  else
    fail "install: test/done-check.sh fails in the installed copy (last line: $(tail -n 1 "$tmp/installed-done-check.log" 2>/dev/null))"
  fi
else
  fail "install: SKILL.md is missing from the root of the skill folder"
fi

if (( failures > 0 )); then
  printf 'repo-check: %d failure(s)\n' "$failures"
  exit 1
fi
printf 'repo-check: all checks passed\n'
