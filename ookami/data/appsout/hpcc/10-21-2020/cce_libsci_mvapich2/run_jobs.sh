#!/bin/bash

INPUT_FILE=hpccinf.txt.48x1
INPUT_FILE_OUT=hpccinf.txt
SBATCH_FILE=hpcc.job
TOP_WD=`pwd`
DIR1=std_48x1
N_RUNS=${N_RUNS:-20}

mkdir -p $DIR1
cd $DIR1
for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   [ -d $i ] && rm -rf $i
   mkdir $i
   cd $i
   cp $TOP_WD/$INPUT_FILE ./$INPUT_FILE_OUT
   sbatch $TOP_WD/$SBATCH_FILE
   cd ..
done


