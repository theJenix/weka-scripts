#!/bin/bash
#

set -e

. build-params.sh none

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

normls=( 0 1 2 )
polyexps=( 0.5 1 2 3 4 5 )
#NOTE: with segmentation dataset (normal orientation), overfitting occurs somewhere after 1.25
rbfgammas=( 0.01 0.10 0.50 1 1.25 2 3 )

rm -f $weka_out/run-all-svm-*.out

alloutlog=$weka_out/run-all-svm-$$.out
echo "" > $alloutlog

for norml in "${normls[@]}"
do
  for exp in "${polyexps[@]}"
  do
    echo "./run-svm.sh $1 Poly $exp $norml $1_svm_poly_eg${exp}_n${norml}.out"
    echo "./run-svm.sh $1 Poly $exp $norml $1_svm_poly_eg${exp}_n${norml}.out" >> $alloutlog
    ./run-svm.sh $1 Poly $exp $norml $1_svm_poly_eg${exp}_n${norml}.out
  done
  for gamma in "${rbfgammas[@]}"
  do
    echo "./run-svm.sh $1 RBF $gamma $norml $1_svm_rbf_eg${gamma}_n${norml}.out"
    echo "./run-svm.sh $1 RBF $gamma $norml $1_svm_rbf_eg${gamma}_n${norml}.out" >> $alloutlog
    ./run-svm.sh $1 RBF $gamma $norml $1_svm_rbf_eg${gamma}_n${norml}.out
  done
done

. extractAndProcessSVM.sh $1

T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" >> $alloutlog
