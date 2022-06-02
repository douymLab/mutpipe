import argparse
import numpy as np
import math
from collections import defaultdict, namedtuple

#centromere
#http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz
#telomere
#https://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/gap.txt.gz
parser = argparse.ArgumentParser(description="calculate intersection")
parser.add_argument('-bicseq2', type=str, default=None, help='bicseq2')
parser.add_argument('-dnacopy', type=str, default=None, help='dnacopy')
parser.add_argument('-freec', type=str, default=None, help='freec')
parser.add_argument('-chrlen', type=str, default=None, help='chrlen')
parser.add_argument('-out', type=str, default=None, help='out bed')
parser.add_argument('-soft_num', type=str, default=None, help='software number')

args = parser.parse_args()

bicseq2 = args.bicseq2
dnacopy = args.dnacopy
freec = args.freec
chrlen = args.chrlen
out = args.out
soft_num = int(args.soft_num)

class Position(object):
  # Position was originally a namedtuple, but we want it to be mutable.
  def __init__(self, chrom, pos, postype, method):
    self.chrom = chrom
    self.pos = pos
    self.postype = postype
    self.method = method
    self._interval = None

  @property
  def interval(self):
    return self._interval

  @interval.setter
  def interval(self, val):
    self._interval = val

  def __str__(self):
    return 'chr%s(%s, %s, %s)' % (self.chrom, self.pos, self.postype, self.method)

  def __repr__(self):
    return str(self)

chromlen = {}
chrlenf = open(chrlen, 'r')
for line in chrlenf:
    fields = line.strip().split('\t')
    chrom, clen = fields[0], int(fields[1])
    chromlen[chrom] = clen

chrlenf.close()

bic_array = {}
dc_array = {}
freec_array = {}
total_array = {}
for chrom in chromlen.keys():
    print(chrom, chromlen[chrom])
    #bic_array[chrom] = np.zeros(chromlen[chrom])
    #dc_array[chrom] = np.zeros(chromlen[chrom])
    #freec_array[chrom] = np.zeros(chromlen[chrom])
    total_array[chrom] = np.zeros((chromlen[chrom]+1),dtype=np.int)

bps = defaultdict(list)

bicf = open(bicseq2, 'r')
for line in bicf:
    fields = line.strip().split('\t')
    chrom, start, end = fields[0], int(fields[1]), int(fields[2])
    #if end > chromlen[chrom] - 1:
    #    end = chromlen[chrom] - 1
    #bic_array[chrom][start:end+1] = 1
    total_array[chrom][start:end+1] = total_array[chrom][start:end+1] + 1
    #bps[chrom].append((start,end))
    bps[chrom].append(Position(chrom, start, "start","bicseq"))
    bps[chrom].append(Position(chrom, end, "end","bicseq"))
    #print("start",bic_array[chrom][start],"end",bic_array[chrom][end])
bicf.close()
print("after bicseq2")
for chrom in bps.keys():
    bps[chrom].sort(key = lambda S: S.pos)
    print(bps[chrom])

dcf = open(dnacopy, 'r')
prev_end = -1
for line in dcf:
    fields = line.strip().split('\t')
    chrom, start, end = fields[0], int(fields[1]), int(fields[2])
    #if end > chromlen[chrom] - 1:
    #    end = chromlen[chrom] - 1
    #dc_array[chrom][start:end+1] = 1
    #dnacopy left close right open
    if start != prev_end:
        total_array[chrom][start:end+1] = total_array[chrom][start:end+1] + 1
    else:
        total_array[chrom][start+1:end+1] = total_array[chrom][start+1:end+1] + 1
    prev_end = end
    #bps[chrom].append((start,end))
    bps[chrom].append(Position(chrom, start, "start","dnacopy"))
    bps[chrom].append(Position(chrom, end, "end","dnacopy"))
    #print("start",dc_array[chrom][start],"end",dc_array[chrom][end])
dcf.close()
print("after dnacopy")
for chrom in bps.keys():
    bps[chrom].sort(key = lambda S: S.pos)
    print(bps[chrom])

freecf = open(freec, 'r')
for line in freecf:
    fields = line.strip().split('\t')
    chrom, start, end = fields[0], int(fields[1]), int(fields[2])
    #if end > chromlen[chrom] - 1:
    #    end = chromlen[chrom] - 1
    #freec_array[chrom][start:end+1] = 1
    total_array[chrom][start:end+1] = total_array[chrom][start:end+1] + 1
    #bps[chrom].append((start,end))
    bps[chrom].append(Position(chrom, start, "start","freec"))
    bps[chrom].append(Position(chrom, end, "end","freec"))
    #print("start",freec_array[chrom][start],"end",freec_array[chrom][end])
