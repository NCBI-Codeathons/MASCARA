#!/usr/bin/env Rscript

library(SingleCellExperiment)
library(cicero)

args = commandArgs(trailingOnly=TRUE)
## if (length(args) < 2) {
##     stop("Incorrect number of arguments!\nUsage:\n> run_cicero.R <sceFile> <gtf>\n")
## }

arg.sce <- args[1]
arg.gtf <- args[2]

## Do stuff here

## save files
##saveRDS(some_files)
