#!/bin/sh -ex

docker pull ocamllabs/furore
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown `cat CHAPTERS.txt` -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown `cat CHAPTERS.txt` -t html5 --css github-pandoc.css -o output/index.html
