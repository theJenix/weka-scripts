#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Build the parameters for the weka command line
. build-params.sh $1

weight_opt=''
if [ "$4" == "-F" ] || [ "$4" == "-I" ] ;
then
    weight_opt=$4
fi
# Do some work here
#echo "java -cp $weka_dir/weka.jar weka.classifiers.lazy.IBk -K $2 -W $3 $weight_opt -A 'weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\"' $train_test_args -i -x 10 > $weka_out/$5"
java -cp $weka_dir/weka.jar weka.classifiers.lazy.IBk -K $2 -W $3 $weight_opt -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\"" $train_test_args -i -x 10 > $weka_out/$5

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$5
