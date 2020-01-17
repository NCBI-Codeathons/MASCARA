#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(ACTIONet)
source("src/functions.R")

args = commandArgs(trailingOnly=TRUE)

sce.inferredRNA.path <- args[1]
sce.inferredRNA = readRDS(sce.inferredRNA.path)

## Do stuff here
ACTIONet.out.inferredRNA = run.ACTIONet.inferredRNA(sce.inferredRNA)

## save files
saveRDS(ACTIONet.out.inferredRNA, file = "ACTIONet_out_inferredRNA.rds")

