#!/bin/bash


INPUT=mem
SBATCH_FILE=gromacs.job
TOP_WD=`pwd`
N_RUNS=${N_RUNS:-3}
DIR1=run

mkdir -p $DIR1
cd $DIR1

SBATCH_ARG="--nodes=8 --ntasks-per-node=48 -t 24:00:00 -p long -q long"
for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   [ -d $i ] && rm -rf $i
   mkdir $i
   cd $i

   cp /lustre/projects/Buffalo/appker/inputs/gromacs/$INPUT/topol.tpr ./

   sbatch ${SBATCH_ARG} ${TOP_WD}/${SBATCH_FILE}

   cd ..
done


