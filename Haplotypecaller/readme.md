![Haplotypecaller](https://github.com/douymLab/mutpipe/blob/main/Haplotypecaller/Haplotypecaller.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/Haplotypecaller
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_qualitycontrol
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `output`
    
    Directory path for output files
    
-   `bam_tumor`

    Directory path for tumor bam files
     
-   `bam_normal`

    Directory path for normal bam files

-   `ref_dir`

    Directory path for unziped reference files

-   `gz_ref_dir`

    Directory path for reference files that zipped or do not need to be unzipped

-   `gz_ref`

    Reference file name need to unzip including

    fa: "Homo_sapiens_assembly38.fasta.gz"
    interval_list: "S31285117_Padded.list.gz"

    Download by [reference workflow](reference/readme.md)

-   `ref`

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    + `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
    + `snp` Homo_sapiens_assembly38.dbsnp138.vcf
    + `snpi` Homo_sapiens_assembly38.dbsnp138.vcf.idx
    + `poly` Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz
    + `polyi` Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi
    + `hapmap` hapmap_3.3.hg38.vcf.gz
    + `hapmapi` hapmap_3.3.hg38.vcf.gz.tbi
    + `omn` 1000G_omni2.5.hg38.vcf.gz
    + `omni` 1000G_omni2.5.hg38.vcf.gz.tbi
    + `highsnp` 1000G_phase1.snps.high_confidence.hg38.vcf.gz
    + `highsnpi` 1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi
    + `mills` Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    + `millsi` Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi
    + `interval_list` WES interval list: S31285117_Padded.list

    Note: The interval list is based on our WES kit Sureselect Human All Exon V7. The list and other version kit's list can download from https://earray.chem.agilent.com/suredesign/

    Required reference files prepared in [reference workflow](reference)

    Reference files need to decompress will be extracted automatically in workflow.

## Step3: run workflow

Given that snakemake is installed, run

```{bash}
conda activate snakemake
```

1.  dry run test

```{bash}
snakemake -np
```

2.  actual run

```{bash}
snakemake --cores 1 --use-conda
```

## Run on slurm

modify `workflow/scripts/slurm.json` according to your needs

```{bash}
sh workflow/run.slurm.sh
```

## Demo

### `config/config.yaml`

```{yaml}
path:
  gz_ref_dir: '../reference/data'
  ref_dir: reference
  output: "demo/output"
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"

gz_ref:
  fa: "Homo_sapiens_assembly38.fasta.gz"
  interval_list: "S31285117_Padded.list.gz"

ref:
  fa: "Homo_sapiens_assembly38.fasta"
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  interval_list: "S31285117_Padded.list"
  snp: "Homo_sapiens_assembly38.dbsnp138.vcf"
  snpi: "Homo_sapiens_assembly38.dbsnp138.vcf.idx"
  poly: "Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz"
  polyi: "Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi"
  hapmap: "hapmap_3.3.hg38.vcf.gz"
  hapmapi: "hapmap_3.3.hg38.vcf.gz.tbi"
  omn: "1000G_omni2.5.hg38.vcf.gz"
  omni: "1000G_omni2.5.hg38.vcf.gz.tbi"
  highsnp: "1000G_phase1.snps.high_confidence.hg38.vcf.gz"
  highsnpi: "1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi"
  mills: "Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"
  millsi: "Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi"

max-gaussians: 2
```

## Input

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## Output

normal_cohort.snps.VQSR.vcf.gz
tumor_cohort.snps.VQSR.vcf.gz
normal_cohort.indels.VQSR.vcf.gz
tumor_cohort.indels.VQSR.vcf.gz