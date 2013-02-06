#!/bin/bash
#
# Helper script to process all of the SVM output files into set of summary files (for one dataset).

set -e

. build-params.sh $1

. cleanOutput.sh $1_svm

./extractSummary.sh $weka_out/$1_svm* > $weka_out/$1_svm_temp.out 
grep -e "^\s*$" -v $weka_out/$1_svm_temp.out > $weka_out/$1_svm_temp2.out  
cat $weka_out/$1_svm_temp2.out | sed -e "s/^.*$1_svm_\(\w\+\)_eg\([0-9\.]\+\)\_n\([0-2]\+\)\.out/\1,\2,\3/g" > $weka_out/$1_svm_summary.out

grep "Error on train" -A9 $weka_out/$1_svm_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/\w\+,[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_svm_summary_train.out
grep "Error on test"  -A9 $weka_out/$1_svm_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/\w\+,[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_svm_summary_test.out
grep "cross"          -A9 $weka_out/$1_svm_summary.out | grep -v "cross" | sed -e 's/^--$//g' | sed -e 's/\w\+,[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_svm_summary_cross.out

. cleanTemp.sh $1_svm

