# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/FREEC/dag.png)
## Dependency:  
- python 3.6
- snakemake 5.3.0
- R 4.1.2
- dplyr
- stringr
- rtracklayer
- FREEC

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_freec --file environment.yaml

Then you could activate the environment "mutpipe_freec" through this command:
 
  > $ conda activate mutpipe_freec

Some R package is not included in conda environment, please install R package manually:

  > \> if (!require("BiocManager", quietly = TRUE))   
  > \> &nbsp;&nbsp;&nbsp;&nbsp;install.packages("BiocManager")   
  > \> BiocManager::install("dplyr")   
  > \> BiocManager::install("stringr")   
  > \> BiocManager::install("rtracklayer")   

FREEC also needs to be installed manually:

  > $ cd tools   
  > $ wget https://github.com/BoevaLab/FREEC/archive/refs/tags/v11.6   
  > $ tar -zxvf FREEC-11.6.tar.gz   
  > $ cd FREEC-11.6/src   
  > $ make   

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Fasta index file of reference genome (hg38): Homo_sapiens_assembly38.fasta.fai

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_freec  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Input
path/to/BQSRTumorBamFolder/{sample}.tumor.bam
## Output
result/{sample}.tumor.bam_CNVs
result/{sample}.tumor.bam_info.txt
result/{sample}.tumor.bam_ratio.txt
result/{sample}_median_ratio.txt
