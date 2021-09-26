#!/bin/bash
#SBATCH -J indel_test
#SBATCH -p intel-debug,amd-debug
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -e %J.err
#SBATCH -o %J.out

#sinfo
#stat_partition
#stat_job
#stat_node

#import socket

#shell.prefix("module load gcc; source /storage/douyanmeiLab/lulu/tools/miniconda3/etc/profile.d/conda.sh; conda activate mutpipe;")

##interactive jobs:
#srun --pty /bin/bash


##note: 
##small amount of jobs: please use debug partition with debug Qos
##large amount of jobs: use intel-e5 and amd-ep2
##amd-ep2-16c: reserved for parallel computing. please make sure the number of CPUs per node could be divided by 16, and use either --exclusive/--ntasks-per-node

##run snakemkake on cluster:
snakemake --unlock --cores 4
snakemake --rerun-incomplete -j #{jobs} --cluster-config {cluster}.json --cluster "sbatch -p {partition} --account={account} -c {#core} -t #{time} --mem={mem}"

#login01	172.16.75.132:22
#login02	172.16.75.132:10002
#login03	172.16.75.132:10013

