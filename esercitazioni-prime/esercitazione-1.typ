#let ink = rgb("#212630")
#let accent = rgb("#3e63dd")
#let accent-scuro = rgb("#2c46b8")
#let tinta = rgb("#eef3fd")
#let ambra = rgb("#e9a13b")
#let ambra-scuro = rgb("#a86508")
#let ambra-tinta = rgb("#fdf3e2")
#let codice-bg = rgb("#f4f5f7")
#let mono = "DejaVu Sans Mono"

#set document(title: "Verifica di informatica — Simulazione 1", author: "Marini Mattia")
#set page(
  paper: "a4",
  margin: (top: 2.1cm, bottom: 2.4cm, x: 2.2cm),
  footer: context [
    #set text(size: 8.5pt, fill: luma(140))
    #stack(
      dir: ttb,
      spacing: 7pt,
      line(length: 100%, stroke: 0.5pt + luma(225)),
      align(center)[Verifica di informatica #h(10pt)·#h(10pt) #counter(page).display()],
    )
  ],
)
#set text(lang: "it", region: "IT", size: 11pt, fill: ink)
#set par(justify: true)
#set heading(numbering: "1.")
#set list(marker: (text(fill: accent)[•],), indent: 1em, spacing: 0.7em)
#set raw(tab-size: 4)

#show raw.where(block: true): it => block(
  width: 100%,
  fill: codice-bg,
  radius: 4pt,
  inset: (x: 10pt, y: 9pt),
  outset: (y: 3pt),
  stroke: none,
)[#it]
#show raw.where(block: false): it => box(
  fill: codice-bg,
  inset: (x: 3pt, y: 1pt),
  outset: (y: 2pt),
  radius: 3pt,
)[#it]

#show heading.where(level: 1): it => block(above: 1.4em, below: 1em, width: 100%)[
  #stack(
    dir: ttb,
    spacing: 0.35em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 9pt,
      align: horizon,
      box(fill: accent, inset: (x: 7pt, y: 4pt), radius: 4pt, baseline: 32%)[
        #text(fill: white, weight: 800, size: 12pt)[#counter(heading).display()]
      ],
      text(size: 17pt, weight: 800, fill: ink)[#it.body],
    ),
    line(length: 100%, stroke: 2.2pt + accent),
  )
]

#let etichetta(txt) = text(size: 7.6pt, weight: 700, tracking: 0.14em, fill: luma(118))[#upper(txt)]

#let stella(pieno: true, dim: 0.78em, col: ambra) = {
  let r = dim / 2
  let pts = ()
  for i in range(10) {
    let a = 90deg - i * 36deg
    let rad = if calc.rem(i, 2) == 0 { r } else { r * 0.42 }
    pts.push((r + rad * calc.cos(a), r - rad * calc.sin(a)))
  }
  box(baseline: 40%)[
    #polygon(fill: if pieno { col } else { none }, stroke: 1pt + col, ..pts)
  ]
}

#let stelle(n) = box(baseline: 40%)[
  #for i in range(5) {
    if i > 0 { h(2pt) }
    stella(pieno: i < n)
  }
]

#let bitbox(v) = box(
  width: 1.55em,
  height: 1.55em,
  inset: 0pt,
  radius: 3pt,
  fill: if v == "1" { accent } else { white },
  stroke: 0.9pt + luma(185),
)[#align(center + horizon)[#text(
  font: (mono,),
  size: 0.9em,
  weight: 700,
  fill: if v == "1" { white } else { luma(120) },
)[#v]]]

#let righe-risposta(n) = grid(
  columns: 1,
  row-gutter: 16pt,
  ..range(n).map(_ => line(
    length: 100%,
    stroke: (paint: luma(195), thickness: 0.6pt, dash: "dotted"),
  )),
)

// Etichetta + contenuto, con uno spazio piccolo e coerente fra i due.
#let sezione(titolo, corpo) = stack(
  dir: ttb,
  spacing: 0.5em,
  etichetta(titolo),
  corpo,
)

#let nota(corpo) = block(
  width: 100%,
  fill: ambra-tinta,
  stroke: (left: 2.6pt + ambra),
  radius: (top-right: 3pt, bottom-right: 3pt),
  inset: (x: 10pt, y: 7pt),
)[
  #text(fill: ambra-scuro, weight: 700)[Nota.] #corpo
]

#let template(codice) = block(breakable: false)[
  #sezione("Template di partenza", codice)
]

