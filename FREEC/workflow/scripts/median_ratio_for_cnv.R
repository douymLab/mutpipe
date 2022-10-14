#BiocManager::install("dplyr")
#install.packages("stringr")
library(stringr)
library(dplyr)
# cat median_ratio_for_cnv.R | R --slave --args < {sample}_intersect.txt > < {sample}_ratio.txt > 
args <- commandArgs()
in_f <- args[4]
out_f <- args[5]
print(out_f)
data <- read.csv(in_f,header = F,sep="\t",col.names = c("chr_1","start_1","end_1","ratio","median ratio","cnv_1","chr","start","end","cnv","alter","WilcoxonRankSumTestPvalue","KolmogorovSmirnovPvalue"))
head(data)
data$chr_start <- paste(data$chr,data$start,sep="_")
data$chr_start_end_cnv_alter <- paste(data$chr,data$start,data$end,data$cnv,data$alter,data$WilcoxonRankSumTestPvalue, data$KolmogorovSmirnovPvalue, sep="_")
data %>%
  group_by(chr_start)%>%
  summarise(median(ratio))
data_ratio <- data %>%
  group_by(chr_start_end_cnv_alter)%>%
  summarise(median_ratio = median(ratio))
head(data_ratio)
newData <- str_split_fixed(string = data_ratio$chr_start_end_cnv_alter,pattern = '_',n=7)
colnames(newData) = c("chr","start","end","cnv","alter","WilcoxonRankSumTestPvalue","KolmogorovSmirnovPvalue")
head(newData)
after <- cbind(as.data.frame(newData), data_ratio$median_ratio)
head(after)
write.table(after,file=out_f,quote = FALSE, row.names = FALSE,sep="\t")