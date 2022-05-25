# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/mutpipe_SelectPointMutation.png)
## Strategy
### We use the following strategy to select the mutation point from mutpipe's mutect2, strelka2 and octopus variants caller:
1. Before combine the callers, we filter the variants by the following criteria:
  - the variant is PASS
  - the variant's population allele frequency(popAF) < 0.0001 

2. We combine multiple callers by a voting approch.  

- For SNVs, we manually examined 588 sites by using IGV.  
  ![avatar](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/SNV.png)  
  Variants called by >=2 software has a ~86% precision. Based on the precision, we choose the SNVs voted by >=2 software as the consensus SNVs.
    
- For Indels, we manually examined 85 sites by using IGV.  
  ![avatar](https://github.com/douymLab/mutpipe/blob/main/SelectPonitMutations/Indel.png)  
  Variants called by >=2 software has a ~89% precision. Based on the precision, we choose the SNVs voted by >=2 software as the consensus Indels.

## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_SelectPointMutation --file environment.yaml

Then you could activate the environment "mutpipe_SelectPointMutation" through this command:
 
  > $ conda activate mutpipe_SelectPointMutation

### install ANNOVAR
ANNOVAR not includ in conda package, please install ANNOVAR manually.   
To insall ANNOVAR, please apply a ueser license agreement via http://www.openbioinformatics.org/annovar/annovar_download_form.php.  
Since we use hg38 reference, ANNOVAR need addition annotation resources for hg38. The download example is as follows:
> $ perl path/to/annotate_variation.pl -buildver hg38 -downdb -webfrom annovar refGene path/to/humandb/   

The other annotation resources can be found in: https://annovar.openbioinformatics.org/en/latest/user-guide/download/  

**NOTE: If you have installed ANNOVAR or downloaded the humandb resources already, please remember the directory to the `ANNOVAR` and `humandb/`**


## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_SelectPointMutation  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "  
    OR:  
    > \$ sbatch pipe.sbatch.sh

## Demo
### input:
test vcffile we provide under the "demo" folder
### output:
#### output_dir/result/test.tumor.SNV.out  

> chr1 103004573 103004573 T C  
chr1 1045564 1045564 C A  
chr1 109280342 109280342 C T  
chr1 109985119 109985119 G A  
chr1 11082881 11082881 G C   
......  

#### output_dir/result/test.tumor.INDEL.out
> chr1 119421709 119421709 C -  
chr1 151760036 151760046 GAGGGAGAGTA -  
chr1 154960916 154960916 - GACAG  
chr1 180787872 180787872 T -  
chr1 201069289 201069292 CATT -  
...... 

#### output_dir/result/test.SNV.exonic_variant_function
> line4	nonsynonymous SNV	AHCYL1:NM_006621:exon1:c.G67A:p.E23K,	chr1 109985119 109985119 G A  
line6	synonymous SNV	ATP5PB:NM_001688:exon4:c.C381T:p.L127L,	chr1 111456243 111456243 C T  
......

#### output_dir/result/test.SNV.variant_function
> intronic	COL11A1	chr1 103004573 103004573 T C  
intronic	AGRN	chr1 1045564 1045564 C A  
intronic	PSRC1	chr1 109280342 109280342 C T  
......

#### output_dir/result/test.INDEL.exonic_variant_function
>  line7	nonframeshift deletion	ZFYVE9:NM_007324:exon4:c.750_785del:p.250_262del,ZFYVE9:NM_004799:exon4:c.750_785del:p.250_262del,	chr1 52238167 52238202 AAGTATAGGTAGAGACCCCTCCATGTCTGCGATTAC -  
line9	nonframeshift insertion	MIGA1:NM_001363586:exon2:c.91_92insTCTCTG:p.L31delinsLSV,MIGA1:NM_001363584:exon2:c.91_92insTCTCTG:p.L31delinsLSV,MIGA1:NM_198549:exon2:c.187_188insTCTCTG:p.L63delinsLSV,MIGA1:NM_001270384:exon2:c.187_188insTCTCTG:p.L63delinsLSV,MIGA1:NM_001363583:exon2:c.91_92insTCTCTG:p.L31delinsLSV,	chr1 77783343 77783343 - TCTCTG  

#### output_dir/result/test.INDEL.variant_function
> intronic	HSD3B2	chr1 119421709 119421709 C -  
UTR3	MRPL9(NM_001300733:c.*14_*4delTACTCTCCCTC,NM_031420:c.*14_*4delTACTCTCCCTC)   chr1 151760036 151760046 GAGGGAGAGTA -  
intronic	PYGO2	chr1 154960916 154960916 - GACAG  
intronic	XPR1	chr1 180787872 180787872 T -  
......





