# Define rules to be run locally when using a compute cluster

localrules:
	download_hs38,
	download_fas_dict,
	download_fas_idx,
	download_pon,
	decom_interval_file

## Downloading reference genome (hg38) via GATK
rule download_hs38:
	output:
		os.path.join(res_dir,"Homo_sapiens_assembly38.fasta.gz"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cd {res_dir};
		FILE=Homo_sapiens_assembly38.fasta.gz
		if [ ! -f "$FILE" ]; then
			wget https://media.githubusercontent.com/media/broadinstitute/gatk/master/src/test/resources/large/Homo_sapiens_assembly38.fasta.gz;
		fi
		"""

## unzip reference genome (hg38) via GATK
rule decom_hs38:
	input: os.path.join(res_dir,"Homo_sapiens_assembly38.fasta.gz"),
	output:
		os.path.join(res_dir,"Homo_sapiens_assembly38.fasta"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cd {res_dir}
		gzip -d Homo_sapiens_assembly38.fasta.gz
		"""

## Creating the FASTA sequence dictionary file
rule download_fas_dict:
	output:
		os.path.join(res_dir,"Homo_sapiens_assembly38.dict"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cd {res_dir}
		gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict .
		"""

## Creating the fasta index file
rule download_fas_idx:
	output:os.path.join(res_dir,"Homo_sapiens_assembly38.fasta.fai"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cd {res_dir}
		gsutil cp -R gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai .
		"""

## Downloading PON
rule download_pon:
	output:
		os.path.join(res_dir,"1000g_pon.hg38.vcf.gz"),
		os.path.join(res_dir,"1000g_pon.hg38.vcf.gz.tbi"),
		os.path.join(res_dir,"small_exac_common_3.hg38.vcf.gz"),
		os.path.join(res_dir,"small_exac_common_3.hg38.vcf.gz.tbi"),
		os.path.join(res_dir,"af-only-gnomad.hg38.vcf.gz"),
		os.path.join(res_dir,"af-only-gnomad.hg38.vcf.gz.tbi"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cd {res_dir}
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/1000g_pon.hg38.vcf.gz .
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/1000g_pon.hg38.vcf.gz.tbi .
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz .
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/small_exac_common_3.hg38.vcf.gz.tbi .
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/af-only-gnomad.hg38.vcf.gz .
		gsutil cp -R gs://gatk-best-practices/somatic-hg38/af-only-gnomad.hg38.vcf.gz.tbi .
		"""

## unzip the WES interval file
rule decom_interval_file:
	output:
		os.path.join(res_dir,"S31285117_Padded.list"),
	conda: "mutpipe_mutect2",
	shell:
		"""
		cp data/S31285117_Padded.list.gz {res_dir}/S31285117_Padded.list.gz
		cd {res_dir}
		gzip -d S31285117_Padded.list.gz
		"""