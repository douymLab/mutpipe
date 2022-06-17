SAMPLE=$1
BAM_INFO=$2
BAM_CNV_P_VALUE=$3
BAM_RATIO=$4

OUT=$5
#script dir
SCRIPT_DIR=$6
TMP=tmp


if [ ! -d $TMP  ];then
  mkdir $TMP

fi

WINDOW=`grep 'Window' $BAM_INFO | awk -F '\t' '{print $2}'`
grep -v "Start" $BAM_RATIO|awk '{printf "%s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$2+'$WINDOW',$3,$4,$5}'> $TMP/$SAMPLE.tumor.bam_ratio.end.txt
grep -v 'start' $BAM_CNV_P_VALUE > $TMP/$SAMPLE.tumor.bam_CNV.p.value.nohead.txt
bedtools intersect -wa -wb -a $TMP/$SAMPLE.tumor.bam_ratio.end.txt -b $TMP/$SAMPLE.tumor.bam_CNV.p.value.nohead.txt > $TMP/$SAMPLE.intersect.txt
cat $SCRIPT_DIR/median_ratio_for_cnv.R | R --slave --args $TMP/$SAMPLE.intersect.txt $OUT
#sort -n $TMP/$SAMPLE.median_ratio.txt > $OUT
