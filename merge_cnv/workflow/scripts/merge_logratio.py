import argparse
import numpy as np
import math
from collections import defaultdict, namedtuple

#centromere
#http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz
#telomere
#https://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/gap.txt.gz
parser = argparse.ArgumentParser(description="merge three software logratio")
parser.add_argument('-bicseq2', type=str, default=None, help='bicseq2')
parser.add_argument('-dnacopy', type=str, default=None, help='dnacopy')
parser.add_argument('-freec', type=str, default=None, help='freec')
parser.add_argument('-seg', type=str, default=None, help='seg')
parser.add_argument('-bic_lower', type=str, default=None, help='bic_lower threshold')
parser.add_argument('-bic_upper', type=str, default=None, help='bic_upper threshold')
parser.add_argument('-dc_lower', type=str, default=None, help='dc_lower threshold')
parser.add_argument('-dc_upper', type=str, default=None, help='dc_upper threshold')
parser.add_argument('-freec_lower', type=str, default=None, help='freec_lower threshold')
parser.add_argument('-freec_upper', type=str, default=None, help='freec_upper threshold')
parser.add_argument('-out', type=str, default=None, help='out')

args = parser.parse_args()

bicseq2 = args.bicseq2
dnacopy = args.dnacopy
freec = args.freec
seg = args.seg
bic_lower = float(args.bic_lower)
bic_upper = float(args.bic_upper)
dc_lower = float(args.dc_lower)
dc_upper = float(args.dc_upper)
freec_lower = float(args.freec_lower)
freec_upper = float(args.freec_upper)
out = args.out

seg_dict0 = defaultdict(list)

seg_f = open(seg, 'r')
for line in seg_f:
    fields = line.strip().split()
    chrom, start, end = fields[0], fields[1], fields[2]

    key = chrom+"~"+start+"~"+end
    seg_dict0[key] = []

seg_f.close()

# bicseq2
seg_dict = defaultdict(list)
bicseq2_f = open(bicseq2, 'r')
for line in bicseq2_f:
    fields = line.strip().split()
    chrom, start, end, bic_chrom, bic_start, bic_end, bic_logratio = fields[0],fields[1], fields[2],fields[3],int(fields[4]),int(fields[5]),fields[6]
    key = chrom+"~"+start+"~"+end
    #bic_str = bic_chrom + "-" + bic_start + "-" + bic_end + ":" + bic_logratio + ";"
    if bic_chrom != '.':
        bic_array = (bic_chrom, bic_start, bic_end, float(bic_logratio))
        seg_dict[key].append(bic_array)
    else:
        seg_dict[key]=[]
    #seg_dict[key].append(bic_str)

bicseq2_f.close()
#dnacopy
seg_dict1 = defaultdict(list)
dnacopy_f = open(dnacopy, 'r')
for line in dnacopy_f:
    fields = line.strip().split()
    chrom, start, end, dc_chrom, dc_start, dc_end, dc_logratio = fields[0],fields[1], fields[2],fields[3],int(fields[4]),int(fields[5]),float(fields[6])
    key = chrom+"~"+start+"~"+end
    dc_array = (dc_chrom, dc_start, dc_end, dc_logratio)
    seg_dict1[key].append(dc_array)

dnacopy_f.close()

#freec
seg_dict2 = defaultdict(list)
freec_f = open(freec, 'r')
for line in freec_f:
    fields = line.strip().split()
    chrom, start, end, freec_chrom, freec_start, freec_end, freec_ratio = fields[0],fields[1], fields[2],fields[3],int(fields[4]),int(fields[5]), fields[6]
    key = chrom+"~"+start+"~"+end
    if freec_chrom != '.':
        if float(freec_ratio) > 0:
            print(freec_ratio,"freec_ratio") 
            freec_logratio = math.log2(float(freec_ratio))
        else:
            freec_logratio = float('nan')
        freec_array = (freec_chrom, freec_start, freec_end, freec_logratio)

        seg_dict2[key].append(freec_array)
    else:
        seg_dict2[key] = []
freec_f.close()

#transverse
for key in seg_dict.keys():
    keys = key.split("~")
    print(keys)
    chrom, start, end = keys[0], keys[1], keys[2]
    print(chrom)
    bic = seg_dict[key]
    print(key)
    #bic_str = ""
    #for b in bic:
    #    print(b.tostring()) 
    #    bic_str
    line = "{}\t{}\t{}\t{}\n".format(chrom, start, end, bic)
    print(line)
