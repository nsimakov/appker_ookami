
07-13-2021

# fftw

```bash
module load slurm fujitsu/compiler/1.0.20
cd /lustre/home/xdmod/appker/Ookami-Fujitsu/execs/bld
wget https://github.com/fujitsu/fftw3/archive/refs/tags/sve-v1.0.0.tar.gz
tar -xf sve-v1.0.0.tar.gz
cd fftw3-sve-v1.0.0

mkdir bld
cd bld
../configure --prefix=/lustre/home/xdmod/appker/Ookami-Fujitsu/execs/fftw-sve-v1.0.0 \
    --enable-mpi --disable-openmp --disable-threads CC=fcc MPICC=mpifcc F77=frt \
    CFLAGS='-Nclang -Ofast'          \
    FFLAGS='-Kfast'                  \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    --enable-fortran                 \
    --enable-shared                  \
    ac_cv_prog_f77_v='-###'       

make -j
make check
make -j install
rm -rf *


../configure --prefix=/lustre/home/xdmod/appker/Ookami-Fujitsu/execs/fftw-sve-v1.0.0 \
    --enable-mpi --disable-openmp --disable-threads CC=fcc MPICC=mpifcc F77=frt \
    CFLAGS='-Nclang -Ofast'          \
    FFLAGS='-Kfast'                  \
    --enable-sve                     \
    --enable-armv8-cntvct-el0        \
    --enable-fma                     \
    --enable-fortran                 \
    --enable-shared                  \
    --enable-float                   \
    ac_cv_prog_f77_v='-###'
make -j
make check
make -j install
rm -rf *

                  \

# export vars for reuse
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-Fujitsu/execs/fftw-sve-v1.0.0
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}


```
 
# hpcc

```bash

cd /lustre/home/xdmod/appker/Ookami-Fujitsu/execs/hpcc/1.5.0-git
module load slurm fujitsu/compiler/1.0.20
# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=fujitsu_compiler_intfft -j 32
cp hpcc hpcc_fujitsu_compiler_intfft
make arch=fujitsu_compiler_intfft -j 32 clean

make arch=fujitsu_compiler -j 32
cp hpcc hpcc_fujitsu_compiler
make arch=fujitsu_compiler -j 32 clean
```
Table \ref{tab:systems} - System specs.
Figure \ref{fig:hpcc_dgemm} martix multiplication.
Figure \ref{fig:hpcc_hpl_fft} HPL and FFT.
Ookami is compared to several XSEDE systems, see Table \ref{tab:systems} for some of their specifications.

\IEEEauthorblockN{ Nikolay A. Simakov }
\IEEEauthorblockA{\textit{Center for Computational Research, SUNY University at Buffalo} \\
Buffalo, NY, USA \\
