#!/bin/sh

cd resources;

## Creating the fasta index file
gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai .
# OR use: samtools Homo_sapiens_assembly38.fasta