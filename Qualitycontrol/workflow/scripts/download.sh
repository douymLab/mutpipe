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

## Downloading common germline variant sites
gsutil cp -R gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz .
gstuil cp -R gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz.tbi .

## unzip the WES interval file
gzip -d S31285117_Padded.bed.gz
