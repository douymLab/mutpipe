![strelka2](https://github.com/douymLab/mutpipe/blob/main/strelka2/strelka2.png)

# Quick Start 

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/strelka2
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_strelka
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

-   `gz_ref`

    reference file need to decompress

    - `fa`: "Homo_sapiens_assembly38.fasta.gz"

-   ref

    reference files

    + `fa` Reference genome (hg38): Homo_sapiens_assembly38.fasta
    + `fai` FASTA index file: Homo_sapiens_assembly38.fasta.fai
    + `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
    + `regionbed` WES interval list: region.bed.gz
    + `regionbedi`  WES interval list index: region.bed.gz.tbi

    Note: The interval list is based on our WES kit Sureselect Human All Exon V7. The list and other version kit's list can download from https://earray.chem.agilent.com/suredesign/

    Required reference files prepared in [reference workflow](/reference)

    Reference files need to decompress will be extracted automatically in workflow.

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

gz_ref:
  fa: "Homo_sapiens_assembly38.fasta.gz"

ref:
  fa: "Homo_sapiens_assembly38.fasta"
  fai: "Homo_sapiens_assembly38.fasta.fai"
  dict: "Homo_sapiens_assembly38.dict"
  regionbed: "region.bed.gz"
  regionbedi: "region.bed.gz.tbi"
```

## input:

path/to/{sample}.tumor.bam
path/to/{sample}.normal.bam

## output:

> output_dir/results/variants/somatic.snvs.vcf.gz  

> chr1	1045481	.	A	C	.	LowEVS	SOMATIC;QSS=1;TQSS=1;NT=ref;QSS_NT=1;TQSS_NT=1;SGT=AA->AA;DP=71;MQ=60.00;MQ0=0;ReadPosRankSum=-1.61;SNVSB=0.00;SomaticEVS=0.40	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	10:0:0:0:10,10:0,0:0,0:0,0	60:0:0:0:58,59:2,2:0,0:0,0  
> chr1	1045564	.	C	A	.	PASS	SOMATIC;QSS=54;TQSS=1;NT=ref;QSS_NT=54;TQSS_NT=1;SGT=CC->AC;DP=101;MQ=60.00;MQ0=0;ReadPosRankSum=0.34;SNVSB=0.00;SomaticEVS=8.50	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	16:0:0:0:0,0:16,16:0,0:0,0	84:0:0:0:5,5:79,80:0,0:0,0  
> chr1	7745084	.	G	T	.	LowEVS	SOMATIC;QSS=19;TQSS=1;NT=ref;QSS_NT=19;TQSS_NT=1;SGT=GG->GT;DP=57;MQ=60.00;MQ0=0;ReadPosRankSum=1.80;SNVSB=0.00;SomaticEVS=1.18	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	11:0:0:0:0,0:0,0:11,11:0,0	46:0:0:0:0,0:0,0:43,43:3,3


> output_dir/results/variants/somatic.snvs.vcf.gz 

> chr1	7745037	.	G	GGCT	.	PASS	SOMATIC;QSI=44;TQSI=1;NT=ref;QSI_NT=44;TQSI_NT=1;SGT=ref->het;MQ=60.00;MQ0=0;RU=GCT;RC=0;IC=1;IHP=4;SomaticEVS=8.01	DP:DP2:TAR:TIR:TOR:DP50:FDP50:SUBDP50:BCN50	31:31:31,31:0,0:0,0:24.99:0.00:0.00:0.00	84:84:77,77:6,6:1,1:69.41:0.46:0.00:0.00