#let esempi(righe) = block(breakable: false)[
  #sezione(
    "Esempi di input e output",
    table(
      columns: (auto, auto, 1fr),
      inset: (x: 8pt, y: 5pt),
      align: (left, left, left),
      stroke: 0.5pt + luma(215),
      table.header([*Input*], [*Output*], [*Spiegazione*]),
      ..righe.flatten(),
    ),
  )
]

#let domanda(n, titolo, punti, righe, corpo) = block(
  breakable: false,
  width: 100%,
)[
  #stack(
    dir: ttb,
    spacing: 0.9em,
    block(
      width: 100%,
      fill: tinta,
      radius: (top-right: 3pt, bottom-right: 3pt),
      inset: 8pt,
      stroke: (left: 2.6pt + accent),
    )[
      #grid(
        columns: (auto, 1fr, auto),
        column-gutter: 8pt,
        align: horizon,
        box(fill: accent, inset: (x: 6pt, y: 2.5pt), radius: 999pt)[
          #text(fill: white, size: 0.78em, weight: 700)[Domanda #n]
        ],
        text(weight: 700, size: 12pt, fill: ink)[#titolo],
        text(weight: 700, fill: accent-scuro)[#punti punti],
      )
    ],
    corpo,
    righe-risposta(righe),
  )
]

#let esercizio(n, titolo, punti, diff, corpo) = [
  #block(
    width: 100%,
    fill: tinta,
    radius: (top-right: 3pt, bottom-right: 3pt),
    inset: 8pt,
    stroke: (left: 2.6pt + accent),
    below: 0.9em,
  )[
    #grid(
      columns: (auto, 1fr, auto, auto),
      column-gutter: 8pt,
      align: horizon,
      box(fill: accent, inset: (x: 6pt, y: 2.5pt), radius: 999pt)[
        #text(fill: white, size: 0.78em, weight: 700)[Esercizio #n]
      ],
      text(weight: 700, size: 12pt, fill: ink)[#titolo],
      stelle(diff),
      text(weight: 700, fill: accent-scuro)[#punti punti],
    )
  ]
  #corpo
]

#let lettura(n, titolo, punti, diff, righe, corpo) = block(
  breakable: false,
  width: 100%,
)[
  #stack(
    dir: ttb,
    spacing: 0.9em,
    block(
      width: 100%,
      fill: tinta,
      radius: (top-right: 3pt, bottom-right: 3pt),
      inset: 8pt,
      stroke: (left: 2.6pt + accent),
    )[
      #grid(
        columns: (auto, 1fr, auto, auto),
        column-gutter: 8pt,
        align: horizon,
        box(fill: accent, inset: (x: 6pt, y: 2.5pt), radius: 999pt)[
          #text(fill: white, size: 0.78em, weight: 700)[Snippet #n]
        ],
        text(weight: 700, size: 12pt, fill: ink)[#titolo],
        stelle(diff),
        text(weight: 700, fill: accent-scuro)[#punti punti],
      )
    ],
    corpo,
    righe-risposta(righe),
  )
]

#let campo(nome) = stack(
  dir: ttb,
  spacing: 0.4em,
  etichetta(nome),
  line(length: 100%, stroke: 0.6pt + luma(170)),
)

#let dato(titolo, valore) = stack(
  dir: ttb,
  spacing: 0.6em,
  etichetta(titolo),
  text(weight: 800, fill: accent)[#valore],
)

// ============================================================
//  COPERTINA
// ============================================================

