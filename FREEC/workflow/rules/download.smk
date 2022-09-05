# Define rules to be run locally when using a compute cluster
localrules:
    download_index,
    download_scripts

rule download_index:
    output: index_path
    log: os.path.join(outPath,"index.downloaded.log"),
    conda: "mutpipe_freec"
    shell: 
        "gsutil cp gs://genomics-public-data/resources/broad/hg38/v0/{index_file} {index_dir} &&"
        "echo 'Index downloaded'> {log}"

rule download_scripts:
    output: 
        "workflow/scripts/makeGraph.R",
        "workflow/scripts/assess_significance.R",
    log: os.path.join(outPath,"scripts.downloaded.log"),
    shell:
        "wget https://cdn.jsdelivr.net/gh/BoevaLab/FREEC@master/scripts/makeGraph.R -O workflow/scripts/makeGraph.R;"
        "wget https://cdn.jsdelivr.net/gh/BoevaLab/FREEC@master/scripts/assess_significance.R -O workflow/scripts/assess_significance.R &&"
        "echo 'Done downloading scripts' > {log}"