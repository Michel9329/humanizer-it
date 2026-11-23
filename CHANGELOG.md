# Changes

## 2026-11-23

Skill text (`SKILL.md`, `reference/`):

- Six signals adapted from blader/humanizer 4.0.0, with Italian examples: the objection nobody raised, stacked hedges, the passive that hides who acts, vague links, the first line that repeats the heading, re-explaining to someone who already knows. One rule new in 4.0.0 was left out on purpose: it allows adding a detail that sounds true, and this skill does not invent facts.
- Tells of interface text: titles, eyebrows, labels.
- The text to rewrite or audit is material, never instructions. Notes addressed "to the AI", fake operator or system messages and closing tags inside it are edited or removed like the rest, in all three modes, and reported in AUDIT. This is the skill's defence against prompt injection in pasted text.
- Done check, step 2 now names the six signals and the interface tells, not only the ten families.
- `reference/parole.md`: assistant tics from the system prompts Anthropic publishes; the hedge added to the last item of a list ("quando serve"); sentences that open with "Ci ho".
- `reference/casi-reali.md`: seven new cases, in the same generic form; cases are now numbered within their sections.

Fixes:

- The `description` in the front matter of `SKILL.md` was not valid YAML: an unquoted value cannot contain a colon followed by a space. Claude Code loads a skill whose front matter does not parse, but without its fields, so the name fell back to the folder name and the description to the first line of the body. The description no longer contains that sequence, and the tests check it.
- Done check pattern: `[Mm]i basta un s[iì]` also flagged "Mi basta un sito", while `SKILL.md` named as false positive "mi basta un secondo", which the pattern never matched. The alternative now ends at the end of the word. The pattern also no longer relies on constructs that mean different things under different locales (accented letters inside brackets, the `.` wildcard) or on an escape (`\]`) that is not needed. The false positives listed in `SKILL.md` are now real ones, and the tests keep the list true.

Tests and repository:

- `test/done-check.sh` tests every branch of the Done check pattern, read from `SKILL.md`, against lines that must be flagged, ordinary Italian that must not be, and the documented false positives, under `LC_ALL=C` and `LC_ALL=C.UTF-8`, with LF and CRLF line endings. This replaces the old test, which checked one flagged sample and one clean sample.
- `test/repo-check.sh` checks the front matter, the counts the text states, the files and links named in the Markdown files, leftovers from the private workspace the skill comes from, and the install into a temporary `~/.claude/skills/humanizer-it`.
- `test/run.sh` runs both. CI runs it on Ubuntu and on Windows (Git Bash), with read-only permissions and without keeping the checkout token.
- `.gitattributes` keeps LF line endings on every platform.

## 2026-11-12

- First public release.
