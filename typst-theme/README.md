# typst-theme

Shared colours, typography, page setup, code-block styling and heading style
for the Liceo Russell Typst materials.

```typ
#import "../typst-theme/src/lib.typ": theme

#show: doc => theme(doc, footer-text: "Verifica di informatica")
```

The package exports `palette`, `font-mono`, `etichetta` and `theme`.

Links are rendered as inline monospace “verb” chips: code background, thin
border, and accent-coloured text, while remaining clickable.

Compile documents from the `misc` repository root so the shared packages are
inside Typst's project sandbox:

```sh
typst compile --root . esercitazioni-prime/esercitazione-1.typ
```
