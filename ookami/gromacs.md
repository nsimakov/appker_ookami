
```bash
module load cmake gcc/10.2.0 openmpi/4.0.5
cd /lustre/projects/Buffalo/appker/execs/src

wget http://ftp.gromacs.org/pub/gromacs/gromacs-2021-beta2.tar.gz
tar -xf gromacs-2021-beta2.tar.gz
cd gromacs-2021-beta2
mkdir bld_gcc_openmpi
cd bld_gcc_openmpi

module load cmake gcc/10.2.0 openmpi/4.0.5 fftw/3.3.8-serial-single

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
  -DGMX_MPI=ON  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=ON \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=ON \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs/2021-beta2-gcc_openmpi
make -j 32
make -j 32 install

```




# Stampede2
```bash
cd /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs
wget http://www.fftw.org/fftw-3.3.9.tar.gz
tar -xf fftw-3.3.9.tar.gz
cd fftw-3.3.9
mkdir bld_nosimd
cd bld_nosimd
../configure --prefix=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_nosimd \
    --enable-float \
    --disable-sse --disable-sse2 --disable-avx --disable-avx2 --disable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --disable-generic-simd256 \
    --disable-openmp --disable-threads
make -j 8 install
cd ..

mkdir bld_sse2
cd bld_sse2
../configure --prefix=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_sse2 \
    --enable-float \
    --disable-sse --enable-sse2 --disable-avx --disable-avx2 --disable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --disable-generic-simd256 \
    --disable-openmp --disable-threads
make -j 8 install
cd ..

mkdir bld_avx512
cd bld_avx512
../configure --prefix=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_avx512 \
    --enable-float \
    --disable-sse --disable-sse2 --disable-avx --disable-avx2 --enable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --disable-generic-simd256 \
    --disable-openmp --disable-threads
make -j 8 install

cd ../..
wget https://ftp.gromacs.org/gromacs/gromacs-2021.tar.gz
tar -xf gromacs-2021.tar.gz
cd gromacs-2021
mkdir bld_nosimd
cd bld_nosimd
# fftw
export FFTW_ROOT=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_nosimd
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module load intel/19.1.1 gcc/9.1.0 impi/19.0.7

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=None -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_nosimd
make -j 8
make -j 8 install

cd ..
mkdir bld_sse2
cd bld_sse2

export FFTW_ROOT=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_sse2
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module load intel/19.1.1 gcc/9.1.0 impi/19.0.7

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=SSE2 -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_sse2
make -j 8
make -j 8 install

cd ..
mkdir bld_avx512
cd bld_avx512

export FFTW_ROOT=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/fftw_avx512
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module load intel/19.1.1 gcc/9.1.0 impi/19.0.7

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx \
  -DGMX_MPI=ON -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_avx512
make -j 8
make -j 8 install


mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_avx512/bin/gmx_mpi mdrun -v -nsteps 50000 >& avx512_96.out
mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_sse2/bin/gmx_mpi mdrun -v -nsteps 50000 >& sse2_96.out
mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_nosimd/bin/gmx_mpi mdrun -v -nsteps 50000 >& nosimd_96.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_avx512/bin/gmx_mpi mdrun -v -nsteps 50000 >& avx512_48.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_sse2/bin/gmx_mpi mdrun -v -nsteps 50000 >& sse2_48.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_nosimd/bin/gmx_mpi mdrun -v -nsteps 50000 >& nosimd_48.out

for i in {1..10}
do
mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_avx512/bin/gmx_mpi mdrun -v -nsteps 50000 >& avx512_96_$i.out
mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_sse2/bin/gmx_mpi mdrun -v -nsteps 50000 >& sse2_96_$i.out
mpirun -n 96 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_nosimd/bin/gmx_mpi mdrun -v -nsteps 50000 >& nosimd_96_$i.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_avx512/bin/gmx_mpi mdrun -v -nsteps 50000 >& avx512_48_$i.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_sse2/bin/gmx_mpi mdrun -v -nsteps 50000 >& sse2_48_$i.out
mpirun -n 48 /work/01482/xdtas/appker/stampede2-skx/benchmarks/gromacs/gromacs_nosimd/bin/gmx_mpi mdrun -v -nsteps 50000 >& nosimd_48_$i.out
done


```


# ookami
```bash
cd /lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs
wget http://www.fftw.org/fftw-3.3.9.tar.gz
tar -xf fftw-3.3.9.tar.gz
cd fftw-3.3.9
mkdir bld_nosimd
cd bld_nosimd
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_nosimd \
    --enable-float \
    --disable-sse --disable-sse2 --disable-avx --disable-avx2 --disable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --disable-generic-simd256 \
    --disable-openmp --disable-threads
make -j 8 install
cd ..

mkdir bld_neon
cd bld_neon
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_neon \
    --enable-float \
    --disable-sse --disable-sse2 --disable-avx --disable-avx2 --disable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --disable-generic-simd256 \
    --disable-openmp --disable-threads \
    --enable-neon \
    --enable-armv8-cntvct-el0
make -j 8 install
cd ..

mkdir bld_gen256
cd bld_gen256
../configure --prefix=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_gen256 \
    --enable-float \
    --disable-sse --disable-sse2 --disable-avx --disable-avx2 --disable-avx512 --disable-avx-128-fma \
    --disable-kcvi --disable-generic-simd128 --enable-generic-simd256 \
    --disable-openmp --disable-threads \
    --disable-neon \
    --enable-armv8-cntvct-el0
make -j 8 install
cd ..



cd ..
wget https://ftp.gromacs.org/gromacs/gromacs-2021.tar.gz
tar -xf gromacs-2021.tar.gz
cd gromacs-2021
mkdir bld_nosimd
cd bld_nosimd
# fftw
export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_nosimd
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DGMX_MPI=ON -DGMX_SIMD=None -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/gromacs_nosimd
make -j 8
make -j 8 install

cd ..

mkdir bld_neon
cd bld_neon

export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_neon
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DGMX_MPI=ON -DGMX_SIMD=ARM_NEON_ASIMD -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/gromacs_neon
make -j 8
make -j 8 install



cd ..
mkdir bld_fftw_gen256
cd bld_fftw_gen256

export FFTW_ROOT=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/fftw_gen256
export FFTW_DIR=${FFTW_ROOT}/lib
export FFTW_INC=${FFTW_ROOT}/include
export LD_LIBRARY_PATH=${FFTW_DIR}:${LD_LIBRARY_PATH}

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=OFF \
  -DGMX_MPI=ON -DGMX_SIMD=ARM_NEON_ASIMD -DBUILD_SHARED_LIBS=OFF \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/gromacs_fftw_gen256
make -j 8
make -j 8 install




for i in {1..10}
do
mpirun -n 48 /lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/gromacs_neon/bin/gmx_mpi mdrun -v -nsteps 50000 >& neon_$i.out
mpirun -n 48 /lustre/home/xdmod/appker/Ookami-OSSFE/test/gromacs/gromacs_nosimd/bin/gmx_mpi mdrun -v -nsteps 50000 >& nosimd_$i.out
done



```




