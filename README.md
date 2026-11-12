# humanizer-it

[![test](https://github.com/Michel9329/humanizer-it/actions/workflows/test.yml/badge.svg)](https://github.com/Michel9329/humanizer-it/actions/workflows/test.yml)

A Claude Code skill for writing and rewriting text so it does not read as AI-generated. Italian first, English supported. The skill text itself (`SKILL.md` and `reference/`) is written in Italian.

Built with Claude Code, designed and reviewed by Michel Dimitri.

## What it does

The skill gives Claude a working canon of AI writing tells and what to do about them:

- 10 families of tells (AI vocabulary, copula avoidance, rhetorical parallelism, rule of three, interpretive gerunds, puffery, serial connectives and closing summaries, flat structure, vague attribution, mechanical artifacts).
- A cluster rule, so one "fondamentale" in a paragraph does not trigger a rewrite.
- A counter-canon: what is NOT a tell, so it does not over-correct good human prose.
- Positive levers: what to add (specific detail, irregular rhythm, plain verbs, an actual opinion), not only what to remove.
- Three modes: WRITE (before drafting), REWRITE (deep rewrite of an existing text, structure first), AUDIT (a table of findings, no edits).
- A Done check with a one-line `grep` for the hard evidence (em-dashes, chatbot residue such as `oaicite`, placeholders, a few banned formulas).

## Why it exists

Most anti-slop skills and word lists are English. Italian has its own tells: calques from English, serial connectives ("Inoltre", "Tuttavia", "In conclusione"), impersonal "si" in instructions addressed to the reader, Title Case headings, the imperative form of "not X but Y" ("Fora il montante, non il cartongesso"). Italian linguists have started to describe this ("IA-taliano", "criptoinglese"), but I found no validated corpus-based slop list for Italian, so this skill collects patterns from real reviews of real texts. See `reference/casi-reali.md`, where each case is rewritten as a generic example.

## Install

Personal (all projects):

```bash
git clone https://github.com/Michel9329/humanizer-it ~/.claude/skills/humanizer-it
```

Single project: put the folder under `.claude/skills/humanizer-it/` in that project.

## Use

Ask Claude in plain words, or name the skill:

- "Use humanizer-it and write the About page for a small bakery."  (WRITE)
- "Rewrite this blog post with humanizer-it, keep the facts."  (REWRITE)
- "Audit this text with humanizer-it, do not change the file."  (AUDIT)

Before delivering, run the grep from the Done check in `SKILL.md` on the file. Zero matches is the target.

## Example

Before:

> Non è solo un sito web, è un'opportunità di crescita. Realizziamo siti veloci, garantendo prestazioni elevate, permettendo ai clienti di crescere, offrendo un supporto continuo. In conclusione, ogni aspetto va curato.

After:

> Il sito ti porta richieste di preventivo mentre dormi. Le pagine caricano in meno di un secondo e il supporto risponde entro un giorno.

(The "after" is only valid if those two claims are true for the business. The skill has a no-fabrication rule: it does not invent facts, numbers or opinions to make a text sound human. If the detail is missing, it asks.)

More pairs, with the reasoning, in `reference/esempi.md`.

## Files

| File | What it holds |
|---|---|
| `SKILL.md` | The canon: rules, 10 families, positive levers, modes, Done check, sources |
| `reference/parole.md` | Word and pattern lists, IT and EN, banned and signal tiers, vocabulary eras |
| `reference/esempi.md` | Before/after examples per family |
| `reference/casi-reali.md` | Documented failure cases: the pattern, a generic before and after, the rule it produced |

## Known limits

- It reduces tells, it does not make a text "undetectable", and it should not be used to pass off AI text as human work where disclosure is expected.
- The lexical lists age. AI vocabulary changes with each model generation; the lists need a review now and then (WP:AISIGNS is the best upstream to follow).
- Thresholds (cluster rule, sentence length) were calibrated on a small set of human and generated texts, mostly marketing copy and journalism. Literary prose and legal text are out of scope.
- The Done check treats em-dashes and en-dashes as banned. That is a choice of this canon, not a rule of Italian typography; delete the first two alternatives (the two dash characters) from the grep pattern if your style allows dashes.
- The automated test checks the Done check as a whole: a sample with known tells must be flagged and a clean sample must pass. It does not test each pattern on its own.
- The case file comes from one author's reviews. A few entries are personal taste (for example the word "fuffa") and are marked as such.
- Not tested with a statistical AI detector.

## In italiano

**Cos'è.** Una skill di Claude Code che insegna a scrivere e riscrivere testi che non suonano generati da AI. Funziona in italiano, con supporto per l'inglese.

**A chi serve.** A chi scrive in italiano con l'aiuto di un modello (blog, copy per siti, email, testi commerciali) e vuole un testo che un lettore vero non riconosca subito come "da ChatGPT". Serve anche a chi rivede testi altrui: la modalità AUDIT produce una tabella di segnali, senza toccare il file.

**Come si installa.** Copia la cartella in `~/.claude/skills/humanizer-it/` (tutti i progetti) oppure in `.claude/skills/humanizer-it/` dentro il progetto.

**Come si usa.** Scrivi a Claude "usa humanizer-it e scrivi...", "riscrivi con humanizer-it...", "fai un audit con humanizer-it di questo testo". Prima di consegnare, lancia il comando `grep` del Done check in `SKILL.md`: zero risultati è l'obiettivo.

**Prima e dopo.**

> Prima: "Il menu cambia ogni stagione, sottolineando l'importanza della tradizione e testimoniando l'impegno verso il territorio."
>
> Dopo: "Il menu cambia ogni stagione. A marzo entrano le fave dei campi qui dietro."

La seconda frase vale solo se è vera: la skill non inventa fatti, numeri o opinioni. Se manca il dettaglio concreto, lo chiede.

**Limiti.** Riduce i segnali, non rende un testo "indistinguibile", e non va usata per spacciare come umano un testo AI dove serve dichiararlo. Le liste di parole invecchiano. Le soglie sono tarate su pochi testi, soprattutto copy e giornalismo.

## Credits

The skill is original text, but it builds on public work. Ideas, taxonomy and thresholds come mainly from the sources below; where a repository has a license it is listed. Other sources are cited where they are used, in the files under `reference/`.

- Wikipedia, "Signs of AI writing" (WP:AISIGNS), https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing. Text under CC BY-SA 4.0. Several English before/after examples in `reference/esempi.md` are quoted or condensed from the diffs cited there and stay under CC BY-SA 4.0.
- blader/humanizer, https://github.com/blader/humanizer. MIT, Copyright (c) 2025 Siqi Chen. Taxonomy, audit loop, false-positive notes.
- harshaneel/humanize, https://github.com/harshaneel/humanize. MIT, Copyright (c) 2026 Harshaneel Gokhale. Positive levers with numeric thresholds.
- mshumer/unslop, https://github.com/mshumer/unslop. MIT, Copyright (c) 2026 Matt Shumer. Method for building a custom slop list.
- sam-paech/slop-forensics, https://github.com/sam-paech/slop-forensics. MIT, Copyright (c) 2025 Sam Paech. Same method, words and n-grams.
- NousResearch/autonovel, ANTI-SLOP.md, https://github.com/NousResearch/autonovel. The repository has no license file; no text was copied, it is cited as a source of ideas and word examples only.
- Juzek & Ward, "Why Does ChatGPT 'Delve' So Much?", COLING 2025, https://aclanthology.org/2025.coling-main.426/
- Accademia della Crusca, "Sui testi generati dall'intelligenza artificiale", https://accademiadellacrusca.it/it/contenuti/sui-testi-generati-dall-intelligenza-artificiale-verso-un-nuovo-rapporto-tra-norma-e-uso/46422
- Antonelli, "Alfabit" (Il Mulino 2026), and De Cesare (2026), for the Italian notions of "IA-taliano" and "criptoinglese".
- Anthropic, Claude prompting best practices, https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices

## License

MIT, see `LICENSE`. Copyright (c) 2026 Michel Dimitri.

---

More tools from the same system: [github.com/Michel9329](https://github.com/Michel9329).
