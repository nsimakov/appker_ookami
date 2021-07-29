Based on stable open source libraries

# Initial: gcc-10.2.0 and openmpi-4.0.5

```bash
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5
mkdir -p /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/openmpi-gcc-4.0.5
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/openmpi-gcc-4.0.5
```


## OpenBlas 0.3.12
```bash
wget https://github.com/xianyi/OpenBLAS/releases/download/v0.3.12/OpenBLAS-0.3.12.tar.gz
tar -xf OpenBLAS-0.3.12.tar.gz 
cd OpenBLAS-0.3.12
```

Edit Makefile.arm64
```makefile
ifeq ($(CORE), ARMV8)
CCOMMON_OPT += -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512
FCOMMON_OPT += -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512
endi
```

build and installl
```bash
make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j

make install PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12

#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}

```

```
 OpenBLAS build complete. (BLAS CBLAS LAPACK LAPACKE)

  OS               ... Linux             
  Architecture     ... arm64               
  BINARY           ... 64bit                 
  C compiler       ... GCC  (cmd & version : gcc (GCC) 10.2.0)
  Fortran compiler ... GFORTRAN  (cmd & version : GNU Fortran (GCC) 10.2.0)
  Library Name     ... libopenblas_armv8-r0.3.12.a (Single-threading)  
```

# fftw-3.3.8

```bash
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/openmpi-gcc-4.0.5
wget ftp://ftp.fftw.org/pub/fftw/fftw-3.3.8.tar.gz
tar -xf fftw-3.3.8.tar.gz
cd fftw-3.3.8/
mkdir bld
cd bld
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" ;\
;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" --enable-single --program-suffix=f;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
echo "Done"


# export vars for reuse
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}


# lets check if explicitly specifying neon will make any difference
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8-neon  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" --enable-neon; \
;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8-neon  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" --enable-single --program-suffix=f --enable-neon;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
echo "Done"

#mpirun ./hpcc_gcc_openblas_fftw_openmpi;mpirun ./hpcc_gcc_openblas_fftwneon_openmpi
#MPIFFT_Gflops=7.88332
#MPIFFT_Gflops=7.74876
#
#no difference !
```

## hpcc

```bash

cd /lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/hpcc
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5
# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=gcc_openblas_fftw_openmpi -j 32
```

#gromacs
## gromacs-2020.4
```bash
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/openmpi-gcc-4.0.5/
wget http://ftp.gromacs.org/pub/gromacs/gromacs-2020.4.tar.gz
tar -xf gromacs-2020.4.tar.gz
cd gromacs-2020.4
mkdir bld
cd bld


# fftw
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=ARM_NEON_ASIMD -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/gromacs-2020.4
make -j 32
make -j 32 install
# Using 48 MPI processes Using 1 OpenMP thread per MPI process
# Performance:       12.260 


cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/gromacs-2020.4
make -j 32 install
# Using 48 MPI processes Using 1 OpenMP thread per MPI process
# Performance:       12.225
# same
```

## gromacs-2021
```bash
module use /lustre/projects/global/software/a64fx/modulefiles

module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.1.0


cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/openmpi-gcc-4.1.0
wget https://ftp.gromacs.org/gromacs/gromacs-2021.tar.gz
tar -xf gromacs-2021.tar.gz
cd gromacs-2021
mkdir bld
cd bld


# fftw
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/fftw-3.3.8
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.1.0/gromacs-2021
make -j 32
make -j 32 install

```


# UPDATE: 2021-06-16

Compiler change

gcc/10.3.0

```bash
module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles
module load slurm

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake 
module load gcc/10.3.0 openmpi/gcc10/4.1.0

mkdir -p /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.3.0
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.3.0
```


## OpenBlas 0.3.15
```bash
wget https://github.com/xianyi/OpenBLAS/releases/download/v0.3.15/OpenBLAS-0.3.15.tar.gz
tar -xf OpenBLAS-0.3.15.tar.gz 
cd OpenBLAS-0.3.15
```

Edit Makefile.arm64
```makefile
ifeq ($(CORE), ARMV8)
CCOMMON_OPT += -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512
FCOMMON_OPT += -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512
endi
```

build and installl
```bash
make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j

make install PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/OpenBLAS-0.3.15

#OpenBLAS-0.3.15
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/OpenBLAS-0.3.15
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}

```

```
 OpenBLAS build complete. (BLAS CBLAS LAPACK LAPACKE)

  OS               ... Linux             
  Architecture     ... arm64               
  BINARY           ... 64bit                 
  C compiler       ... GCC  (cmd & version : gcc (GCC) 10.2.0)
  Fortran compiler ... GFORTRAN  (cmd & version : GNU Fortran (GCC) 10.2.0)
  Library Name     ... libopenblas_armv8-r0.3.12.a (Single-threading)  
```



# fftw-3.3.8

```bash
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.3.0
wget http://www.fftw.org/fftw-3.3.9.tar.gz
tar -xf fftw-3.3.9.tar.gz
cd fftw-3.3.9/
mkdir bld
cd bld
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/fftw-3.3.9  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" ;\
;
make -j;make check;make -j install;

rm -rf *;

../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/fftw-3.3.9  \
    --enable-mpi --disable-openmp --disable-threads \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512 -fstrict-aliasing -fno-schedule-insns" --enable-single --program-suffix=f;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
echo "Done"


# export vars for reuse
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/fftw-3.3.9
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

```

# hpcc

```bash

cd /lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0
# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=gcc_openblas_fftw_openmpi -j 32
```

#gromacs
## gromacs-2021.2
```bash
wget https://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz
tar -xf gromacs-2021.2.tar.gz
cd gromacs-2021.2
mkdir bld
cd bld



cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=ARM_SVE -DGMX_SIMD_ARM_SVE_LENGTH=512 -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.3.0/gromacs-2021.2
make -j 32
make -j 32 install

```

## IMB
```bash
rsync -a ../gcc-10.2.0/openmpi-gcc-4.0.5/mpi-benchmarks-IMB-v2019.2 ./
cd imb/
make clean
CC=mpicc CXX=mpicxx make  IMB-MPI1

CC=mpicc CXX=mpicxx CXXFLAGS="-DRDMAV_HUGEPAGES_SAFE=1" CFLAGS="-DRDMAV_HUGEPAGES_SAFE=1" make IMB-EXT  IMB-MPI1


module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles
module load slurm
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake 
module load gcc/10.3.0 openmpi/gcc10/4.1.0
CC=mpicc CXX=mpicxx make  IMB-MPI1

running in interactive mode as:
mpirun -n 2 --map-by ppr:1:node -H hf -x LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./IMB-MPI1
# or
mpirun -n 2 --map-by ppr:1:node -H fj026,fj027 -x LD_LIBRARY_PATH=$LD_LIBRARY_PATH -x RDMAV_HUGEPAGES_SAFE=1 ./IMB-MPI1
strace -o -ff 

```

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                    
rank 0
13818 xdmod     20   0  622912  94080  25792 R  99.7   0.3   0:18.87 IMB-MPI1  
rank 1
 6387 xdmod     20   0  643392  94080  25792 R  50.0   0.3   1:23.08 IMB-MPI1


 
 
 
   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                 
15833 xdmod     20   0    9472   3136   1536 R  47.4   0.0   0:06.75 strace                                                                                  
15835 xdmod     20   0  633152  94080  25792 R  47.4   0.3   0:08.52 IMB-MPI1 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                 
 8493 xdmod     20   0  622912  94080  25792 R  94.7   0.3   0:34.59 IMB-MPI1
 
 
 
 33214
 
 26054
