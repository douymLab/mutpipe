Prepare reference data used in mutpipe

This is a help workflow to download reference data

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/reference
```

we strongly suggest installing dependencies via mamba:

Given that Mamba and snakemake are installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_reference
```

## Step2: configure workflow

Modify config file

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   threads

    Threads for data download

-   reference_path

    Directory path for files downloaded

-   download_log

    Directory path for the log file of download
    
## Step3: run workflow

1.  dry run test

```{bash}
conda activate snakemake
snakemake -np
```

2.  actual run

```{bash}
snakemake --cores 1 --use-conda

## Demo

### config.yaml

```{yaml}
threads: 16
download_log: log
reference_path: data
```

### input:

`data/reference_mainfile.tsv`

### output:

Files record in `data/reference_mainfile.tsv`

| 1000G_omni2.5.hg38.vcf.gz                                       | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/1000G_omni2.5.hg38.vcf.gz                                                   |
| --------------------------------------------------------------- | --------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------- |
| 1000G_omni2.5.hg38.vcf.gz.tbi                                   | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/1000G_omni2.5.hg38.vcf.gz.tbi                                               |
| 1000G_phase1.snps.high_confidence.hg38.vcf.gz                   | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz                               |
| 1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi               | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi                           |
| 1000g_pon.hg38.vcf.gz                                           | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/1000g_pon.hg38.vcf.gz                                                                   |
| 1000g_pon.hg38.vcf.gz.tbi                                       | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/1000g_pon.hg38.vcf.gz.tbi                                                               |
| af-only-gnomad.hg38.vcf.gz                                      | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/af-only-gnomad.hg38.vcf.gz                                                              |
| af-only-gnomad.hg38.vcf.gz.tbi                                  | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/af-only-gnomad.hg38.vcf.gz.tbi                                                          |
| Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz     | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz                 |
| Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi             |
| centromeric.txt                                                 | merge_cnv       | -      | -                                                                                                                             |
| chr1.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr1.fa.gz                                                         |
| chr2.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr2.fa.gz                                                         |
| chr3.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr3.fa.gz                                                         |
| chr4.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr4.fa.gz                                                         |
| chr5.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr5.fa.gz                                                         |
| chr6.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr6.fa.gz                                                         |
| chr7.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr7.fa.gz                                                         |
| chr8.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr8.fa.gz                                                         |
| chr9.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr9.fa.gz                                                         |
| chr10.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr10.fa.gz                                                        |
| chr11.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr11.fa.gz                                                        |
| chr12.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr12.fa.gz                                                        |
| chr13.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr13.fa.gz                                                        |
| chr14.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr14.fa.gz                                                        |
| chr15.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr15.fa.gz                                                        |
| chr16.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr16.fa.gz                                                        |
| chr17.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr17.fa.gz                                                        |
| chr18.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr18.fa.gz                                                        |
| chr19.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr19.fa.gz                                                        |
| chr20.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr20.fa.gz                                                        |
| chr21.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr21.fa.gz                                                        |
| chr22.fa.gz                                                     | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr22.fa.gz                                                        |
| chrX.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chrX.fa.gz                                                         |
| chrY.fa.gz                                                      | BIC_SEQ2        | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chrY.fa.gz                                                         |
| chr1.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr1.fa.gz                                                         |
| chr2.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr2.fa.gz                                                         |
| chr3.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr3.fa.gz                                                         |
| chr4.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr4.fa.gz                                                         |
| chr5.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr5.fa.gz                                                         |
| chr6.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr6.fa.gz                                                         |
| chr7.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr7.fa.gz                                                         |
| chr8.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr8.fa.gz                                                         |
| chr9.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr9.fa.gz                                                         |
| chr10.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr10.fa.gz                                                        |
| chr11.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr11.fa.gz                                                        |
| chr12.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr12.fa.gz                                                        |
| chr13.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr13.fa.gz                                                        |
| chr14.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr14.fa.gz                                                        |
| chr15.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr15.fa.gz                                                        |
| chr16.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr16.fa.gz                                                        |
| chr17.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr17.fa.gz                                                        |
| chr18.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr18.fa.gz                                                        |
| chr19.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr19.fa.gz                                                        |
| chr20.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr20.fa.gz                                                        |
| chr21.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr21.fa.gz                                                        |
| chr22.fa.gz                                                     | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr22.fa.gz                                                        |
| chrX.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chrX.fa.gz                                                         |
| chrY.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chrY.fa.gz                                                         |
| hg19.fa.gz                                                      | MSIprofilter    | wget   | http://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/hg19.fa.gz                                                             |
| gencode.v33.annotation.gff3.gz                                  | xtea            | wget   | http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_33/gencode.v33.annotation.gff3.gz                            |
| germline.v0.7.4.forest.gz                                       | octopus         | gsutil | gs://luntergroup/octopus/forests/germline.v0.7.4.forest.gz                                                                    |
| grch38-no-alt.tar.gz                                            | BIC_SEQ2        | wget   | http://ftp.imp.fu-berlin.de/pub/cpockrandt/genmap/indices/grch38-no-alt.tar.gz                                                |
| hapmap_3.3.hg38.vcf.gz                                          | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/hapmap_3.3.hg38.vcf.gz                                                      |
| hapmap_3.3.hg38.vcf.gz.tbi                                      | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/hapmap_3.3.hg38.vcf.gz.tbi                                                  |
| Homo_sapiens_assembly38.dbsnp138.vcf                            | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf                                        |
| Homo_sapiens_assembly38.dbsnp138.vcf.idx                        | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx                                    |
| Homo_sapiens_assembly38.dict                                    | Mutect2         | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict                                                |
| Homo_sapiens_assembly38.dict                                    | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict                                                |
| Homo_sapiens_assembly38.dict                                    | Qualitycontrol  | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict                                                |
| Homo_sapiens_assembly38.dict                                    | xtea            | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict                                                |
| Homo_sapiens_assembly38.fasta.fai                               | Mutect2         | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | FREEC           | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | merge_cnv       | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | merge_cnv       | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | octopus         | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | Qualitycontrol  | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | strelka2        | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.fai                               | xtea            | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai                                           |
| Homo_sapiens_assembly38.fasta.gz                                | Mutect2         | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Homo_sapiens_assembly38.fasta.gz                                | Haplotypecaller | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Homo_sapiens_assembly38.fasta.gz                                | octopus         | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Homo_sapiens_assembly38.fasta.gz                                | Qualitycontrol  | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Homo_sapiens_assembly38.fasta.gz                                | strelka2        | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Homo_sapiens_assembly38.fasta.gz                                | xtea            | wget   | http://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz |
| Mills_and_1000G_gold_standard.indels.hg38.vcf.gz                | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz                            |
| Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi            | Haplotypecaller | gsutil | gs://genomics-public-data/resources/broad/hg38/v0/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi                        |
| RefCDS_human_GRCh38_GencodeV18_recommended.rda                  | dndscv          | wget   | https://raw.githubusercontent.com/im3sanger/dndscv_data/master/data/RefCDS_human_GRCh38_GencodeV18_recommended.rda            |
| rep_lib_annotation.tar.gz                                       | xtea            | wget   | https://media.githubusercontent.com/media/parklab/xTea/master/rep_lib_annotation.tar.gz                                       |
| S31285117_Regions.bed                                         | Qualitycontrol  | -      | -                                                                                                                             |
| S31285117_Padded.list.gz                                        | Mutect2         | -      | -                                                                                                                             |
| S31285117_Padded.list.gz                                        | Haplotypecaller | -      | -                                                                                                                             |
| S31285117_Padded.list.gz                                        | strelka2        | -      | -                                                                                                                             |
| small_exac_common_3.hg38.vcf.gz                                 | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz                                                         |
| small_exac_common_3.hg38.vcf.gz                                 | Qualitycontrol  | gsutil | gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz                                                         |
| small_exac_common_3.hg38.vcf.gz.tbi                             | Mutect2         | gsutil | gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz.tbi                                                     |
| small_exac_common_3.hg38.vcf.gz.tbi                             | Qualitycontrol  | gsutil | gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz.tbi                                                     |
| somatic.v0.7.4.forest.gz                                        | octopus         | gsutil | gs://luntergroup/octopus/forests/somatic.v0.7.4.forest.gz                                                                     |
| telomere.txt                                                    | merge_cnv       | -      | -                                                                                                                             |
| hg38_len_offset.sorted.txt                                      | merge_cnv       | -      | -                                                                                                                             |
| hg38_len.txt                                                    | merge_cnv       | -      | -                                                                                                                             |
|                                                                 |                 |        |                                                                                                                               |