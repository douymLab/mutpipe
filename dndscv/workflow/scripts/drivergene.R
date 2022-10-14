library("dndscv")
mutations <- read.csv(file = snakemake@input[['file']],sep = "\t",header = FALSE,col.names = c("sampleID","chr","pos","ref","mut"))
mutations$chr = gsub("chr","",mutations$chr)
dndsout = dndscv(mutations,refdb = snakemake@input[['refdb']], cv=NULL)
sel_cv = dndsout$sel_cv
signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
write.csv(signif_genes,file = snakemake@output[[1]])
