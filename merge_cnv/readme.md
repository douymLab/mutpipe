![merge_cnv](https://github.com/douymLab/mutpipe/blob/main/merge_cnv/dag.png)

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/merge_cnv
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_mergecnv
```

## Step2: configure workflow

### 1. Install ANNOVAR

We cannot redistribute ANNOVAR to other users.

To insall ANNOVAR, please apply a ueser license agreement via http://www.openbioinformatics.org/annovar/annovar_download_form.php.

Since we use hg38 reference, ANNOVAR need addition annotation resources for hg38. The download example is as follows:

```{bash}
conda activate mutpipe_dndscv
perl annovar/annotate_variation.pl -buildver hg38 -downdb -webfrom annovar refGene annovar/humandb/
conda deactivate
```

The other annotation resources can be found in: https://annovar.openbioinformatics.org/en/latest/user-guide/download/

### 2. Modify config file

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided below.

-   `path`
    
    -   `ref_dir`
    
        Directory path for decompress reference files
    
    -   `gz_ref_dir`
    
        Directory path for compress reference files or do not need to decompress
    
    -  `ANNOVAR`
    
        Directory path for [ANNOVAR](#1-install-annovar)
    
    -  `humandb`
    
        Directory path for [humandb](#1-install-annovar)
    
    -  `output`
    
        Directory path for output files

-  `gz_ref`

    -  `fa` Homo_sapiens_assembly38.fasta.gz

-  `ref`

    -  `fa` Homo_sapiens_assembly38.fasta

    -  `fai` Fasta index file of reference genome (hg38): Homo_sapiens_assembly38.fasta.fai

    -  `dict` FASTA sequence dictionary file: Homo_sapiens_assembly38.dict

    -  `centromeric` Centromeres (hg38): centromeric.txt

    -  `telomere` Telomeres (hg38): telomere.txt

    -  `hg38_len` hg38_len.txt

    -  `hg38_len_offset` hg38_len_offset.sorted.txt

    Required reference files prepared in [reference workflow](/reference)

    Reference files need to decompress will be extracted automatically in workflow.

-  `pre_res`

    -  `bic_seq2_res`: path/to/BIC_SEQ2/output
    -  `dnacopy_res`: path/to/DNAcopy/output
    -  `freec_res`: path/to/FREEC/output

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
  ANNOVAR: annovar
  humandb: annovar/humandb
  output: demo/output

gz_ref:
  fa: "Homo_sapiens_assembly38.fasta.gz"

ref:
  fa: Homo_sapiens_assembly38.fasta
  fai: Homo_sapiens_assembly38.fasta.fai
  dict: Homo_sapiens_assembly38.dict
  centromeric: centromeric.txt
  telomere: telomere.txt
  hg38_len: hg38_len.txt
  hg38_len_offset: hg38_len_offset.sorted.txt

pre_res:
  bic_seq2_res: ../BIC_SEQ2/demo/output
  dnacopy_res: ../DNAcopy/demo/output
  freec_res: ../FREEC/demo/output
```

## Input
path/to/BIC_SEQ2/results/{sample}_pvalue.CNVs   
path/to/DNAcopy/result/{sample}.CNVs   
path/to/freec/result/{sample}.tumor.bam_CNVs   
path/to/freec/result/{sample}_median_ratio.txt   
path/to/DNAcopy/depth/{sample}.depth.regions.logratio.mainchr.bed   
## Output
result/{sample}.seg_vote_by_g2.bed   
result/{sample}.seg_vote_by_3.bed   
result/{sample}.g2.point.bed.log2.png   
result/{sample}.3.point.bed.log2.png   
anno/{sample}.g2.variant_function   
anno/{sample}.e3.variant_function   
