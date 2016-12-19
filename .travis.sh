#!/bin/sh -ex

docker pull ocamllabs/furore
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown 01-intro.md -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown 01-intro.md -t html5 --css github-pandoc.css -o output/index.html
