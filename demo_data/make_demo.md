## downsample BAM file

## real BAM file

```{bash}
nbam=YC-104.normal.bam
tbam=YC-104.tumor.bam
```
## normal

## percentage of reads to keep

```{bash}
frac=$( samtools idxstats $nbam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {frac=200000/total; if (frac > 1) {print 1} else {print frac}}' )
echo ${frac}
```

## downsample BAM file

```{bash}
sambamba view -h -t 16 -s $frac -f bam --subsampling-seed=20220905 $nbam -o YC-104.normal.bam
```

## tumor

## percentage of reads to keep

```{bash}
frac=$( samtools idxstats $tbam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {frac=600000/total; if (frac > 1) {print 1} else {print frac}}' )
echo ${frac}
```

## downsample BAM file

```{bash}
sambamba view -h -t 16 -s $frac -f bam --subsampling-seed=20220905 $tbam -o YC-104.tumor.bam
```