for key in seg_dict1.keys():
    keys = key.split("~")
    print(keys)
    chrom, start, end = keys[0], keys[1], keys[2]
    print(chrom)
    dc = seg_dict1[key]
    print(key)
    line = "{}\t{}\t{}\t{}\n".format(chrom, start, end, dc)
    print(line)
for key in seg_dict2.keys():
    keys = key.split("~")
    print(keys)
    chrom, start, end = keys[0], keys[1], keys[2]
    print(chrom)
    freec = seg_dict2[key]
    print(key)
    line = "{}\t{}\t{}\t{}\n".format(chrom, start, end, freec)
    print(line)


#merge


out_f = open(out, 'w')
header = "chrom\tstart\tend\tbic\tdc\tfreec\tbic_mean\tdc_mean\tfreec_mean\tmean\tfunction\tstar\tbic_fun\tdc_fun\tfreec_fun\tgain_num\tloss_num\n"
out_f.write(header)
merge_dict = defaultdict(list)
for key in seg_dict0.keys():
    keys = key.split("~")
    print(keys)
    chrom, start, end = keys[0], keys[1], keys[2]
    
    bic = []
    bic_median = float('nan')
    if key in seg_dict:
        bic=seg_dict[key]
        b_weights = []
        b_logratio = []
        if len(bic) > 0:
            for b in bic:
                #print("b is",b[3])
                #bic_median = np.median(b[3])
                b_logratio.append(b[3])
                b_weights.append(b[2]-b[1])
                #print("b_weights", b_weights)
            bic_median = np.average(b_logratio, weights = b_weights)
            
            #bic_median = np.median(b_logratio)
    
    dc = []
    dc_logratio = []
    dc_weights = []
    dc_median = float('nan')
    if key in seg_dict1:
        dc = seg_dict1[key]
        if len(dc) > 0:
            for d in dc:
                dc_logratio.append(d[3])
                dc_weights.append(d[2]-d[1])
            #print("dc_logratio,dc_weights",dc_logratio,dc_weights)
            dc_median = np.average(dc_logratio, weights = dc_weights)

            #dc_median = np.median(dc_logratio)
    
    freec = []
    f_logratio = []
    f_weights = []
    freec_median = float('nan')
    if key in seg_dict2:
        freec = seg_dict2[key]
        if len(freec) > 0:
            for f in freec:
                if(not math.isnan(f[3])):
                    #log2f = math.log2(f[3])
                    f_logratio.append(f[3])
                    f_weights.append(f[2]-f[1])
                    #print("f_logratio, f_weights",f_logratio, f_weights)
            if len(f_weights)>0:
                freec_median = np.average(f_logratio, weights = f_weights)
            #freec_median = np.median(f_logratio)
    

    valid_median = []
    if not math.isnan(bic_median):
        valid_median.append(bic_median)
    if not math.isnan(dc_median):
        valid_median.append(dc_median)
    if not math.isnan(freec_median):
        valid_median.append(freec_median)

    star = len(valid_median)
    print("valid_median",valid_median)


    gain_num = 0
    loss_num = 0
    bic_fun = ""
    if bic_median > bic_upper and not math.isinf(bic_median):
        bic_fun = "gain"
        gain_num = gain_num + 1
    elif bic_median < bic_lower and not math.isinf(bic_median):
        bic_fun = "loss"
        loss_num = loss_num + 1
    else:
        bic_fun = "-"

    dc_fun = ""
    if dc_median > dc_upper and not math.isinf(dc_median):
        dc_fun = "gain"
        gain_num = gain_num + 1
    elif dc_median < dc_lower and not math.isinf(dc_median):
        dc_fun = "loss"
        loss_num = loss_num + 1
    else:
        dc_fun = "-"

    freec_fun = ""
    if freec_median > freec_upper and not math.isinf(freec_median):
        freec_fun = "gain"
        gain_num = gain_num + 1
    elif freec_median < freec_lower and not math.isinf(freec_median):
        freec_fun = "loss"
        loss_num = loss_num + 1
    else:
        freec_fun = "-"


    mean = np.mean(valid_median)
    #merge_dict.append(bic).append(dc).append(freec)
    fun = ""
    if gain_num >= 2:
        fun = "gain"
    elif loss_num >= 2:
        fun = "loss"
    else:
        fun = "-"



    line = "{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format(chrom, start, end, bic, dc, freec,bic_median,dc_median,freec_median,mean,fun,star,bic_fun, dc_fun, freec_fun, gain_num, loss_num)
    print(line)
    out_f.write(line)

out_f.close()
