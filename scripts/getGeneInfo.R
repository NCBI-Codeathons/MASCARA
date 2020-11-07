######################
## getGeneInfo.R retrieves information about a gene from biomart
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

# In the MASCARA pipeline, the ensembl id will be provided as output of the pipeline here I am save the ensembl ids of two sample genes
neuregulin <- "ENSG00000169752"
BRACA <- "ENSG00000139618"

# The following function returns the ensembl gene ID, description, and genomic coordinates
minOutput <- function(ensemblID){
  require(biomaRt)
  ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
  getBM(attributes=c('ensembl_gene_id','description','chromosome_name','start_position','end_position','strand'), 
        filters = 'ensembl_gene_id', 
        values = ensemblID, 
        mart = ensembl)
}
minOutput(neuregulin)

# Example output:
# ensembl_gene_id                                      description chromosome_name
# 1 ENSG00000169752 neuregulin 4 [Source:HGNC Symbol;Acc:HGNC:29862]              15
# start_position end_position strand
# 1       75935969     76059795     -1

minOutput(BRACA)
# Example output:
# ensembl_gene_id                                                    description
# 1 ENSG00000139618 BRCA2 DNA repair associated [Source:HGNC Symbol;Acc:HGNC:1101]
# chromosome_name start_position end_position strand
# 1              13       32315086     32400268      1

# The following function also reports the peptide ID, phenotype description, and 
# information about associated GO terms, but it is very hard to see in this format
# It is better to view it as a data frame 
maxOutput<- function(ensemblID){
  require(biomaRt)
  ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
  getBM(attributes=c('ensembl_gene_id','ensembl_peptide_id','description','phenotype_description','go_id','name_1006','definition_1006','chromosome_name','start_position','end_position','strand'), 
        filters = 'ensembl_gene_id', 
        values = ensemblID, 
        mart = ensembl)
}
maxNeur <- as.data.frame(maxOutput(neuregulin))
maxBRACA <- as.data.frame(maxOutput(BRACA))
