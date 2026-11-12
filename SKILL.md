---
name: humanizer-it
description: Scrivere e riscrivere testi che non suonano generati da AI, in italiano (con supporto inglese), per un lettore umano e contro i pattern statistici della macchina. Tre modalità: WRITE (prima di scrivere), REWRITE (riscrittura profonda di un testo esistente), AUDIT (report dei tell senza modificare il file). Usala prima di produrre blog, copy lungo, email, copy per siti, e su ogni testo che deve leggersi scritto da una persona brava. Write and rewrite text so it does not read as AI-generated (Italian primary, English supported).
---

# Humanizer-it: testi che non suonano AI

Canone anti AI-tell per l'italiano, con supporto inglese. Fonti: Wikipedia "Signs of AI writing" (WP:AISIGNS), i repo GitHub migliori del filone (blader/humanizer, NousResearch autonovel ANTI-SLOP, harshaneel/humanize, mshumer/unslop, sam-paech/slop-forensics), la guidance Anthropic sul prompting, la linguistica italiana (Accademia della Crusca 2026, Antonelli "Alfabit", De Cesare sul "criptoinglese", Juzek & Ward COLING 2025). Liste parole, esempi estesi e casi reali sono in `reference/`.

Obiettivo doppio: il testo deve suonare umano a un LETTORE vero (priorità) e non esibire i pattern statistici della macchina (uniformità, prevedibilità lessicale). I due si servono a vicenda.

## Quando invocarla

- PRIMA di scrivere blog, copy lungo, email e outreach, copy per siti, social, qualunque testo che rappresenta una persona o un'azienda (modalità WRITE).
- Su un testo esistente che "sa di AI" o che nasce da un draft AI/SEO (modalità REWRITE).
- In revisione su un testo prodotto da altri (modalità AUDIT).
- FUORI SCOPE: documenti legali (privacy, cookie, termini, contratti). Le formule tecniche obbligate restano; valgono solo i principi base (accenti, chiarezza).
- Se esiste una skill o un campione di voce dell'autore, sono livelli separati: questa skill è l'anti-tell universale, qualunque voce; la voce dell'autore è un'altra cosa. Sui testi a nome di una persona si usano entrambe.

## Le tre regole sopra tutto

1. **Cluster rule**: un segnale isolato non è prova di niente (un "fondamentale", un inciso, una lista). Il tell è il CLUSTER, con soglia precisa (calibrata su giornalismo umano vero): almeno 2 segnali della STESSA famiglia, oppure 2+ famiglie CIASCUNA con 2+ occorrenze, oppure densità alta (un segnale ogni meno di 60 parole). Segnali singoli sparsi in famiglie diverse sono prosa normale, anche giornalistica: NON si toccano. Si correggono i pattern, non le singole parole a caccia di streghe.
2. **Umanizzare NON è sgrammaticare**: mai errori deliberati, mai refusi finti, mai accenti sbagliati. L'umanità viene da ritmo, concretezza, lessico vivo e opinioni, non dalla sciatteria. La perfezione formale assoluta è semmai un debole segnale AI, ma si compensa con la texture, non con gli errori.
3. **No-fabrication rule** (REWRITE): la riscrittura non inventa MAI fatti, nomi, numeri, citazioni o esempi assenti dalla fonte. Vale anche per OPINIONI e prese di posizione attribuite a un autore o a un marchio: una stance ("questo non lo facciamo mai") si scrive solo se sta nel brief o nelle parole dell'autore, o se l'autore la approva. In assenza, la frase sorprendente si costruisce con un dettaglio raro, non con un'opinione inventata. Se manca il dettaglio concreto, si chiede, non si fabbrica.

E il contro-canone, per NON sovracorreggere. NON sono tell (indicatori inefficaci, WP:AISIGNS): grammatica perfetta in sé, mix di registri (spesso è un tecnico che scrive informale), prosa ricercata in generale, una transition word isolata, contenuto senza fonti. In italiano NON sono tell: virgolette tipografiche o caporali «» (tipografia corretta, il tell anglofono non si importa) e la variazione di sinonimi moderata (la scuola italiana la insegna: tell debole, pesa solo la rotazione meccanica da thesaurus). Le liste di parole vanno prese ALLA LETTERA: una parola sovra-usata dall'AI non rende sospetti i suoi sinonimi, e "has been featured" (passato) non è il verbo-marketing "features".

## Le 10 famiglie di tell (IT + EN)

