#!/bin/bash
#
# Helper script to process all of the boosting (with j48) output files into one summary file.

set -e

. build-params.sh $1

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

. cleanOutput.sh $1_boosting_j48

./extractSummary.sh $weka_out/$1_boosting_j48* > $weka_out/$1_boosting_j48_temp.out 
grep -e "^\s*$" -v $weka_out/$1_boosting_j48_temp.out > $weka_out/$1_boosting_j48_temp2.out  
cat $weka_out/$1_boosting_j48_temp2.out | sed -e "s/^.*$1_boosting_j48_i\([0-9]\+\)\_wt\([0-9]\+\)\.out/\1,\2/g" > $weka_out/$1_boosting_j48_summary.out

grep "Error on train" -A9 $weka_out/$1_boosting_j48_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,$//g' > $weka_out/$1_boosting_j48_summary_train.out
grep "Error on test"  -A9 $weka_out/$1_boosting_j48_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,$//g' > $weka_out/$1_boosting_j48_summary_test.out
grep "cross" -A9 $weka_out/$1_boosting_j48_summary.out | grep -v "cross" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,$//g' > $weka_out/$1_boosting_j48_summary_cross.out

. cleanTemp.sh $1_boosting_j48

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $weka_out/run-all-boosting-j48.out

