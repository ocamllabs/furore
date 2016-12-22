#!/bin/sh -ex

docker build -t furore-local .

RUN="docker run -w /mnt -v `pwd`:/mnt furore-local"

# docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
${RUN} sh -c "cd weekly && rm -f weekly.ml.exe && opam config exec -- ./weekly.ml > weekly.md"
${RUN} pandoc --toc -f markdown weekly/intro.md /weekly/weekly.md -t html5 --css github-pandoc.css -o output/weekly.html
${RUN} pandoc --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html
${RUN} pandoc --toc -f markdown -S yearly/intro.md `cat YEARS.txt` --css github-pandoc.css -o output/yearly.html
${RUN} pandoc --toc --epub-cover-image=graphics/origami-camel.png -f markdown yearly/intro.md `cat YEARS.txt` -t epub -o output/yearly.epub
${RUN} pandoc --toc --epub-cover-image=graphics/origami-camel.png -f markdown weekly/intro.md weekly/weekly.md -t epub -o output/weekly.epub
