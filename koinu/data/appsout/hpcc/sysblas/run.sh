#!/bin/bash
# std_64x1
for f in std_128x1 std_256x1
do
    echo $f
    cd $f
    ./run.sh
    cd ..
done
