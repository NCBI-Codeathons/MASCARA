# Defining-Cell-Fate-Regulators-in-Multi-omic-Single-Cell-Developmental-Datasets


## A simple method for identifying transcription factor mediated regulatory networks from scRNA and scATAC data

### Goals and Aims
The goal of to develop a pipeline for the identification of transcriptional regulators important in the various clusters identified by single cell sequencing. It is possible to identify regulators of related networks in RNA-seq via looking for  gene regulatory networks in transcriptomes of the same cells in different conditions. This has been successful in both bulk and single cell. It is also possible to identify transcription factor binding in ATAC-seq via searching for motif enrichment in the accessible chromatin regions. This has also been done successfully in both bulk and single cell studies. The aim to take a dataset which includes both single cell RNA and ATAC seqs, identify cell type clusters in them, and then integrate them in order to find different levels of cell type regulators. We would take this opportunity to standardize and automate various aspects of this pipeline, especially the integration between data types, for future uses, and also to allow direct flow into other levels of analysis. A specific example of this downstream preparation would be to ask if this could be integrated with a pseudotime analysis, in order to understand how regulatory networks change at different time points of cell type differentiation.

NAME is a containerized workflow that is able to identify biologically important gene regulatory networks by leveraging data from scRNA and scATAC experiments.

NAME uses ACTIONet to first call cell states based on normal gene expression. It then identifies differential gene expression between cell states and is able to identify and prioritize transcription factor mediated gene regulatory networks based on data from the CHEA database (LINK). These lists are further refined and influenced by the ATAC-seq data.

### Dependencies

[Docker](https://www.docker.com/) - an independent container platform

Taking a sce object for both scRNA and scATAC

### Workflow

PICTURE OF THE PROCESSES


### Workflow
TBD

### Deliverables

A workflow that outputs a table containing a ranked transcription factor mediated network and an easy to use interactive visualization platform of the gene regulatory networks.

### Installation
Build Docker image:

```
docker build https://github.com/NCBI-Codeathons/Defining-Cell-Fate-Regulators-in-Multi-omic-Single-Cell-Developmental-Datasets.git#master:docker
```

### Tutorial

TBD

### Input File Format

### Output

### Team Members
* Matthew Moss (Lead)
* Mervin Fansler
* Nicholas Gomez
* Claire Marchal
* [Shahin Mohammadi](https://www.linkedin.com/in/shmohammadi/)
* Marygrace Trousdell
