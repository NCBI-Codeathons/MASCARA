################################################################################
## CRAN PACKAGES
################################################################################

install.packages("ggpubr")

################################################################################
## BIOCONDUCTOR PACKAGES
################################################################################
BiocManager::install(c("GenomicRanges", "Gviz", "rtracklayer", 'BiocGenerics',
                       'DelayedArray', 'DelayedMatrixStats',
                       'limma', 'S4Vectors', 'SingleCellExperiment',
                       'SummarizedExperiment', 'batchelor', 'chromVAR',
                       'JASPAR2016','motifmatchr','monocle'))

################################################################################
## GITHUB PACKAGES
################################################################################

## Monocle 3
devtools::install_github('cole-trapnell-lab/leidenbase')
devtools::install_github('cole-trapnell-lab/monocle3')

## Cicero
devtools::install_github("cole-trapnell-lab/cicero-release", ref="monocle3")

## ACTIONet
devtools::install_github("shmohammadi86/NetLibR")
devtools::install_github("shmohammadi86/ACTIONet")

## ChromVar optional
devtools::install_github("GreenleafLab/chromVARmotifs")