Per ogni famiglia: il pattern, un esempio, la direzione del fix. Esempi estesi in `reference/esempi.md`, liste parole in `reference/parole.md`.

### 1. Lessico AI

Parole sovra-rappresentate dai modelli. EN (Juzek & Ward 21 focal words, WP:AIVOCAB, ANTI-SLOP): delve, showcase, underscore, boast, intricate, garner, realm, groundbreaking, tapestry, pivotal, testament, landscape (astratto), meticulous, vibrant, robust, seamless, leverage, foster, align with. IT (calchi e corpus divulgativo): approfondiamo/addentrarsi, cruciale, fondamentale (seriale), panorama (astratto), plasmare, testimonianza di, meticoloso, vibrante, dinamico, innovativo, all'avanguardia, ottimizzare/massimizzare, agevolare, elevare il livello, optare per, senza soluzione di continuità.
Fix: parole piane e concrete. "Ha" non "vanta", "usa" non "utilizza/sfrutta", "scegliere" non "optare per", "vediamo" non "approfondiamo". Il vocabolario AI CAMBIA per era ("delve" è quasi sparito nel 2025; emphasizing/showcasing/highlighting dominano l'era attuale): la lista in reference si aggiorna, il naso no.

### 2. Evitamento delle copule (è/ha)

L'AI scansa "è" e "ha": serves as, stands as, represents, boasts, features; in italiano si configura come, si pone come, rappresenta, costituisce, funge da, vanta, offre (seriale). L'umano scrive "è" e "ha" senza paura (il calo di is/are è misurato nei corpora post-2023).
BAD: "Il ristorante si configura come punto di riferimento e vanta una posizione unica." FIX: "Il ristorante è un punto di riferimento. Sta in una posizione unica."

### 3. Parallelismi retorici

"Not just X, but Y" / "non solo X, ma anche Y" / "Non è X. È Y." / "niente X, niente Y, solo Z" / falsi range "dalla A alla B" dove A e B non stanno su una scala. Fingono di correggere un fraintendimento che nessuno aveva.
BAD: "Non è solo un sito web, è un'opportunità di crescita." FIX: dire cos'È, direttamente: "Il sito ti porta richieste di preventivo mentre dormi."
Variante IMPERATIVA (vedi `reference/casi-reali.md`): la regola pratica scritta come contrasto con un errore che nessuno stava facendo ("Fora il montante, non il cartongesso", "Avvita dal basso, non di lato"), in fila nei titoletti di una guida. FIX: istruzione piana col dato dentro ("Le viti da 4 cm entrano nel montante per almeno 3 cm"). Stessa famiglia la colloquialità da copy negli occhielli ("Le viti che ci vogliono"): l'occhiello dice cos'è ("Viti per questo muro").

### 4. Rule of three e simmetria

Triplette ovunque (aggettivo, aggettivo, aggettivo), liste sempre di 3 o 5 voci, 3 pro / 3 contro, sezioni tutte della stessa forma. Il lettore sente il metronomo.
Fix: cardinalità varia (uno, due, quattro con gerarchia), struttura "lumpy": un paragrafo di una riga dopo uno di otto, una sezione che chiude senza morale.

### 5. Gerundio interpretativo e a catena

La subordinata appesa che interpreta il fatto appena detto (calco dell'-ing clause): "...sottolineando l'importanza della tradizione", "...testimoniando l'impegno", "...garantendo risultati". E le catene: "garantendo..., permettendo..., offrendo...".
Fix: chiudere la frase al fatto. Se l'interpretazione serve, frase autonoma con fonte. Al massimo un gerundio INTERPRETATIVO per periodo. ESENTI i gerundi modali o consecutivi che portano contenuto fattuale nuovo ("aumentando i margini del 12%" è un fatto, non interpretazione vuota; anche coordinati, come nella prosa d'autore italiana).

### 6. Gonfiaggio di importanza e puffery

Significance inflation ("ruolo cruciale", "punto di svolta", "segna un momento fondamentale", "lascito duraturo") e linguaggio da brochure ("incastonato", "nel cuore di", "suggestivo", "mozzafiato", "rinomato", "vivace borgo"). E il Barnum statement: la frase che vale per chiunque ("Ogni azienda è unica e merita una strategia su misura").
Fix: il fatto specifico e raro batte l'aggettivo: "a 20 minuti dal centro, dentro il parco regionale" e non "contesto suggestivo e accogliente". Test Barnum: se la frase funziona identica per il concorrente, si cancella.

### 7. Metadiscorso, connettivi seriali, chiuse riassuntive

"È importante sottolineare che", "vale la pena ricordare", "va notato che"; paragrafi che aprono in catena con Inoltre/Tuttavia/Infine/In conclusione; la chiusa rituale che ripete quanto appena letto ("In conclusione, possiamo affermare che..."). Antonelli 2026: il "generoso ricorso a connettivi di raccordo" è IL tratto dell'IA-taliano.
Include le etichette che annunciano la forma del testo invece del contenuto ("In breve", "Riassunto", "Il punto", "Da sapere una volta sola"): l'occhiello dice il fatto.
Fix: se una cosa è importante si dimostra col fatto, non si dichiara. Le transizioni le regge la logica del contenuto (richiami lessicali, giustapposizione), non i connettivi da manuale. Si chiude sull'ultimo fatto, un'azione o una battuta, mai sul riassunto.

### 8. Struttura piatta e formattazione meccanica

Frasi tutte della stessa lunghezza, paragrafi simmetrici tesi-spiegazione-mini chiusa, blocchi-isola senza aggancio al precedente, bullet dove serviva prosa, titoletti-bold-due-punti seriali, grassetti "didattici" ovunque, Title Case Nei Titoli (in italiano non esiste: tell fortissimo), emoji decorative.
E i tell del registro POST-humanizer (il genere che nasce eseguendo le regole anti-slop alla perfezione):
- **Due punti a cerniera**: l'em-dash bandito che migra su ":" ("Tradotto: ...", "Il risultato: ..."). Più di circa 2 ogni 100 parole = cluster.
- **Simmetria di funzione**: battuta o punchline a chiusura di OGNI paragrafo (stesso metronomo della chiusa-riassunto, solo più cool), callback o bookend troppo pulito nei testi brevi, numeri tondi equidistribuiti (uno ogni circa 30 parole, tutti comodi). La specificità umana è grumosa: un dettaglio con attrito vale più di tre numeri tondi.
Fix con soglie (da harshaneel/humanize, valide per copy web, landing, email; per longform editoriale e prosa d'autore conta solo l'irregolarità RELATIVA: l'italiano giornalistico ha frasi più lunghe dell'inglese e zero frasi da 6 parole è normale): almeno una frase di 6 parole o meno ogni circa 150; mai tre frasi consecutive con lunghezze entro 5 parole l'una dall'altra. Prosa che scorre con transizioni fra i paragrafi. Dalla guida Anthropic: "prose without bullets, numbered lists, or excessive bolding" nei documenti; bold solo dove l'enfasi è genuina; sentence case nei titoli. Le leve positive si applicano A CAMPIONE, mai una-ciascuna-per-paragrafo.

### 9. Attribuzioni vaghe ed esempi generici

"Gli esperti concordano", "diversi studi dimostrano", "industry reports" senza nome; l'esempio ipotetico "ad esempio, un'azienda potrebbe..."; lo stesso concetto ripetuto con parole leggermente diverse a poche righe di distanza.
Fix: nome, luogo, numero, data, o si taglia. Gli esempi si pescano da materiale reale e verificabile, mai inventati. Un concetto = una volta, poi si avanza.

### 10. Artefatti meccanici (prove materiali)

Em-dash (in italiano l'AI li usa 3-5 volte più di un umano, spesso spaziati), preamboli meta ("Ecco di seguito...", "Sulla base di..."), sycophancy ("Ottima domanda!", "Spero sia utile"), riempitivi di sincerità ("onestamente", "sinceramente", "francamente" come convincitori), domande retoriche-esca seriali, staccato drama ("Corto. Incisivo. Efficace."), signposting ("Ecco il punto:", "entriamo nel vivo"), placeholder ([Nome], XX-XX), residui di chatbot (contentReference/oaicite, [cite:, grok-card, 【†, attached_file, utm_source=chatgpt.com), "in quanto modello linguistico", troncamenti a metà frase.
Fix: grep meccanico (vedi Done check) e taglio. Sono le uniche prove inconfutabili: tolleranza zero.

## Le leve positive (cosa METTERE, non solo togliere)

La skill non è solo sottrattiva. Un testo umano ha qualità che l'AI di default non produce:

1. **Specificità**: numeri, nomi propri, luoghi, date, strumenti. "Compra da tre aziende agricole entro 10 km" batte qualunque "impegno per il territorio". La profondità vera sta nei dettagli e negli edge case, non nella riformulazione elegante del problema.
2. **Ritmo irregolare**: alternanza vera di frasi secche e periodi articolati, senza cadenza regolare (anche l'alternanza REGOLARE lungo/corto è un pattern). Una frase nominale ogni tanto. Un paragrafo di una riga.
3. **Texture umana**: ironia leggera, intensificatori parlati ("confusione assurda"), virgolette autoironiche ("chi cerca 'normalmente'"), una domanda retorica che lusinga l'interlocutore vero (non il lettore generico), mostrare la fatica fatta ("ho dovuto cercare dentro i siti delle istituzioni"), riconoscere la competenza altrui ("come ben sai").
4. **Lingua viva**: modi di dire, un'iperbole, la metafora presa dal MESTIERE di chi legge o di chi scrive (il forno, il cantiere, l'atelier). È il livello di contesto che l'AI non tiene.
5. **Prendere posizione**: un umano dice "questa cosa non la farei mai" e spiega perché. Il take sempre bilanciato e prudente è della macchina. (Sempre nei limiti della no-fabrication rule.)
6. **Copule e possesso piani**: "è", "ha", "c'è". Le piccole ridondanze sintattiche ("per il fatto che") sono umane: non limarle tutte.
7. **Transizioni organiche**: ogni paragrafo si aggancia al precedente; il discorso scorre come un ragionamento, non come una scaletta riempita.
8. **Brevità = selezione, non compressione** (Anthropic): si accorcia scegliendo cosa includere, non comprimendo in frammenti, sigle e catene di frecce.

**Voice calibration**: se esiste un campione di voce reale dell'autore (email già approvate, testi suoi verbatim), il campione VINCE sulle regole default di questa skill: si adottano le sue abitudini di lunghezza, lessico e punteggiatura. Migliorare la versione che piaceva col delta minimo, mai ricostruire da zero.

## Modalità operative

### WRITE (prima di scrivere)

1. Carica le leve positive e tieni a mente le 10 famiglie.
2. Scrivi partendo dal fatto specifico o dal problema del lettore, MAI da "In un mondo sempre più digitale...".
3. Scrivi come parli a un collega competente: registro naturale, opinioni ammesse.
4. Chiudi col Done check (sotto).

### REWRITE (umanizza testo esistente, riscrittura profonda)

Tre passate, in quest'ordine (struttura prima delle parole):

1. **Struttura**: rompi il template. Fondi i blocchi-isola con transizioni vere, taglia intro-riassunto e chiuse rituali, converti in prosa le liste che erano ragionamenti, spezza la simmetria dei paragrafi. Si può ristrutturare, fondere e tagliare sezioni: l'obiettivo è il risultato, non la fedeltà al draft. I FATTI restano intoccabili (no-fabrication).
2. **Frase e lessico**: tell swap famiglia per famiglia (copule, parallelismi, gerundi, lessico AI, metadiscorso, attribuzioni vaghe). Ritmo: applica le soglie di burstiness.
3. **Texture**: passata che AGGIUNGE l'umano (leve 1-5). Se il testo ha un autore con voce nota, calibra sul campione.

Poi auto-critica esplicita (loop di blader/humanizer): "cosa rende questo testo ancora ovviamente AI?" e "ho inventato qualcosa?"; una seconda passata mirata sui finding. Poi Done check.

### AUDIT (report senza riscrivere)

Scansiona il testo e produci un report in tabella: riga, famiglia di tell, frammento incriminato, gravità (CLUSTER se sopra soglia, ISOLATO se singolo), fix proposto. Non modifica il file. Gli artefatti chatbot (oaicite, grok-card, utm, placeholder...) sono sempre CLUSTER a prescindere: prove materiali. ATTENZIONE a em-dash ed en-dash su testi scritti da altri: lì sono un segnale pesato (spaziatura e densità 3-5 volte la baseline), non una prova, perché la tipografia editoriale italiana usa le lineette legittimamente. Il divieto a tolleranza zero vale solo sui testi che consegni tu.

## Done check (gate di uscita, tutte le modalità)

1. **Grep meccanici** (zero tolleranza), one-liner pronto sul file da consegnare:

```bash
grep -nE "—|–|oaicite|contentReference|oai_citation|turn0(search|image)|\[cite:|start_span|grok.card|【|attached_file|ppl-ai-file-upload|utm_source=(chatgpt|openai|copilot)|referrer=grok|INSERT_|PASTE_|\[Nome\]|XX-XX|In conclusione|In sintesi[,:]|[Èè] importante (sottolineare|notare)|Ecco di seguito|a 360 gradi|sinergi|[Mm]i basta un s[iì]|[Vv]i basta rispondere" <file>
```

Zero match = si passa allo scan; ogni match si corregge prima. Note sul perimetro: le quattro formule ("In conclusione", "In sintesi", "È importante sottolineare/notare", "Ecco di seguito") sono nella fascia BAN per i testi che consegni (vedi `reference/parole.md`); em-dash ed en-dash sono una scelta di questo canone (i range si scrivono col trattino semplice: 9-13, 2019-2024); "mi basta un secondo" è un falso positivo noto del pattern, si ignora a occhio. Per usare il canone con regole tipografiche diverse, togli `—|–` dal pattern.
2. **Scan famiglie**: rilettura con le 10 famiglie davanti; ogni cluster residuo si corregge, non si giustifica.
3. **Lettura ad alta voce** (mentale ma frase per frase): dove suona "da manuale" si riscrive.
4. **Una frase sorprendente**: c'è almeno UNA frase che un'AI non avrebbe scritto? Se no, il testo è piatto: aggiungi una leva (opinione approvata, metafora dal mestiere, dettaglio raro).
5. **Test Barnum sul totale** (30-second test): questo testo, identico, potrebbe essere mandato o pubblicato da un concorrente? Se sì, non è finito.
6. **Ritmo IRREGOLARE** (il target è l'irregolarità, non la quota fissa: una frase corta ogni 150 parole esatte è essa stessa un metronomo): ci sono tre frasi consecutive con lunghezze entro 5 parole l'una dall'altra? I due punti a cerniera superano circa 2 ogni 100 parole? Ogni paragrafo chiude con una punchline (simmetria di funzione)?
7. **Anti-sameness**: le frasi FIX di `reference/esempi.md` sono didattiche, MAI riusabili verbatim in un testo vero. Se una formulazione l'hai già usata per un altro testo o un altro cliente, riscrivila. Vale anche sulle serie: oggetti di email, incipit, chiuse identiche su N pezzi sono un cluster a sé (vedi `reference/casi-reali.md`).
8. **Giudice finale**: MAI autoproclamare "non sa di AI". Sui testi importanti il verdetto spetta a chi li rivede. Ogni bocciatura diventa un caso in `reference/casi-reali.md`.

## Manutenzione

- Ogni "sa di AI" detto da chi rivede un testo passato per questa skill diventa un caso in `reference/casi-reali.md`, con la frase incriminata e il fix. La skill impara dai casi veri.
- Il lessico AI è un bersaglio mobile (ere dei modelli): a ogni giro di manutenzione ricontrolla WP:AISIGNS (attivamente mantenuta) e aggiorna `reference/parole.md`.
- Una slop-list italiana validata su corpus non esiste in letteratura; il metodo per costruirla è descritto in `reference/parole.md` (Juzek & Ward, unslop, slop-forensics).

## Fonti primarie

- Wikipedia, "Signs of AI writing" (WP:AISIGNS): https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing (fonte madre, circa 50 segnali, attivamente mantenuta; testo CC BY-SA 4.0)
- blader/humanizer (tassonomia, audit loop, falsi positivi): https://github.com/blader/humanizer
- NousResearch autonovel, ANTI-SLOP.md (sostituzioni e checklist multilivello): https://github.com/NousResearch/autonovel/blob/master/ANTI-SLOP.md
- harshaneel/humanize (leve positive con soglie numeriche): https://github.com/harshaneel/humanize
- mshumer/unslop e sam-paech/slop-forensics (metodo corpus-based per slop-list custom)
- Anthropic, prompting best practices (blocco anti-markdown, selettività vs compressione): https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- Juzek & Ward, COLING 2025 (21 focal words, metodo trasferibile): https://aclanthology.org/2025.coling-main.426/
- Accademia della Crusca, "Sui testi generati dall'intelligenza artificiale" (IA-taliano, connettivi di raccordo): https://accademiadellacrusca.it/it/contenuti/sui-testi-generati-dall-intelligenza-artificiale-verso-un-nuovo-rapporto-tra-norma-e-uso/46422 · Antonelli, "Alfabit" (Il Mulino 2026) · De Cesare 2026 ("criptoinglese")
- Fonti divulgative italiane: marcoilardi.it, il Post (30/03/2026), aipatterndetector.it
