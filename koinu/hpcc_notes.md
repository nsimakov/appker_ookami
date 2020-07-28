# Building

Also check [https://gitlab.com/arm-hpc/packages/-/wikis/packages/hpc-challenge](https://gitlab.com/arm-hpc/packages/-/wikis/packages/hpc-challenge)
for HPCC build for ARM.

## OpenMPI
OpenMPI should be compiled with MPI1 support.
Currently system-wide openmpi provides, so no need to custom build. 

```bash
cd /gpfs/ookami/projects/appker/execs/build
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.4.tar.gz
tar xvzf openmpi-4.0.4.tar.gz
cd openmpi-4.0.4

./configure \
    --prefix=/gpfs/ookami/projects/appker/openmpi-4.0.4-mpi1 \
    --with-ucx=/gpfs/ookami/software/ucx-1.8.1 \
    --enable-orterun-prefix-by-default --with-hwloc \
    --with-xpmem=/opt/xpmem \
    --with-knem=/opt/knem-1.1.3.90mlnx1 \
    --without-verbs --with-cuda=/usr/local/cuda \
    --enable-mpi1-compatibility
    
make -j 8
make install
```

## HPCC system BLAS, internal FFT

```bash
module load openmpi

cd /gpfs/ookami/projects/appker/execs/build
hg clone http://hg.code.sf.net/p/hpcc/code hpcc-code
cd hpcc-code/hpl/setup/
source make_generic
mv Make.UNKNOWN ../Make.Linux.ARM
cd ..
# check the makefile:
cat Make.Linux.ARM
# go back to hpcc root
cd ..
make -j 4 arch=Linux.ARM
# copy hpcc binary with descriptive suffix for futer use and comparison
cp hpcc hpcc_sysblas
```
