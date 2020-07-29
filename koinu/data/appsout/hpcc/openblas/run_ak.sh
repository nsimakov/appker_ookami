#!/bin/bash

EXE=${EXE:-/gpfs/ookami/projects/appker/execs/build/hpcc-code/hpcc}
NPROC=${NPROC:-64}
N_RUNS=${N_RUNS:-10}
AK_WD=${AK_WD:-.}

echo $AK_WD
cd $AK_WD

for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   mpirun -n $NPROC $MPIRUN_ARGS $EXE
   mv hpccoutf.txt hpccoutf.txt.$i
done

