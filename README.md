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
* [Miranda Darby] (https://github.com/MMDarby)
* [Bala Desinghu] (https://github.com/dmbala)
* [Samantha Henry]
* [Jenelys Ruiz Ortiz] (https://www.linkedin.com/in/jenelys-ruiz-16224316a/)



### Goals and Aims
The advent of single cell sequencing technologies have now allowed for the identification and characterization of rare cell types. Identifying the key transcription factors and downstream target genes is important for understanding the biology of these rare populations. The goal of this project is to develop a workflow that identifies and ranks transcriptional regulators important in the various cell states as identified by single cell sequencing. By combining both scRNA-seq and scATAC-seq we can increase our power to identify biologically meaningful gene regulatory networks.

The aim is to take a dataset which includes both single cell RNA and ATAC seqs, identify cell type clusters in them, and then integrate them in order to find different levels of cell type regulators. We would take this opportunity to standardize and automate various aspects of this pipeline, especially the integration between data types, for future uses, and also to allow direct flow into other levels of analysis. A specific example of this downstream preparation would be to ask if this could be integrated with a pseudotime analysis, in order to understand how regulatory networks change at different time points of cell type differentiation.

### Dependencies

The goal of our workflow is to be containerized so that all packages and dependencies are included in the docker image. We only require snakemake to run the pipeline and few R packages in order to visualize the output from MASCARA.

#### Pipeline
[Singularity](https://sylabs.io/docs/#singularity) - a container platform.

[Snakemake](https://snakemake.readthedocs.io/en/stable/) - a workflow management tool.

#### Visualization
[R](https://www.r-project.org/) - A software environment for statistical computing and graphics

Install shiny, networkD3, and dplyr within R
```
install.packages(c("shiny", "networkD3", "dplyr"))
```

### Workflow

<img width="729" alt="Screen Shot 2020-01-17 at 1 27 48 PM" src="https://user-images.githubusercontent.com/59709364/72636567-47416100-392d-11ea-8799-1a2990a69c3e.png">)

### Deliverables

A workflow that outputs a table containing a ranked transcription factor mediated network and an easy to use interactive visualization platform of the gene regulatory networks.

### Installation

Clone this repository using

```
git clone https://github.com/NCBI-Codeathons/MASCARA.git
```

### Input Files

The pipeline requires as input:

 - scRNA-seq result - a [SingleCellExperiment](https://osca.bioconductor.org/data-infrastructure.html) object as .Rds file
 - scATAC-seq result - a [SingleCellExperiment](https://osca.bioconductor.org/data-infrastructure.html) object as .Rds file
 - transcriptome - a GTF file
 - chrom.sizes file

### Output

* **network.tsv** - tab-delimited file containing the cluster specific transcription factors and downstream target genes. Column IDs are Celltype, TF (Transcription Factor), TG (Targets), weight (interaction strength on a scale from -1 to 1)  

<img width="1111" alt="results" src="https://user-images.githubusercontent.com/59709364/72639224-19f7b180-3933-11ea-866d-b902f5158102.png">

11/8/20 - Added gene information for genes contained within the network, including ensemble gene ID, gene information, and location

<img src="https://github.com/NCBI-Codeathons/MASCARA/blob/master/src/Chart.png">

### Tutorial

#### 1(a): Running Example Data
The full example data can be downloaded by navigating to the `data/` folder and running

```
snakemake
```
This will download two `.Rds` files, representing the scRNA-seq and scATAC-seq `SingleCellExperiment` objects from [Granja, et al., 2019](https://github.com/GreenleafLab/MPAL-Single-Cell-2019), as well as GTF and chrom.sizes files for **hg19**.

Update 11/8/20: Sample data now PBMC same cell single cell RNA and ATAC seq, here:

ATAC: http://cf.10xgenomics.com/samples/cell-atac/1.0.1/atac_v1_pbmc_10k/atac_v1_pbmc_10k_filtered_peak_bc_matrix.h5
ATAC Meta Data: http://cf.10xgenomics.com/samples/cell-atac/1.0.1/atac_v1_pbmc_10k/atac_v1_pbmc_10k_singlecell.csv
RNA: http://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_filtered_feature_bc_matrix.h5

The main pipeline is preconfigured (see `config.yaml`) to uses these downloaded files.  The full pipeline can then be run by navigating to the root of the repository (`MASCARA/`) and running
```
snakemake --use-singularity
```

#### 1(b): Running Other Data
To run user-supplied data, edit the `config.yaml` file to specify the locations of the input files (scRNA-seq .Rds, scATAC-seq .Rds, transcriptome GTF, and chrome.sizes). Be sure to also change the `genome:` value to match the genome that was used in the alignments. 

From the root of the repository (`MASCARA/`), run the pipeline using
```
snakemake --use-singularity
```

#### 2: Visualization with Shiny

Once the pipeline has finished running, there will be a final output file `data/output/network.tsv`. These results can be visualized and explored interactively in a Shiny app by running the following from the command line

```
Rscript shinyapp/app.R data/output/network.tsv
```

This will automatically launch open the app in the default web browser.

### Example Output

![shiny_app_example](https://media.giphy.com/media/Kc1f8O613s8yzkdCxV/giphy.gif)

### Future Directions

In the future we hope to integrate a pseudotime analysis as a method to understand how regulatory networks change at different time points during cell type differentiation and or disease progression. Incorporating a trajectory inference may help to better characterize the evolution and divergences between cell clusters. 



#### Citations
[Data](https://github.com/GreenleafLab/MPAL-Single-Cell-2019) used in tutorial:

* Granja, J.M., Klemm, S., McGinnis, L.M. et al. Single-cell multiomic analysis identifies regulatory programs in mixed-phenotype acute leukemia. Nat Biotechnol 37, 1458–1465 (2019) doi:10.1038/s41587-019-0332-7

**Packages/Applications**
* [Docker](https://www.docker.com/) - Dirk Merkel. 2014. Docker: lightweight Linux containers for consistent development and deployment. Linux J. 2014, 239, Article 2 (March 2014).
* [Cicero](https://cole-trapnell-lab.github.io/cicero-release/) - Pliner, H. A., Packer, J. S., McFaline-Figueroa, J. L., Cusanovich, D. A., Daza, R. M., Aghamirzaie, D., … Trapnell, C. (2018). Cicero Predicts cis-Regulatory DNA Interactions from Single-Cell Chromatin Accessibility Data. Molecular cell, 71(5), 858–871.e8. doi:10.1016/j.molcel.2018.06.044
* [ChromVar](https://github.com/GreenleafLab/chromVAR) - Schep, A., Wu, B., Buenrostro, J. et al. chromVAR: inferring transcription-factor-associated accessibility from single-cell epigenomic data. Nat Methods 14, 975–978 (2017) doi:10.1038/nmeth.4401
* [ACTIONet](https://github.com/shmohammadi86/ACTIONet) - Mohammadi, S., Davila-Velderrain, J., Kellis, M. (2019) A multiresolution framework to characterize single-cell state landscapes. bioRxiv 746339; doi: doi.org/10.1101/746339


#### Team Members
<img src="https://user-images.githubusercontent.com/59709364/72642061-84abeb80-3939-11ea-866f-d788f7b9af0f.jpg" alt="mascara_team" width="400" height="300">

