#!/bin/bash
#
# Helper script to process all of the j48 output files into one summary file.

set -e

. build-params.sh $1

. cleanOutput.sh $1_j48

./extractSummary.sh $weka_out/$1_j48* > $weka_out/$1_j48_temp.out 
grep -e "^\s*$" -v $weka_out/$1_j48_temp.out > $weka_out/$1_j48_temp2.out  
cat $weka_out/$1_j48_temp2.out | sed -e "s/^.*$1_j48_c\([0-9\.u]\+\)\_mo\([0-9\.]\+\)\.out/\1,\2/g" > $weka_out/$1_j48_summary.out

grep "Error on train" -A9 $weka_out/$1_j48_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_j48_summary_train.out
grep "Error on test"  -A9 $weka_out/$1_j48_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_j48_summary_test.out
grep "cross" -A9 $weka_out/$1_j48_summary.out | grep -v "cross" | sed -e 's/^--$//g' | sed -e 's/[0-9\.u]\+,[0-9\.]\+,$//g' > $weka_out/$1_j48_summary_cross.out

. cleanTemp.sh $1_j48

