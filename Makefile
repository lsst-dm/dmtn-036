export TEXMFHOME ?= lsst-texmf/texmf

DMTN-036.pdf: *.tex
	latexmk -xelatex -bibtex -f DMTN-036.tex

