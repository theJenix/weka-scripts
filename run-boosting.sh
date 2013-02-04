#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.meta.AdaBoostM1 -P 100 -S 1 -I 10 -W weka.classifiers.trees.DecisionStump $train_test_args -i -x 10 > $weka_out/$2

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$2
