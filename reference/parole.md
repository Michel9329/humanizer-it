# Humanizer-it: liste parole e pattern (IT + EN)

Fonte EN primaria: WP:AISIGNS (Wikipedia, "Signs of AI writing", letta integrale nel 2026) + Juzek & Ward COLING 2025 + Kobak, Science Advances 2025. Fonte IT: Crusca/Palermo 2026, Antonelli "Alfabit", fonti divulgative (Ilardi, Il Post, StudioCataldi, Fastweb) e adattamenti marcati come tali.

Regola d'uso (dalla fonte, adattata): questa sezione va presa ALLA LETTERA, una parola sovra-usata dall'AI NON implica che anche i suoi sinonimi lo siano. Una o due parole della lista possono essere coincidenza; TANTE, insieme, in un testo post-2022, sono uno dei tell più forti. Le parole co-occorrono: dove ce n'è una, cercane altre.

Usi LEGITTIMI da non flaggare mai (calibrati su giornalismo umano vero): gerundio modale o consecutivo con contenuto fattuale nuovo ("aumentando i margini del 12%"); "rappresenta + quota o percentuale" (senso: costituire); "fondamentale" predicativo singolo; "Inoltre" singolo non in catena; lineette lunghe in testi editoriali altrui (tipografia italiana legittima: il divieto vale sui testi che consegni tu).

## Fascia BAN (mai nei testi che consegni, nessuna eccezione)

Artefatti meccanici e tic da chatbot. Grep prima di consegnare (il one-liner è nel Done check di `SKILL.md`):

- Em-dash (U+2014) nel corpo del testo, più l'en-dash (U+2013) come estensione del canone: i range si scrivono col trattino semplice. Nota dalla fonte: gli em-dash AI sono tipicamente SPAZIATI; la loro ASSENZA non prova nulla, alcuni modelli recenti li sopprimono.
- Formule promosse a BAN nei testi consegnati (in origine SEGNALE, promosse per coerenza col Done check): "In conclusione", "In sintesi" a chiusura, "È importante sottolineare/notare", "Ecco di seguito".
- Emoji decorative in testi professionali.
- Placeholder: `[Nome]`, `[inserire...]`, `XX-XX`, `{{...}}`, `INSERT_`, `PASTE_`, `___`.
- Artefatti chatbot (prova inconfutabile): `contentReference`, `oaicite`, `oai_citation`, `turn0search`, `turn0image`, `attributableIndex`, `[cite:`, `start_span`, `end_span`, `grok-card`, `grok_render_citation_card_json`, `【` + `†` (DeepSeek), `attached_file`, `ppl-ai-file-upload`, `:::writing` / `:::scrittura`, `↩` attorno alle note.
- UTM traccianti: `utm_source=chatgpt.com`, `utm_source=openai`, `utm_source=copilot.com`, `referrer=grok.com`.
- Frasi da chat: "Spero sia utile", "Certamente!", "Ottima domanda", "Fammi sapere se", "Ecco una bozza", "In quanto modello linguistico", "al mio ultimo aggiornamento".
- Aziendalese: "sinergia", "a 360 gradi", "leader di settore" (senza dati), "eccellenza" (filler), "all'avanguardia" (senza dire cosa), "punto di riferimento" (generico), "realtà dinamica", "giovane e dinamico", "soluzioni innovative".
- "fuffa": in alcuni contesti italiani il termine è diventato un marcatore del testo da chatbot; alternative: "riempitivo", "aria fritta". (Preferenza di stile, verifica se vale per il tuo pubblico.)
- CTA cheap-yes: "mi basta un sì", "vi basta rispondere", e in genere le formule che abbassano l'attrito di risposta ("anche due righe", "bastano due parole", "rispondi come ti viene").

## Fascia SEGNALE (legittime da sole; in cluster = riscrivere)

### Italiano: lessico

approfondiamo / addentrarsi (delve) · cruciale · fondamentale (seriale) · panorama (astratto) · plasmare · testimonianza di · a testimonianza del · sottolinea / mette in luce / evidenzia (seriali) · meticoloso · vibrante · dinamico · innovativo · stimolante · efficiente / efficienza · ottimizzare / massimizzare / agevolare · elevare il livello · optare per · valorizzare · favorire · robusto · senza soluzione di continuità · incastonato / immerso nel cuore di · suggestivo · mozzafiato · rinomato · vanta · ricco patrimonio · si configura come / si pone come / rappresenta / costituisce / funge da (al posto di "è") · offre (seriale, al posto di "ha") · svolge un ruolo cruciale · punto di svolta · momento fondamentale · lascito duraturo · in continua evoluzione · a tutto tondo · poliedrico

