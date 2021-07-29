Based on the most recent and developer version of open source libraries

# gcc-10.2.0 and openmpi-4.0.5

```bash
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/11.0-git openmpi/gcc/4.1.0
mkdir -p /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
```


## OpenBlas docularxu
```bash
git clone https://github.com/docularxu/OpenBLAS.git
cd OpenBLAS/
```

See Makefile.arm64 should we add -msve-vector-bits=512
```makefile
ifeq ($(CORE), TSV110SVE)
CCOMMON_OPT += -march=armv8.2-a+sve -mtune=tsv110
FCOMMON_OPT += -march=armv8.2-a+sve -mtune=tsv110
endif

ifeq ($(CORE), TSV110SVE)
CCOMMON_OPT += -march=armv8.2-a+sve -mtune=a64fx
FCOMMON_OPT += -march=armv8.2-a+sve -mtune=a64fx
endif

```

build and installl
```bash
wget https://github.com/xianyi/OpenBLAS/archive/v0.3.13.tar.gz
tar -xf v0.3.13.tar.gz
cd OpenBLAS-0.3.13

make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j TARGET=TSV110SVE
```

## OpenBlas 0.3.13

```bash
cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
wget https://github.com/xianyi/OpenBLAS/archive/v0.3.13.tar.gz
tar -xf v0.3.13.tar.gz
cd OpenBLAS-0.3.13

make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j

make install PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13

#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}
```


# fftw-3.3.8

```bash
../configure                        \
    CC="fcc"                         \
    F77="frt"                        \
    CFLAGS='-Nclang -Ofast'          \
    FFLAGS='-Kfast'                  \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-float                   \
    --enable-fma                     \
    --enable-fortran                 \
    --enable-openmp                  \
    --enable-shared                  \
--enable-mpi
    --prefix="$INSTALL_PATH"         \
    --libdir="$INSTALL_PATH/lib64"   \
    ac_cv_prog_f77_v='-###'          \
    OPENMP_CFLAGS='-Kopenmp'




git clone https://github.com/fujitsu/fftw3.git fftw3-fujitsu
cd fftw3-fujitsu
touch ChangeLog
autoreconf --verbose --install --symlink --force

mkdir bld
cd bld
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu  \
    --enable-mpi --disable-openmp --disable-threads \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" ;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu  \
    --enable-mpi --disable-openmp --disable-threads \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    --enable-single --program-suffix=f  \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" 
make -j;\
make check;\
make -j install;\
rm -rf *;\
echo "Done"


# export vars for reuse
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
```

# hpcc

```bash

cd /lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/hpcc
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5
# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=gcc_openblas_fftw_openmpi -j 32
```

#gromacs

```bash
module use /lustre/projects/global/software/a64fx/modulefiles

module unload gcc/11.0-git
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5


cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02/
wget https://ftp.gromacs.org/gromacs/gromacs-2021.tar.gz
tar -xf gromacs-2021.tar.gz
cd gromacs-2021
mkdir bld
cd bld


# fftw
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13
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
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/gromacs-2021
make -j 32
make -j 32 install
```









# 2021-06

gcc-10.2.0 and openmpi-4.0.5



```bash
module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles
module load slurm

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake 
module load gcc/11.1.0cc/10.3.0 openmpi/gcc10/4.1.0

mkdir -p /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.3.0
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.3.0
```



```bash
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/11.0-git openmpi/gcc/4.1.0
mkdir -p /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
```


## OpenBlas docularxu
```bash
git clone https://github.com/docularxu/OpenBLAS.git
cd OpenBLAS/
```

See Makefile.arm64 should we add -msve-vector-bits=512
```makefile
ifeq ($(CORE), TSV110SVE)
CCOMMON_OPT += -march=armv8.2-a+sve -mtune=tsv110
FCOMMON_OPT += -march=armv8.2-a+sve -mtune=tsv110
endif

ifeq ($(CORE), TSV110SVE)
CCOMMON_OPT += -march=armv8.2-a+sve -mtune=a64fx
FCOMMON_OPT += -march=armv8.2-a+sve -mtune=a64fx
endif

```

build and installl
```bash
wget https://github.com/xianyi/OpenBLAS/archive/v0.3.13.tar.gz
tar -xf v0.3.13.tar.gz
cd OpenBLAS-0.3.13

make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j TARGET=TSV110SVE
```

## OpenBlas 0.3.13

```bash
cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02
wget https://github.com/xianyi/OpenBLAS/archive/v0.3.13.tar.gz
tar -xf v0.3.13.tar.gz
cd OpenBLAS-0.3.13

make BINARY=64 CC=`which gcc` \
FC=`which gfortran` HOSTCC=`which gcc` ARCH=arm64 \
USE_THREAD=0 -j

make install PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13

#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13
export CMAKE_INCLUDE_PATH=${OPENBLAS_ROOT}/include:${CMAKE_INCLUDE_PATH}
export INCLUDE_PATH=${OPENBLAS_ROOT}/include:${INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${CMAKE_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${OPENBLAS_ROOT}/lib:${LIBRARY_PATH}
export PKG_CONFIG_PATH=${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}
```


# fftw-3.3.8

```bash
../configure                        \
    CC="fcc"                         \
    F77="frt"                        \
    CFLAGS='-Nclang -Ofast'          \
    FFLAGS='-Kfast'                  \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-float                   \
    --enable-fma                     \
    --enable-fortran                 \
    --enable-openmp                  \
    --enable-shared                  \
--enable-mpi
    --prefix="$INSTALL_PATH"         \
    --libdir="$INSTALL_PATH/lib64"   \
    ac_cv_prog_f77_v='-###'          \
    OPENMP_CFLAGS='-Kopenmp'




git clone https://github.com/fujitsu/fftw3.git fftw3-fujitsu
cd fftw3-fujitsu
touch ChangeLog
autoreconf --verbose --install --symlink --force

mkdir bld
cd bld
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu  \
    --enable-mpi --disable-openmp --disable-threads \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" ;\
make -j;\
make check;\
make -j install;\
rm -rf *;\
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu  \
    --enable-mpi --disable-openmp --disable-threads \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    --enable-single --program-suffix=f  \
    CFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" \
    FFLAGS="-O3 -fomit-frame-pointer -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fstrict-aliasing -fno-schedule-insns" 
make -j;\
make check;\
make -j install;\
rm -rf *;\
echo "Done"


# export vars for reuse
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
```

# hpcc

```bash

cd /lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/hpcc
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5
# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=gcc_openblas_fftw_openmpi -j 32
```

#gromacs

```bash
module use /lustre/projects/global/software/a64fx/modulefiles

module unload gcc/11.0-git
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5


cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02/
wget https://ftp.gromacs.org/gromacs/gromacs-2021.tar.gz
tar -xf gromacs-2021.tar.gz
cd gromacs-2021
mkdir bld
cd bld


# fftw
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/fftw3-fujitsu
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}
#OpenBLAS-0.3.12
export OPENBLAS_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13
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
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/gromacs-2021
make -j 32
make -j 32 install
```




















