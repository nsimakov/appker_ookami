/lustre/projects/global/software/a64fx/mvapich2/2.3.4/bin

# HPCC

```bash
module load mvapich2/2.3.4
module load arm/arm-linux-compiler/20.3
module load arm/arm-linux-compiler/armpl

make arch=arm_compiler_armpl_intfft_mvapich clean
make arch=arm_compiler_armpl_intfft_mvapich -j
mv hpcc hpcc_arm_compiler_armpl_intfft_mvapich

make arch=arm_compiler_armpl_mvapich clean
make arch=arm_compiler_armpl_mvapich -j
mv hpcc hpcc_arm_compiler_armpl_mvapich

make arch=arm_compiler_armpl_intfft_mvapich clean
make arch=arm_compiler_armpl_intfft_mvapich -j
mv hpcc hpcc_arm_compiler_armpl_intfft_mvapich_b2

make arch=arm_compiler_armpl_mvapich clean
make arch=arm_compiler_armpl_mvapich -j
mv hpcc hpcc_arm_compiler_armpl_mvapich_b2

/lustre/projects/Buffalo/appker/execs/hpcc/hpcc-arm-compiler


module load openmpi/4.0.5
module load arm/arm-linux-compiler/20.3
module load arm/arm-linux-compiler/armpl

make arch=arm_compiler_armpl_openmpi clean
make arch=arm_compiler_armpl_openmpi -j
mv hpcc hpcc_arm_compiler_armpl_openmpi

make arch=arm_compiler_armpl_intfft_openmpi clean
make arch=arm_compiler_armpl_intfft_openmpi -j
mv hpcc hpcc_arm_compiler_armpl_intfft_openmpi

grep -R HPL_Tflops *
grep -R StarDGEMM_Gflops *
grep -R MPIFFT_Gflops *

module load mvapich2/2.3.4
module load gcc
module load arm/arm-linux-compiler/armpl

make arch=gcc_armpl_mvapich clean
make arch=gcc_armpl_mvapich -j
mv hpcc hpcc_gcc_armpl_mvapich


module restore PrgEnv-cray
module load slurm cray-mvapich2_nogpu_svealpha/2.3.4 cray-libsci/20.10.1.2 cray-fftw/3.3.8.8

make arch=cray_libsci_fftwcray_mvapich clean
make arch=cray_libsci_fftwcray_mvapich -j 32
mv hpcc hpcc_cray_libsci_fftwcray_mvapich

make arch=cray_libsci_intfft_mvapich clean
make arch=cray_libsci_intfft_mvapich -j 32
mv hpcc hpcc_cray_libsci_intfft_mvapich

```
-O3 -mtune=native -mcpu=native -march=armv8-a+sve -msve-vector-bits=512
-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512
# GROMACS

```bash
module load cmake gcc mvapich2/2.3.4
cmake ../.. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=on \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs-2021-beta1-b1
make -j 32
make install

cmake ../.. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=on \
  -DGMX_SIMD=None -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs-2021-beta1-b2
make -j 32
make install

#build7
module load cmake gcc/10.2.0 mvapich2/2.3.4
cd build7-serial

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
  -DGMX_MPI=OFF   -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=ON \
  -DGMX_PYTHON_PACKAGE=ON   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=ON \
  -DPYTHONMODULE_SCIPY=/lustre/projects/Buffalo/appker/execs/python/3.9.0/lib/python3.9/site-packages/scipy \
  -DPYTHONMODULE_PYMBAR=/lustre/projects/Buffalo/appker/execs/python/3.9.0/lib/python3.9/site-packages/pymbar \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/global/software/a64fx/gromacs/2021-beta1
make -j 32
make -j 32 install

cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
  -DGMX_MPI=ON  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=ON \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=ON \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/src/gromacs/2021-beta2-gcc-openmpi
make -j 32
make -j 32 install

cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_PHYSICAL_VALIDATION=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=OFF \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=ON \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/global/software/a64fx/gromacs/2021-beta1
make -j 32
make install

cd build7
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=on \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/global/software/a64fx/gromacs/2021-beta1
make -j 32
make install

```

```bash
module load cmake gcc/10.2.0 mvapich2/2.3.4
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=on \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs-2021-beta1-b3
make -j 32
make install



cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=armclang -DCMAKE_CXX_COMPILER=armclang++ -DGMX_MPI=on \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-march=armv8.2-a+sve -mcpu=a64fx -O3" \
  -DCMAKE_CXX_FLAGS="-march=armv8.2-a+sve -mcpu=a64fx -O3" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs-2021-beta1-b4
make -j 32
make install


module load cmake gcc/dev mvapich2/2.3.4
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DGMX_MPI=on \
  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_C_FLAGS="-O3 -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=/lustre/projects/Buffalo/appker/execs/gromacs-2021-beta1-b5
make -j 32
make install
```

## Stampede2

``` bash
module load intel/19.1.1 impi/19.0.7

cmake .. -DGMX_FFT_LIBRARY=mkl -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=mpiicc -DCMAKE_CXX_COMPILER=mpiicpc -DGMX_MPI=on \
  -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/execs/gromacs-2021-beta1-b1

cmake .. -DGMX_FFT_LIBRARY=mkl -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DGMX_MPI=on \
  -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/execs/gromacs-2021-beta1-b2


idev -m 120 -N 1 -n 48 -p skx-dev

module load gcc/9.1.0 impi/19.0.7 mkl/19.1.1
cmake .. -DGMX_FFT_LIBRARY=mkl -DREGRESSIONTEST_DOWNLOAD=ON   -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_MPI=on   -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF   -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/execs/gromacs-2021-beta1-b2
``` 

## Local

```bash
module load intel_parallel_studio_xe/2020_update2

mkdir build
cd build
cmake .. -DGMX_FFT_LIBRARY=mkl -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=mpiicc -DCMAKE_CXX_COMPILER=mpiicpc -DGMX_MPI=on \
  -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off \
  -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF \
  -DCMAKE_INSTALL_PREFIX=/usr/local/gromacs-2020-4



idev -m 120 -N 1 -n 48 -p skx-dev

module load gcc/9.1.0 impi/19.0.7 mkl/19.1.1
cmake .. -DGMX_FFT_LIBRARY=mkl -DREGRESSIONTEST_DOWNLOAD=ON   -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_MPI=on   -DGMX_SIMD=AVX_512 -DBUILD_SHARED_LIBS=off -DGMX_PYTHON_PACKAGE=off   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=OFF   -DCMAKE_INSTALL_PREFIX=/work/01482/xdtas/appker/stampede2-skx/execs/gromacs-2021-beta1-b2
``` 


# HPCG

```bash
module load gcc/10.2.0 mvapich2/2.3.4
cd build7-serial
```
