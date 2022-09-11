# Quick Start

![avatar](https://github.com/douymLab/mutpipe/blob/main/dndscv/dndscv.png) \## Dependency:

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
  refdb_file: 'RefCDS_human_GRCh38_GencodeV18_recommended.rda'
  refdb_dir: '../demo/dndscv_input/'
  input: '../demo/dndscv_input/'
  out: 'demo/output/'
```

### input:

The input file is the output file from mutpipe's SelectPointMutation test inputfiles we provide under the "demo" folder

### output:

outputdir/drivergene.csv \| \|gene_name\|qglobal_cv\| \|:---:\|:---------:\|:----------:\| \|17498\|TP53\|1.52027279654021E-11\|
