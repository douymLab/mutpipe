![MSIprofiler](https://github.com/douymLab/mutpipe/blob/main/MSIprofiler/MSIprofiler.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/MSIprofiler
```

we strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_msiprofiler
```

## Step2: configure workflow

### 1. Install MSIprofiler

MSIprofier package in conda dont work, please install MSIprofier manually.

To insall MSIprofier(https://github.com/parklab/MSIprofiler):

```{bash}
git clone https://github.com/parklab/MSIprofiler.git
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

     Required reference files prepared in [reference workflow](reference/readme.md)

     Reference files need to decompress will automatic do it in workflow.

  -  `msiprofiler`
  
     Directory path for [MSIprofiler](#1-install-msiprofiler)

-  `chr_list` a chromosome list. for example `9` or `[1,2,"Y"]`

-  `threads`

  -  `get_ref`

      Threads for MSIprofiler in performing reference sets

  -  `msi`

      Threads for MSIprofiler in performing unphased chromosomes

-  `parameters`

  -  `min_coverage` parameter for MSIprofiler

  -  `nprocs` parameter for MSIprofiler

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

## Select the confidence MSIprofiler result

To select the confidence MSIprofiler result, we use the following strategies:

1. Kolmogorov-Smirnov P value < 0.01  

2. The length of the MS repeat in the normal/control sample only 2 haplotype(eg. a site with length 7,7,7,6 is a MSIsite, while a site with 7,6,5,7 might be filtered)  
You can filter the MSI result use this command:

```{bash}
bash workflow/scripts/filter.sh path/to/sample.unphased.txt path/to/sample.unphased.filtered.txt  
```

eg.

```{bash}
bash workflow/scripts/filter.sh demo/output/MSI/YC-104.unphased.txt demo/output/MSI/YC-104.unphased.filtered.txt
```

## Demo

### `config/config.yaml`

```{yaml}
path:
  msiprofiler: 'MSIprofiler'
  ref_dir: "reference"
  gz_ref_dir: '../reference/data'
  output: "demo/output"
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"

chr_list: 9

threads:
  get_ref: 10
  msi: 4

parameters:
  min_coverage: 8
  nprocs: 2
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:

> output_dir/MSI/test.unphased.txt 

> chr9	97994572	97994579	TTGTTGTT	3	8	0.4	8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8	8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8	1.0 high    
chr9	97994610	97994615	TTTTTT	1	6	0.4	7,7,6,6,6,7,6,7,7,6,6,6,6,7,6,6,7,7,7,6,7,7,6,7,7,7,7,7	6,6,6,6,7,7,6,6,6,6,6,6,6,6,6,6,6,7,6,6,6,6,6,7,6,6,6,6,6,6,6,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7	0.00273445761255	low  
chr9	97994657	97994666	CAAATCAAAT	5	10	0.4	10,10,10,10,10,10,10,10,10,10,10,10	10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10	1.0	high

> output_dir/MSI/test.unphased.filterd.txt 
 
> chr9	97994610	97994615	TTTTTT	1	6	0.4	7,7,6,6,6,7,6,7,7,6,6,6,6,7,6,6,7,7,7,6,7,7,6,7,7,7,7,7	6,6,6,6,7,7,6,6,6,6,6,6,6,6,6,6,6,7,6,6,6,6,6,7,6,6,6,6,6,6,6,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7	0.00273445761255	low

