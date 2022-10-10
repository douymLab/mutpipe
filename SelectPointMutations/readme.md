## Strategy

### We use the following strategy to select the mutation point from mutpipe's mutect2, strelka2 and octopus variants caller:

1. Before combine the callers, we filter the variants by the following criteria:

  - the variant is PASS
  - the variant's population allele frequency(popAF) < 0.0001 

2. We combine multiple callers by a voting approch.  

- For SNVs, we manually examined 588 sites by using IGV.  
  ![SNV](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/SNV.png)  
  Variants called by >=2 software has a ~86% precision. Based on the precision, we choose the SNVs voted by >=2 software as the consensus SNVs.
    
- For Indels, we manually examined 85 sites by using IGV.  
  ![Indel](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/Indel.png)  
  Variants called by >=2 software has a ~89% precision. Based on the precision, we choose the SNVs voted by >=2 software as the consensus Indels.

![SelectPonitMutations](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/mutpipe_SelectPointMutation.png)

# Quick Start 

# Quick Start

## Step1: deploy workflow

Given that mutpipe is cloned, run

```{bash}
cd mutpipe/SelectPonitMutations
```

We strongly suggest installing dependencies via mamba:

Given that Mamba is installed, run

```{bash}
mamba env create --file workflow/envs/environment.yaml -n mutpipe_selectpointmutations
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
    
    -  `ANNOVAR`
    
        Directory path for [ANNOVAR](#1-install-annovar)
    
    -  `humandb`
    
        Directory path for [humandb](#1-install-annovar)
    
    -  `output`
    
        Directory path for output files

-   `vcf_links`
    
    -  `mutect2`
    
        Directory path to vcf from [Mutect2](Mutect2/readme.md)

    -  `octopus`
    
        Directory path to vcf from [octopus](octopus/readme.md)

    -  `strelka2`
    
        Directory path to {sample}_strelka from [strelka2](strelka2/readme.md)

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
  ANNOVAR: annovar
  humandb: annovar/humandb
  output: demo/output

vcf_links:
  mutect2: ../Mutect2/demo/output
  octopus: ../octopus/demo/output
  strelka2: ../strelka2/demo/output/strelka_somatic
```

## input:

path/to/Mutect2/output/{sample}.somatic.mt2.INDELs.vcf.gz
path/to/Mutect2/output/{sample}.somatic.mt2.SNVs.vcf.gz
path/to/octopus/output/{sample}.vcf.gz
path/to/strelka2/demo/output/strelka_somatic/{sample}_strelka/results/variants/somatic.indels.vcf.gz
path/to/strelka2/demo/output/strelka_somatic/{sample}_strelka/results/variants/somatic.snvs.vcf.gz

## output:

### output_dir/result/test.tumor.SNV.out  

> chr1 103004573 103004573 T C  
chr1 1045564 1045564 C A  
chr1 109280342 109280342 C T  
chr1 109985119 109985119 G A  
chr1 11082881 11082881 G C   
......  

### output_dir/result/test.tumor.INDEL.out
> chr1 119421709 119421709 C -  
chr1 151760036 151760046 GAGGGAGAGTA -  
chr1 154960916 154960916 - GACAG  
chr1 180787872 180787872 T -  
chr1 201069289 201069292 CATT -  
...... 

### output_dir/result/test.SNV.exonic_variant_function
> line4	nonsynonymous SNV	AHCYL1:NM_006621:exon1:c.G67A:p.E23K,	chr1 109985119 109985119 G A  
line6	synonymous SNV	ATP5PB:NM_001688:exon4:c.C381T:p.L127L,	chr1 111456243 111456243 C T  
......

### output_dir/result/test.SNV.variant_function
> intronic	COL11A1	chr1 103004573 103004573 T C  
intronic	AGRN	chr1 1045564 1045564 C A  
intronic	PSRC1	chr1 109280342 109280342 C T  
......

### output_dir/result/test.INDEL.exonic_variant_function
>  line7	nonframeshift deletion	ZFYVE9:NM_007324:exon4:c.750_785del:p.250_262del,ZFYVE9:NM_004799:exon4:c.750_785del:p.250_262del,	chr1 52238167 52238202 AAGTATAGGTAGAGACCCCTCCATGTCTGCGATTAC -  
line9	nonframeshift insertion	MIGA1:NM_001363586:exon2:c.91_92insTCTCTG:p.L31delinsLSV,MIGA1:NM_001363584:exon2:c.91_92insTCTCTG:p.L31delinsLSV,MIGA1:NM_198549:exon2:c.187_188insTCTCTG:p.L63delinsLSV,MIGA1:NM_001270384:exon2:c.187_188insTCTCTG:p.L63delinsLSV,MIGA1:NM_001363583:exon2:c.91_92insTCTCTG:p.L31delinsLSV,	chr1 77783343 77783343 - TCTCTG  

### output_dir/result/test.INDEL.variant_function
> intronic	HSD3B2	chr1 119421709 119421709 C -  
UTR3	MRPL9(NM_001300733:c.*14_*4delTACTCTCCCTC,NM_031420:c.*14_*4delTACTCTCCCTC)   chr1 151760036 151760046 GAGGGAGAGTA -  
intronic	PYGO2	chr1 154960916 154960916 - GACAG  
intronic	XPR1	chr1 180787872 180787872 T -  
......





