![dndscv](https://github.com/douymLab/mutpipe/blob/main/dndscv/dndscv.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/dndscv
```

we strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_dndscv
```

## Step2: configure workflow

### 1. Install package

```{bash}
conda activate mutpipe_dndscv
Rscript scripts/package_install.R
conda deactivate
```

### 2. Modify config file

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   refdb_file

    RefCDS object to run dndscv. Default of eference genome hg38.

    You could change it as you need, referencing here : <https://github.com/im3sanger/dndscv_data/tree/master/data>

-   refdb_dir

    Directory name to save refdb_file

-   input

    Directory for input files

-   out

    Directory name for output files

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

### config.yaml

```{yaml}
path:
  ref_file: 'RefCDS_human_GRCh38_GencodeV18_recommended.rda'
  ref_dir: '../reference/data'
  input: '../demo_data/dndscv_input'
  output: 'demo/output'
```

### input:

The input file is the output file from mutpipe's SelectPointMutation test inputfiles we provide under the "demo_data" folder

### output:

outputdir/drivergene.csv \|

\|gene_name\|qglobal_cv\|

\|:---:\|:---------:\|:----------:\|

\|17498\|TP53\|1.52027279654021E-11\|
