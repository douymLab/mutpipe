#!/bin/bash
#INPUT
SAMPLE=$1
BIC=$2
DC=$3
FREEC=$4
FREEC_RATIO=$5
CHR_LEN=$6
CENTROMERE=$7
TELOMERE=$8
STREAM_WINDOWN=$9

#TMP
TMP=tmp

#OUTPUT
OUTDIR=${10}
echo $OUTDIR
VOTE_BY_g2=result/$SAMPLE.vote_by_g2.bed
VOTE_BY_3=result/$SAMPLE.vote_by_3.bed

#SCRIPT_DIR
SCRIPT_DIR=${11}

#function
function preprocess {
	#rm -rf $OUTDIR && mkdir -p $OUTDIR 
	#rm -rf $TMP && mkdir -p $TMP 
	if [ ! -d $OUTDIR ];then
      		mkdir -p $OUTDIR
	fi
	if [ ! -d $TMP ];then
      		mkdir -p $TMP
	fi
	ln -s $BIC $TMP/$SAMPLE.bicseq2.0.txt
	ln -s $DC $TMP/$SAMPLE.dnacopy.0.txt
	ln -s $FREEC $TMP/$SAMPLE.freec.0.txt
	ln -s $FREEC_RATIO $TMP/$SAMPLE.freec.ratio.0.txt


	#awk '{printf "%s\t%s\n",$1,$2}' /storage/douyanmeiLab/reference/human_g1k_v37_decoy.fasta.fai > hg37.genome
	sed 's/chr//' $TMP/$SAMPLE.bicseq2.0.txt > $TMP/$SAMPLE.bicseq2.txt
	sed 's/chr//' $TMP/$SAMPLE.dnacopy.0.txt > $TMP/$SAMPLE.dnacopy.txt
	awk -F "\\t" '{if(length($1)<=2 && $1!="M") print}' $TMP/$SAMPLE.freec.0.txt > $TMP/$SAMPLE.freec.txt
	grep -v "start" $TMP/$SAMPLE.freec.ratio.0.txt | awk -F "\\t" '{if(length($1)<=2 && $1!="M") print}' > $TMP/$SAMPLE.freec.ratio.txt
	
	grep -v "start" $TMP/$SAMPLE.bicseq2.txt| awk '{printf "%s\t%s\t%s\n",$1,$2,$3}'|sed 's/chr//' |grep "^[0-9 X Y]"> $TMP/$SAMPLE.bicseq2.bed
	grep -v "start" $TMP/$SAMPLE.dnacopy.txt| awk '{printf "%s\t%s\t%s\n",$2,$3,$4}'|sed 's/chr//' |grep "^[0-9 X Y]"|sed "s/^X/23/g"|sed "s/^Y/24/g"|sort -k1,1n -k2,2n|sed "s/^23/X/g"|sed "s/^24/Y/g" > $TMP/$SAMPLE.dnacopy.bed
	bedtools complement -i $TMP/$SAMPLE.freec.txt -g $CHR_LEN > $TMP/$SAMPLE.freec.bed.step1
	awk '{printf "%s\t%s\t%s\n",$1,$2+1,$3-1}' $TMP/$SAMPLE.freec.bed.step1|awk '{if ($2==1) printf "%s\t%s\t%s\n",$1,0,$3; else printf "%s\t%s\t%s\n",$1,$2,$3}'> $TMP/$SAMPLE.freec.bed.step2
	python $SCRIPT_DIR/handel_freec.py -freec $TMP/$SAMPLE.freec.bed.step2 -chrlen $CHR_LEN -o $TMP/$SAMPLE.freec.bed.step2.1
	cat $TMP/$SAMPLE.freec.txt $TMP/$SAMPLE.freec.bed.step2.1 > $TMP/$SAMPLE.freec.bed.step3
sort -k1,1n -k2,2n $TMP/$SAMPLE.freec.bed.step3 > $TMP/$SAMPLE.freec.bed.step4
	awk '{printf "%s\t%s\t%s\n",$1,$2,$3}' $TMP/$SAMPLE.freec.bed.step4 |grep "^[0-9 X Y]"|sed "s/^X/23/g"|sed "s/^Y/24/g"|sort -k1,1n -k2,2n|sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.freec.bed
}

