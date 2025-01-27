#!/bin/bash
set -e # exit upon error condition
#
# Copyright (c) 2020 The Broad Institute, Inc. All rights reserved.
#

while getopts ":t:g:o:r:a:s:p:n:f:m:e:c:" opt; do
    case $opt in
        t) association_tar="$OPTARG";;
        g) cna_corr_tar="$OPTARG";;
        o) ssgsea_ome="$OPTARG";;
        r) ssgsea_rna="$OPTARG";;
        a) analysis_dir="$OPTARG";;
        s) ssgsea_assoc="$OPTARG";;
        p) ptmsea="$OPTARG";;
        n) nmf_res="$OPTARG";;
        f) nmf_figs="$OPTARG";;
        m) nmf_ssgsea="$OPTARG";;
        e) omicsev_tar="$OPTARG";;
        c) cosmo_tar="$OPTARG";;
        \?) echo "Invalid Option -$OPTARG" >&2;;
    esac
done

scatter_processing()
{
  dir_name=$1
  array=($(ls $dir_name/*.tar))
  for index in "${!array[@]}"
  do
    mkdir -p $dir_name/$index && tar xf ${array[index]} -C $dir_name/$index;
    group="$( echo -e "$( grep "input gct" $dir_name/$index/*parameters.txt | \
      cut -d ':' -f 2 | tr -d '[:space:]')" | \
      rev | cut -d '.' -f2- | rev )"
    mkdir -p $dir_name/"ssgsea-$group";
    cp -r $dir_name/$index/* $dir_name/"ssgsea-$group"/.;
    rm -rf $dir_name/$index;
  done
}

dir_create()
{
  cd $src;
  mkdir -p $summ_path
  # proteome-only modules
  scatter_processing $src/$ssgsea_assoc
  mkdir -p association_tar && tar xf $association_tar -C association_tar --strip-components 1
  mkdir -p ssgsea_ome && tar xf $ssgsea_ome -C ssgsea_ome
  # optional genomics-required modules
  if [[ ! -z $ssgsea_rna ]]; then
    mkdir -p ssgsea_rna && tar xf $ssgsea_rna -C ssgsea_rna
  fi
  if [[ ! -z $cna_corr_tar ]]; then
    mkdir -p cna_corr_tar && tar xf $cna_corr_tar -C cna_corr_tar --strip-components 1
  fi
  if [[ ! -z $omicsev_tar ]]; then
    mkdir -p omicsev_tar && tar xf $omicsev_tar -C omicsev_tar
  fi
  if [[ ! -z $cosmo_tar ]]; then
    mkdir -p cosmo_tar && tar xf $cosmo_tar -C cosmo_tar
  fi
  # optional modules
  if [[ ! -z $ptmsea ]]; then
    mkdir -p ptmsea && tar xf $ptmsea -C ptmsea
  fi
  if [ ! -z $nmf_res ] && [ ! -z $nmf_figs ]; then
    mkdir -p so_nmf
    mkdir -p so_nmf/nmf_results && tar xf $nmf_res -C so_nmf/nmf_results
    mkdir -p so_nmf/nmf_figures && tar xf $nmf_figs -C so_nmf/nmf_figures
    mkdir -p so_nmf/nmf_ssgsea && tar xf $nmf_ssgsea -C so_nmf/nmf_ssgsea
  fi
}


collect()
{
  cd $src;
  mkdir -p $summ_path/association;
  if ls association_tar/association/*.pdf 1> /dev/null 2>&1; then # if we have PDFs
    cp association_tar/association/*.pdf $summ_path/association/.;
  fi

  if [[ ! -z $cna_corr_tar ]]; then # genomics-requires modules
    mkdir -p $summ_path/rna; 
    cp cna_corr_tar/rna/*.pdf $summ_path/rna/.;
    mkdir -p $summ_path/cna; 
    cp cna_corr_tar/cna/*.png $summ_path/cna/.;
    mkdir -p $summ_path/sample-qc; 
    cp cna_corr_tar/sample-qc/*.pdf $summ_path/sample-qc/.;
  fi
  
  mkdir -p $full_path;

  cp -r association_tar/* $full_path/.;
  rm -rf association_tar;

  if [ -d "cna_corr_tar/" ]; then
    cp -r cna_corr_tar/* $full_path/.;
    rm -rf cna_corr_tar;
  fi
  if [ -d "omicsev_tar/" ]; then
    cp -r omicsev_tar/* $full_path/.;
    rm -rf omicsev_tar;
  fi
  if [ -d "cosmo_tar/" ]; then
    cp -r cosmo_tar/* $full_path/.;
    rm -rf cosmo_tar;
  fi

  cp -r ssgsea_ome $full_path/ssgsea_ome/;
  cp -r $ssgsea_assoc $full_path/$ssgsea_assoc/;
  mkdir -p $summ_path/ssgsea_ome;
  mkdir -p $summ_path/$ssgsea_assoc;
  cp -r ssgsea_ome/* $summ_path/ssgsea_ome/.;
  cp -r $ssgsea_assoc/* $summ_path/$ssgsea_assoc/.;

  rm -rf ssgsea_ome $ssgsea_assoc;

  if [ -d "ssgsea_rna/" ]; then
    cp -r ssgsea_rna $full_path/ssgsea_rna/;
    mkdir -p $summ_path/ssgsea_rna;
    cp -r ssgsea_rna/* $summ_path/ssgsea_rna/.;
    rm -rf ssgsea_rna;
  fi


  if [[ ! -z $ptmsea ]]; then
    cp -r ptmsea $full_path/ptmsea/;
    mkdir -p $summ_path/ptmsea;
    cp -r ptmsea $summ_path/ptmsea/.;
    rm -rf ptmsea;
  fi

  if [ ! -z $nmf_res ] && [ ! -z $nmf_figs ]; then
    cp -r so_nmf $full_path/so_nmf/;
    mkdir -p $summ_path/so_nmf;
    cp -r so_nmf/nmf_figures/ $summ_path/so_nmf; # copy only the figures to summary-path
    rm -rf so_nmf;
  fi
}

src=`pwd`

summ="$analysis_dir-summary-results"
full="$analysis_dir-full-results"

summ_path=$src/$summ
full_path=$src/$full
dir_create
collect
cd $src;
tar -cvf panoply_main_summary.tar $summ
tar -cvf panoply_main_full.tar $full
