#!/usr/bin/env bash
# Runs the whole test suite: bash test/run.sh
# Works from any directory, makes no network calls, writes only to temporary
# directories that each script removes on exit.
set -euo pipefail

here=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
status=0
for t in done-check repo-check; do
  printf '== %s\n' "$t"
  bash "$here/$t.sh" || status=1
done
if (( status == 0 )); then
  printf '== all tests passed\n'
else
  printf '== some tests FAILED\n'
fi
exit "$status"
