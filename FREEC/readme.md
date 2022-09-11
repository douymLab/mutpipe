# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/FREEC/dag.png)

## Step1: install mamba and deploy workflow

Download workflow

```{bash}
git clone https://github.com/xiayh17/mutpipe
cd mutpipe/dndscv
```

we strongly suggest installing dependencies via mamba:

```{bash}
conda install -n base -c conda-forge mamba
conda activate base
mamba create -c conda-forge -c bioconda -n snakemake snakemake
mamba env create --file workflow/envs/environment.yaml -n mutpipe_dndscv
```

Then you could activate the environment "snakemake" through this command:

```{bash}
conda activate snakemake
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   output
    
    Directory name for output files
    
-  index_file

    Fasta index file of reference genome (hg38): Homo_sapiens_assembly38.fasta.fai
    
-  index_dir

    Directory name to save index_file
    
-   bam_tumor

     Directory for tumor bam files
     
-   bam_normal

    Directory for normal bam files
    
-   threads

    threads for control-freec
    
-   coefficientOfVariation

    coefficientOfVariation for control-freec

## Step3: run workflow

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
  index_dir: "demo/resources"
  index_file: "Homo_sapiens_assembly38.fasta.fai"
  bam_tumor: "../demo/bam/tumor"
  bam_normal: "../demo/bam/normal"

controlfreec_params: 
  coefficientOfVariation: 0.062
  threads: 16
```

## Input
path/to/BamFolder/{sample}.tumor.bam
path/to/BamFolder/{sample}.normal.bam
## Output
result/{sample}.tumor.bam_CNVs   
result/{sample}.tumor.bam_info.txt   
result/{sample}.tumor.bam_ratio.txt   
result/{sample}_median_ratio.txt   