function calculate_interval {
	bedtools complement -i $TMP/$SAMPLE.bicseq2.bed -g $CHR_LEN -L > $TMP/$SAMPLE.bicseq2.interval.bed
	bedtools complement -i $TMP/$SAMPLE.dnacopy.bed -g $CHR_LEN -L > $TMP/$SAMPLE.dnacopy.interval.bed
	bedtools complement -i $TMP/$SAMPLE.freec.bed -g $CHR_LEN > $TMP/$SAMPLE.freec.interval.bed
}
function expand_interval {
	awk '{printf "%s\t%s\t%s\n",$1,$2-50000,$3+50000}' $TMP/$SAMPLE.freec.interval.bed |sed 's/-50000/0/g'>$TMP/$SAMPLE.freec.interval.expand.bed
	awk '{printf "%s\t%s\t%s\n",$1,$2-50000,$3+50000}' $TMP/$SAMPLE.bicseq2.interval.bed |sed 's/-50000/0/g' >$TMP/$SAMPLE.bicseq2.interval.expand.bed
	awk '{printf "%s\t%s\t%s\n",$1,$2-50000,$3+50000}' $TMP/$SAMPLE.dnacopy.interval.bed |sed 's/-50000/0/g'>$TMP/$SAMPLE.dnacopy.interval.expand.bed

	join $TMP/$SAMPLE.bicseq2.interval.expand.bed $CHR_LEN -a 1 -o 1.1 -o 1.2 -o 1.3 -o 2.2 |awk '{if ($3>$4-1) print $1,$2,$4; else print $1,$2,$3}'|sed 's/ /\t/g' > $TMP/$SAMPLE.bicseq2.interval.expand.1.bed
	join $TMP/$SAMPLE.dnacopy.interval.expand.bed $CHR_LEN -a 1 -o 1.1 -o 1.2 -o 1.3 -o 2.2 |awk '{if ($3>$4-1) print $1,$2,$4; else print $1,$2,$3}'|sed 's/ /\t/g' > $TMP/$SAMPLE.dnacopy.interval.expand.1.bed
	join $TMP/$SAMPLE.freec.interval.expand.bed $CHR_LEN -a 1 -o 1.1 -o 1.2 -o 1.3 -o 2.2 |awk '{if ($3>$4-1) print $1,$2,$4; else print $1,$2,$3}'|sed 's/ /\t/g' > $TMP/$SAMPLE.freec.interval.expand.1.bed
}

function calculate_intersection {
	python $SCRIPT_DIR/cal_intersection_by_greater_than_num.py -bicseq2 $TMP/$SAMPLE.bicseq2.interval.expand.1.bed -dnacopy $TMP/$SAMPLE.dnacopy.interval.expand.1.bed -freec $TMP/$SAMPLE.freec.interval.expand.1.bed -chrlen $CHR_LEN -out $TMP/$SAMPLE.123.bed -soft_num 1
}

