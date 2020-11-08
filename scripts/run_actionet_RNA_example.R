library(SingleCellExperiment)
library(ACTIONet)
library(scater)
library(SingleCellExperiment) 
library(scran) 

# Sample script to run ActionNet on scRNA data. 


# Download example dataset from the 10X Genomics website
#download.file('http://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_filtered_feature_bc_matrix.h5', 'pbmc_10k_v3.h5') 

#data_dir <- here("data", "outs", "filtered_gene_bc_matrices", "GRCh38")
#sce <- read10xCounts(data_dir)

#require(ACTIONet)
# Run ACTIONet
#ace = import.ace.from.10X.h5('pbmc_10k_v3.h5', prefilter = T, min_cells_per_feat = 0.01, min_feats_per_cell = 1000)
ace <- readRDS("../data/input/scRNA-Healthy-Hematopoiesis.SCE.rds")

ace = reduce.ace(ace)
ace = run.ACTIONet(ace)

# Annotate cell-types
data("curatedMarkers_human")
markers = curatedMarkers_human$Blood$PBMC$Ding2019$marker.genes
annot.out = annotate.cells.using.markers(ace, markers)
ace$celltypes = annot.out$Labels

# Visualize output
plot.ACTIONet(ace, "celltypes", transparency.attr = ace$node_centrality)

# Export results as AnnData
ACE2AnnData(ace, fname = "pbmc_10k_v3.h5ad")

