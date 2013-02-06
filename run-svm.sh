#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1

# Kernel params
if [ "$2" == "RBF" ] ;
then
    kernel_params="-C 250007 -G $3"
else
    kernel_params="-C 250007 -E $3"
fi

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.functions.SMO -C 1.0 -L 0.0010 -P 1.0E-12 -N $4 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.$2Kernel $kernel_params" $train_test_args -i -x 10 > $weka_out/$5

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$5
