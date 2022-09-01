rule download_refdb:
    output: {refdb_path}
    params: {refdb_file}
    log: "log/RefCDS_object_ready.log"
    script: 
        '../scripts/download_refdb.R'
        
rule install_dndscv:
	log: "log/dndscv_package_ready.log"
	script:
		'../scripts/package_install.R'