#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(ACTIONet)
source("src/functions.R")

args = commandArgs(trailingOnly=TRUE)

sce.RNA.path <- args[1]
sce.RNA = readRDS(sce.RNA.path)

## Do stuff here
ACTIONet.out.RNA = run.ACTIONet.RNA(sce.RNA)

## save files
saveRDS(ACTIONet.out.RNA, file = "ACTIONet_out_RNA.rds")

