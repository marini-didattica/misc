// Compile from the misc repository root:
// typst compile --root . esercitazioni-seconde/esercitazione-1.typ
#import "../typst-theme/src/lib.typ": theme
#import "../typst-components/src/lib.typ": cover, esercizio, lettura, nota, template, esempi, callout, checklist, consegna

#set document(title: "Verifica di informatica — Simulazione 1", author: "Marini Mattia")
#show: doc => theme(doc, footer-text: "Verifica di informatica")

#cover(
  top: "LICEO RUSSELL · INFORMATICA · CLASSE SECONDA",
  title: "Simulazione verifica 1",
  subtitle: "Produzione e lettura di codice con liste in Python",
  decoration: auto,
  descriptors: (
    ("Durata", "90 minuti"),
    ("Punteggio", "110 punti"),
    ("Produzione", "80 punti"),
    ("Lettura", "30 punti"),
  ),
  student-data: ("nome", "cognome", "classe", "data"),
  body: [
    #callout("Istruzioni")[
      - La prova è divisa in due parti: *produzione del codice* (80 punti) e *lettura del codice* (30 punti).
      - Per la produzione scrivi un file separato per ogni esercizio (`es1.py` … `es5.py`), eseguilo e verifica il risultato con gli esempi.
      - Nella lettura spiega a parole che cosa fa ogni frammento e, se stampa qualcosa, riporta anche l'output; non riscrivere il codice.
      - Sono valutati la correttezza, la gestione dei casi limite e la chiarezza del codice.
      - Non è consentito consultare appunti, libri o Internet. E' possibile usare il *cheatsheet* Python al link #link("https://marini-didattica.github.io/misc/cheatsheet-prime/python-intro.pdf")[https://marini-didattica.github.io/misc/cheatsheet-prime/python-intro.pdf]
    ]

    #v(0.65cm)

    #table(
      columns: (auto, 1fr, auto),
      inset: (x: 9pt, y: 6pt),
      align: (left, left, right),
      stroke: 0.5pt + luma(215),
      table.header([*Parte*], [*Contenuto*], [*Punti*]),
      [1], [Produzione del codice — cinque esercizi], [80],
      [2], [Lettura del codice — cinque frammenti], [30],
      table.cell(colspan: 2, align: right)[*Totale*], [*110*],
    )

    #v(3pt)
    #text(size: 8.5pt, fill: luma(120), style: "italic")[
      Il punteggio delle singole voci è riportato accanto a ciascun esercizio.
    ]
  ],
)

// ============================================================
//  PARTE 1 — PRODUZIONE DEL CODICE
// ============================================================

#pagebreak()

= Produzione del codice (80 punti)

Per ciascun esercizio scrivi un file separato (`es1.py` … `es5.py`), eseguilo e verifica il risultato con gli esempi. Il programma deve stampare *soltanto* il risultato richiesto.

#checklist("Prima di consegnare", (
  [Il programma stampa *solo* il risultato richiesto, senza messaggi in più?],
  [Hai provato i casi limite: lista vuota, un solo elemento, valori duplicati, numeri negativi?],
  [I nomi delle variabili sono chiari e il codice è rientrato in modo corretto?],
  [Ogni esercizio è nel suo file `es1.py` … `es5.py`?],
))

E' *fondamentale* che il programma funzioni per qualsiasi lista gli venga data: le soluzioni valide solo per l'esempio valgono *0 punti*.

#v(1.5em)

#esercizio(1, [Posizioni alternate], 12, 1)[
  #consegna[Data la lista `l`, stampa gli elementi che occupano le posizioni 0, 2, 4, … separati da uno spazio. Le posizioni si contano da 0.]

  #nota[Con `[1, 2, 3, 4, 5]` l'output è `1 3 5`. Puoi stampare mentre scorri la lista.]

  #template[
    ```python
    l = [1, 2, 3, 4, 5]

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [1, 2, 3, 4, 5]`], [`1 3 5`], [Si parte dalla posizione `0` e si salta una posizione.]),
    ([`l = [10, 20, 30]`], [`10 30`], [Gli elementi in posizione `0` e `2`.]),
    ([`l = []`], [nessun output], [Una lista vuota non stampa nulla.]),
  ))
]

#v(1.5em)

#esercizio(2, [Inversione in place], 16, 2)[
  #consegna[Inverti la lista `l` *senza usare una lista ausiliaria*. Alla fine stampa `l`.]

  #nota[Non usare `reverse()`, `reversed()` o `l[::-1]`: scambia l'elemento in posizione `0` con l'ultimo, poi `1` con il penultimo, e così via.]

  #template[
    ```python
    l = [1, 2, 3, 4, 5]

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [1, 2, 3, 4, 5]`], [`[5, 4, 3, 2, 1]`], [Gli estremi vengono scambiati fino al centro.]),
    ([`l = [1, 2]`], [`[2, 1]`], [Un solo scambio.]),
    ([`l = [7]`], [`[7]`], [Una lista con un solo elemento resta uguale.]),
  ))
]