freecf.close()
print("after freec")
for chrom in bps.keys():
    bps[chrom].sort(key = lambda S: S.pos)
    print(bps[chrom])

# sort bps
print("after sort")
for chrom in bps.keys():
    bps[chrom].sort(key = lambda S: S.pos)
    print(bps[chrom])
#for chrom in chromlen.keys():
#    total_array = bic_array[chrom] + dc_array[chrom] + freec_array[chrom]

start_2 = defaultdict(set)
end_2 = defaultdict(set)
for chrom in chromlen.keys():
    for  bp in bps[chrom]:
        print(chrom,bp.postype,bp.pos)
        if bp.postype == "start":
            if bp.pos == 0:
                print("pos",bp.pos,"total_array[chrom][bp.pos]",total_array[chrom][bp.pos],"total_array[chrom][bp.pos+1]",total_array[chrom][bp.pos+1])
            else:
                print("pos",bp.pos,"total_array[chrom][bp.pos]",total_array[chrom][bp.pos],"total_array[chrom][bp.pos -1]",total_array[chrom][bp.pos-1],"total_array[chrom][bp.pos+1]",total_array[chrom][bp.pos+1])
        if bp.postype == "end":
            if bp.pos == chromlen[chrom]:
                print("pos",bp.pos,"total_array[chrom][bp.pos]",total_array[chrom][bp.pos],"total_array[chrom][bp.pos-1]",total_array[chrom][bp.pos-1])
            else:
                print("pos",bp.pos,"total_array[chrom][bp.pos]",total_array[chrom][bp.pos - 1],"total_array[chrom][bp.pos -1]",total_array[chrom][bp.pos-1],"total_array[chrom][bp.pos+1]",total_array[chrom][bp.pos+1])


# teminal pos
        #if bp.pos != 0 and bp.pos != chromlen[chrom]:
        #    print("here1",bp.pos, "prev",total_array[chrom][bp.pos],"next",total_array[chrom][bp.pos + 1])
        if bp.pos == 0:
            if total_array[chrom][bp.pos] >= soft_num:
                start_2[chrom].add(bp.pos)
        elif bp.pos == chromlen[chrom]:
            if total_array[chrom][bp.pos] >= soft_num:
                end_2[chrom].add(bp.pos)
        #        print("here3",bp.pos)
        elif total_array[chrom][bp.pos] != total_array[chrom][bp.pos + 1]:
        #   print("here2",bp.pos)
            if total_array[chrom][bp.pos] < soft_num and total_array[chrom][bp.pos+1] >= soft_num:
                start_2[chrom].add(bp.pos + 1)
            elif total_array[chrom][bp.pos + 1] < soft_num and total_array[chrom][bp.pos] >= soft_num:
                end_2[chrom].add(bp.pos)
        elif total_array[chrom][bp.pos] != total_array[chrom][bp.pos - 1]:
            if total_array[chrom][bp.pos] < soft_num and total_array[chrom][bp.pos-1] >= soft_num:
                end_2[chrom].add(bp.pos - 1)  
            elif total_array[chrom][bp.pos - 1] < soft_num and total_array[chrom][bp.pos] >= soft_num:
                start_2[chrom].add(bp.pos)

sorted_start_2 = defaultdict(list)
sorted_end_2 = defaultdict(list)
for chrom in chromlen.keys():
    sorted_start_2[chrom] = sorted(list(start_2[chrom]))
    sorted_end_2[chrom] = sorted(end_2[chrom])
for chrom in chromlen.keys():
    print(chrom, sorted_start_2[chrom])
    print(chrom, sorted_end_2[chrom])


segs_2 = defaultdict(list)
for chrom in chromlen.keys():
    for i in range(len(sorted_start_2[chrom])):
        #print(i)
        segs_2[chrom].append((sorted_start_2[chrom][i], sorted_end_2[chrom][i]))
outf = open(out,'w')
for chrom in chromlen.keys():
    print(segs_2[chrom])
    for i in range(len(segs_2[chrom])):
        line = "{}\t{}\t{}\n".format(chrom, segs_2[chrom][i][0], segs_2[chrom][i][1])
        print(line)
        outf.write(line)
outf.close()

        
