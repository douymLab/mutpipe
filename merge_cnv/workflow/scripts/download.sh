#!/bin/sh

cd resources;

## Creating the fasta index file
gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai .
# OR use: samtools Homo_sapiens_assembly38.fasta
awk -F "\\t" '{if(length($1)<=5 && $1!="chrM") print}' Homo_sapiens_assembly38.fasta.fai | sed 's/chr//g' > hg38_len.txt   


