#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(ACTIONet)

args = commandArgs(trailingOnly=TRUE)
## if (length(args) < 2) {
##     stop("Incorrect number of arguments!\nUsage:\n> run_actionet.R <sceFile> <genome>\n")
## }

arg.sce <- args[1]
arg.genome <- args[2]

## Do stuff here

## save files
##saveRDS(some_files)
