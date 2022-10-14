![Mutect2](https://github.com/douymLab/mutpipe/blob/main/Mutect2/Mutect2.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/Mutect2
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_mutect2
```

## Step2: configure workflow

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `output`
    
    Directory name for output files
    
-   `bam_tumor`

     Directory for tumor bam files
     
-   `bam_normal`

    Directory for normal bam files

  -  `ref_dir`
  
     Directory path for decompressed reference files
  
  -  `gz_ref_dir`
  
     Directory path for compressed reference files or do not need to decompress

-   `gz_ref`

    fa: "Homo_sapiens_assembly38.fasta.gz"
    interval_list: "S31285117_Padded.list.gz"

-   `ref`

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    + `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
    - Pannel of Normal:
      + `pon` 1000g_pon.hg38.vcf.gz
      + `poni` 1000g_pon.hg38.vcf.gz.tbi
    + `common_vcf` common_vcfsmall_exac_common_3.hg38.vcf.gz
    + `common_vcfi` small_exac_common_3.hg38.vcf.gz.tbi
    + `germline` af-only-gnomad.hg38.vcf.gz
    + `germlinei` af-only-gnomad.hg38.vcf.gz.tbi
    + `interval_list` WES interval list: S31285117_Padded.list

    Note: The interval list is based on our WES kit Sureselect Human All Exon V7. The list and other version kit's list can download from https://earray.chem.agilent.com/suredesign/

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
  gz_ref_dir: '../reference/data'
  ref_dir: reference
  output: "demo/output"
  bam_tumor: "../demo_data/test/"
  bam_normal: "../demo_data/test/"

gz_ref:
  fa: "Homo_sapiens_assembly38.fasta.gz"
  interval_list: "S31285117_Padded.list.gz"

ref:
  fa: "Homo_sapiens_assembly38.fasta"
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  interval_list: "S31285117_Padded.list"
  germline: "af-only-gnomad.hg38.vcf.gz"
  germlinei: af-only-gnomad.hg38.vcf.gz.tbi
  pon: "1000g_pon.hg38.vcf.gz"
  poni: 1000g_pon.hg38.vcf.gz.tbi
  common_vcf: small_exac_common_3.hg38.vcf.gz
  common_vcfi: small_exac_common_3.hg38.vcf.gz.tbi
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:
> output_dir/{sample}.somatic.mt2.SNVs.vcf.gz

> chr1	1045564	.	C	A	.	PASS	AS_FilterStatus=SITE;AS_SB_TABLE=44,52|2,3;DP=101;ECNT=1;GERMQ=93;MBQ=34,24;MFRL=255,378;MMQ=60,60;MPOS=6;NALOD=1.15;NLOD=3.91;POPAF=4.00;ROQ=14;TLOD=7.85	GT:AD:AF:DP:F1R2:F2R1:SB	0/0:16,0:0.067:16:7,0:6,0:5,11,0,0	0/1:80,5:0.069:85:27,1:36,3:39,41,2,3

> output_dir/{sample}.somatic.mt2.INDELs.vcf.gz

> chr1	7745037	.	G	GGCT	.	PASS	AS_FilterStatus=SITE;AS_SB_TABLE=25,82|3,3;DP=114;ECNT=1;GERMQ=93;MBQ=34,20;MFRL=220,210;MMQ=60,60;MPOS=43;NALOD=1.30;NLOD=5.72;POPAF=4.00;ROQ=93;TLOD=15.38	GT:AD:AF:DP:F1R2:F2R1:SB	0/0:31,0:0.048:31:9,0:7,0:13,18,0,0	0/1:76,6:0.055:82:38,3:30,0:12,64,3,3



