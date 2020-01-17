# MASCARA (**M**ultiomic **A**nalysis of **S**ingle **C**ell **A**TAC-seq and **R**NA-seq)


## A simple method for identifying transcription factor mediated regulatory networks from scRNA and scATAC data

### Team Members
* [Matthew Moss](https://github.com/mmoss609) (Lead)
* [Mervin Fansler](https://github.com/mfansler)
* [Nicholas Gomez](https://www.linkedin.com/in/nickgomez/)
* [Claire Marchal](https://www.linkedin.com/in/marchalc/)
* [Shahin Mohammadi](https://www.linkedin.com/in/shmohammadi/)
* [Marygrace Trousdell](https://www.linkedin.com/in/marygrace-trousdell/)

### Goals and Aims
The goal of to develop a pipeline for the identification of transcriptional regulators important in the various clusters identified by single cell sequencing. It is possible to identify regulators of related networks in RNA-seq via looking for  gene regulatory networks in transcriptomes of the same cells in different conditions. This has been successful in both bulk and single cell. It is also possible to identify transcription factor binding in ATAC-seq via searching for motif enrichment in the accessible chromatin regions. This has also been done successfully in both bulk and single cell studies. The aim to take a dataset which includes both single cell RNA and ATAC seqs, identify cell type clusters in them, and then integrate them in order to find different levels of cell type regulators. We would take this opportunity to standardize and automate various aspects of this pipeline, especially the integration between data types, for future uses, and also to allow direct flow into other levels of analysis. A specific example of this downstream preparation would be to ask if this could be integrated with a pseudotime analysis, in order to understand how regulatory networks change at different time points of cell type differentiation.

NAME is a containerized workflow that is able to identify biologically important gene regulatory networks by leveraging data from scRNA and scATAC experiments.

NAME uses ACTIONet to first call cell states based on normal gene expression. It then identifies differential gene expression between cell states and is able to identify and prioritize transcription factor mediated gene regulatory networks based on data from the CHEA database (LINK). These lists are further refined and influenced by the ATAC-seq data.

### Dependencies

#### Pipeline
[Docker](https://www.docker.com/) - an independent container platform

#### Visualization
[R](https://www.r-project.org/) - A software environment for statistical computing and graphics

Install shiny within R
```
install.packages("shiny")
```

### Workflow

![mascara_pipeline_diagram](https://user-images.githubusercontent.com/59709364/72620669-c161ed80-390d-11ea-88cd-2aae69ac46d0.png)

### Workflow
TBD

### Deliverables

A workflow that outputs a table containing a ranked transcription factor mediated network and an easy to use interactive visualization platform of the gene regulatory networks.

### Installation

Pull the Docker image
```
docker pull mfansler/mascara
```

Or the Docker image can be manually build using
```
docker build https://github.com/NCBI-Codeathons/Defining-Cell-Fate-Regulators-in-Multi-omic-Single-Cell-Developmental-Datasets.git#master:docker
```

### Input File Format

Two SingleCellExperiment [(sce)](https://osca.bioconductor.org/data-infrastructure.html) *class* files. One each for scRNA-seq and scATAC-seq.

### Output

**network.tsv** - tab-delimited file containing the cluster specific transcription factors and downstream target genes. INSERT COLUMN IDS

### Tutorial

TBD

#### Visualization

In R:

Load network.tsv (output from MASCARA)

```
x <- read.table("network.tsv",header=TRUE,sep="\t")
```

Run Shiny App

```

```




### Future Directions

Perhaps integrate within our pipeline a pseudotime analysis, in order to understand how regulatory networks change at different time points of cell type differentiation. Incorporating a trajectory inference may help to better characterize the evolution and divergences between cell clusters.
