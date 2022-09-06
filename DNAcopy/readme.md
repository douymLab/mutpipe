# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/DNAcopy/dag.png)

## Step1: install mamba and deploy workflow

Download workflow

```{bash}
git clone https://github.com/xiayh17/mutpipe
cd mutpipe/dndscv
```

we strongly suggest installing dependencies via mamba:

```{bash}
conda install -n base -c conda-forge mamba
mamba env create --file workflow/envs/environment.yaml -n mutpipe_dnacopy
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
  bam_tumor: "demo/bam/tumor"
  bam_normal: "demo/bam/normal"
```

## Input
path/to/BQSRTumorBamFolder/{sample}.tumor.bam
## Output
results/{sample}.CNVs   
results/{sample}.mapd   
