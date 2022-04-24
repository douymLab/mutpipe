#!/bin/bash
#SBATCH -J index
#SBATCH -p intel-e5
#SBATCH -q normal
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000M
#SBATCH -o /storage/douyanmeiLab/lujinhong/logs/22_4_9/LZ/%x_%J_out.txt

import socket
set +u
module load gcc;
module load jdk/11.0.10;
source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
set -u

##run snakemkake on cluster:
snakemake --unlock --cores 4
#snakemake --rerun-incomplete -j {#jobs} --cluster-config {cluster}.json --cluster "sbatch -p {partition} --account={account} -c {#core} -t #{time} --mem={mem}"
snakemake --rerun-incomplete -j 490 --restart-times 3 --latency-wait 120 --keep-going --cluster "sbatch -p intel-e5 -q large -c 1 -t 48:00:00 --mem=8000 -o /storage/douyanmeiLab/lujinhong/logs/22_4_9/LZ/%x_%J_out.txt "
