#!/bin/bash
#

weka_dir=weka-3-6-9
java -cp $weka_dir/weka.jar weka.classifiers.trees.J48 -t $weka_dir/data/$1.arff -i -x 10 > $2
