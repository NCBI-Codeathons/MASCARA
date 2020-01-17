# MASCARA (Multiomic Analysis of Single Cell ATAC-seq and RNA-seq)

<img width="1178" alt="Screen Shot 2020-01-17 at 11 50 36 AM" src="https://user-images.githubusercontent.com/59709364/72636703-a606da80-392d-11ea-8c33-9f680fd33c5a.png">

## A simple method for identifying transcription factor mediated regulatory networks from scRNA and scATAC data

### Team Members
* [Matthew Moss](https://github.com/mmoss609) (Lead)
* [Mervin Fansler](https://github.com/mfansler)
* [Nicholas Gomez](https://www.linkedin.com/in/nickgomez/)
* [Claire Marchal](https://www.linkedin.com/in/marchalc/)
* [Shahin Mohammadi](https://www.linkedin.com/in/shmohammadi/)
* [Marygrace Trousdell](https://www.linkedin.com/in/marygrace-trousdell/)

### Goals and Aims
The advent of single cell sequencing technologies have now allowed for the identification and characterization of rare cell types. Identifying the key transcription factors and downstream target genes is important for understanding the biology of these rare populations. The goal of this project is to develop a workflow that identifies and ranks transcriptional regulators important in the various cell states as identified by single cell sequencing. By combining both scRNA-seq and scATAC-seq we can increase our power to identify biologically meaningful gene regulatory networks.

The aim is to take a dataset which includes both single cell RNA and ATAC seqs, identify cell type clusters in them, and then integrate them in order to find different levels of cell type regulators. We would take this opportunity to standardize and automate various aspects of this pipeline, especially the integration between data types, for future uses, and also to allow direct flow into other levels of analysis. A specific example of this downstream preparation would be to ask if this could be integrated with a pseudotime analysis, in order to understand how regulatory networks change at different time points of cell type differentiation.

### Dependencies

The goal of our workflow is to be containerized so that all packages and dependencies are included in the docker image. We only require a few R packages in order to visualize the output from MASCARA.

#### Pipeline
[Docker](https://www.docker.com/) - an independent container platform

#### Visualization
[R](https://www.r-project.org/) - A software environment for statistical computing and graphics

Install shiny and network within R
```
install.packages(c("shiny","networkD3"))
```

### Workflow

<img width="729" alt="Screen Shot 2020-01-17 at 1 27 48 PM" src="https://user-images.githubusercontent.com/59709364/72636567-47416100-392d-11ea-8799-1a2990a69c3e.png">)

### Deliverables

A workflow that outputs a table containing a ranked transcription factor mediated network and an easy to use interactive visualization platform of the gene regulatory networks.

### Installation

Pull the Docker image
```
docker pull mfansler/mascara
```

Or the Docker image can be manually build using
```
docker build https://github.com/NCBI-Codeathons/MASCARA.git#master:docker
```

### Input File Format

Two SingleCellExperiment [(sce)](https://osca.bioconductor.org/data-infrastructure.html) *class* files. One each for scRNA-seq and scATAC-seq.

### Output

**network.tsv** - tab-delimited file containing the cluster specific transcription factors and downstream target genes. INSERT COLUMN IDS

### Tutorial

<img width="1111" alt="results" src="https://user-images.githubusercontent.com/59709364/72639224-19f7b180-3933-11ea-866d-b902f5158102.png">


#### Visualization

In R:

Load the libraries
```
library(shiny)
library(networkD3)
```

Load network.tsv (output from MASCARA)
```
x <- read.table("network.tsv",header=TRUE,sep="\t")
```

Set up the user interface and the server for Shiny with the R functions provided.

```
source("MASCARA_shiny_UI.R")
```

Start the Shiny App

```
shinyApp(ui = ui, server = server)
```


<iframe src="https://giphy.com/embed/Kc1f8O613s8yzkdCxV" width="480" height="400" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/Kc1f8O613s8yzkdCxV">via GIPHY</a></p>


### Future Directions

In the future we hope to integrate a pseudotime analysis as a method to understand how regulatory networks change at different time points during cell type differentiation and or disease progression. Incorporating a trajectory inference may help to better characterize the evolution and divergences between cell clusters. 


