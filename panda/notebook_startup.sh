#!/bin/bash
#
# Copyright (c) 2020 The Broad Institute, Inc. All rights reserved.
#

apt-get update
apt-get -t unstable install -y libssl-dev
apt-get -t unstable install -y libcurl4-openssl-dev

cat <<EOM>> build-config-yaml-startup.r
if( !requireNamespace( "BiocManager", quietly = TRUE ) )
install.packages( "BiocManager", 
  repos = "http://cran.us.r-project.org") #,
#  dependencies = TRUE );
# BiocManager::install( version = "3.14" );
install.packages( "pacman" )
library( pacman )
BiocManager::install( 
  c( "Biobase", "rhdf5", "prada", "SummarizedExperiment" ) )
p_install( data.table )
p_install( matrixStats )
p_load( glue )
# devtools::install_github("cmap/cmapR")
# cmapR <- "https://www.bioconductor.org/packages/3.11/bioc/"
# cmapR <- glue( "{cmapR}src/contrib/Archive/cmapR/cmapR_0.99.19.tar.gz" )
# install.packages( cmapR, repos = NULL, type = "source" )
p_load( cmapR )
p_load( RColorBrewer )
p_load( ids )
p_load( getopt )
p_load( scales )
p_load( yaml )
EOM

Rscript build-config-yaml-startup.r
