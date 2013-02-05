#!/bin/bash
#

set -e

. build-params.sh none

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

confidences=( 'u' 0.1 0.125 0.25 0.5 )
minobjs=( 1 2 5 10 25 50 )

for conf in "${confidences[@]}"
do
  for minobj in "${minobjs[@]}"
  do 
    echo "Running ./run-j48.sh $1 $conf $minobj $1_j48_c${conf}_mo${minobj}.out"
    echo "Running ./run-j48.sh $1 $conf $minobj $1_j48_c${conf}_mo${minobj}.out" > $weka_out/run-all-j48.out
    ./run-j48.sh $1 $conf $minobj $1_j48_c${conf}_mo${minobj}.out
  done
done

. extractAndProcessJ48.sh $1

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $weka_out/run-all-j48.out
