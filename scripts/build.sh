#!/bin/sh -ex

docker build -t furore-local .
# docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html

YEARS="2014 2013"

for y in ${YEARS}; do
  docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/$y.md -t html5 --css github-pandoc.css -o output/$y.html
  docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/$y.md -t epub -o output/$y.epub
done
