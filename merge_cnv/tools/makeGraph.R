#!/usr/bin/env Rscript
# cat makeGraph.R | R --slave --args < chrlen > < *g2.point.bed > < *3.point.bed > <sample ID>
args <- commandArgs()
chrlen_f <- args[4]
g2_f <- args[5]
e3_f <- args[6]
sample <- args[7]
chrlen = read.csv(chrlen_f,header=F,col.names=c("chr","len","start"),sep="\t")
head(chrlen)
data <- read.csv(g2_f,header=F,sep="\t",col.names = c("chr","start","end","logratio","fun"))
head(data)
pdf(paste(args[5],".log2.pdf",sep = ""), height=3, width=12, bg = "white")
par(mfrow=c(1,1))
plot(data$start,data$logratio,xlab = paste ("position"),ylab = "copy number profile (log2)",pch = ".",col = "grey",xaxt="n", ylim = c(-2,2), main=paste(sample,"CNVs called by >=2 software",sep=" "))
tt <- which(data$fun=="gain")
points(data$start[tt],data$logratio[tt],col=colors()[136], pch=".")

tt <- which(data$fun=="loss")
points(data$start[tt],data$logratio[tt],col=colors()[461], pch=".")
axis(1, chrlen$start + chrlen$len/2,labels=chrlen$chr,cex.lab=2, cex.axis=1.5)
abline(v=chrlen$start+chrlen$len, lty=1, col="black")
dev.off()

data <- read.csv(e3_f,header=F,col.names = c("chr","start","end","logratio","fun"), sep = '\t')
head(data)
pdf(paste(args[6],".log2.pdf",sep = ""), height=3, width=12, bg = "white")
par(mfrow=c(1,1))
plot(data$start,data$logratio,xlab = paste ("position"),ylab = "copy number profile (log2)",pch = ".",col = "grey", xaxt="n", ylim = c(-2,2),main=paste(sample,"CNVs called by 3 software", sep=" "))
tt <- which(data$fun=="gain")
points(data$start[tt],data$logratio[tt],col=colors()[136], pch=".")

tt <- which(data$fun=="loss")
points(data$start[tt],data$logratio[tt],col=colors()[461], pch=".")
axis(1, chrlen$start + chrlen$len/2,labels=chrlen$chr,cex.lab=2, cex.axis=1.5)
abline(v=chrlen$start+chrlen$len, lty=1, col="black")
dev.off()