#v(1.5em)

#esercizio(3, [Palindroma], 16, 2)[
  #consegna[Stabilisci se la lista `l` è *palindroma*: si legge allo stesso modo da sinistra a destra e da destra a sinistra. Stampa `True` oppure `False`.]

  #nota[Una lista vuota e una lista con un solo elemento sono palindrome. Confronta gli elementi agli estremi e avvicinati al centro.]

  #template[
    ```python
    l = [1, 2, 3, 2, 1]

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [1, 2, 3, 2, 1]`], [`True`], [La sequenza è simmetrica.]),
    ([`l = [1, 2, 3]`], [`False`], [Gli estremi `1` e `3` sono diversi.]),
    ([`l = []`], [`True`], [Non c'è nessuna coppia da confrontare.]),
  ))
]

#v(1.5em)

#esercizio(4, [Secondo più grande], 18, 3)[
  #consegna[Trova e stampa il secondo valore più grande della lista `l`. La lista contiene almeno due valori distinti.]

  #nota[Se il massimo compare più volte, considera il valore distinto successivo: in `[5, 5, 3]` il secondo più grande è `3`.]

  #template[
    ```python
    l = [1, 2, 3, 4, 5]

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [1, 2, 3, 4, 5]`], [`4`], [Il massimo è `5`, il valore successivo è `4`.]),
    ([`l = [5, 5, 3]`], [`3`], [Il massimo compare due volte, ma il secondo valore distinto è `3`.]),
    ([`l = [-3, -1, -7]`], [`-3`], [Il massimo è `-1`, il secondo è `-3`.]),
  ))
]

#v(1.5em)

#esercizio(5, [Rimuovi i negativi], 18, 3)[
  #consegna[Modifica `l` rimuovendo tutti i numeri negativi. Alla fine stampa `l`. Lo zero va mantenuto.]

  #nota[Puoi modificare la lista originale oppure costruirne una nuova, purché alla fine `l` contenga solo i valori non negativi.]

  #template[
    ```python
    l = [3, -2, 0, -7, 5]

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [3, -2, 0, -7, 5]`], [`[3, 0, 5]`], [Vengono eliminati `-2` e `-7`; lo `0` resta.]),
    ([`l = [-1, -2, -3]`], [`[]`], [Tutti gli elementi sono negativi.]),
    ([`l = [0, 1, 2]`], [`[0, 1, 2]`], [Non ci sono numeri negativi da rimuovere.]),
  ))
]

// ============================================================
//  PARTE 2 — LETTURA DEL CODICE
// ============================================================

#pagebreak()

= Lettura del codice (30 punti)

Per ciascun frammento di codice spiega a parole che cosa fa e, se il programma stampa qualcosa, riporta anche l'output. Non devi riscrivere il codice o eseguirne la traccia; va dimostrato di averne compreso l'intento, descrivendone il funzionamento.

#v(1.5em)

#lettura(1, [Primo frammento], 6, 2, 3)[
  ```python
  v = [2, 4, 5, 3, 8]
  crescente = True
  i = 1
  while i < len(v):
      if v[i] < v[i - 1]:
          crescente = False
      i = i + 1
  print(crescente)
  ```
]

#v(1.5em)

#lettura(2, [Secondo frammento], 6, 2, 3)[
  ```python
  v = [4, 8, 6, 10]
  somma = 0
  for x in v:
      somma = somma + x
  media = somma / len(v)
  for x in v:
      if x > media:
          print(x)
  ```
]

#v(1.5em)

#lettura(3, [Terzo frammento], 6, 1, 3)[
  ```python
  v = [4, 9, 1, 7]
  massimo = v[0]
  minimo = v[0]
  i = 1
  while i < len(v):
      if v[i] > massimo:
          massimo = v[i]
      if v[i] < minimo:
          minimo = v[i]
      i = i + 1
  print(massimo)
  print(minimo)
  ```
]

#v(1.5em)

#lettura(4, [Quarto frammento], 6, 3, 3)[
  ```python
  v = [3, 4, 1, 2, 3, 0]
  best = 1
  cur = 1
  i = 1
  while i < len(v):
      if v[i] > v[i - 1]:
          cur = cur + 1
          if cur > best:
              best = cur
      else:
          cur = 1
      i = i + 1
  print(best)
  ```
]

#v(1.5em)

#lettura(5, [Quinto frammento], 6, 3, 3)[
  ```python
  v = [1, 2, 3, 4, 5]
  k = 6
  count = 0
  i = 0
  while i < len(v):
      j = i + 1
      while j < len(v):
          if v[i] + v[j] == k:
              count = count + 1
          j = j + 1
      i = i + 1
  print(count)
  ```
]
