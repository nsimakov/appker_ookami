#!/bin/bash

TIME_TO_RUN=${1:-0:29:00}
SBATCH_FILE=hpcg.job
TOP_WD=`pwd`
N_RUNS=${N_RUNS:-2}
DIR1=run4

echo "TIME_TO_RUN: ${TIME_TO_RUN}"
echo "DIR1: ${DIR1}"

mkdir -p $DIR1
cd $DIR1

for NODES in 1 2 4 8 16 32 64
do
mkdir -p N_$NODES
cd N_$NODES

#SBATCH_ARG="--nodes=$NODES --ntasks-per-node=48 -t ${TIME_TO_RUN} -p stren"
SBATCH_ARG="--nodes=$NODES --ntasks-per-node=48 -t ${TIME_TO_RUN} -p skx-normal -q normal --exclusive"
for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   [ -d $i ] && rm -rf $i
   mkdir $i
   cd $i

   echo sbatch ${SBATCH_ARG} ${TOP_WD}/${SBATCH_FILE}
   sbatch ${SBATCH_ARG} ${TOP_WD}/${SBATCH_FILE}

   cd ..
done
cd ..
done
