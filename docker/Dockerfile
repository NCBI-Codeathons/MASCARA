############################################################
# Dockerfile to build (Multiomic Analysis of Single Cell ATAC-seq and RNA-seq)
# A simple method for identifying transcription factor mediated regulatory networks from scRNA and scATAC data
############################################################

# File Author / Maintainer
MAINTAINER Bala Desinghu <dmbala@gmail.com>


##FROM rocker/r-base:devel
## FROM rocker/rstudio:3.6.0
FROM bioconductor/bioconductor_docker


# File Author / Maintainer
MAINTAINER Bala Desinghu <dmbala@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

## Update package lists 
RUN apt-get update -qq \
  && apt-get dist-upgrade -y

## additional build dependencies and some extrs 
RUN apt-get install -y --no-install-recommends \
      bwidget \
      ca-certificates \
      curl \
      git \
      gsl-bin \
      libcurl4-openssl-dev \
      libproj-dev \
      libssl-dev \
      libv8-dev \
      libxml2-dev \
      pandoc pandoc-citeproc \
      qpdf \
      xauth \
      xfonts-base \
      xvfb \
      snakemake \
      nano \ 
      vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists

## install devtools
RUN install2.r devtools remotes

## install graph devs
RUN apt-get update && apt-get install -y --no-install-recommends \
    libigraph0-dev libboost-graph-dev 


## install R packages with the script r_packages 
ADD r_packages.R /tmp/
RUN R -f /tmp/r_packages.R

