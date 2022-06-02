import argparse
import numpy as np
from collections import defaultdict, namedtuple

#centromere
#http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz
#telomere
#https://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/gap.txt.gz
parser = argparse.ArgumentParser(description="merge segments")
parser.add_argument('-chrlen', type=str, default=None, help='chrlen')
parser.add_argument('-seg', type=str, default=None, help='bed')
parser.add_argument('-fun', type=str, default=None, help='gain or loss')
parser.add_argument('-out', type=str, default=None, help='out seg')

args = parser.parse_args()

chrlen = args.chrlen
seg = args.seg
out = args.out
fun = args.fun

bps = defaultdict(set)
segs = defaultdict(list)

segf = open(seg, 'r')
for line in segf:

    fields = line.strip().split("\t")
    if fields[1] == "start":
        continue
    chrom, start, end = fields[0], int(fields[1]), int(fields[2])
    bps[chrom].add(start)
    bps[chrom].add(end)

segf.close()

#chrlenf = open(chrlen, 'r')
#for line in chrlenf:
#    fields = line.strip().split('\t')
#    chrom, clen = fields[0], int(fields[1])
#    if chrom in bps.keys():
#        bps[chrom].add(0)
#        bps[chrom].add(clen)
#chrlenf.close()

print("after sorting...")
bpl = defaultdict(list)
mbpl = defaultdict(list)
for chrom in bps.keys():
    bpl[chrom] = list(bps[chrom])
    bpl[chrom].sort()
    print(chrom, bpl[chrom])
    
    i = 0
    while i < len(bpl[chrom]) - 1:
        #print(i)
        if (bpl[chrom][i+1] - bpl[chrom][i]) <= 2:
            i = i + 2
        else:
            mbpl[chrom].append(bpl[chrom][i])
            i = i + 1
    mbpl[chrom].append(bpl[chrom][len(bpl[chrom])-1])
    print("merged",chrom, mbpl[chrom])


for chrom in mbpl.keys():
    pos_array = np.asarray(mbpl[chrom])
    i = 0
    while i < len(mbpl[chrom]) - 1:
        segs[chrom].append((mbpl[chrom][i], mbpl[chrom][i+1]))
        i = i + 2

outf = open(out, 'w')
for chrom in mbpl.keys():
    #print(chrom, segs[chrom])
    for segment in segs[chrom]:
        #print(segment)
        line = "{}\t{}\t{}\t{}\n".format(chrom,segment[0],segment[1],fun)
        print(line)
        outf.write(line)
outf.close()
#
#outf = open(out, 'w')
#for line in outf:
#    outf.write


