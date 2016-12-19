#!/bin/sh -ex

docker build -t furore-local .
# docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html
docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/2015.md -t html5 --css github-pandoc.css -o output/2015.html
docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/2015.md -t epub -o output/2015.epub
