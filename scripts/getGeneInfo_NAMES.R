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


