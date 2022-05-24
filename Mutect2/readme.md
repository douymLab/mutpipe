# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/Mutect2/Mutect2.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_mutect2 --file environment.yaml

Then you could activate the environment "mutpipe_mutect2" through this command:
 
  > $ conda activate mutpipe_mutect2

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- Pannel of Normal:   
    + 1000g_pon.hg38.vcf.gz   
    + 1000g_pon.hg38.vcf.gz.tbi         
    + small_exac_common_3.hg38.vcf.gz
    + small_exac_common_3.hg38.vcf.gz.tbi
    + af-only-gnomad.hg38.vcf.gz
    + af-only-gnomad.hg38.vcf.gz.tbi
- WES interval list: S31285117_Padded.list  
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
    > \$ conda activate mutpipe_mutect2  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Demo
### input:
test bamfile we provide under the "demo" folder
### output:
> output_dir/test.somatic.mt2.SNVs.vcf.gz  

> chr1	1045564	.	C	A	.	PASS	AS_FilterStatus=SITE;AS_SB_TABLE=44,52|2,3;DP=101;ECNT=1;GERMQ=93;MBQ=34,24;MFRL=255,378;MMQ=60,60;MPOS=6;NALOD=1.15;NLOD=3.91;POPAF=4.00;ROQ=14;TLOD=7.85	GT:AD:AF:DP:F1R2:F2R1:SB	0/0:16,0:0.067:16:7,0:6,0:5,11,0,0	0/1:80,5:0.069:85:27,1:36,3:39,41,2,3

> output_dir/test.somatic.mt2.INDELs.vcf.gz  

> chr1	7745037	.	G	GGCT	.	PASS	AS_FilterStatus=SITE;AS_SB_TABLE=25,82|3,3;DP=114;ECNT=1;GERMQ=93;MBQ=34,20;MFRL=220,210;MMQ=60,60;MPOS=43;NALOD=1.30;NLOD=5.72;POPAF=4.00;ROQ=93;TLOD=15.38	GT:AD:AF:DP:F1R2:F2R1:SB	0/0:31,0:0.048:31:9,0:7,0:13,18,0,0	0/1:76,6:0.055:82:38,3:30,0:12,64,3,3