#page(footer: none)[
  #align(center)[
    #v(0.7cm)
    #text(size: 9pt, weight: 700, tracking: 0.18em, fill: accent)[
      LICEO RUSSELL · INFORMATICA · CLASSE PRIMA
    ]
    #v(11pt)
    #text(size: 28pt, weight: 800, fill: ink)[Verifica di informatica]
    #v(2pt)
    #text(size: 14pt, fill: luma(110))[Simulazione 1 — Teoria, scrittura e lettura del codice]
    #v(0.55cm)
    #box(baseline: 30%)[
      #for (i, b) in ("0", "1", "0", "1", "1", "0", "0", "1").enumerate() {
        if i > 0 { h(3pt) }
        bitbox(b)
      }
    ]
    #v(0.6cm)
  ]

  #block(
    width: 100%,
    fill: white,
    stroke: 0.7pt + luma(218),
    radius: 4pt,
    inset: (x: 11pt, y: 9pt),
  )[
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      align: (center, center, center, center, center),
      dato("Durata", "60 minuti"),
      dato("Punteggio", "110 punti"),
      dato("Teoria", "20 punti"),
      dato("Scrittura", "60 punti"),
      dato("Lettura", "30 punti"),
    )
  ]

  #v(0.75cm)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 18pt,
    row-gutter: 28pt,
    campo("Nome"), campo("Cognome"),
    campo("Classe"), campo("Data"),
  )

  #v(0.7cm)

  #block(
    width: 100%,
    fill: tinta,
    stroke: (left: 2.6pt + accent),
    radius: (top-right: 4pt, bottom-right: 4pt),
    inset: (x: 11pt, y: 9pt),
  )[
    #stack(
      dir: ttb,
      spacing: 0.6em,
      text(weight: 800, fill: accent-scuro, size: 11.5pt)[Istruzioni],
      [
        - La prova è divisa in tre parti: *teoria* (20 punti), *scrittura del codice* (60 punti) e *lettura del codice* (30 punti).
        - Rispondi alle domande di teoria in modo *sintetico ma completo*, usando le righe a disposizione.
        - Per la parte di produzione del codice scrivi i programmi in *Python*, uno per esercizio. Sono valutati la correttezza, la gestione dei casi limite e la chiarezza del codice.
        - Non è consentito consultare appunti, libri o Internet. E' possibile usare il *cheatsheet* scaricabile al link #link("https://marini-didattica.github.io/misc/cheatsheet-prime/python-intro.pdf")[https://marini-didattica.github.io/misc/cheatsheet-prime/python-intro.pdf]
      ],
    )
  ]

  #v(0.65cm)

  #table(
    columns: (auto, 1fr, auto),
    inset: (x: 9pt, y: 6pt),
    align: (left, left, right),
    stroke: 0.5pt + luma(215),
    table.header([*Parte*], [*Contenuto*], [*Punti*]),
    [1], [Teoria — tre domande a risposta aperta], [20],
    [2], [Scrittura del codice — tre esercizi di programmazione], [60],
    [3], [Lettura del codice — tre brevi programmi], [30],
    table.cell(colspan: 2, align: right)[*Totale*], [*110*],
  )

  #v(3pt)
  #text(size: 8.5pt, fill: luma(120), style: "italic")[
    Il punteggio delle singole voci è riportato accanto a ciascuna domanda e a ciascun esercizio.
  ]
]

// ============================================================
//  PARTE 1 — TEORIA
// ============================================================

#pagebreak()

= Teoria (20 punti)

Rispondi in modo breve e preciso, usando le righe sotto ogni domanda.

#v(1.5em)

#domanda(1, [Le componenti di un computer], 7, 6)[
  Descrivi brevemente quali sono le principali componenti di un personal computer e qual è lo scopo di ciascuna.

  #nota[Una o due frasi per componente sono sufficienti. Nomina almeno *cinque* componenti diverse.]
]

#v(1.5em)

#domanda(2, [Numeri, caratteri e parole], 8, 7)[
  Descrivi brevemente come vengono immagazzinati i numeri in un computer. Come si possono salvare caratteri e parole?

]

#v(1.5em)

#domanda(3, [Istruzioni e instruction set], 5, 5)[
  Che cos'è un'*istruzione* di un processore? Come viene rappresentata? Cosa si intende quando di parla di *instruction set*?

  #nota[Accenno ad *assembly* = punti extra]
]

// ============================================================
//  PARTE 2 — SCRITTURA DEL CODICE
// ============================================================


= Scrittura del codice (60 punti)

Per ciascun esercizio scrivi un file separato (`es1.py`, `es2.py`, `es3.py`), eseguilo e verifica il risultato con gli esempi. Il programma deve stampare *soltanto* il risultato richiesto.

#block(
  breakable: false,
  width: 100%,
  fill: tinta,
  stroke: 0.6pt + luma(222),
  radius: 4pt,
  inset: 10pt,
)[
  #stack(
    dir: ttb,
    spacing: 0.6em,
    text(weight: 800, fill: accent-scuro)[Prima di consegnare],
    [
      - Il programma stampa *solo* il risultato richiesto, senza messaggi in più?
      - Hai provato i casi limite: `n = 0`, lista vuota e così via?
      - I nomi delle variabili sono chiari e il codice è rientrato in modo corretto?
      - Ogni esercizio di programmazione è nel suo file `es1.py`, `es2.py`, `es3.py`?
    ],
  )
]

E' *fondamentale* che il programma funzioni per qualsiasi input gli venga dato. Gli esercizi che sono strutturati per funzionare solo su input specifici verranno valutati *0 punti*. Ad esempio, se venisse chiesto di stampare tutti i numeri contenuti in una lista, uno ad uno, allora il seguente esercizio varrebbe zero punti:
```python
l = [1,2,3]
print(l[0])
print(l[1])
print(l[2])
```




