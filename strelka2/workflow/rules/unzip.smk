## unzip reference genome (hg38) via GATK
rule decom_hs38:
	input: 
		fa = os.path.join(gz_ref_dir,fa_gz),
		fai = os.path.join(gz_ref_dir,fai),
		dict = os.path.join(gz_ref_dir,dict),
	output:
		fa = os.path.join(res_dir,fa),
		fai = os.path.join(res_dir,fai),
		dict = os.path.join(res_dir,dict),
	shell:
		"""
		zcat {input.fa} > {output.fa};
		cp -n {input.fai} {output.fai};
		cp -n {input.dict} {output.dict};
		"""