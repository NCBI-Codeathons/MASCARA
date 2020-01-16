# Defining-Cell-Fate-Regulators-in-Multi-omic-Single-Cell-Developmental-Datasets


## A simple method for identifying transcription factor mediated regulatory networks from scRNA and scATAC data

NAME is a containerized workflow that is able to identify biologically important gene regulatory networks by leveraging data from scRNA and scATAC experiments.

NAME uses ACTIONet to first call cell states based on normal gene expression. It then identifies differential gene expression between cell states and is able to identify and prioritize transcription factor mediated gene regulatory networks based on data from the CHEA database (LINK). These lists are further refined and influenced by the ATAC-seq data.

### Dependencies

Docker (link) - an independent container platform

Taking a sce object for both scRNA and scATAC

### Workflow

PICTURE OF THE PROCESSES


### Workflow
TBD

### Deliverables

A workflow that outputs a table containing a ranked transcription factor mediated network and an easy to use interactive visualization platform of the gene regulatory networks.

### Installation
INSTALL DOCKER IMAGE

### Tutorial

TBD

### Input File Format

### Output
