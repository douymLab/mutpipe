![Qualitycontrol](https://github.com/douymLab/mutpipe/blob/main/Qualitycontrol/Qualitycontrol.png)

# Quick Start 

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/octopus
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_qualitycontrol
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `path`
    
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

-   `gz_ref`

    reference file need to decompress

    - `fa`: "Homo_sapiens_assembly38.fasta.gz"
    - `interval_list`: "S31285117_Padded.list.gz"
    - `germline`: "germline.v0.7.4.forest.gz"
    - `somatic`: "somatic.v0.7.4.forest.gz"

-   `ref`

    reference files

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    + `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
    + `bed` WES interval list: S31285117_Regions.bed
    - Common germline variant sites: 
      + `common_vcf` small_exac_common_3.hg38.vcf.gz
      + `common_vcfi` small_exac_common_3.hg38.vcf.gz.tbi

    Note: The interval list is based on our WES kit is Sureselect Human All Exon V7. The list and other version kit's list can download form https://earray.chem.agilent.com/suredesign/

    Required reference files prepared in [reference workflow](/reference)

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
  ref_dir: reference
  gz_ref_dir: ../reference/data
  bam_tumor: "../demo_data/test"
  bam_normal: "../demo_data/test"
  output: demo/output

gz_ref:
  fa: Homo_sapiens_assembly38.fasta.gz

ref:
  fa: Homo_sapiens_assembly38.fasta
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  bed: "S31285117_Regions.bed"
  common_vcf: small_exac_common_3.hg38.vcf.gz
  common_vcfi: small_exac_common_3.hg38.vcf.gz.tbi
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:
> output_dir/allsample_contamination  

>sample	contamination	error  
test.tumor	0.0	1.0

> output_dir/allsamples_statistics.list

> sample	type	count	mean	std	min	25%	50%	75%	max  
test	normal	236.0	15.283898305084746	9.38989470712482	1.0	7.0	13.0	24.25	31.0  
test	tumor	242.0	48.67355371900826	23.84521409950976	1.0	30.5	58.0	65.75	84.0

## others:
+ output_dir/bam_stats/test/test.normal.flagstats
+ output_dir/bam_stats/test/test.normal.stats
+ output_dir/bam_stats/test/test.tumor.flagstats
+ output_dir/bam_stats/test/test.tumor.stats


