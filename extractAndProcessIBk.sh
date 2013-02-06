#!/bin/bash
#

set -e

. build-params.sh $1

. cleanOutput.sh $1_ibk

./extractSummary.sh $weka_out/$1_ibk* > $weka_out/$1_ibk_temp.out 
grep -e "^\s*$" -v $weka_out/$1_ibk_temp.out > $weka_out/$1_ibk_temp2.out  
cat $weka_out/$1_ibk_temp2.out | sed -e "s/^.*$1_ibk_nn\([0-9]\+\)\_ws\([0-9]\+\)_w-\?\([IF]\?\)\.out/\1,\2,\3/g" > $weka_out/$1_ibk_summary.out

grep "Error on train" -A9 $weka_out/$1_ibk_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,[FI]\?,$//g' > $weka_out/$1_ibk_summary_train.out
grep "Error on test"  -A9 $weka_out/$1_ibk_summary.out | grep -v "Error" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,[FI]\?,$//g' > $weka_out/$1_ibk_summary_test.out
grep "cross" -A9 $weka_out/$1_ibk_summary.out | grep -v "cross" | sed -e 's/^--$//g' | sed -e 's/[0-9]\+,[0-9]\+,[FI]\?,$//g' > $weka_out/$1_ibk_summary_cross.out

. cleanTemp.sh $1_ibk

