#!/bin/bash
#

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Learning rate of 0.3 (Default)
./run-mlp.sh vote 100 0.3 vote_mlp_100_lr03.out
./run-mlp.sh vote 200 0.3 vote_mlp_200_lr03.out
./run-mlp.sh vote 300 0.3 vote_mlp_300_lr03.out
./run-mlp.sh vote 400 0.3 vote_mlp_400_lr03.out
./run-mlp.sh vote 500 0.3 vote_mlp_500_lr03.out
./run-mlp.sh vote 600 0.3 vote_mlp_600_lr03.out
./run-mlp.sh vote 700 0.3 vote_mlp_700_lr03.out
./run-mlp.sh vote 1000 0.3 vote_mlp_1000_lr03.out

# Learning rate of 0.5 (Better)
./run-mlp.sh vote 100 0.5 vote_mlp_100_lr05.out
./run-mlp.sh vote 200 0.5 vote_mlp_200_lr05.out
./run-mlp.sh vote 300 0.5 vote_mlp_300_lr05.out
./run-mlp.sh vote 400 0.5 vote_mlp_400_lr05.out
./run-mlp.sh vote 500 0.5 vote_mlp_500_lr05.out
./run-mlp.sh vote 600 0.5 vote_mlp_600_lr05.out
./run-mlp.sh vote 700 0.5 vote_mlp_700_lr05.out
./run-mlp.sh vote 1000 0.5 vote_mlp_1000_lr05.out


T="$(($(date +%s)-T))"
echo "Total Elapsed Time (seconds): ${T}" > run-all-mlp.out
