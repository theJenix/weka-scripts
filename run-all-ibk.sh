#!/bin/bash
#

set -e

. build-params.sh none

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

nneighbors=(1 5 10 15 20 25 30 35 40 )
windowSizes=( 0 1 5 10 15 20 25 30 50 )
weighting=( '-' '-I' '-F' )

for nn in "${nneighbors[@]}"
do
  for ws in "${windowSizes[@]}"
  do 
    if [ $nn -gt 1 ] ;
    then
      for w in "${weighting[@]}"
      do
        echo "Running ./run-ibk.sh $1 $nn $ws $w $1_ibk_nn${nn}_ws${ws}_w${w}.out"
        echo "Running ./run-ibk.sh $1 $nn $ws $w $1_ibk_nn${nn}_ws${ws}_w${w}.out" > $weka_out/run-all-ibk.out
        ./run-ibk.sh $1 $nn $ws $w $1_ibk_nn${nn}_ws${ws}_w${w}.out
      done
    else
      echo "Running ./run-ibk.sh $1 $nn $ws $w $1_ibk_nn${nn}_ws${ws}_w.out"
      echo "Running ./run-ibk.sh $1 $nn $ws $w $1_ibk_nn${nn}_ws${ws}_w.out" > $weka_out/run-all-ibk.out
      ./run-ibk.sh $1 $nn $ws - $1_ibk_nn${nn}_ws${ws}_w.out
    fi
  done
done

# Extract and process the data to generate CSV files with algorithm statistics
. extractAndProcessIBk.sh $1

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $weka_out/run-all-ibk.out
