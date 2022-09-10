#!/bin/sh

cd resources;

## Download FASTA sequence of each chromosome and decompress
wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/*'
for i in {1..22} 'X' 'Y'
        do
                gzip tar -xzvf chr$i.fa.gz
        done


## Compute genome mappability (hg38) via GenMap
### Download the index for hg38
wget http://ftp.imp.fu-berlin.de/pub/cpockrandt/genmap/indices/grch38-no-alt.tar.gz
gzip -d  grch38-no-alt.tar.gz
