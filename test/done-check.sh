#!/usr/bin/env bash
# Tests the Done check grep pattern printed in SKILL.md.
#
# The pattern is read from SKILL.md, so the documentation and the test cannot
# drift. It is split into its top-level alternatives, and every group is
# expanded, so that each branch is tested on its own:
#   - every branch must flag at least one line of fixtures/must-flag.txt;
#   - every line of must-flag.txt must be flagged;
#   - no line of must-pass.txt may be flagged;
#   - every line of known-false-positives.txt must be quoted in SKILL.md and
#     still be flagged, so the note there stays true.
# The checks run under LC_ALL=C and LC_ALL=C.UTF-8, on LF and CRLF copies of
# the fixtures, and both locales must flag exactly the same lines.
#
# Needs bash 4+, grep, sed, tr. Writes only to a temporary directory.
set -euo pipefail

# Byte semantics for sed, tr and the parser below. Every grep run sets its own
# locale explicitly.
export LC_ALL=C

here=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
root=$(cd -- "$here/.." && pwd)
fixtures=$here/fixtures

tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT

failures=0
ok() { printf 'ok    %s\n' "$*"; }
fail() { printf 'FAIL  %s\n' "$*"; failures=$((failures + 1)); }
skip() { printf 'skip  %s\n' "$*"; }

# --- read the pattern --------------------------------------------------------

