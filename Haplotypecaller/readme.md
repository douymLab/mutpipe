# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/Haplotypecaller/Haplotypecaller.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_Haplotypecaller --file environment.yaml

Then you could activate the environment "Haplotypecaller" through this command:
 
  > $ conda activate Haplotypecaller

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA sequence dictionary file: Homo_sapiens_assembly38.dict
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- VQSR resources:   
    + hapmap_3.3.hg38.vcf.gz
    + hapmap_3.3.hg38.vcf.gz.tbi
    + 1000G_omni2.5.hg38.vcf.gz
    + 1000G_omni2.5.hg38.vcf.gz.tbi
    + Homo_sapiens_assembly38.dbsnp138.vcf   
    + Homo_sapiens_assembly38.dbsnp138.vcf.idx         
    + 1000G_phase1.snps.high_confidence.hg38.vcf.gz
    + 1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi
    + Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    + Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi
    + Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz
    + Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi
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
    > \$ conda activate mutpipe_Haplotypecaller   
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "