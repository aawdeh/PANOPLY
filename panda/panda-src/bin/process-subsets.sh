#!/bin/bash
#
# Copyright (c) 2020 The Broad Institute, Inc. All rights reserved.
#

echo -e "\n---------------------------"
echo -e "Creating, uploading, linking-"
echo -e "sample set subsets -------"
echo -e "---------------------------\n"

source config.sh
source $src/tedmint-lib.sh

mkdir -p subsets
Rscript --verbose $src/r-source/create-subsets.r \
  -a $csv_types \
  -b $gct_types \
  -i $inp \
  -o $dst \
  -w $wkspace

echo -e "Done.."

Rscript --verbose $src/r-source/attribute-sample-set.r \
  -a $bucket \
  -b $wkspace \
  -c $project \
  -d $csv_types \
  -e $gct_types
