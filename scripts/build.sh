#!/bin/sh -ex

docker build -t furore-local .
# docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html

#for y in `cat YEARS.txt`; do
#  docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/$y.md -t html5 --css github-pandoc.css -o output/$y.html
#  docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/$y.md -t epub -o output/$y.epub
#done

docker run -w /mnt -v `pwd`:/mnt furore-local pandoc --toc -f markdown yearly/intro.md yearly/2014.md yearly/2013.md --css github-pandoc.css -o output/yearly.html
