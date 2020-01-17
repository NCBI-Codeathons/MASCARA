#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(ACTIONet)
source("src/functions.R")

args = commandArgs(trailingOnly=TRUE)

sce.RNA <- args[1]
ACTIONet.out.RNA = run.ACTIONet.RNA(sce.RNA)

## Do stuff here

## save files
saveRDS(ACTIONet.out.RNA, file = "ACTIONet_out_RNA.rds")

