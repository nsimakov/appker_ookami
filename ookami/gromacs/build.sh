#!/usr/bin/env bash
# Build Gromacs in the script directory
# run on compute node directly

WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

module load cmake gcc/10.2.0 mvapich2/2.3.4

mkdir -p $WORKSPACE/modulefiles
mkdir -p $WORKSPACE/src

module use $WORKSPACE/modulefiles

# Build fftw
cd $WORKSPACE/src
wget http://www.fftw.org/fftw-3.3.8.tar.gz
tar -xf fftw-3.3.8.tar.gz
cd fftw-3.3.8
./configure \
  --prefix=$WORKSPACE/fftw/3.3.8-serial-single
  CFLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512 -fPIC" \
  --enable-single --disable-openmp --disable-threads
make -j 32
make install

mkdir -p $WORKSPACE/modulefiles/fftw

cat > $WORKSPACE/modulefiles/fftw/3.3.8-serial-single << EOF
#%Module1.0##########################################################
##

set     pkg_ver         3.3.8-serial-single

set     pkg_home        $WORKSPACE/fftw/\${pkg_ver}

setenv          FFTW_VERSION 3.3.8.8
setenv          FFTW_ROOT \$pkg_home
setenv          FFTW_DIR \$pkg_home/lib
setenv          FFTW_INC \$pkg_home/include
prepend-path    PATH \$pkg_home/bin
prepend-path    MANPATH \$pkg_home/share/man
EOF

module load fftw/3.3.8-serial-single

# Build Gromacs
cd $WORKSPACE/src
wget http://ftp.gromacs.org/pub/gromacs/gromacs-2021-beta2.tar.gz
tar -xf gromacs-2021-beta2.tar.gz
cd gromacs-2021-beta2
mkdir build1
cd build1
cmake .. -DGMX_FFT_LIBRARY=fftw3 -DREGRESSIONTEST_DOWNLOAD=ON \
  -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
  -DGMX_MPI=ON  -DGMX_SIMD=ARM_SVE -DBUILD_SHARED_LIBS=ON \
  -DGMX_PYTHON_PACKAGE=OFF   -DGMX_INSTALL_NBLIB_API=OFF -DGMXAPI=ON \
  -DCMAKE_C_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_CXX_FLAGS="-O3 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512" \
  -DCMAKE_INSTALL_PREFIX=$WORKSPACE/gromacs/2021-beta2
make -j 32
make -j 32 install

mkdir -p $WORKSPACE/modulefiles/gromacs

cat > $WORKSPACE/modulefiles/gromacs/2021-beta2 << EOF
#%Module1.0##########################################################
##

set     pkg_ver         2021-beta2

set     pkg_home        $WORKSPACE/gromacs/\${pkg_ver}


setenv          GMXPREFIX \$pkg_home
setenv          GMXBIN \$pkg_home/bin
setenv          GMXLDLIB \$pkg_home/lib64
setenv          GMXMAN \$pkg_home/share/man
setenv          GMXDATA \$pkg_home/share/gromacs
setenv          GMXTOOLCHAINDIR \$pkg_home/hare/cmake
setenv          GROMACS_DIR \$pkg_home
prepend-path    PATH    \$pkg_home/bin
prepend-path    MANPATH \$pkg_home/share/man
prepend-path    LD_LIBRARY_PATH \$pkg_home/lib64
prepend-path    PKG_CONFIG_PATH \$pkg_home/lib64/pkgconfig
EOF

cd $WORKSPACE
module load gromacs/2021-beta2

