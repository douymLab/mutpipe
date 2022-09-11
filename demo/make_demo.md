Download publicly available BAM files using wget
WGS Normal sample (50X)
BAM: wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/WGS_EA_N_1.bwa.dedup.bam

File size: 95GB
BAM INDEX: wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/WGS_EA_N_1.bwa.dedup.bai

WGS Tumor sample (50X)
BAM: wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/WGS_EA_T_1.bwa.dedup.bam

File size: 107GB
BAM INDEX: wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/WGS_EA_T_1.bwa.dedup.bai

#samtools无法直接downsample到一个固定数目的reads
frac=$( samtools idxstats bam_links/normal/WGS_EA.normal.bam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {frac=15000000/total; if (frac > 1) {print 1} else {print frac}}' )
# samtools view -s $frac bam_links/normal/WGS_EA.normal.bam > bam_links/normal/WGS_EA_tiny.normal.bam
sambamba view -h -t 16 -s $frac -f bam --subsampling-seed=20220905 bam_links/normal/WGS_EA.normal.bam -o bam_links/normal/WGS_EA_tiny.normal.bam

#samtools无法直接downsample到一个固定数目的reads
frac=$( samtools idxstats bam_links/tumor/WGS_EA.tumor.bam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {frac=150000/total; if (frac > 1) {print 1} else {print frac}}' )
# samtools view -s $frac bam_links/tumor/WGS_EA.tumor.bam > bam_links/tumor/WGS_EA_tiny.tumor.bam
sambamba view -h -t 16 -s $frac -f bam --subsampling-seed=20220905 bam_links/tumor/WGS_EA.tumor.bam -o bam_links/tumor/WGS_EA_mini.tumor.bam