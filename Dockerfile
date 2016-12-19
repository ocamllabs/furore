FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install pandoc 
#RUN apt-get -y texlive texlive-xetex texlive-fonts-extra
#COPY * /mnt/
#RUN pandoc -f markdown intro.md -o report.pdf
