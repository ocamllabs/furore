#!/bin/sh -ex

docker build -t furore-local .

RUN="docker run -w /mnt -v `pwd`:/mnt furore-local pandoc"

# docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
${RUN} --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html
${RUN} --toc -f markdown -S yearly/intro.md `cat YEARS.txt` --css github-pandoc.css -o output/yearly.html
${RUN} --toc --epub-cover-image=graphics/origami-camel.png -f markdown yearly/intro.md `cat YEARS.txt` -t epub -o output/yearly.epub
