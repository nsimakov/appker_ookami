#!/bin/bash
N_RUNS=10

for f in std_64x1 std_128x1 std_256x1
do
    echo "Processing $f"
    cd $f

    touch gen.info

    for (( i=1; i<=$N_RUNS; i++ ))
    do
       echo "Processing run $i"
       cp hpccoutf.txt.$i appstdout
       PYTHONPATH=/gpfs/ookami/projects/appker/akrr python3 /gpfs/ookami/projects/appker/akrr/akrr/parsers/hpcc_parser.py ./ result_$i.xml
    done
    rm gen.info appstdout

    cd ..
done
