library(motifmatchr)
library(GenomicRanges)
library(SingleCellExperiment)
library(chromVAR)
library(SummarizedExperiment)
library(Matrix)
library(BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19)
library(BiocParallel)

# This is an example script to run chromVAR on example data set. We modify this script for the actual scATAC data. 

data(example_counts, package = "chromVAR")
example_counts <- addGCBias(example_counts,
                              genome = BSgenome.Hsapiens.UCSC.hg19)
counts_filtered <- filterSamples(example_counts, min_depth = 1500,
                                  min_in_peaks = 0.15)
counts_filtered <- filterPeaks(counts_filtered)
motifs <- getJasparMotifs()
motif_ix <- matchMotifs(motifs, counts_filtered, genome = BSgenome.Hsapiens.UCSC.hg19)

# computing deviations
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix)


