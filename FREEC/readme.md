![FREEC](https://github.com/douymLab/mutpipe/blob/main/FREEC/dag.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/FREEC
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_freec
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `output`
    
    Directory path for output files
    
-  `index_file`

    File name for Fasta index file of reference genome (hg38): Homo_sapiens_assembly38.fasta.fai
    
-  `index_dir`

    Directory path to save `index_file`

    Required reference files prepared in [reference workflow](/reference)

    Reference files need to decompress will be extracted automatically in workflow.
    
-   `bam_tumor`

    Directory path for tumor bam files
     
-   `bam_normal`

    Directory path for normal bam files
    
-   `threads`

    Threads for control-freec
    
-   `coefficientOfVariation`

    CoefficientOfVariation for control-freec
    
-   `TEMPDIR`

    Temporary directory for temporary files.

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

### config.yaml

```{yaml}
path:
  output: "demo/output"
  index_dir: "../reference/data"
  index_file: "Homo_sapiens_assembly38.fasta.fai"
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"

controlfreec_params: 
  coefficientOfVariation: 0.062
  threads: 16

TEMPDIR: "tmp"
```

## Input
path/to/BamFolder/{sample}.tumor.bam
path/to/BamFolder/{sample}.normal.bam
## Output
result/{sample}.tumor.bam_CNVs   
result/{sample}.tumor.bam_info.txt   
result/{sample}.tumor.bam_ratio.txt   
result/{sample}_median_ratio.txt   
