#!/bin/bash

EXE=/gpfs/ookami/projects/appker/execs/build/hpcc-code/hpcc_sysblas
NPROC=128
N_RUNS=10

for (( i=1; i<=$N_RUNS; i++ ))
do
   echo "Run $i"
   mpirun -n $NPROC --use-hwthread-cpus $EXE
   mv hpccoutf.txt hpccoutf.txt.$i
done

