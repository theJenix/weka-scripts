#!/bin/bash
#

weka_dir=../weka-3-6-9
weka_out=../weka-out
# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

train_file=$weka_dir/data/$1-train.arff
test_file=$weka_dir/data/$1-test.arff
single_file=$weka_dir/data/$1.arff

train_test_args=''
if [ -e $train_file && -e $test_file ] ;
then
    train_test_args='-t $train_file -T $test_file'
else
    train_test_args='-t $single_file'
fi

# Do some work here
java -cp $weka_dir/weka.jar weka.classifiers.functions.MultilayerPerceptron -L $3 -M $4 -N $2 -V 0 -S 0 -E 20 -H a -t $weka_dir/data/$1.arff -i -x 10 > $weka_out/$5

T="$(($(date +%s)-T))"
echo "Elapsed Time (seconds): ${T}" >> $weka_out/$5
