# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/merge_cnv/dag.png)
## Dependency:  
- python 3.6
- snakemake 5.3.0
- R 4.1.2
- ANNOVAR

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_merge_cnv --file environment.yaml

Then you could activate the environment "mutpipe_merge_cnv" through this command:
 
  > $ conda activate mutpipe_merge_cnv

### install ANNOVAR
ANNOVAR not includ in conda package, please install ANNOVAR manually.
To insall ANNOVAR, please apply a ueser license agreement via http://www.openbioinformatics.org/annovar/annovar_download_form.php.
Since we use hg38 reference, ANNOVAR need addition annotation resources for hg38. The download example is as follows:
> $ perl path/to/annotate_variation.pl -buildver hg38 -downdb -webfrom annovar refGene path/to/humandb/

The other annotation resources can be found in: https://annovar.openbioinformatics.org/en/latest/user-guide/download/

**NOTE: If you have installed ANNOVAR or downloaded the humandb resources already, please remember the directory to the `ANNOVAR` and `humandb/`**

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Fasta index file of reference genome (hg38): Homo_sapiens_assembly38.fasta.fai
- Centromeres (hg38): centromeric.txt
- Telomeres (hg38): telomere.txt
The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_merge_cnv  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Input
path/to/BIC_SEQ2/results/{sample}_pvalue.CNVs   
path/to/DNAcopy/result/{sample}.CNVs   
path/to/freec/result/{sample}.tumor.bam_CNVs   
path/to/freec/result/{sample}_median_ratio.txt   
## Output
result/{sample}.seg_vote_by_g2.bed   
result/{sample}.seg_vote_by_3.bed   
anno/{sample}.g2.variant_function   
anno/{sample}.e3.variant_function   
