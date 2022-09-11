# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/BIC_SEQ2/dag.png)

## Step1: install mamba and deploy workflow

Download workflow

```{bash}
git clone https://github.com/xiayh17/mutpipe
cd mutpipe/BIC_SEQ2
```

we strongly suggest installing dependencies via mamba:

```{bash}
conda install -n base -c conda-forge mamba
conda activate base
mamba create -c conda-forge -c bioconda -n snakemake snakemake
mamba env create --file workflow/envs/environment.yaml -n mutpipe_bicseq
```

Then you could activate the environment "snakemake" through this command:

```{bash}
conda activate snakemake
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   output
    
    Directory name for output files
    
-   bam_tumor

     Directory for tumor bam files
     
-   bam_normal

    Directory for normal bam files

-   res_dir

    Directory for resources including:
    * FASTA sequence of each chromosome of reference genome (hg38): chr*.fa
    * Index for hg38: grch38-no-alt.tar.gz
    They will download automatically in workflow

-   aria2c_threads 

    Number of threads for resources download

-   TEMPDIR

    Temporary directory for temporary files. A large space required in this workflow.

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

### `config/config.yaml`

```{yaml}
path:
  output: "demo/output"
  res_dir: "demo/resources"
  bam_tumor: "../demo/bam/tumor"
  bam_normal: "../demo/bam/normal"

aria2c_threads: 16

TEMPDIR: "tmp"
```

## Input
path/to/BQSRTumorBamFolder/{sample}.tumor.bam
## Output
results/{sample}_pvalue.CNVs
