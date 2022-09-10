#!/bin/bash
#SBATCH -J genmap
#SBATCH -p intel-e5
#SBATCH -q normal
#SBATCH -c 20

genmap map -K 150 -E 2 -I resources/grch38-no-alt -O resources/genmap -t -w -bg > resources/genmap.log