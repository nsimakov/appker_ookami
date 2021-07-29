
```bash
salloc -t 24:00:00 -p long -q long -N 1
ssh ?
cd /lustre/home/xdmod/appker/Ookami/execs/src
wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.2-release/nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
tar -xf  nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz

module restore PrgEnv-cray
module load cray-fftw/3.3.8.8 cray-mvapich2_nogpu_svealpha/2.3.4 cray-libsci/20.10.1.2
module load slurm
cd nwchem-7.0.2/

export NWCHEM_TOP=/lustre/home/xdmod/appker/Ookami/execs/src/nwchem-7.0.2
export NWCHEM_TARGET=LINUX64

export USE_MPI=y
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
export USE_NOFSCHECK=TRUE
export FC=ftn
export CC=cc
export NWCHEM_MODULES=all
export USE_SCALAPACK=y 
export USE_64TO32=y
export LIBMPI=" "
export BLASOPT=" "
export LAPACK_LIB=$BLASOPT

cd $NWCHEM_TOP/src  
make nwchem_config 
make >& make.log


# Ookami-OSS
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0

module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 gcc/10.2.0 openmpi/gcc/4.0.5

wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.2-release/nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
tar -xf  nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
cd nwchem-7.0.2

export NWCHEM_TOP=/lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0/nwchem-7.0.2
export NWCHEM_TARGET=LINUX64
export ARMCI_NETWORK=MPI-PR

export USE_MPI=y
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
export USE_NOFSCHECK=TRUE
export FC=gfortran
export CC=gcc
export NWCHEM_MODULES=all
export USE_SCALAPACK=y 
export USE_64TO32=y
export LIBMPI="-lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
export MPI_LIB=/lustre/projects/global/software/a64fx/openmpi/gcc/4.0.5/lib
export MPI_INCLUDE="-I/lustre/projects/global/software/a64fx/openmpi/gcc/4.0.5/include"
export BLASOPT="-L/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12/lib -lopenblas"
export LAPACK_LIB="-L/lustre/home/xdmod/appker/Ookami-OSS/execs/soft/gcc-10.2.0/openmpi-gcc-4.0.5/OpenBLAS-0.3.12/lib -lopenblas"


cd $NWCHEM_TOP/src  
make nwchem_config 
make >& make.log


# Ookami-OSSFE
cd /lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02

module use /lustre/projects/global/software/a64fx/modulefiles
module load gcc/11.0-git openmpi/gcc/4.1.0

wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.2-release/nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
tar -xf  nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
cd nwchem-7.0.2

export NWCHEM_TOP=/lustre/home/xdmod/appker/Ookami-OSSFE/execs/bld/2021-02/nwchem-7.0.2
export NWCHEM_TARGET=LINUX64
export ARMCI_NETWORK=MPI-PR

export USE_MPI=y
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
export USE_NOFSCHECK=TRUE
export FC=gfortran
export CC=gcc
export NWCHEM_MODULES=all
export USE_SCALAPACK=y 
export USE_64TO32=y
export LIBMPI="-lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
export MPI_LIB=/lustre/projects/global/software/a64fx/openmpi/gcc/4.1.0/lib
export MPI_INCLUDE="-I/lustre/projects/global/software/a64fx/openmpi/gcc/4.1.0/include"
export BLASOPT="-L/lustre/home/xdmod/appker/Ookami-OSSFE/execs/soft/2021-02/OpenBLAS-0.3.13/lib -lopenblas"
export LAPACK_LIB=$BLASOPT


cd $NWCHEM_TOP/src  
make nwchem_config
make >& make.log


# Ookami-ARM
cd /lustre/home/xdmod/appker/Ookami-OSS/execs/bld/gcc-10.2.0

module use /lustre/projects/global/software/a64fx/modulefiles
module load arm/arm-linux-compiler/20.3 arm/arm-linux-compiler/armpl/20.3.0 openmpi/arm/4.1.0


wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.2-release/nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
tar -xf  nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.gz
cd nwchem-7.0.2

export NWCHEM_TOP=/lustre/home/xdmod/appker/Ookami-ARM/execs/nwchem-7.0.2
export NWCHEM_TARGET=LINUX64
export ARMCI_NETWORK=MPI-PR

export USE_MPI=y
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
export USE_NOFSCHECK=TRUE
export FC=armflang
export CC=armclang
export NWCHEM_MODULES=all
export USE_SCALAPACK=y 
export USE_64TO32=y
export LIBMPI="-lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
export MPI_LIB=/lustre/projects/global/software/a64fx/openmpi/arm/4.1.0/lib
export MPI_INCLUDE="-I/lustre/projects/global/software/a64fx/openmpi/arm/4.1.0/include"
export BLASOPT="-armpl=sve"
export LAPACK_LIB=$BLASOPT

cd $NWCHEM_TOP/src  
make nwchem_config
make >& make.log
```