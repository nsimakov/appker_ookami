
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





