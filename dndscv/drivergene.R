library("dndscv")


args <- commandArgs()

mutations <- read.csv(file = args[6],sep = "\t",header = FALSE,col.names = c("sampleID","chr","pos","ref","mut"))
dndsout = dndscv(mutations,refdb = args[7] , cv=NULL)
sel_cv = dndsout$sel_cv
signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
write.csv(signif_genes,file = args[8])