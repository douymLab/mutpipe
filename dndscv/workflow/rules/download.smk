rule download:
    input: {refdb_path}

rule file:
    output: {refdb_path}
    shell: 
        "mkdir -p {refdb_dir};"
        "cd {refdb_dir};"
        "wget -N https://raw.githubusercontent.com/im3sanger/dndscv_data/master/data/RefCDS_human_GRCh38_GencodeV18_recommended.rda"
        