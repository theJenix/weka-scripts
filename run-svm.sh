#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.functions.SMO -C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0" $train_test_args -i -x 10 > $weka_out/$2

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$2
