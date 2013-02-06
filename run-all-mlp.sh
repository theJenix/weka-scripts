#!/bin/bash
#

set -e

. build-params.sh none

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

rm -f $weka_out/run-all-mlp-*.out

alloutlog=$weka_out/run-all-mlp-$$.out
echo "" > $alloutlog

momentums=( 2 3 5)
learningrates=( 3 5 7 )
epochs=( 100 200 300 400 500 600 700 1000 2500 5000 10000 )

for epoch in "${epochs[@]}"
do
  for learningrate in "${learningrates[@]}"
  do 
    for momentum in "${momentums[@]}"
    do
      
      echo "Running ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum $1_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out"
      echo "Running ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum $1_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out" >> $alloutlog
      ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum $1_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out
    done
  done
done

. extractAndProcessMLP.sh $1

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $alloutlog
