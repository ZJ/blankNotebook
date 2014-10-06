#!/bin/sh

cat ./src/template/fullHeader.tex > ./build/buildLabNB.tex
find ./src -mindepth 3 -maxdepth 3 -iname "*.lbnb" -print0 | xargs -0 cat >> ./build/buildLabNB.tex
cat ./build/buildLabNB.tex ./src/template/footer.tex > ./build/fullLabNB.tex
rm ./build/buildLabNB.tex
