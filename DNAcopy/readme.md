# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/DNAcopy/dag.png)
## Dependency:  
- python 3.6.15
- snakemake 5.3.0
- mosdepth 0.3.3
- R 4.1.2
- DNAcopy 1.70.0

we strongly suggest installing dependencies(expect DNAcopy) via conda:

  > $ conda create -n mutpipe_dnacopy --file environment.yaml

Then you could activate the environment "mutpipe_dnacopy" through this command:
 
  > $ conda activate mutpipe_dnacopy

DNAcopy is not included in conda environment, please install DNAcopy manually:

  > \> if (!require("BiocManager", quietly = TRUE))   
  > \> &nbsp;&nbsp;&nbsp;&nbsp;install.packages("BiocManager")   
  > \> BiocManager::install("DNAcopy")   

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
results/{sample}.CNVs   
results/{sample}.mapd   
