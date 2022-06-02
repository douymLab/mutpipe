import argparse
import numpy as np
from collections import defaultdict, namedtuple

#centromere
#http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz
#telomere
#https://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/gap.txt.gz
parser = argparse.ArgumentParser(description="generate consensus breakpoints")
parser.add_argument('-cbp', type=str, default=None, help='consensus breakpoints')
parser.add_argument('-centro', type=str, default=None, help='centromeres file')
parser.add_argument('-telo', type=str, default=None, help='telomeres file')
parser.add_argument('-bp', type=str, default=None, help='breakpoints')
parser.add_argument('-seg', type=str, default=None, help='segments')
args = parser.parse_args()

cbp = args.cbp
centro = args.centro
telo = args.telo
bp = args.bp
seg = args.seg

bps = defaultdict(set)

cbp_file = open(cbp, 'r')
for line in cbp_file:
    fields = line.strip().split()
    chrom, start, end, cbp = fields[0], int(fields[1]), int(fields[2]), int(fields[3])
    bps[chrom].add(cbp)
    dict(bps)
print("consensus breakpoints:")
for i in bps.keys():
    print(i,bps[i])

cbp_file.close()

centro_file = open(centro, 'r')

cens = defaultdict(list)
for line in centro_file:
    fields = line.strip().split()
    chrom, start, end, arm, region_type = fields[0].upper(), int(fields[1]), int(fields[2]), fields[3].lower(), fields[4].lower()
    assert chrom.startswith('CHR')
    chrom = chrom[3:]
    if region_type != 'acen':
        continue
    cens[chrom].append((start,end))

for chrom in cens.keys():
      assert len(cens[chrom]) == 2
      cens[chrom].sort()
      assert cens[chrom][0][1] == cens[chrom][1][0]
      cens[chrom] = (cens[chrom][0][0], cens[chrom][1][1])
      assert cens[chrom][0] < cens[chrom][1]

for i in cens.keys():
    bps[i].add(cens[i][0])
    bps[i].add(cens[i][1])

print("after adding centromeres:")
for i in bps.keys():
    print(i,bps[i])

centro_file.close()


telo_file = open(telo,'r')
for line in telo_file:
    fields = line.strip().split()
    chrom, start, end = fields[1], int(fields[2]), int(fields[3])
    chrom = chrom[3:]
    print(start)
    bps[chrom].add(start)
    bps[chrom].add(end)


print("after adding telomeres:")
for i in bps.keys():
    print(i,bps[i])

sbps = defaultdict(list)
for chrom in bps.keys():
   sbps[chrom]=sorted(list(bps[chrom]))

print("after sorting:")
for i in sbps.keys():
    print(i,sbps[i])

segs = defaultdict(list)
for chrom in sbps.keys():
    pos_array = np.asarray(sbps[chrom])
    for i in range(0,len(pos_array)-1):
        segs[chrom].append((sbps[chrom][i]+1, sbps[chrom][i+1]))

seg_file = open(seg, 'w')
for chrom in segs.keys():
    #print(chrom, segs[chrom])
    for segment in segs[chrom]:
        line = "{}\t{}\t{}\n".format(chrom,segment[0],segment[1])
        #print(line)
        seg_file.write(line)
seg_file.close()
