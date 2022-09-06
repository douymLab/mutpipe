#!/usr/bin/env Rscript

# cat DNAcopy.R|R --slave --args < sample > < *_logratio.bed > < *_.cnv > < *_.mapd >
library(DNAcopy)
args <- commandArgs()

sample <- args[4]
bed <- args[5]
dir <- args[6]
data <- read.csv(bed,sep = "\t", header = F, col.names = c("chr","start","end","logratio"))
CNA.object <- CNA(data$logratio, data$chr,data$start,data.type="logratio",sampleid=sample)
smoothed.CNA.object <- smooth.CNA(CNA.object)
segment.smoothed.CNA.object <- segment(smoothed.CNA.object, verbose=1)
segment.smoothed.CNA.object$data <- na.omit(segment.smoothed.CNA.object$data)
segment.smoothed.CNA.object$output <- na.omit(segment.smoothed.CNA.object$output)
segment.smoothed.CNA.object$out <- na.omit(segment.smoothed.CNA.object$out)
segment.smoothed.CNA.object$segRows <- na.omit(segment.smoothed.CNA.object$segRows)

pdf(paste0(dir,sample,"_whole_studies.pdf"), width = 20, height = 6)
plot(segment.smoothed.CNA.object, plot.type="w",ylim=c(-2,2))
dev.off()

pdf(paste0(dir,sample,"_each_study_by_chromosome.pdf"), width = 20, height = 20)
tryCatch({
  plot(segment.smoothed.CNA.object, plot.type="s",ylim=c(-2,2))
}, error = function(e) {
  print(e)
})

dev.off()

pdf(paste0(dir, sample,"_Plot_by_plateaus.pdf"), width = 20, height = 20)
tryCatch({
plot(segment.smoothed.CNA.object, plot.type="p",ylim=c(-2,2))
}, error = function(e) {
  print(e)
})
dev.off()

pdf(paste0(dir,sample,"_each_chromosome_across_studies.pdf"), width = 20, height = 6)
tryCatch({
    plot(segment.smoothed.CNA.object, plot.type="c", cbys.layout=c(2,1), cbys.nchrom=6,ylim=c(-2,2))
}, error = function(e) {
  print(e)
})
dev.off()
sdundo.CNA.object <- na.omit(segment(smoothed.CNA.object,undo.splits="sdundo",undo.SD=3,verbose=1))
cnv <- paste0(dir,sample,".CNVs")
write.table(sdundo.CNA.object[2], file = cnv, sep = "\t",col.names = TRUE, quote = FALSE, row.names = FALSE)

pdf(paste0(dir,sample, "_each_study_by_chromosome_re.pdf"), width = 20, height = 20)
tryCatch({
    plot(sdundo.CNA.object,plot.type="s",ylim=c(-2,2))
}, error = function(e) {
  print(e)
})
dev.off()

first_row <- c (1, 0, 50000, 0)
data1 <- rbind(first_row, data[1:nrow(data),])
mapd <- median(abs(data$logratio - data1$logratio),na.rm = TRUE)

mapd.df <- data.frame(c(sample), c(mapd))
mapd_file <- paste0(dir, sample,".mapd") 
write.table(mapd.df, file = mapd_file, sep="\t",quote = FALSE, col.names = FALSE, row.names = FALSE)
