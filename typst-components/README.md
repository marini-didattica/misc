# typst-components

Reusable blocks for the Liceo Russell Typst materials, built on top of
`typst-theme`.

Main exports:

- `cover`
- `domanda`
- `esercizio`
- `lettura`
- `nota`, `template`, `esempi`
- `callout`, `checklist`, `consegna`
- `stelle`, `righe-risposta`

```typ
#import "../typst-components/src/lib.typ": cover, domanda, esercizio

#cover(
  title: "Simulazione verifica 1",
  descriptors: (("Durata", "80 minuti"),),
)
```

Compile from the `misc` repository root with `--root .` so the components can
import the sibling theme package.
