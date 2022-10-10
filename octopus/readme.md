![octopus](https://github.com/douymLab/mutpipe/blob/main/octopus/octopus.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/octopus
```

we strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_octopus
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-  path
    
    -   `output`
        
        Directory name for output files
        
    -   `bam_tumor`
    
        Directory for tumor bam files
         
    -   `bam_normal`
    
        Directory for normal bam files
    
    -   `ref_dir`
    
        Directory path for decompressed reference files
    
    -   `gz_ref_dir`
    
        Directory path for compressed reference files or do not need to decompress

-   `octopus_param`

    Threads for octopus

-   `gz_ref`

    reference file need to decompress

    - `fa`: "Homo_sapiens_assembly38.fasta.gz"
    - `interval_list`: "S31285117_Padded.list.gz"
    - `germline`: "germline.v0.7.4.forest.gz"
    - `somatic`: "somatic.v0.7.4.forest.gz"

-   ref

    reference files

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    - octopus pre-traning model (More details: https://github.com/luntergroup/octopus)
      + `somatic` somatic.v0.7.4.forest
      + `germline` germline.v0.7.4.forest
    + `interval_list` WES interval list: S31285117_Padded.list.gz  

    Note: The interval list is based on our WES kit Sureselect Human All Exon V7. The list and other version kit's list can download from https://earray.chem.agilent.com/suredesign/

    Required reference files prepared in [reference workflow](reference/readme.md)

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
  ref_dir: "reference"
  gz_ref_dir: '../reference/data'
  output: "demo/output"
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"

octopus_param:
  threads: 4

gz_ref:
  fa: "Homo_sapiens_assembly38.fasta.gz"
  interval_list: "S31285117_Padded.list.gz"
  germline: "germline.v0.7.4.forest.gz"
  somatic: "somatic.v0.7.4.forest.gz"

ref:
  fa: "Homo_sapiens_assembly38.fasta"
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  interval_list: "S31285117_Padded.list"
  germline: "germline.v0.7.4.forest"
  somatic: "somatic.v0.7.4.forest"
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:
> output_dir/filter/{sample}.vcf.gz  

> ``` chr1	14932	.	G	T	108.04	RF	AC=2;AN=4;DP=30;MQ=27;NS=2;PP=108.04;RFGQ_ALL=2.84	GT:GQ:DP:MQ:PS:PQ:FT:RFGQ	0|1:108:4:22:14932:100:RF:2.76	0|1:108:26:27:14932:100:RF:2.92 ```  
> ``` chr1	15903	.	G	GC	36.45	PASS	AC=4;AN=4;DP=3;MQ=28;NS=2;PP=36.45;RFGQ_ALL=6.92	GT:GQ:DP:MQ:PS:PQ:FT:RFGQ	1|1:8:1:35:15903:100:PASS:8.03	1|1:8:2:25:15903:100:PASS:6.07 ```



