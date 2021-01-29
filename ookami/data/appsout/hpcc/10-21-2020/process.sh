#!/bin/bash
N_RUNS=20

for f in std_48x1
do
    echo "Processing $f"
    cd $f

    for (( i=1; i<=$N_RUNS; i++ ))
    do
       cd $i
       echo "Processing run $i"
       cp hpccoutf.txt appstdout
       touch gen.info
       PYTHONPATH=/home/nikolays/xdmod_wsp/akrr python3 /home/nikolays/xdmod_wsp/akrr/akrr/parsers/hpcc_parser.py ./ ../result_$i.xml
       rm gen.info appstdout
       cd ..
    done
    cd ..
done
