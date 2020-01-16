FROM bioconductor/bioconductor_docker

MAINTAINER Mervin Fansler <mef3005@med.cornell.edu>

LABEL name="mfansler/mascara" \
      version="0.1.0" \
      url="https://github.com/NCBI-Codeathons/Defining-Cell-Fate-Regulators-in-Multi-omic-Single-Cell-Developmental-Datasets" \
      maintainer="maintainer@bioconductor.org" \
      description="Bioconductor-based docker image with tools for single-cell multiomics analysis." \
      license="MIT License"

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
    libigraph0-dev libboost-graph-dev


###############################
# R and bioconductor packages #

ADD r_packages.R /tmp/
RUN R -f /tmp/r_packages.R
