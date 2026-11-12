# Casi documentati

Errori veri, emersi usando questa skill su testi destinati a lettori reali (email, siti, preventivi, guide). Ogni caso è riscritto in forma generica: l'esempio conserva il problema, non il testo originale. Per ogni caso trovi lo schema dell'errore, un prima e dopo, e la regola che ne è nata, con la famiglia di `SKILL.md` o il file in cui è stata aggiunta.

Gli esempi "dopo" mostrano la direzione e non vanno copiati: riusarli identici in un testo vero crea esattamente il problema del caso 9.

## Formule e frasi

### 1. Formule che abbassano l'attrito di risposta

- Schema: il testo istruisce il lettore su quanto poco gli basta fare per rispondere. È un calco dell'inglese ("even a one-line reply is fine") e torna travestito con parole sempre diverse.
- Prima: "Mi basta un sì." · "Rispondi come ti viene, anche due righe."
- Dopo: una domanda vera sul merito, oppure niente.
- Regola: si giudica la funzione, non la parola. Bandite tutte le formule che dicono al lettore come rispondere. Famiglia 10.

### 2. Preamboli che annunciano la trasparenza

- Schema: la frase annuncia che sta per dire una cosa scomoda invece di dirla.
- Prima: "Una cosa la dico subito, perché è giusto dirla prima." · "Sarò onesto:" · "Va detto che".
- Dopo: il fatto scomodo, scritto per primo e senza cornice.
- Regola: la trasparenza parte dal fatto. Un controllo automatico può perfino scambiare questi preamboli per uno stile personale: il giudizio spetta a chi conosce la voce. Famiglia 7.

### 3. Slogan che ripete se stesso

- Schema: la seconda metà della frase ripete la prima con la stessa parola chiave. Suona da marchio e non dice niente di verificabile, per questo sopravvive a più giri di revisione.
- Prima (esempio costruito): "Una bottega, con i tempi di una bottega."
- Dopo: il fatto che la frase evitava ("Tre persone, ordini consegnati in dieci giorni").
- Regola: prova a sostituire la frase con un fatto. Se il fatto c'è, la frase andava tolta comunque. Famiglie 3 e 6.

### 4. Chiusa a effetto che riassume un principio

- Schema: il paragrafo chiude con una massima elegante invece che con l'ultimo fatto. Vale per chiunque, quindi non vale per nessuno (test Barnum).
- Prima: "Il sito va online una volta sola. Poi va tenuto vivo." · "Le cose le mostriamo quando sono fatte."
- Dopo: chi fa cosa, detto piano ("Voi pensate ai clienti, al sito penso io").
- Regola: dopo un rifiuto non si propone un'altra massima riformulata, si cambia tipo di frase. Una chiusa che promette un comportamento del lettore ("ogni volta troverà qualcosa di nuovo") va controllata sul lettore vero: spesso è falsa. Famiglia 8, simmetria di funzione.

### 5. "Fai X, non Y" nelle istruzioni

- Schema: la regola pratica è scritta come contrasto con un errore che nessuno stava facendo. È la forma italiana di "not X, but Y", e nei titoletti di una guida ne esce una fila.
- Prima: "Fora il montante, non il cartongesso." · "Avvita dal basso, non di lato." · occhiello "Le viti che ci vogliono".
- Dopo: l'istruzione col dato dentro ("La vite da 4 cm entra nel montante per almeno 3 cm"); l'occhiello dice cos'è ("Viti per questo muro").
- Regola: aggiunta a `SKILL.md`, famiglia 3, come variante imperativa. Le fonti consultate (Wikipedia "Signs of AI writing", agent-skills/humanize sui "negative parallelisms", GPTZero, Pangram, le linee guida Anthropic sul prompting) descrivono il parallelismo negativo ma non questa variante.

### 6. "Si" impersonale nelle istruzioni pratiche

- Schema: indicazioni scritte al "si" impersonale in una pagina che dà del tu, con registro misto nella stessa scheda e immagini da dépliant.
- Prima: "Si prende la statale verso nord. All'uscita si gira a destra. Due chilometri, e sei arrivato."
- Dopo: "Prendi la statale verso nord. All'uscita gira a destra. Dopo due chilometri sei arrivato."
- Regola: istruzioni come al telefono a chi sta guidando: tu, imperativo, una cosa per riga, nessuna promessa di servizio non verificata. Aggiunta a `parole.md`.

## Pagine e documenti

### 7. Il testo che descrive se stesso

- Schema: lead, etichette e chiuse che raccontano la forma della pagina invece del contenuto.
- Prima: "Prima quello che è già deciso. Poi le opzioni. In fondo, mese per mese, i costi." · etichette "In breve", "Da sapere, una volta sola" · chiusa "Li mettiamo tutti, così sapete cosa c'è dietro ogni cifra."
- Dopo: etichette piane ("Già concordato", "Da sapere"), al massimo una riga di istruzione, poi fatti e numeri.
- Regola: le istruzioni su come scrivere si applicano, non si scrivono nel testo. Niente etichette che descrivono la funzione del blocco. Famiglia 7, aggiunta a `parole.md`.

### 8. Frase che dice del documento una cosa falsa

