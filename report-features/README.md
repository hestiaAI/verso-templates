# A Formal Verso Report

A structured report starter built with Verso's Manual genre. It includes report metadata, an
executive summary, automatically numbered sections, recommendations, references, and appendices.
Both website and PDF editions use a coordinated teal, coral, and gold geometric motif with a ring,
diamond planes, and a dotted grid.

Replace the sample title, metadata, and prompts with your report content.

Build the multi-page website and PDF with Lean 4 and TeX Live (including `latexmk`, XeLaTeX, and the
DejaVu fonts package) installed:
```
lake build
sh build.sh
```

The generated website is in `_out/html-multi/`. The PDF is `_out/tex/main.pdf`; the TeX source is
kept alongside it. Serve `_out/html-multi/` with a local web server to view the website.