function find_breakpoints_in_intersection {
	bedtools intersect -a $TMP/$SAMPLE.123.bed -b $TMP/$SAMPLE.bicseq2.interval.bed -loj > $TMP/$SAMPLE.bicseq2.bp.bed
	bedtools intersect -a $TMP/$SAMPLE.123.bed -b $TMP/$SAMPLE.dnacopy.interval.bed -loj > $TMP/$SAMPLE.dnacopy.bp.bed
	bedtools intersect -a $TMP/$SAMPLE.123.bed -b $TMP/$SAMPLE.freec.interval.bed -loj > $TMP/$SAMPLE.freec.bp.bed


	awk '{printf "%s\t%s\t%s\t%s\n",$1"~"$2"~"$3,$4,$5,$6}' $TMP/$SAMPLE.bicseq2.bp.bed > $TMP/$SAMPLE.bicseq2.bp.concat.bed
	awk '{printf "%s\t%s\t%s\t%s\n",$1"~"$2"~"$3,$4,$5,$6}' $TMP/$SAMPLE.dnacopy.bp.bed > $TMP/$SAMPLE.dnacopy.bp.concat.bed
	awk '{printf "%s\t%s\t%s\t%s\n",$1"~"$2"~"$3,$4,$5,$6}' $TMP/$SAMPLE.freec.bp.bed > $TMP/$SAMPLE.freec.bp.concat.bed
	awk '{printf "%s\n",$1"~"$2"~"$3}' $TMP/$SAMPLE.123.bed > $TMP/$SAMPLE.3.concat.bed

	join $TMP/$SAMPLE.3.concat.bed $TMP/$SAMPLE.bicseq2.bp.concat.bed -a 1 -e 'empty' -o 1.1 -o 2.2 -o 2.3 -o 2.4 > $TMP/$SAMPLE.concat.bicseq2.bed
	join $TMP/$SAMPLE.concat.bicseq2.bed $TMP/$SAMPLE.dnacopy.bp.concat.bed -a 1 -e 'empty' -o 1.1 -o 1.2 -o 1.3 -o 1.4 -o 2.2 -o 2.3 -o 2.4 > $TMP/$SAMPLE.bicseq2.dnacopy.bed
	join $TMP/$SAMPLE.bicseq2.dnacopy.bed $TMP/$SAMPLE.freec.bp.concat.bed -a 1 -e 'empty' -o 1.1 -o 1.2 -o 1.3 -o 1.4 -o 1.5 -o 1.6 -o 1.7 -o 2.2 -o 2.3 -o 2.4 > $TMP/$SAMPLE.bicseq2.dnacopy.freec.bed
	sed 's/~/ /g' $TMP/$SAMPLE.bicseq2.dnacopy.freec.bed > $TMP/$SAMPLE.bicseq2.dnacopy.freec.bp.bed

}
function choose_representative_breakpoints {
	python $SCRIPT_DIR/make_consensus_bp.py -bp $TMP/$SAMPLE.bicseq2.dnacopy.freec.bp.bed -out $TMP/$SAMPLE.bicseq2.dnacopy.freec.consensus.bp.bed
}
function add_centromeres_telomeres {
	python $SCRIPT_DIR/generate_consensus_bp.py -cbp $TMP/$SAMPLE.bicseq2.dnacopy.freec.consensus.bp.bed -centro $CENTROMERE -telo $TELOMERE -bp $TMP/$SAMPLE.bp.txt -seg $TMP/$SAMPLE.seg.txt
}

