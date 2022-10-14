![DNAcopy](https://github.com/douymLab/mutpipe/blob/main/DNAcopy/dag.png)

# Quick Start 

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/DNAcopy
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_dnacopy
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `output`
    
    Directory path for output files
    
-   `bam_tumor`

    Directory path for tumor bam files
     
-   `bam_normal`

    Directory path for normal bam files

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
  output: "demo/output"
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"
```

## Input
path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam
## Output
results/{sample}.CNVs   
results/{sample}.mapd   
