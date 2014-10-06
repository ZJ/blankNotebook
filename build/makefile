all: fullLabNB.pdf

fullLabNB.tex: ../src/template/fullHeader.tex ../src/template/footer.tex ../src/20*/*/*.lbnb
	cat ../src/template/fullHeader.tex > /tmp/buildLabNB.tex
	find ../src -mindepth 3 -maxdepth 3 -iname "*.lbnb" -print0 | xargs -0 cat >> /tmp/buildLabNB.tex
	cat /tmp/buildLabNB.tex ../src/template/footer.tex > fullLabNB.tex
	
fullLabNB.pdf: fullLabNB.tex
	pdflatex --interaction=batchmode --shell-escape --synctex=1 fullLabNB
	pdflatex --interaction=batchmode --shell-escape --synctex=1 fullLabNB