function generate_results {
	grep -v 'start' $TMP/$SAMPLE.bicseq2.txt |sed 's/chr//g' > $TMP/$SAMPLE.bicseq2.nochr.txt
	grep -v 'start' $TMP/$SAMPLE.dnacopy.txt |awk '{printf "%s\t%s\t%s\t%s\n", $2,$3,$4,$6}'> $TMP/$SAMPLE.dnacopy.formated.txt
	bedtools intersect -b $TMP/$SAMPLE.seg.txt -a $TMP/$SAMPLE.dnacopy.formated.txt -wb | awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$5,$6,$7,$1,$2,$3,$4}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg.dnacopy.txt
	# log2 ratio
	bedtools intersect -b $TMP/$SAMPLE.seg.txt -a $TMP/$SAMPLE.bicseq2.nochr.txt -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$13,$14,$15,$1,$2,$3,$9,$11}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg.bicseq2.txt
	# log2 tumor us expected ratio
	bedtools intersect -b $TMP/$SAMPLE.seg.txt -a $TMP/$SAMPLE.bicseq2.nochr.txt -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$13,$14,$15,$1,$2,$3,$10,$11}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg.bicseq2.txt
	
	grep -v 'start' $TMP/$SAMPLE.freec.ratio.txt > $TMP/$SAMPLE.freec.ratio.nohead.txt
	bedtools intersect -a $TMP/$SAMPLE.freec.bed -b $TMP/$SAMPLE.freec.ratio.nohead.txt -loj| awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$11,$9,$10,$7}'|sed 's/\t\./\t1/g' > $TMP/$SAMPLE.freec.1.bed
	#awk '{if ($4!=-1) printf "%s\t%s\t%s\t%s\n",$1,$2,$3,log($4)/log(2); else printf "%s\t%s\t%s\t%s\n",$1,$2,$3,"-inf"}' $TMP/$SAMPLE.freec.0.bed > $TMP/$SAMPLE.freec.1.bed
	bedtools intersect -b $TMP/$SAMPLE.seg.txt -a $TMP/$SAMPLE.freec.1.bed -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$8,$9,$10,$1,$2,$3,$4,$5,$6,$7}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg.freec.txt

	python $SCRIPT_DIR/merge_logratio.py -bicseq2 $TMP/$SAMPLE.seg.bicseq2.txt -dnacopy $TMP/$SAMPLE.seg.dnacopy.txt -freec $TMP/$SAMPLE.seg.freec.txt -bic_upper 0.2016339 -bic_lower -0.4150375 -dc_upper 0.2016339 -dc_lower -0.4150375 -freec_upper 0.2016339 -freec_lower -0.4150375 -out $TMP/$SAMPLE.seg_vote.txt -seg $TMP/$SAMPLE.seg.txt
	#python merge_logratio.ori.bak.py -bicseq2 $TMP/$SAMPLE.seg.bicseq2.txt -dnacopy $TMP/$SAMPLE.seg.dnacopy.txt -freec $TMP/$SAMPLE.seg.freec.txt -bic_upper 0.3219281 -bic_lower -0.4150375 -dc_upper 0.3219281 -dc_lower -0.4150375 -freec_upper 0.3219281 -freec_lower -0.4150375 -out $TMP/$SAMPLE.seg_vote.txt -seg $TMP/$SAMPLE.seg.txt
	#python merge_logratio.py -bicseq2 $TMP/$SAMPLE.seg.bicseq2.txt -dnacopy $TMP/$SAMPLE.seg.dnacopy.txt -freec $TMP/$SAMPLE.seg.freec.txt -bic_upper 0.3219281 -bic_lower -0.4150375 -dc_upper 2.3 -dc_lower 1.6 -freec_upper 2 -freec_lower 2 -out $TMP/$SAMPLE.seg_vote.txt -seg $TMP/$SAMPLE.seg.txt
	awk -F '\t' '{if ($16>=2) printf "%s\t%s\t%s\t%s\n",$1,$2,$3,"gain"; else if ($17>=2) printf "%s\t%s\t%s\t%s\n",$1,$2,$3,"loss"}' $TMP/$SAMPLE.seg_vote.txt > $TMP/$SAMPLE.seg_vote_by_g2.txt
	awk -F '\t' '{if ($16==3) printf "%s\t%s\t%s\t%s\n",$1,$2,$3,"gain"; else if ($17==3) printf "%s\t%s\t%s\t%s\n",$1,$2,$3,"loss"}' $TMP/$SAMPLE.seg_vote.txt > $TMP/$SAMPLE.seg_vote_by_3.txt

	#merge segment voted by 3 software
	grep -v 'start' $TMP/$SAMPLE.seg_vote_by_3.txt|awk '{if ($4=="gain") print $0}'>$TMP/$SAMPLE.seg_vote_by_3_gain.txt
	grep -v 'start' $TMP/$SAMPLE.seg_vote_by_3.txt|awk '{if ($4=="loss") print $0}'>$TMP/$SAMPLE.seg_vote_by_3_loss.txt
	python $SCRIPT_DIR/merge_seg.py -chrlen $CHR_LEN -seg $TMP/$SAMPLE.seg_vote_by_3_gain.txt -fun gain -out $TMP/$SAMPLE.merged_seg_vote_by_3_gain.txt
	python $SCRIPT_DIR/merge_seg.py -chrlen $CHR_LEN -seg $TMP/$SAMPLE.seg_vote_by_3_loss.txt -fun loss -out $TMP/$SAMPLE.merged_seg_vote_by_3_loss.txt
	cat $TMP/$SAMPLE.merged_seg_vote_by_3_gain.txt $TMP/$SAMPLE.merged_seg_vote_by_3_loss.txt |sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g" > $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt
	
	
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt -a $TMP/$SAMPLE.dnacopy.formated.txt -wb | awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$5,$6,$7,$1,$2,$3,$4}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_dnacopy_3.bed
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt -a $TMP/$SAMPLE.bicseq2.nochr.txt -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$13,$14,$15,$1,$2,$3,$9}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_bicseq2_3.bed
	#bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt -a $TMP/$SAMPLE.freec.1.bed -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$7,$8,$9,$1,$2,$3,$4,$5,$6}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_freec_3.bed
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt -a $TMP/$SAMPLE.freec.1.bed -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$8,$9,$10,$1,$2,$3,$4,$5,$6,$7}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_freec_3.bed
	
	#python $SCRIPT_DIR/merge_logratio_v2.py -bicseq2 $TMP/$SAMPLE.seg_bicseq2_3.bed -dnacopy $TMP/$SAMPLE.seg_dnacopy_3.bed -freec $TMP/$SAMPLE.seg_freec_3.bed -out $TMP/$SAMPLE.seg_vote_3.sorted.bed -seg $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt
	python $SCRIPT_DIR/merge_logratio_v3.py -bicseq2 $TMP/$SAMPLE.seg_bicseq2_3.bed -dnacopy $TMP/$SAMPLE.seg_dnacopy_3.bed -freec $TMP/$SAMPLE.seg_freec_3.bed -out $TMP/$SAMPLE.seg_vote_3.sorted.bed -seg $TMP/$SAMPLE.merged_seg_vote_by_3.sorted.txt -bic_upper 0.2016339 -bic_lower -0.4150375 -dc_upper 0.2016339 -dc_lower -0.4150375 -freec_upper 0.2016339 -freec_lower -0.4150375
	awk -F '\t' '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$6,$18,$10}' $TMP/$SAMPLE.seg_vote_3.sorted.bed > $OUTDIR/$SAMPLE.seg_vote_by_3.bed
	
	#merge segments voted by more than 2 software
	grep -v 'start' $TMP/$SAMPLE.seg_vote_by_g2.txt|awk '{if ($4=="gain") print $0}'>$TMP/$SAMPLE.seg_vote_by_g2_gain.txt
	grep -v 'start' $TMP/$SAMPLE.seg_vote_by_g2.txt|awk '{if ($4=="loss") print $0}'>$TMP/$SAMPLE.seg_vote_by_g2_loss.txt
	python $SCRIPT_DIR/merge_seg.py -chrlen $CHR_LEN -seg $TMP/$SAMPLE.seg_vote_by_g2_gain.txt -fun gain -out $TMP/$SAMPLE.merged_seg_vote_by_g2_gain.txt
	python $SCRIPT_DIR/merge_seg.py -chrlen $CHR_LEN -seg $TMP/$SAMPLE.seg_vote_by_g2_loss.txt -fun loss -out $TMP/$SAMPLE.merged_seg_vote_by_g2_loss.txt
	cat $TMP/$SAMPLE.merged_seg_vote_by_g2_gain.txt $TMP/$SAMPLE.merged_seg_vote_by_g2_loss.txt |sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g" > $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt
	#python merge_seg.py -chrlen ../v2/hg37.main.genome -seg seg_vote_by_g2.txt -out merged_seg_vote_by_g2.txt
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt -a $TMP/$SAMPLE.dnacopy.formated.txt -wb | awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$5,$6,$7,$1,$2,$3,$4}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_dnacopy_g2.bed
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt -a $TMP/$SAMPLE.bicseq2.nochr.txt -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$13,$14,$15,$1,$2,$3,$9}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_bicseq2_g2.bed
	#bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt -a $TMP/$SAMPLE.freec.1.bed -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$7,$8,$9,$1,$2,$3,$4,$5,$6}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_freec_g2.bed
	bedtools intersect -b $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt -a $TMP/$SAMPLE.freec.1.bed -wb|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$8,$9,$10,$1,$2,$3,$4,$5,$6,$7}'|sed 's/X/23/g' |sed 's/Y/24/g'| sort -k1,1n -k2,2n |sed "s/^23/X/g"|sed "s/^24/Y/g"> $TMP/$SAMPLE.seg_freec_g2.bed
	#python $SCRIPT_DIR/merge_logratio_v2.py -bicseq2 $TMP/$SAMPLE.seg_bicseq2_g2.bed -dnacopy $TMP/$SAMPLE.seg_dnacopy_g2.bed -freec $TMP/$SAMPLE.seg_freec_g2.bed -out $TMP/$SAMPLE.seg_vote_g2.bed -seg $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt
	python $SCRIPT_DIR/merge_logratio_v3.py -bicseq2 $TMP/$SAMPLE.seg_bicseq2_g2.bed -dnacopy $TMP/$SAMPLE.seg_dnacopy_g2.bed -freec $TMP/$SAMPLE.seg_freec_g2.bed -out $TMP/$SAMPLE.seg_vote_g2.bed -seg $TMP/$SAMPLE.merged_seg_vote_by_g2.sorted.txt -bic_upper 0.2016339 -bic_lower -0.4150375 -dc_upper 0.2016339 -dc_lower -0.4150375 -freec_upper 0.2016339 -freec_lower -0.4150375
	awk -F '\t' '{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$6,$18,$10}' $TMP/$SAMPLE.seg_vote_g2.bed > $OUTDIR/$SAMPLE.seg_vote_by_g2.bed
}

function main {
	preprocess
	calculate_interval
	expand_interval
	calculate_intersection
	find_breakpoints_in_intersection
	choose_representative_breakpoints
	add_centromeres_telomeres
	generate_results
}
main











