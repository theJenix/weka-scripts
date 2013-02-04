#!/bin/bash
#

weka_dir=../weka-3-6-9
weka_out=../weka-out
# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.functions.MultilayerPerceptron -L $3 -M $4 -N $2 -V 0 -S 0 -E 20 -H a -split-percentage 10 -t $weka_dir/data/$1.arff -i > $weka_out/$5

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$5
