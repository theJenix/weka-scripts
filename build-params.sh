#!/bin/bash
#
# A utility script to set variables for use in the Weka command line.  This script sets the following variables:
#  weka_dir - the path to the weka folder
#  weka_out - the path to a folder for output files
#  train_test_args - args to identify a training and testing file, or just a training file (NOTE: this uses cross validation instead of a separate testing file)
#

declare -x weka_dir
declare -x weka_out
declare -x train_test_args

weka_dir=../weka-3-6-9
weka_out=../weka-out

train_file=$weka_dir/data/$1-train.arff
test_file=$weka_dir/data/$1-test.arff
single_file=$weka_dir/data/$1.arff

train_test_args=''
if [ -e $train_file ] && [ -e $test_file ] ;
then
    train_test_args="-t $train_file -T $test_file"
else
    train_test_args="-t $single_file"
fi

