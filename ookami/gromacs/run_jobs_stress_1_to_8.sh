#!/bin/bash

TIME_TO_RUN=${1:24:00:00}
INPUT=${2:mem}
SBATCH_FILE=gromacs_stress.job
TOP_WD=`pwd`
N_RUNS=${N_RUNS:-20}
DIR1=run

mkdir -p $DIR1
cd $DIR1

for NODES in 1 2 4 8
do
mkdir N_$NODES
cd N_$NODES
SBATCH_ARG="--nodes=$NODES --ntasks-per-node=48 -t 24:00:00 -p long -q long"
for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   [ -d $i ] && rm -rf $i
   mkdir $i
   cd $i

   sbatch ${SBATCH_ARG} ${TOP_WD}/${SBATCH_FILE} ${INPUT}

   cd ..
done
cd ..
done

