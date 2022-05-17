#!/bin/sh

paste <(cat $1 | awk '$(NF-1)<0.01') \
<(cat $1 |awk '$(NF-1)<0.01 {print $8}'| \
sed 's/,/ /g'|while read line;do echo $line| \
sed 's/ /\n/g'|sort|uniq|wc -l;done)|awk '$NF<3'|cut -f 1-11 >> $2
