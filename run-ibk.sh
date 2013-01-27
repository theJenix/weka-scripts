#!/bin/bash
#

weka_dir=../weka-3-6-9
java -cp $weka_dir/weka.jar weka.classifiers.lazy.IBk -K $2 -W 0 -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\"" -t $weka_dir/data/$1.arff -i -x 10 > ../weka-out/$3
