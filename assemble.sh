#!/bin/bash
#
# A script to assemble Weka ARFF files from lightly processed UCI data sets.
# This script expects the following files (for a given dataset 'dataset'):
#     dataset.arff-start - the top part of the file...comments and attributions,
#     and the @relation declaration
#     dataset.attr - the @attribute declarations for the file
#     dataset.data or dataset-train.data - the data file in csv format.  the
#     order of the columns in the data file must match the order of the
#     @attributes defined in dataset.attr
#
# Usage:
#   ./assemble.sh dataset
#
# NOTE: this will single file datasets, or datasets with separate testing and
# training data.  To use this with the latter styles of datasets, add a separate
# parameter to indicate if you want to assemble the training or testing set.
# e.g.
#   ./assemble.sh dataset train
#

if [ -z "$2" ] ;
then
    cat $1.arff-start > $1.arff
    cat $1.attr >> $1.arff
    echo "@data" >> $1.arff
    cat $1.data >> $1.arff
else
    cat $1.arff-start > $1-$2.arff
    cat $1.attr >> $1-$2.arff
    echo "@data" >> $1-$2.arff
    cat $1-$2.data >> $1-$2.arff
fi
