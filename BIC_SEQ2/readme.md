# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/BIC_SEQ2/dag.png)
## Dependency:  
- python 3.6.15
- snakemake 5.3.0
- samtools 1.8
- R 4.1.2
- genmap 1.2.0
- NBICseq-norm 0.2.4
- NBICseq-seg 0.7.2

we strongly suggest installing dependencies(expect BIC-seq2) via conda:

  > $ conda create -n mutpipe_bicseq2 --file environment.yaml
  mamba env create --file workflow/envs/aria2.yaml -n aria2

Then you could activate the environment "mutpipe_bicseq2" through this command:
 
  > $ conda activate mutpipe_bicseq2

BIC-seq2 is not included in conda environment, please install BIC-seq2 manually:

  > $ cd tools   
  > $ wget http://compbio.med.harvard.edu/BIC-seq/NBICseq-norm_v0.2.4.tar.gz   
  > $ tar -zxvf NBICseq-norm_v0.2.4.tar.gz   
  > $ wget http://compbio.med.harvard.edu/BIC-seq/NBICseq-seg_v0.7.2.tar.gz   
  > $ tar -zxvf NBICseq-seg_v0.7.2.tar.gz   

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- FASTA sequence of each chromosome of reference genome (hg38): chr*.fa
- Index for hg38: grch38-no-alt.tar.gz

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_bicseq2  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Input
path/to/BQSRTumorBamFolder/{sample}.tumor.bam
## Output
results/{sample}_pvalue.CNVs
