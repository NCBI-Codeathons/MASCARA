#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(cicero)

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 3) {
     stop("Incorrect number of arguments!\nUsage:\n> run_cicero.R <sceFile> <gtf>\n")
}

sce_file <- args[1]
gtf <- args[2]
chsz <- args[3]
cicero_output<-mascara_atac(sce_file=sce_file,gtf=gtf,chsz=chsz)
saveRDS(cicero_output,"data/intermediate/sce.inferredRNA.rds")
