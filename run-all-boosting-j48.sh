#!/bin/bash
#

set -e

. build-params.sh none

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

rm -f $weka_out/run-all-boosting-j48-*.out

alloutlog=$weka_out/run-all-boosting-j48-$$.out
echo "" > $alloutlog

iterations=( 10 20 30 40 50 60 70 80 90 100 )
weighttholds=( 100 90 80 70 60 50 25 10 )

for iter in "${iterations[@]}"
do
  for wt in "${weighttholds[@]}"
  do 
    echo "Running ./run-boosting-j48.sh $1 $iter $wt 0.25 2 $1_boosting_j48_i${iter}_wt${wt}.out"
    echo "Running ./run-boosting-j48.sh $1 $iter $wt 0.25 2 $1_boosting_j48_i${iter}_wt${wt}.out" > $alloutlog
    ./run-boosting-j48.sh $1 $iter $wt 0.25 2 $1_boosting_j48_i${iter}_wt${wt}.out
  done
done

. extractAndProcessBoostingJ48.sh $1

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $alloutlog 
