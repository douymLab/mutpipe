# Define rules to be run locally when using a compute cluster
localrules:
    download_refdb,
    install_dndscv

rule download_refdb:
	output: 
		refdb = {refdb_path},
		success = os.path.join(outPath,'refcds_downloaded.success')
	params: {refdb_file}
	conda:
		"mutpipe_dndscv",
	log: 
		os.path.join(outPath,"RefCDS_object_ready.log"),
	script:
		'../scripts/download_refdb.R'

rule install_dndscv:
	output: 
		success = os.path.join(outPath,'dnds_installed.success')
	conda:
		"mutpipe_dndscv",
	log: 
		os.path.join(outPath,"dndscv_package_install.log"),
	script:
		'../scripts/package_install.R'