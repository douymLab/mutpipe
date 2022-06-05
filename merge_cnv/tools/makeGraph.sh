#INPUT
#SAMPLE="YC_282"
#DEPTH="../DNAcopy/depth/YC_282.depth.regions.logratio.mainchr.bed"
#RESULT_PREFIX="result"
#CHRLEN="/storage/douyanmeiLab/lulu/data/ref/hg38/hg38_len_offset.sorted.txt"
#TMP="tmp"
SAMPLE=$1
DEPTH=$2
CHRLEN=$3
RESULT_PREFIX=$4
TMP=$5
if [ ! -d $TMP/depth ];then
        mkdir -p $TMP/depth
fi
#sort -s -t $'\t' -k 1b,1 $CHRLEN > /storage/douyanmeiLab/lulu/data/ref/hg38/hg38_len_offset.sorted.txt
sed 's/^chr//g' $DEPTH |sort -s -t $'\t' -k 1b,1 > $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.bed
join -1 1 -2 1 $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.bed $CHRLEN| awk '{printf "%s\t%s\t%s\t%s\n",$1,$2+$6,$3+$6,$4}' > $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.position.bed

#e3
awk -F '\t' '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$7,$8}' $RESULT_PREFIX/$SAMPLE.seg_vote_by_3.bed|grep -v "start" > $TMP/$SAMPLE.seg_vote_by_3.nohead.bed
sort -s -t $'\t' -k 1b,1 $TMP/$SAMPLE.seg_vote_by_3.nohead.bed > $TMP/$SAMPLE.seg_vote_by_3.sorted.bed
join -1 1 -2 1 $TMP/$SAMPLE.seg_vote_by_3.sorted.bed $CHRLEN| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2+$7,$3+$7,$4,$5}'> $TMP/$SAMPLE.seg_vote_by_3.position.bed
bedtools intersect -a $TMP/$SAMPLE.seg_vote_by_3.position.bed -b $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.position.bed -wa -wb| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$6,$7,$8,$9,$4}' > $TMP/$SAMPLE.3.gain.loss.points.bed
bedtools intersect -a $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.position.bed -b $TMP/$SAMPLE.3.gain.loss.points.bed -loj| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$9}' > $RESULT_PREFIX/$SAMPLE.3.point.bed


#g2
awk -F '\t' '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$7,$8}' $RESULT_PREFIX/$SAMPLE.seg_vote_by_g2.bed|grep -v "start" > $TMP/$SAMPLE.seg_vote_by_g2.nohead.bed
sort -s -t $'\t' -k 1b,1 $TMP/$SAMPLE.seg_vote_by_g2.nohead.bed > $TMP/$SAMPLE.seg_vote_by_g2.sorted.bed
join -1 1 -2 1 $TMP/$SAMPLE.seg_vote_by_g2.sorted.bed $CHRLEN| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2+$7,$3+$7,$4,$5}'> $TMP/$SAMPLE.seg_vote_by_g2.position.bed
bedtools intersect -a $TMP/$SAMPLE.seg_vote_by_g2.position.bed -b $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.position.bed -wa -wb| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$6,$7,$8,$9,$4}' > $TMP/$SAMPLE.g2.gain.loss.points.bed
bedtools intersect -a $TMP/depth/$SAMPLE.depth.regions.logratio.mainchr.nochr.position.bed -b $TMP/$SAMPLE.g2.gain.loss.points.bed -loj| awk '{printf "%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$9}' > $RESULT_PREFIX/$SAMPLE.g2.point.bed