- Schema: una frase poco chiara viene resa più chiara senza chiedersi se dica qualcosa. Il risultato afferma sul documento una cosa che il documento non contiene.
- Prima: "Il prezzo di ogni passo dipende da quello che il passo consegna, scritto accanto al passo." (accanto c'erano solo nome, durata e prezzo).
- Dopo: frase tolta, e una tabella "Cosa consegna ogni passo".
- Regola: davanti a una frase poco chiara si prova prima a toglierla. Ogni frase che descrive il documento ("trovate sotto", "è indicato accanto") si controlla sul documento finito. Famiglia 6.

### 9. Lo stesso tic su progetti diversi

- Schema: una formula del modello ricompare identica in testi di committenti diversi, spesso nei testi di riserva dei componenti, che nessuno sovrascrive e restano in produzione.
- Prima: "Bastano due parole: al resto pensiamo noi." sotto un modulo contatti, poi di nuovo altrove.
- Dopo: "Parlaci del tuo progetto e ti diciamo come possiamo aiutarti."
- Regola: prima di scrivere un microcopy, chiediti se l'hai già usato altrove. Se sì, è un tic. Il test Barnum vale anche tra i propri clienti. Done check, punto 7.

### 10. Uniformità su una serie

- Schema: ogni testo della serie è a posto, ma messi in fila sono tutti uguali. In una serie di email a freddo quasi tutti gli oggetti aprivano con "Chi cerca un {professione} di fiducia a {zona}".
- Dopo: ogni oggetto ancorato a un fatto positivo e vero del destinatario, nessun oggetto che condivide le prime due parole con un altro.
- Regola: l'anti-tell si valuta anche sulla serie. Oggetti, incipit o chiuse identici su N pezzi sono un cluster a sé, e sugli oggetti fanno anche da impronta per i filtri antispam. Famiglia 8.

### 11. Inventario di pezzi invece dell'uso

- Schema: una fase di progetto descritta come elenco di componenti separati da virgole, invece di cosa fa e vede chi la userà.
- Prima: "Sul tablet: una scheda per ogni cliente, le tue note, lo storico, l'archivio su server in Europa..."
- Dopo: "Apri la scheda del cliente, scrivi la nota della visita, la volta dopo la ritrovi lì."
- Regola: una fase si racconta con l'uso. Ogni frase su "cosa succede se non funziona" va riletta con gli occhi di chi paga. Famiglia 9.

### 12. Gergo da strumento in una consegna

- Schema: un foglio o un PDF per il destinatario scritto con codici e stati da strumento interno, e decorazione che ripete a colori quello che la colonna accanto dice già.
- Prima: celle come "ERRORE: NOME: il fornitore scrive X, il codice è Y", etichette colorate accanto a ogni riga.
- Dopo: frasi intere e piane, l'esito in una parola nella prima colonna, nessuna etichetta decorativa.
- Regola: rileggi ogni cella come la legge il destinatario. Se serve una legenda per capirla, è scritta male. Famiglia 8.

## Metodo

### 13. Il registro post-humanizer

- Schema: un red team interno ha scritto circa 170 parole di copy per una piccola impresa di servizi che passavano tutto il Done check di allora. Usava i tell che la skill non copriva: sei due punti a cerniera (l'em-dash migrato su ":"), lessico "anti-slop" ("Tradotto:", "Zero sorprese in fattura"), una battuta in chiusura di ogni paragrafo, un richiamo finale all'apertura, sei numeri tondi distribuiti a intervalli regolari.
- Correzione: famiglia 8 estesa (due punti a cerniera con soglia, simmetria di funzione), sezione sul registro post-humanizer in `parole.md`, Done check riformulato sull'irregolarità invece che su una quota fissa. Lo stesso audit ha mostrato l'errore opposto su testi giornalistici umani, segnalati a torto: soglia dei cluster alzata.
- Regola: ogni divieto genera il suo tic sostitutivo. La skill va aggiornata seguendo il registro che emerge, non solo le parole.

### 14. Paragrafi-isola

- Schema: paragrafi giustapposti senza legame, cadenza piatta, connettivi da manuale in testa a ogni blocco.
- Prima: "Inoltre, ... Tuttavia, ... In conclusione, ..."
- Regola: le transizioni le regge la logica del contenuto. Un testo parlato si giudica col ritmo del parlato: un discorso scritto come scaletta suona duro anche quando gli argomenti sono giusti. Famiglie 7 e 8.

### 15. Riscrivere invece di correggere

- Schema: davanti a una correzione su una riga, il testo approvato viene riscritto da capo e perde la voce di chi l'aveva scritto.
- Regola: si corregge la riga indicata col delta minimo. Il campione di voce reale vince sulle regole di default (voice calibration). Se il testo è già dell'autore, l'unico ritocco ammesso toglie ambiguità.

### 16. Autovalutazione

- Schema: chi ha scritto il testo dichiara da solo che "non sa di AI".
- Regola: il verdetto spetta a chi rivede. Dopo quattro o cinque scarti sullo stesso testo ci si ferma e si ripensa l'impianto invece di produrre la sesta variante. Done check, punto 8.

## Come aggiungere un caso

Schema dell'errore, un prima e dopo generici, la regola nata e dove è stata aggiunta (`SKILL.md`, `parole.md`). Riscrivi l'esempio in modo che conservi il problema e non il testo originale: niente nomi, luoghi, settori riconoscibili, citazioni di chi ha rivisto il testo o dettagli sul lavoro.
