# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/Qualitycontrol/Qualitycontrol.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_Qualitycontrol --file environment.yaml

Then you could activate the environment "mutpipe_Qualitycontrol" through this command:
 
  > $ conda activate mutpipe_Qualitycontrol

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- Common germline variant sites: 
   + small_exac_common_3.hg38.vcf.gz
   + small_exac_common_3.hg38.vcf.gz.tbi
- WES interval list: S31285117_Padded.bed.gz  
Note: The interval list is based on our WES kit is Sureselect Human All Exon V7. The list and other version kit's list can download form https://earray.chem.agilent.com/suredesign/

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate mutpipe_Qualitycontrol  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Demo
### input:
test bamfile we provide under the "demo" folder
### output:
> output_dir/allsample_contamination  

>sample	contamination	error  
test.tumor	0.0	1.0

> output_dir/allsamples_statistics.list

> sample	type	count	mean	std	min	25%	50%	75%	max  
test	normal	236.0	15.283898305084746	9.38989470712482	1.0	7.0	13.0	24.25	31.0  
test	tumor	242.0	48.67355371900826	23.84521409950976	1.0	30.5	58.0	65.75	84.0

#### others:
+ output_dir/bam_stats/test/test.normal.flagstats
+ output_dir/bam_stats/test/test.normal.stats
+ output_dir/bam_stats/test/test.tumor.flagstats
+ output_dir/bam_stats/test/test.tumor.stats


