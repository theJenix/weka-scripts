#!/bin/bash
#

set -e

weka_out=../weka-out
# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

momentums=( 2 3 5)
learningrates=( 3 5 7 )
epochs=( 100 200 300 400 500 600 700 1000)

for epoch in "${epochs[@]}"
do
  for learningrate in "${learningrates[@]}"
  do 
    for momentum in "${momentums[@]}"
    do
      
      echo "Running ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum vote_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out"
      echo "Running ./run-mlp.sh $1 $epoch 0.$learningrate 0.$momentum vote_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out" > $weka_out/run-all-mlp.out
      ./run-mlp.sh vote $epoch 0.$learningrate 0.$momentum $1_mlp_${epoch}_lr0${learningrate}_m0${momentum}.out
    done
  done
done
#./run-mlp.sh vote 200 0.3 0.2 vote_mlp_200_lr03.out
#./run-mlp.sh vote 300 0.3 0.2 vote_mlp_300_lr03.out
#./run-mlp.sh vote 400 0.3 0.2 vote_mlp_400_lr03.out
#./run-mlp.sh vote 500 0.3 0.2 vote_mlp_500_lr03.out
#./run-mlp.sh vote 600 0.3 0.2 vote_mlp_600_lr03.out
#./run-mlp.sh vote 700 0.3 vote_mlp_700_lr03.out
#./run-mlp.sh vote 1000 0.3 vote_mlp_1000_lr03.out

# Learning rate of 0.5 (Better)
#./run-mlp.sh vote 100 0.5 vote_mlp_100_lr05.out
#./run-mlp.sh vote 200 0.5 vote_mlp_200_lr05.out
#./run-mlp.sh vote 300 0.5 vote_mlp_300_lr05.out
#./run-mlp.sh vote 400 0.5 vote_mlp_400_lr05.out
#./run-mlp.sh vote 500 0.5 vote_mlp_500_lr05.out
#./run-mlp.sh vote 600 0.5 vote_mlp_600_lr05.out
#./run-mlp.sh vote 700 0.5 vote_mlp_700_lr05.out
#./run-mlp.sh vote 1000 0.5 vote_mlp_1000_lr05.out


T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $weka_out/run-all-mlp.out
