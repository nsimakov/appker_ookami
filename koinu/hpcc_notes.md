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

## BLAS Libraries
### Arm Performance Libraries (ARMPL)

```bash
# Check for better fit at
# https://developer.arm.com/tools-and-software/server-and-hpc/downloads/arm-performance-libraries
wget https://developer.arm.com/-/media/Files/downloads/hpc/arm-performance-libraries/20-2-0/RHEL8/arm-performance-libraries_20.2_RHEL-8_gcc-8.2.tar
tar -xvf arm-performance-libraries_20.2_RHEL-8_gcc-8.2.tar
cd arm-performance-libraries_20.2_RHEL-8_gcc-8.2
./arm-performance-libraries_20.2_RHEL-8.sh -a -i /gpfs/ookami/projects/appker/arm
# to use
module use /gpfs/ookami/projects/appker/arm/modulefiles
module load armpl
```
It defines following:
```
prepend-path    CPATH /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_common
prepend-path    LD_LIBRARY_PATH /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib
prepend-path    LIBRARY_PATH /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib
setenv          ARMPL_LIBRARIES /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib
append-path     ARMPL_BUILD 84
append-path     ARMPL_DIR /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2
append-path     ARMPL_INCLUDES /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include
append-path     ARMPL_INCLUDES_ILP64 /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_ilp64
append-path     ARMPL_INCLUDES_ILP64_MP /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_ilp64_mp
append-path     ARMPL_INCLUDES_INT64 /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_ilp64
append-path     ARMPL_INCLUDES_INT64_MP /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_ilp64_mp
append-path     ARMPL_INCLUDES_LP64_MP /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_lp64_mp
append-path     ARMPL_INCLUDES_MP /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/include_lp64_mp
append-path     BLAS /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.a
append-path     BLAS_SHARED /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.so
append-path     BLAS_STATIC /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.a
append-path     LAPACK /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.a
append-path     LAPACK_SHARED /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.so
append-path     LAPACK_STATIC /gpfs/ookami/projects/appker/arm/armpl_20.2_gcc-8.2/lib/libarmpl_lp64.a
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
# copy hpcc binary with descriptive suffix for futher use and comparison
cp hpcc hpcc_sysblas
```

## HPCC AMDPL, internal FFT
```bash
module load openmpi
module load armpl

cd /gpfs/ookami/projects/appker/execs/build/hpcc-code
make arch=Linux.ARM clean
cp hpl/Make.Linux.ARM hpl/Make.Linux.ARMPL
# edit with proper settings
# vi hpl/Make.Linux.ARMPL

make -j 4 arch=Linux.ARMPL
# copy hpcc binary with descriptive suffix for futher use and comparison
cp hpcc hpcc_armpl
```