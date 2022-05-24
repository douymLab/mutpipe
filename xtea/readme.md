# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/xtea/xtea.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_xtea --file environment.yaml

Then you could activate the environment "mutpipe_xtea" through this command:
 
  > $ conda activate mutpipe_xtea

### Install xtea
xTEA needs some scripts which not include conda environments. Please install xTEA manually.  
To install xTEA:
> $ git clone https://github.com/parklab/xTea.git  

The scripts in the folder named "xtea" will use later. Remember the path to the diretory.

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- Comprehensive gene annotation: gencode.v33.annotation.gff3
- pre-processed repeat library used by xTea: rep_lib_annotation   
  (more informations: https://github.com/parklab/xTea )

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_xtea  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

