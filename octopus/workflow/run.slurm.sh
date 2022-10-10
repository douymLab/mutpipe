conda activate snakemake
## submit to cluster
snakemake -j 668 \
    --use-conda \
    --cluster-config workflow/scripts/slurm.json \
    --cluster "sbatch -p {cluster.partition} \
                      -q {cluster.qos} \
                      -c {cluster.cpus-per-task} \
                      --mem {cluster.mem} \
                      -t {cluster.time} \
                      -o {cluster.output} \
                      -e {cluster.error}"
