#!/usr/bin/env bash
# Runs the Done check one-liner from SKILL.md against two fixtures:
# bad.txt must produce matches, good.txt must produce none.
set -u
cd "$(dirname "$0")/.."
pattern=$(sed -n 's/^grep -nE "\(.*\)" <file>$/\1/p' SKILL.md | head -n 1)
if [ -z "$pattern" ]; then echo "FAIL: Done check pattern not found in SKILL.md"; exit 1; fi
fail=0
if grep -nE "$pattern" test/fixtures/bad.txt >/dev/null; then echo "ok: bad.txt is flagged"; else echo "FAIL: bad.txt not flagged"; fail=1; fi
if grep -nE "$pattern" test/fixtures/good.txt >/dev/null; then echo "FAIL: good.txt flagged"; fail=1; else echo "ok: good.txt is clean"; fi
exit $fail