### Italiano: formule e strutture

- Metadiscorso: "vale la pena ricordare", "va notato che", "si può affermare che", "è interessante notare" (le forme "è importante sottolineare/notare" sono promosse a BAN, vedi sopra).
- Incipit stereotipati: "In un mondo sempre più...", "Nell'era digitale...", "Nel panorama attuale...", "Nell'universo della...".
- Chiuse rituali: "Riassumendo", "Nel complesso", "possiamo affermare che" ("In conclusione" e "In sintesi" sono promosse a BAN, vedi sopra).
- Etichette-occhiello che annunciano la forma del blocco invece del contenuto: "In breve", "In sintesi" come titolo, "Riassunto", "Il punto", "Da sapere una volta sola". L'occhiello dice il fatto ("Lavatrice e asciugatrice", "Vale in tutta l'Unione europea").
- Connettivi seriali a inizio paragrafo (Antonelli: "generoso ricorso a connettivi di raccordo"): Inoltre / Tuttavia / Di conseguenza / Infine in catena.
- Parallelismi: "non solo X, ma anche Y" · "Non è X. È Y." · "niente X, niente Y, solo Z" · "dalla A alla B" (range finti) · "piuttosto che / anziché" come coda decorativa · la variante imperativa "fai X, non Y" in fila nei titoletti.
- Gerundio interpretativo appeso: "...sottolineando", "...testimoniando", "...garantendo", "...evidenziando", "...contribuendo a" e catene di gerundi.
- Attribuzioni vaghe: "gli esperti concordano", "secondo gli osservatori", "diversi studi" (con 0-1 fonti citate), "come dimostrano numerose ricerche".
- Barnum: "Ogni azienda è unica", "merita una strategia su misura".
- Riempitivi di sincerità: "onestamente", "sinceramente", "francamente", "in tutta franchezza" (come convincitori). Preamboli-annuncio di trasparenza: "una cosa la dico subito", "te lo dico subito", "va detto che", "sarò onesto:".
- Coda che attenua l'ultima voce di un elenco: "Parliamo italiano, inglese, spagnolo quando serve", e le sorelle "all'occorrenza", "se necessario", "dove ha senso". Toglie forza proprio alla voce che il testo sta dichiarando. Fix: la voce resta senza coda, oppure esce dall'elenco. Resta legittima quando la condizione è un'informazione ("lo spagnolo il martedì e il giovedì").
- Attacco di frase col «Ci ho»: "Ci ho lavorato due anni.", "Ci ho messo tre giorni.", "Ci ho pensato a lungo." È il parlato finto dei testi de-slop: una frase corta in prima persona che riprende col pronome la frase prima. Fix: il verbo col suo oggetto detto per nome ("Ho lavorato due anni al gestionale delle prenotazioni") oppure il fatto dentro la frase precedente. Nel parlato trascritto (un'intervista, una citazione) resta.
- Preamboli: "Ecco di seguito", "Sulla base di", "Di seguito".
- Rotazione sinonimi meccanica: sfruttare/utilizzare/impiegare/avvalersi per lo stesso referente (la variazione MODERATA in italiano è scolastica e umana; pesa solo la rotazione da thesaurus).
- Due punti a cerniera (l'em-dash bandito che migra su ":"): "Tradotto: ...", "Risultato: ...", "X: Y-punchline". Soglia cluster: più di circa 2 ogni 100 parole.
- "Si" impersonale seriale nelle istruzioni pratiche (indicazioni stradali, passi, regole): "si prende la statale", "si gira al semaforo", "si arriva al cancello". In una pagina che dà del tu al lettore suona da guida generata. Fix: imperativo al tu ("Prendi", "svolta") o prima persona plurale di chi accoglie ("ti aspettiamo al cancello").

### Italiano: era de-slop (2025+), l'anti-slop che diventa slop

Il registro che i modelli adottano quando gli chiedi di NON fare slop (scoperto con un red team interno: un testo con questi tell passa la checklist classica). Tutte fascia SEGNALE, pesano in cluster:

Tradotto: / Risultato: / Morale: / Spoiler: / La verità: / Detto semplice: (aperture-cerniera) · zero + sostantivo ("zero sorprese", "zero pensieri", "zero fronzoli") · "i numeri parlano chiaro" · "parliamoci chiaro" · "senza fronzoli" · "dritti al punto" · "niente giri di parole" · "fa la differenza" · "il punto è" · "la verità è che" · "che funziona" (seriale) · concreto/concretamente (seriale) · "chiavi in mano" · "Punto." come frase a sé · aforisma-sentenza a chiusura di OGNI paragrafo (simmetria di funzione, famiglia 8) · callback o bookend troppo pulito in testi brevi · numeri tondi equidistribuiti

### Italiano: tic da assistente (dai prompt di sistema pubblicati da Anthropic)

Abitudini che Anthropic toglie ai suoi modelli nei prompt di sistema che pubblica: se le vieta è perché i modelli le fanno. Nei testi da consegnare capitano dove si risponde a qualcuno: email, risposte alle recensioni, FAQ, testi di un assistente sul sito. Fascia SEGNALE: una sola non prova niente, due nello stesso messaggio sì. Tra parentesi il prompt da cui viene ognuna (indirizzo nelle fonti di `SKILL.md`).

- **Lode alla domanda o all'idea, in apertura**: "Domanda interessante", "Che bella idea", "Osservazione acuta" (Opus 4.1: nessun aggettivo positivo su domanda, idea o osservazione). "Ottima domanda" è già in fascia BAN. Si comincia dalla risposta.
- **Conferme di riempimento in testa**: "Assolutamente!", "Certo!", "Naturalmente!", "Perfetto!", "Ottimo!" prima di rispondere (Sonnet 3.5). "Certamente!" è già in fascia BAN.
- **Convincitori oltre la sincerità**: "davvero", "veramente", "genuinamente", "in realtà", "a dire il vero", "effettivamente" messi a rinforzo (Opus 4.8 toglie "actually" insieme a "genuinely" e "honestly"; Opus 5 toglie "straightforward"), e il gemello sulla chiarezza: "è semplice", "semplicemente", "in modo semplice e diretto". Chi è sincero e chiaro non lo annuncia. "In realtà" resta legittimo quando corregge un'idea appena nominata.
- **Scuse a catena e autoaccusa**: "Mi scuso per la confusione", "Hai perfettamente ragione, chiedo scusa", "Errore mio, mi dispiace molto" (Fable 5.2: l'errore si riconosce e si sistema, senza umiliarsi). Una scusa, il fatto, il rimedio.
- **Eco della richiesta**: "Mi chiedi se...", "Se ho capito bene vuoi...", "In merito alla tua richiesta di..." prima di rispondere (Opus 4.8: non si cita e non si parafrasa il messaggio di chi scrive). Si risponde.
- **Il limite messo in testa**: "Premetto che non posso...", "Non essendo un legale...", "Non posso garantirlo, ma..." come prima riga (Fable 5.2, nel passo sulle domande di voto: non si apre con quello che non si farà). Prima quello che si può dire, il limite dove serve.
- **La predica**: spiegare a lungo perché una cosa non si fa, o che cosa "dovrebbe" fare chi legge (Opus 4.1: motivare a lungo un rifiuto suona da predica; Fable 5.2: niente lezioni). Un no sta in una frase, e senza elenco puntato.
- **Extra non richiesti in coda**: "Bonus:", "Un consiglio in più:", "Inoltre, ecco alcuni suggerimenti" dopo aver già risposto (Fable 5.2: esempi, consigli e alternative solo se servono a quella persona). Stessa famiglia di "Fammi sapere se" e "Spero sia utile", già in BAN.
- **Raffica di domande in chiusura**: "Vuoi che lo accorci? Preferisci un tono più formale? Ti serve anche in inglese?" (Fable 5.2 e Opus 5: al massimo una domanda, e dopo aver risposto).
- **Azioni o emozioni tra asterischi**: \*sorride\*, \*annuisce\* (Opus 4.1). In un testo da consegnare è sempre un residuo di chat: si toglie.

### English: AI vocabulary (WP:AIVOCAB, corroborate da fonti accademiche)

Additionally (a inizio frase) · align with · boasts (= has) · bolstered · crucial · delve · emphasizing · enduring · enhance · fostering · garner · highlight (verbo) · interplay · intricate / intricacies · key (agg.) · landscape (astratto) · meticulous(ly) · pivotal · robust · showcase · tapestry (astratto) · testament · underscore (verbo) · valuable · vibrant

Caveat di contesto dalla fonte: "underscore" può essere legittimo (trattino basso, musica); "has been featured" è passato, NON il verbo-marketing "features".

### English: 21 focal words (Juzek & Ward, COLING 2025, Table 2)

delves · delved · delving · delve · showcasing · showcases · boasts · underscores · underscoring · underscore · comprehending · intricacies · intricate · surpassing · surpasses · garnered · emphasizing · realm · groundbreaking · advancements · aligns

(Il paper esclude l'architettura come causa principale; indizi convergenti su dati di fine-tuning e RLHF, questione lasciata aperta e approfondita dal follow-up Juzek & Ward 2025, arXiv 2508.01930, citato da WP:AISIGNS.)

### English: copula avoidance e puffery

serves as / stands as / functions as / operates as / marks / represents (per "is") · features / offers / maintains (per "has") · refers to (incipit) · began his career as (per "was") · nestled · in the heart of · breathtaking · renowned · diverse array · natural beauty · commitment to · rich · profound · exemplifies · maintains an active social media presence (idiosincratica AI, rara pre-2024) · not only... but also · it's not just X, it's Y · no X, no Y, just Z · X rather than Y (Grok)

### English: metadiscorso e formule (storiche ma ancora avvistate)

it's important/crucial to note/remember/consider · worth noting · may vary · In summary · In conclusion · Overall · Despite its X, faces several challenges · Despite these challenges · Future Outlook/Prospects · Industry reports · Observers have cited · Experts argue · such as (davanti a liste in realtà esaustive) · independent coverage · profiled in · trade publications · as of my last knowledge update · not widely documented · based on available information · maintains a low profile / keeps personal details private (speculazione sui buchi)

## Ere del vocabolario (calibra il naso sull'epoca del testo)

- **2023 - metà 2024 (GPT-4)**: delve, tapestry, testament, intricate, boasts, crucial, pivotal, meticulous, interplay, bolstered, garner, enduring, vibrant, landscape, key, valuable, Additionally, emphasizing, underscore
- **Metà 2024 - metà 2025 (GPT-4o)**: align with, fostering, showcasing, highlighting, enhance, bolstered, crucial, emphasizing, enduring, pivotal, underscore, vibrant
- **Metà 2025 in poi (GPT-5)**: emphasizing, enhance, highlighting, showcasing + enfasi "canned" su notabilità e copertura media
- **Grok (idioletto)**: causal, empirical, correlate, underscore (ancora nel 2026); "X rather than Y"
- **Era de-slop IT (2025+)**: aperture-cerniera (Tradotto:/Risultato:), zero+sostantivo, aforismi-sentenza, punchline seriali (sezione dedicata sopra)
- Nota: "delve" è quasi sparito nel 2025. Le liste invecchiano: ricontrollare WP:AISIGNS a ogni manutenzione.

## Slop-list italiana corpus-based (metodo, da eseguire quando serve)

Non esiste in letteratura una lista italiana validata su corpus (verificato nel 2026). Metodo pronto, combinando:

1. **Juzek & Ward**: metodo formale trasferibile: confronta frequenze parola per parola tra corpus pre-2022 e testo generato, filtra le parole naturalmente frequenti, tieni le sovra-rappresentate.
2. **unslop (mshumer)**: genera N campioni del TUO modello su brief italiani del tuo dominio; mina i pattern ricorrenti; produce il profilo di evitamento custom.
3. **slop-forensics (sam-paech)**: stessa idea su parole singole, bigrammi e trigrammi.

Categorie di partenza dai linguisti: "criptoinglese" (calchi e interferenze dall'inglese, De Cesare 2026) e "connettivi di raccordo" (Antonelli 2026). Il registro dei casi reali (`casi-reali.md`) alimenta la lista.
