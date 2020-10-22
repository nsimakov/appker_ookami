# Software Installation Notes

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

## FFT
### FFTW3

```bash
cd /gpfs/ookami/projects/appker/execs/build
wget http://www.fftw.org/fftw-3.3.8.tar.gz
tar xvzf fftw-3.3.8.tar.gz

module load openmpi

cd /gpfs/ookami/projects/appker/execs/build
mkdir -p fftw-3.3.8_bld/openmpi_smp_omp_shared
cd fftw-3.3.8_bld/openmpi_smp_omp_shared
../../fftw-3.3.8/configure --prefix=/gpfs/ookami/software/fftw-3.3.8 \
    --enable-mpi --enable-threads --enable-openmp --enable-shared
make -j 16
make install
# run tests
cd tests
for test in check-local smallcheck bigcheck paranoid-check exhaustive-check
do 
    make $test >& $test.out
done

cd /gpfs/ookami/projects/appker/execs/build
mkdir -p fftw-3.3.8_bld/openmpi_smp_omp_shared_single
cd fftw-3.3.8_bld/openmpi_smp_omp_shared_single
../../fftw-3.3.8/configure --prefix=/gpfs/ookami/software/fftw-3.3.8 \
    --enable-mpi --enable-threads --enable-openmp --enable-shared --enable-single
make -j 16
make install
# run tests
cd tests
for test in check-local smallcheck bigcheck paranoid-check exhaustive-check
do 
    make $test >& $test.out
done

```

Got following message from configuration
```
***************************************************************
WARNING: No cycle counter found.  FFTW will use ESTIMATE mode  
         for all plans.  See the manual for more information.
***************************************************************
```

## HDF5

```bash
#get to application kernel executable directory
cd $AKRR_APPKER_DIR/execs

#create lib directory if needed and temporary directory for compilation
mkdir -p lib
mkdir -p lib\tmp
cd lib\tmp

# obtain parallel-netcdf source code
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.6/src/hdf5-1.10.6.tar.gz
tar xvzf hdf5-1.10.6.tar.gz
cd hdf5-1.10.6

#configure hdf5
./configure --prefix=$AKRR_APPKER_DIR/execs/lib/hdf5-1.10.6 --enable-parallel CC=`which mpiicc` CXX=`which mpiicpc`
make -j 4

#install
make install
cd $AKRR_APPKER_DIR/execs

#optionally clean-up
rm -rf $AKRR_APPKER_DIR/execs/lib/tmp/hdf5-1.10.6
```


# Spack

```bash
cd /gpfs/ookami/projects/appker
git clone https://github.com/spack/spack.git

cat "export SPACK_ROOT=/gpfs/ookami/home/nsimakov/local/spack" >> .bashrc
cat "export PATH=$SPACK_ROOT/bin:$PATH" >> .bashrc
cat "module use /gpfs/ookami/projects/appker/spack/share/spack/modules/linux-rhel8-thunderx2"

source ~/.bashrc

```

Add existent OpenMPI to `~/.spack/packages.yaml`

```yaml
packages:
    openmpi:
        paths:
            openmpi@4.0.4: /gpfs/ookami/software/openmpi-4.0.4
        buildable: False
```

Modify stage place in `$SPACK_ROOT/etc/spack/config.yaml`

```yaml
config:
    build_stage:
        - $spack/var/spack/stage
```
