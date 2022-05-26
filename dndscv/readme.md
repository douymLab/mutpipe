# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/dndscv/dndscv.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_dndscv --file environment.yaml

Then you could activate the environment "mutpipe_dndscv" through this command:
 
  > $ conda activate mutpipe_dndscv

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- RefCDS objects to run dndscv: RefCDS_human_GRCh38.p12_dNdScv.0.1.0.rda  
Note: We chose this RefCDS because our reference genome is hg38. You could change it as you need and download it from https://github.com/im3sanger/dndscv_data

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_dndscv 
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "  
    > OR \$ sbatch pipe.sbatch.sh

## Demo
### input:
The input file is the output file from mutpipe's SelectPointMutation
test inputfiles we provide under the "demo" folder

### output:
outputdir/drivergene.csv
|   |gene_name|qglobal_cv|
|:---:|:---------:|:----------:|
|17498|TP53|1.52027279654021E-11|



