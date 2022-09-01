conda activate mutpipe_dndscv
## network part
snakemake --cores 1 download_refdb
snakemake --cores 1 install_dndscv
## submit to cluster
snakemake -j 666\
    --cluster-config workflow/scripts/slurm.json\
    --cluster "sbatch -p {cluster.partition}\
                      -q {cluster.qos}\
                      -c {cluster.cpus-per-task}\
                      --mem {cluster.mem}\
                      -t {cluster.time}\
                      -o {cluster.output}\
                      -e {cluster.error}"
