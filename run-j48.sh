#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1
shift

if [ "$1" == "u" ] ;
then
    j48_args="-U"
else
    j48_args="-C $1"
fi

shift
j48_args="$j48_args -M $1"

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.trees.J48 $train_test_args $j48_args -i -x 10 > $weka_out/$2

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$2
