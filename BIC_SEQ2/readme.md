# Quick Start

![BIC_SEQ2](https://github.com/douymLab/mutpipe/blob/main/BIC_SEQ2/dag.png)

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/dndscv
```

we strongly suggest installing dependencies via mamba:

Given that Mamba and snakemake is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_bicseq
```

## Step2: configure workflow

### 1. Download and unzip dependencies

#### NBICseq-seg_v0.7.2

```{bash}
wget http://compbio.med.harvard.edu/BIC-seq/NBICseq-seg_v0.7.2.tar.gz
tar -zxvf NBICseq-seg_v0.7.2.tar.gz
```

#### NBICseq-norm_v0.2.4

```{bash}
wget http://compbio.med.harvard.edu/BIC-seq/NBICseq-norm_v0.2.4.tar.gz
tar -zxvf NBICseq-norm_v0.2.4.tar.gz
```

### 2. Modify config file

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   output

    Directory path for output files

-   bam_tumor

    Directory path for tumor bam files

-   bam_normal

    Directory path for normal bam files

-   res_dir

    Directory path for decompress resources including:

    -   FASTA sequence of each chromosome of reference genome (hg38): chr\*.fa
    -   Index directory for hg38: grch38-no-alt

-   ref_gz_dir

    Directory path for compress resources including:

    -   FASTA sequence of each chromosome of reference genome (hg38): chr\*.fa.gz
    -   Index for hg38: grch38-no-alt.tar.gz

-   nbicseq_seg

    Directory for [NBICseq-seg_v0.7.2](#NBICseqsegv072)

-   nbicseq_norm

    Directory for [NBICseq-norm_v0.2.4](#NBICseqnormv024).

-   TEMPDIR

    Temporary directory for temporary files. A large space required in this workflow.

## Step3: run workflow

1.  dry run test

```{bash}
conda activate snakemake
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
  output: demo/output
  res_dir: reference
  ref_gz_dir: ../reference/data
  bam_tumor: "/storage/douyanmeiLab/TCGA_wu/demo/"
  bam_normal: "/storage/douyanmeiLab/TCGA_wu/demo/"
  nbicseq_seg: NBICseq-seg_v0.7.2
  nbicseq_norm: NBICseq-norm_v0.2.4

TEMPDIR: tmp
```

## Input

path/to/{sample}.tumor.bam \## Output results/{sample}\_pvalue.CNVs
