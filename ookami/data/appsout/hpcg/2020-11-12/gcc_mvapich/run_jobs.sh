#!/bin/bash


SBATCH_FILE=hpcg.job
TOP_WD=`pwd`
DIR1=std
N_RUNS=${N_RUNS:-20}

mkdir -p $DIR1
cd $DIR1
for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   [ -d $i ] && rm -rf $i
   mkdir $i
   cd $i
   sbatch $TOP_WD/$SBATCH_FILE
   cd ..
done