# The Done check prints the one-liner as:  grep -nE "<pattern>" <file>
mapfile -t found < <(tr -d '\r' < "$root/SKILL.md" | grep -E '^grep -nE ".*" <file>$' || true)
if (( ${#found[@]} != 1 )); then
  fail "SKILL.md must print exactly one Done check one-liner, found ${#found[@]}"
  exit 1
fi
pattern=${found[0]#grep -nE \"}
pattern=${pattern%\" <file>}
if [[ $pattern == *\"* ]]; then
  fail "the pattern contains a double quote, which breaks the one-liner"
  exit 1
fi
ok "pattern read from SKILL.md (${#pattern} bytes)"

# --- a small ERE parser (bytes, C locale) --------------------------------------

# bracket_end STRING INDEX: print the index of the ']' that closes the bracket
# expression opening at INDEX.
bracket_end() {
  local s=$1 n=${#1} i=$(($2 + 1)) rest
  if [[ ${s:i:1} == '^' ]]; then i=$((i + 1)); fi
  if [[ ${s:i:1} == ']' ]]; then i=$((i + 1)); fi
  while (( i < n )); do
    case ${s:i:2} in
      '[:' | '[=' | '[.')
        # a class such as [:alpha:]; skip to its closing ':]', '=]' or '.]'
        rest=${s:i+2}
        rest=${rest%%"${s:i+1:1}]"*}
        i=$((i + 2 + ${#rest} + 2))
        continue ;;
    esac
    if [[ ${s:i:1} == ']' ]]; then printf '%s\n' "$i"; return 0; fi
    i=$((i + 1))
  done
  return 1
}

# group_end STRING INDEX: print the index of the ')' matching the '(' at INDEX.
group_end() {
  local s=$1 n=${#1} i=$(($2 + 1)) depth=1
  while (( i < n )); do
    case ${s:i:1} in
      '\') i=$((i + 1)) ;;
      '[') i=$(bracket_end "$s" "$i") || return 1 ;;
      '(') depth=$((depth + 1)) ;;
      ')')
        depth=$((depth - 1))
        if (( depth == 0 )); then printf '%s\n' "$i"; return 0; fi ;;
    esac
    i=$((i + 1))
  done
  return 1
}

# split_top STRING: print the alternatives separated by a '|' that is outside
# every group and bracket expression, one per line.
split_top() {
  local s=$1 n=${#1} i=0 start=0 depth=0
  while (( i < n )); do
    case ${s:i:1} in
      '\') i=$((i + 1)) ;;
      '[') i=$(bracket_end "$s" "$i") || return 1 ;;
      '(') depth=$((depth + 1)) ;;
      ')') depth=$((depth - 1)) ;;
      '|')
        if (( depth == 0 )); then
          printf '%s\n' "${s:start:i-start}"
          start=$((i + 1))
        fi ;;
    esac
    i=$((i + 1))
  done
  printf '%s\n' "${s:start}"
}

# expand ALT: print every branch of ALT, one per line, replacing its first group
# with each of the group's alternatives and recursing on the result.
expand() {
  local s=$1 n=${#1} i=0 j alt
  while (( i < n )); do
    case ${s:i:1} in
      '\') i=$((i + 1)) ;;
      '[') i=$(bracket_end "$s" "$i") || return 1 ;;
      '(')
        j=$(group_end "$s" "$i") || return 1
        case ${s:j+1:1} in
          '*' | '+' | '?' | '{')
            printf 'cannot expand a quantified group: %s\n' "$s" >&2
            return 1 ;;
        esac
        while IFS= read -r alt; do
          expand "${s:0:i}$alt${s:j+1}" || return 1
        done < <(split_top "${s:i+1:j-i-1}")
        return 0 ;;
    esac
    i=$((i + 1))
  done
  printf '%s\n' "$s"
}

# lint STRING: report constructs whose meaning depends on the locale or on the
# grep version. Prints one problem per line, nothing if the pattern is clean.
lint() {
  local s=$1 n=${#1} i=0 j
  while (( i < n )); do
    case ${s:i:1} in
      '\')
        # POSIX ERE special characters are the only ones worth escaping; GNU
        # grep 3.8 and later warn about other escapes.
        case ${s:i+1:1} in
          '.' | '[' | '\' | '(' | ')' | '*' | '+' | '?' | '{' | '|' | '^' | '$') ;;
          *) printf 'stray backslash before "%s"\n' "${s:i+1:1}" ;;
        esac
        i=$((i + 1)) ;;
      '[')
        if ! j=$(bracket_end "$s" "$i"); then
          printf 'unterminated bracket expression\n'
          return 0
        fi
        if printf '%s' "${s:i:j-i+1}" | grep -q '[^ -~]'; then
          printf 'non-ASCII character inside %s (one byte under C, one character under UTF-8)\n' "${s:i:j-i+1}"
        fi
        i=$j ;;
      '.') printf 'unescaped "." wildcard (one byte under C, one character under UTF-8)\n' ;;
    esac
    i=$((i + 1))
  done
}

# --- split and lint ------------------------------------------------------------

mapfile -t alternatives < <(split_top "$pattern")
branches=()
for alt in "${alternatives[@]}"; do
  if [[ -z $alt ]]; then fail "empty alternative in the pattern (it would match every line)"; continue; fi
  if ! out=$(expand "$alt"); then fail "cannot expand alternative: $alt"; continue; fi
  mapfile -t more <<< "$out"
  branches+=("${more[@]}")
done
ok "${#alternatives[@]} alternatives, ${#branches[@]} branches after expanding groups"

problems=$(lint "$pattern")
if [[ -z $problems ]]; then
  ok "no locale-dependent constructs and no stray escapes in the pattern"
else
  while IFS= read -r p; do fail "pattern: $p"; done <<< "$problems"
fi

# README.md tells readers to drop the first two alternatives to allow dashes.
if [[ ${alternatives[0]:-} == $'\xe2\x80\x94' && ${alternatives[1]:-} == $'\xe2\x80\x93' ]]; then
  ok "the first two alternatives are the em dash and the en dash, as README.md says"
else
  fail "README.md says the first two alternatives are the em dash and the en dash; they are not"
fi

# --- fixtures --------------------------------------------------------------------

# cases FILE: the lines of a fixture without comments, blank lines or CRs.
cases() { { grep -v -e '^#' -e '^[[:space:]]*$' "$1" || true; } | tr -d '\r'; }

for f in must-flag must-pass known-false-positives; do
  if [[ ! -s $fixtures/$f.txt ]]; then fail "missing fixture: test/fixtures/$f.txt"; exit 1; fi
  cases "$fixtures/$f.txt" > "$tmp/$f.lf"
  sed 's/$/\r/' "$tmp/$f.lf" > "$tmp/$f.crlf"
  if [[ $(tr -cd '\r' < "$tmp/$f.crlf" | wc -c) != "$(wc -l < "$tmp/$f.lf")" ]]; then
    fail "could not build a CRLF copy of $f.txt"
  fi
done
ok "fixtures: $(wc -l < "$tmp/must-flag.lf") must-flag, $(wc -l < "$tmp/must-pass.lf") must-pass, $(wc -l < "$tmp/known-false-positives.lf") known false positives"

while IFS= read -r line; do
  if grep -qF -- "$line" "$root/SKILL.md"; then
    ok "known false positive quoted in SKILL.md: $line"
  else
    fail "known false positive not quoted in SKILL.md: $line"
  fi
done < "$tmp/known-false-positives.lf"

# --- run under each locale -------------------------------------------------------

# A locale is usable here if grep counts "è" (two bytes) as one character in it.
utf8=C.UTF-8
locales=(C)
if [[ $(printf '\303\250\n' | LC_ALL=$utf8 grep -c '^.$' 2>/dev/null || true) == 1 ]]; then
  locales+=("$utf8")
elif [[ -n ${CI:-} ]]; then
  fail "locale $utf8 is not available on this CI runner"
else
  skip "locale $utf8 is not available here; running under C only"
fi

# xgrep LOCALE ARGS...: grep under LOCALE. Messages go to $tmp/stderr, which is
# checked in this shell (xgrep often runs inside a command substitution).
xgrep() {
  local loc=$1
  shift
  LC_ALL=$loc grep "$@" 2>> "$tmp/stderr"
}

for loc in "${locales[@]}"; do
  : > "$tmp/stderr"
  status=0
  xgrep "$loc" -E -e "$pattern" /dev/null || status=$?
  if (( status > 1 )); then fail "$loc: grep rejects the pattern: $(head -n 1 "$tmp/stderr")"; continue; fi
  if [[ -s $tmp/stderr ]]; then
    fail "$loc: grep warns about the pattern: $(head -n 1 "$tmp/stderr")"
  else
    ok "$loc: grep accepts the pattern without warnings"
  fi

  missing=0
  for b in "${branches[@]}"; do
    if ! xgrep "$loc" -qE -e "$b" "$tmp/must-flag.lf"; then
      fail "$loc: branch flags no line of must-flag.txt: $b"
      missing=$((missing + 1))
    fi
  done
  if (( missing == 0 )); then ok "$loc: each of the ${#branches[@]} branches flags at least one line of must-flag.txt"; fi

  # -U keeps the CR in CRLF lines on Windows too, as GNU grep does on Linux
  # (elsewhere it has no effect), so the CRLF runs test the same thing everywhere.
  for eol in lf crlf; do
    unflagged=$(xgrep "$loc" -U -vnE -e "$pattern" "$tmp/must-flag.$eol" || true)
    if [[ -z $unflagged ]]; then ok "$loc, $eol: every must-flag line is flagged"
    else while IFS= read -r l; do fail "$loc, $eol: not flagged: $l"; done <<< "$unflagged"; fi

    flagged=$(xgrep "$loc" -U -nE -e "$pattern" "$tmp/must-pass.$eol" || true)
    if [[ -z $flagged ]]; then ok "$loc, $eol: no must-pass line is flagged"
    else while IFS= read -r l; do fail "$loc, $eol: flagged by mistake: $l"; done <<< "$flagged"; fi

    unflagged=$(xgrep "$loc" -U -vnE -e "$pattern" "$tmp/known-false-positives.$eol" || true)
    if [[ -z $unflagged ]]; then ok "$loc, $eol: every known false positive is still flagged"
    else while IFS= read -r l; do fail "$loc, $eol: no longer flagged, update SKILL.md and the fixtures: $l"; done <<< "$unflagged"; fi
  done

  for f in must-flag must-pass known-false-positives; do
    xgrep "$loc" -nE -e "$pattern" "$tmp/$f.lf" > "$tmp/result.$f.${loc//[^A-Za-z0-9]/_}" || true
  done

  if [[ -s $tmp/stderr ]]; then fail "$loc: grep wrote to stderr: $(head -n 1 "$tmp/stderr")"; fi
done

if (( ${#locales[@]} > 1 )); then
  same=1
  for f in must-flag must-pass known-false-positives; do
    if ! cmp -s "$tmp/result.$f.C" "$tmp/result.$f.${utf8//[^A-Za-z0-9]/_}"; then
      fail "C and $utf8 flag different lines of $f.txt"
      same=0
    fi
  done
  if (( same == 1 )); then ok "C and $utf8 flag exactly the same lines"; fi
fi

if (( failures > 0 )); then
  printf 'done-check: %d failure(s)\n' "$failures"
  exit 1
fi
printf 'done-check: all checks passed\n'
