#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1

if [ "$4" == "u" ] ;
then
    j48_args="-U"
else
    j48_args="-C $4"
fi

j48_args="$j48_args -M $5"

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.meta.AdaBoostM1 -P $2 -S 1 -I $3 -W weka.classifiers.trees.J48 $train_test_args -i -x 10  -- $j48_args > $weka_out/$6

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$6
