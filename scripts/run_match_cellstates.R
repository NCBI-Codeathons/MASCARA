#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(ACTIONet)
source("src/functions.R")

args = commandArgs(trailingOnly=TRUE)

sce.RNA.path <- args[1]
sce.RNA = readRDS(sce.RNA.path)

sce.inferredRNA.path <- args[2]
sce.inferredRNA = readRDS(sce.inferredRNA.path)

sce.chromVAR.path <- args[3]
sce.chromVAR = readRDS(sce.chromVAR.path)


## Do stuff here
res = match.cellstates(ACTIONet.out.RNA, ACTIONet.out.inferredRNA, sce.chromVAR)

## save files
saveRDS(res, file = "final.rds")

