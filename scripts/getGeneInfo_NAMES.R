######################
## getGeneInfo.R retrieves information about a gene from biomart using the gene symbol
## Miranda Darby
## Created 11/7/2020

##If needed, install biomaRt
##BiocManager::install("biomaRt")

#Thereafter load the package like this:
library(biomaRt)

# Select the database to use. In this case we are limiting our search to the ensembl database of human genes
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")

# These filters and attributes can be used to parse the data:
# filters=listFilters(ensembl)
# attributes=listAttributes(ensembl)

# In the MASCARA pipeline, the gene name (which equates to the 'hgnc_symbol' attribute) will be provided as output of the pipeline. 
# Here I am saving the gene names of two sample genes
neuregulin <- "NRG4"
BRCA <- "BRCA2"

# This function retreives the ensembl gene id, entrez gene id, description, and chromosomal coordinates of each gene in a vector of hgnc gene symbols
oneLineOutput <- function(geneName){
  require(biomaRt)
  ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
  getBM(attributes=c('hgnc_symbol','ensembl_gene_id','entrezgene_id','entrezgene_description','chromosome_name','start_position','end_position','strand'), 
        filters = 'hgnc_symbol', 
        values = geneName, 
        mart = ensembl)
}

#Applied to a single gene
neuroDF <- as.data.frame(oneLineOutput(neuregulin))
brcaDF <- as.data.frame(oneLineOutput(BRCA))

# This is a sample list of gene symbols
geneList <- c("EDDM3A","CRISP1","PATE1","DEFB127","AQP2","TMEM114","GRXCR1","SPINT3","CLDN2","SULT2A1","SPINK2","POU3F3","LCN1","PATE3","ANKRD30A","FEZF2","C6orf10","FOXG1","GC","VAX1","SSX2","FGB","SLC45A2","SPINK1","HOXC12","SCN1A","LOC284661","TFDP3","B3GNT6","FOXB2","NR2E1","XAGE1E","TBX10")

# This makes a data frame of the whole list with one gene per row and each attribute as a column
listDF <- as.data.frame(oneLineOutput(geneList))
#write.csv(listDF, file="sampleGeneInfo.csv")

# Reading in the results from the previous MASCARA hackathon group
# The list of genes that we want information about is $TG
mascaraOut <- read.csv("~/Downloads/test.csv")

# Check out the data
str(mascaraOut)

# YIKES! It has been mangled in excel! Gene names stored as factors turned to dates!
# 'data.frame':	40524 obs. of  5 variables:
#   $ X       : Factor w/ 5578 levels "1-Mar","11-Mar",..: 3683 2824 4123 4116 2939 1468 2386 2740 2163 4617 ...
# $ Celltype: Factor w/ 13 levels "01_HSC","02_Early.Eryth",..: 6 6 6 6 6 6 6 6 6 6 ...
# $ TF      : Factor w/ 65 levels "ADNP","BACH1",..: 49 49 49 49 49 49 49 49 49 49 ...
# $ TG      : Factor w/ 3671 levels "1-Mar","2-Sep",..: 2411 1836 2696 2695 1912 964 1559 1783 1417 3012 ...
# $ weight  : num  0.451 0.404 0.42 0.428 0.413 ...

# convert TG from factors to strings
mascaraOut$TG <- as.character(mascaraOut$TG)

#The TG column seems to have been rescued compared to the rownames in $X

str(mascaraOut)
# 'data.frame':	40524 obs. of  5 variables:
#   $ X       : Factor w/ 5578 levels "1-Mar","11-Mar",..: 3683 2824 4123 4116 2939 1468 2386 2740 2163 4617 ...
# $ Celltype: Factor w/ 13 levels "01_HSC","02_Early.Eryth",..: 6 6 6 6 6 6 6 6 6 6 ...
# $ TF      : Factor w/ 65 levels "ADNP","BACH1",..: 49 49 49 49 49 49 49 49 49 49 ...
# $ TG      : chr  "PPT1" "MCL1" "S100A9" "S100A8" ...
# $ weight  : num  0.451 0.404 0.42 0.428 0.413 ...

# Create a data frame with the gene information for all of the genes in TG
geneInfo <- as.data.frame(oneLineOutput(mascaraOut$TG))

# Some of the rows in TG are duplicates and some are missing from geneInfo so there are fewer rows in geneInfo. Use matching to duplicate and rearrange the rows as necessary and to fill in NA where values are missing.
matching <- match(mascaraOut$TG,geneInfo$hgnc_symbol)
mascaraGenes <- geneInfo[matching,]
 
#Attempts to merge
fullGeneDF <- merge(mascaraOut, mascaraGenes, by = intersect(mascaraOut$TG, mascaraGenes$hgnc_symbol),incomparables = NULL)
# Error: Error in fix.by(by.x, x) : 'by' must specify uniquely valid columns
fullGeneDF <- merge(mascaraOut, mascaraGenes,incomparables = NULL)
# Error: vector memory exhausted (limit reached?)

rownames(mascaraGenes) <- as.character(mascaraGenes$hgnc_symbol)
## Got error about duplicate rownames -- probably why merge doesn't work, many genes are repeated throughout the column

# Just going old school and cbinding the tables, then checking afterward
fullGeneDF <-cbind(mascaraOut,mascaraGenes)
write.csv(fullGeneDF,file="~/Documents/GitHub/MASCARA/data/geneInfo.csv")

# Make sure that they match except for NAs
summary(!(fullGeneDF$TG == fullGeneDF$hgnc_symbol))
# Mode   FALSE    NA's 
# logical   39755     769 

#There are no TRUE values, only the number of NAs we expect from gene symbols that weren't present in biomart, so the data is ok.