#v(1.5em)

#esercizio(1, [Conta i numeri pari], 10, 1)[
  #text(weight: 700, fill: accent-scuro)[Consegna.] Dato un intero `n` maggiore o uguale a `0`, conta i numeri pari fra `0` e `n`, estremi inclusi, e stampa un solo numero: il conteggio trovato.

  #nota[
    Viene richiesto di contare _quanti numeri pari_ ci sono fra 0 e n, non di stamparli. Ricorda che un numero è pari se `x % 2 == 0`.
  ]

  #template[
    ```python
    n = 7

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`n = 0`], [`1`], [L'unico numero dell'intervallo è `0`, che è pari.]),
    ([`n = 7`], [`4`], [I pari sono `0, 2, 4, 6`.]),
    ([`n = 10`], [`6`], [I pari sono `0, 2, 4, 6, 8, 10`: anche `n` va contato.]),
  ))
]

#v(1.5em)

#esercizio(2, [La somma da 0 a n], 20, 2)[
  #text(weight: 700, fill: accent-scuro)[Consegna.] Dato un intero `n` maggiore o uguale a `0`, calcola e stampa la somma degli interi da `0` a `n`, estremi inclusi. `n` è già nella variabile `n`.

  #nota[
    `n` deve essere  *incluso* nella somma: con `n = 5` la somma è `15`
  ]

  #template[
    ```python
    n = 10

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`n = 0`], [`0`], [L'intervallo contiene solo lo `0`, che non cambia la somma.]),
    ([`n = 5`], [`15`], [`0 + 1 + 2 + 3 + 4 + 5 = 15`.]),
    ([`n = 100`], [`5050`], [La somma di tutti gli interi da `0` a `100`.]),
  ))
]

#v(1.5em)

#esercizio(3, [Tutti dentro l'intervallo], 30, 3)[
  #text(weight: 700, fill: accent-scuro)[Consegna.] Date la lista `l` e gli interi `a` e `b`, stampa `True` se *tutti* gli elementi di `l` sono fra `a` e `b`, estremi inclusi, altrimenti `False`. Se `l` è vuota, stampa `True`. Le variabili `l`, `a` e `b` sono già nel template.

  #nota[
    *Non è detto che `a < b`.* Con `a = 10` e `b = 1` l'intervallo è `[1, 10]`; non basta controllare che `x` sia compreso fra `a` e `b`.
  ]

  #template[
    ```python
    l = [3, 5, 7, 12]
    a = 1
    b = 10

    # scrivi qui il tuo codice
    ```
  ]

  #esempi((
    ([`l = [3, 5, 7]` \ `a = 1`, `b = 10`], [`True`], [Tutti i valori stanno fra `1` e `10`.]),
    (
      [`l = [3, 5, 7]` \ `a = 10`, `b = 1`],
      [`True`],
      [Gli estremi sono invertiti, ma l'intervallo è sempre `[1, 10]`.],
    ),
    ([`l = [-4, 0, 2, 9]` \ `a = 2`, `b = -4`], [`False`], [L'intervallo è `[-4, 2]`, ma `9` è fuori.]),
  ))
]

// ============================================================
//  PARTE 3 — LETTURA DEL CODICE
// ============================================================

#pagebreak()

= Lettura del codice (30 punti)

Per ciascun frammento di codice spiega a parole che cosa fa e, se il programma stampa qualcosa, riporta anche l'output. Non devi riscrivere il codice o eseguirne la traccia; va dimostrato di averne compreso l'intento che ne sta dietro, descrivendone il funzionamento

#v(1.5em)

#lettura(1, [Primo frammento], 10, 2, 3)[
  ```python
  v = [3, 7, 1, 9]
  i = len(v) - 1
  while i >= 0:
      print(v[i])
      i = i - 1
  ```
]

#v(1.5em)

#lettura(2, [Secondo frammento], 10, 2, 3)[
  Le variabili `a` e `b` contengono due numeri. Cosa succede ai valori delle due variabili durante l'esecuzione del programma?
  ```python
  a = 5
  b = 8
  c = a
  a = b
  b = c
  print(a, b)
  ```
]

#v(1.5em)

#lettura(3, [Terzo frammento], 10, 2, 4)[
  ```python
  n = 10
  i = 0
  while i <= n:
      if i % 2 == 0:
          print(i)
      i = i + 1
  ```
]
