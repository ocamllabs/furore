#!/bin/sh -ex

eval `ssh-agent -s`
chmod 600 furore_id_rsa
ssh-add furore_id_rsa

docker pull ocamllabs/furore
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown intro.md -o output/report.pdf
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc --toc -f markdown intro.md -t html5 --css github-pandoc.css -o output/index.html

cd output
git init
git checkout -b gh-pages
git add *
git commit -m sync -a
git remote add origin git@github.com:ocamllabs/furore
git push -u origin +gh-pages
