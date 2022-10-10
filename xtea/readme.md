![xtea](https://github.com/douymLab/mutpipe/blob/main/xtea/xtea.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/strelka2
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_strelka
```

## Step2: configure workflow

### 1. Install xTea

xTEA needs some scripts which not include conda environments. Please install xTEA manually.

To install xTEA:

```{bash}
git clone https://github.com/parklab/xTea.git
```

### 2. Modify config file

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-  `path`

  -  `output`
  
     Directory path for output files

  -  `bam_tumor`

     Directory path for tumor bam files
   
  -  `bam_normal`

     Directory path for normal bam files
  
  -  `ref_dir`
  
     Directory path for decompress reference files
  
  -  `gz_ref_dir`
  
     Directory path for compress reference files or do not need to decompress

  -  `xtea`
  
     Directory path for [MSIprofiler](#1-install-xtea)

-   `gz_ref`

    reference file need to decompress

    - `fa`: Homo_sapiens_assembly38.fasta.gz
    - `gff`: gencode.v33.annotation.gff3.gz
    - `rep_lib`: rep_lib_annotation.tar.gz

-   ref

    reference files

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    + `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
    + `gff` Comprehensive gene annotation: gencode.v33.annotation.gff3
    + `rep_lib_dir` pre-processed repeat library used by xTea: rep_lib_annotation   
  (more informations: https://github.com/parklab/xTea )

    Note: The interval list is based on our WES kit Sureselect Human All Exon V7. The list and other version kit's list can download from https://earray.chem.agilent.com/suredesign/

    Required reference files prepared in [reference workflow](/reference)

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
  ref_dir: reference
  gz_ref_dir: ../reference/data
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"
  output: demo/output
  xtea: xTea

gz_ref:
  fa: Homo_sapiens_assembly38.fasta.gz
  gff: gencode.v33.annotation.gff3.gz
  rep_lib: rep_lib_annotation.tar.gz

ref:
  fa: Homo_sapiens_assembly38.fasta
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  gff: gencode.v33.annotation.gff3
  rep_lib_dir: rep_lib_annotation
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:

{sample}.tumor_LINE1.vcf