#!/bin/bash

export EXE=/gpfs/ookami/projects/appker/execs/build/hpcc-code/hpcc_openblas
export N_RUNS=10

export NPROC=64
export AK_WD=std_64x1
./run_ak.sh

export MPIRUN_ARGS="--use-hwthread-cpus"

export AK_WD=std_128x1
export NPROC=128
./run_ak.sh

export AK_WD=std_256x1
export NPROC=256
./run_ak.sh

