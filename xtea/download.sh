#!/bin/sh

cd resources;

## Downloading reference genome (hg38) via GATK
wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.fasta.gz
gzip -d Homo_sapiens_assembly38.fasta.gz

## Creating the FASTA sequence dictionary file
gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict .
#Or use: gatk-launch CreateSequenceDictionary -R Homo_sapiens_assembly38.fasta

## Creating the fasta index file
gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai .
# OR use: samtools Homo_sapiens_assembly38.fasta

## Downloading Comprehensive gene annotation
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_33/gencode.v33.annotation.gff3.gz

## Downloading pre-processed repeat library used by xTea
mkdir rep_lib_annotation
wget https://github.com/parklab/xTea/raw/master/rep_lib_annotation.tar.gz
tar -zxvf rep_lib_annotation.tar.gz -C rep_lib_annotation
