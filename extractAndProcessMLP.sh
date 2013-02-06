#!/bin/bash
#
# Helper script to process all of the mlp output files into one summary file.

set -e

. build-params.sh $1

. cleanOutput.sh $1_mlp

./extractSummary.sh $weka_out/$1_mlp* > $weka_out/$1_mlp_temp.out 
grep -e "^\s*$" -v $weka_out/$1_mlp_temp.out > $weka_out/$1_mlp_temp2.out  
#echo "Running ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum $1_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out" > $weka_out/run-all-mlp.out
cat $weka_out/$1_mlp_temp2.out | sed -e "s/^.*$1_mlp_\([0-9]\+\)\_lr0\([0-9]\+\)_m0\([0-9]\+\)\.out/\1,0.\2,0.\3/g" > $weka_out/$1_mlp_summary.out

grep "Error on train" -A9 $weka_out/$1_mlp_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9\.]\+,[0-9\.]\+,[0-9\.]\+,$//g' > $weka_out/$1_mlp_summary_train.out
grep "Error on test"  -A9 $weka_out/$1_mlp_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9\.]\+,[0-9\.]\+,[0-9\.]\+,$//g' > $weka_out/$1_mlp_summary_test.out
grep "cross"          -A9 $weka_out/$1_mlp_summary.out | grep -v "cross" | sed -e 's/^--$//g' | sed -e 's/[0-9\.]\+,[0-9\.]\+,[0-9\.]\+,$//g' > $weka_out/$1_mlp_summary_cross.out

. cleanTemp.sh $1_mlp

