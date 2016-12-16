FROM debian
RUN apt-get update
RUN apt-get -y install texlive pandoc texlive-xetex texlive-fonts-extra
COPY * /mnt/
WORKDIR /mnt
RUN pandoc -f markdown intro.md -o report.pdf
