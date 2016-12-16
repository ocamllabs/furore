#!/bin/sh -ex

eval `ssh-agent -s`
chmod 600 furore_id_rsa
ssh-add furore_id_rsa

docker pull ocamllabs/furore
rm -rf output
mkdir output
docker run -w /mnt -v `pwd`:/mnt ocamllabs/furore pandoc -f markdown intro.md -o output/report.pdf

cd output
git init
git add *
git commit -m sync -a
git remote add git@github.com:ocamllabs/furore
git push origin +gh-pages
