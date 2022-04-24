#!/bin/bash
#SBATCH -J YC_MT2
#SBATCH -p amd-ep2,intel-e5
#SBATCH -q large
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000M
#SBATCH -o /storage/douyanmeiLab/lulu/mutpipe/TCGA_wu/22_3_9/WGS/log/freec/%x_%J_out.txt
#SBATCH -t 120:00:00

#import socket
#shell.prefix("module load gcc; source /storage/douyanmeiLab/yanmei/tools/miniconda3/etc/profile.d/conda.sh; conda activate base; ")

##interactive jobs:
#srun --pty /bin/bash
set +u
module load gcc
module load jdk/11.0.10
#source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
set -u

##note:
##small amount of jobs: please use debug partition with debug Qos
##large amount of jobs: use intel-e5 and amd-ep2
##amd-ep2-16c: reserved for parallel computing. please make sure the number of CPUs per node could be divided by 16, and use either --exclusive/--ntasks-per-node

##run snakemkake on cluster:
snakemake --unlock --cores 1
#snakemake --rerun-incomplete -j {#jobs} --cluster-config {cluster}.json --cluster "sbatch -p {partition} --account={account} -c {#core} -t #{time} --mem={mem}"
snakemake --rerun-incomplete -j 100 --restart-times 0 --latency-wait 120 --keep-going --cluster "sbatch -J freec -p amd-ep2,intel-e5 -q large -c 1 -t 12:00:00 --mem=6G -o /storage/douyanmeiLab/lulu/mutpipe/TCGA_wu/22_3_9/WGS/log/freec/%x_%J_out.txt"
