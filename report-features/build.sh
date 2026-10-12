#!/bin/sh
set -eu

if ! command -v latexmk >/dev/null 2>&1; then
    printf '%s\n' "latexmk is required to build the PDF (install a TeX distribution with XeLaTeX)." >&2
    exit 1
fi
dejavu_mono=$(kpsewhich DejaVuSansMono.ttf)
if [ -z "$dejavu_mono" ]; then
    printf '%s\n' "DejaVu Sans Mono is required (install the TeX Live DejaVu fonts package)." >&2
    exit 1
fi
dejavu_mono_dir=$(dirname "$dejavu_mono")/

lake exe generate-report
cd _out/tex
export DEJAVU_MONO_DIR="$dejavu_mono_dir"
perl -0pi -e 's#\\setmonofont\{DejaVu Sans Mono\}#\\setmonofont[Path={$ENV{DEJAVU_MONO_DIR}},Extension=.ttf]{DejaVuSansMono}#' main.tex
cp ../../report-style.tex report-style.tex
perl -0pi -e 's#\\begin\{document\}#\\input{report-style.tex}\n\\begin{document}#; s#\\begin\{titlingpage\}#\\begin{titlingpage}\n\\ReportCoverArt#' main.tex
latexmk -xelatex -interaction=nonstopmode -halt-on-error main.tex