#!/bin/sh

cd resources;

## Downloading reference genome (hg38) via GATK
wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.fasta.gz
gzip -d Homo_sapiens_assembly38.fasta.gz

## Creating the fasta index file
gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai .
# OR use: samtools Homo_sapiens_assembly38.fasta
