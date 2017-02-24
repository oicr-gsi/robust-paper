LATEX=pdflatex 
BIBTEX=bibtex
ROBU=robust-software
CHK=robust-checks
FINAL=Robust-Paper_PLOS_CopyEdit

all : commands

## commands   : show all commands.
commands :
	@grep -E '^##' Makefile | sed -e 's/## //g'

## pdf        : re-generate PDF
pdf :
	${LATEX} ${ROBU}
	${BIBTEX} ${ROBU}
	${LATEX} ${ROBU}
	${LATEX} -output-directory=dist ${ROBU}
	${LATEX} -jobname=S1_Checklist ${CHK}
	${LATEX} -jobname=S1_Checklist -output-directory=dist ${CHK}

## final      : generate PLOS-compliant tex file
final :
	${LATEX} ${ROBU}
	${BIBTEX} ${ROBU}
	${LATEX} ${ROBU}
	${LATEX} ${ROBU}
	@cp robust-software.tex ${FINAL}.tex
	#replace the external bibliography with the contents from the bbl file
	@sed -e '/\\bibliography{${ROBU}}/ {' -e 'r ${ROBU}.bbl' -e 'd' -e '}' -i ${FINAL}.tex
	${LATEX} ${FINAL}
	${LATEX} -output-directory=dist ${FINAL}

## build      : build HTML files.
build : 
	jekyll build

## clean      : clean up junk files.
clean :
	@rm -rf _site
	@find . -name '*~' -exec rm {} \;
	@find . -name '*.aux' -exec rm {} \;
	@find . -name '*.bak' -exec rm {} \;
	@find . -name '*.bbl' -exec rm {} \;
	@find . -name '*.blg' -exec rm {} \;
	@find . -name '*.dvi' -exec rm {} \;
	@find . -name '*.log' -exec rm {} \;
	@find . -name '*.out' -exec rm {} \;
	@find . -name .DS_Store -exec rm {} \;
	@find . -maxdepth 1 -name '*.pdf' -exec rm {} \; #only remove pdfs from root dir, not subdirs
