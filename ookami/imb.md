```bash
cd /lustre/projects/Buffalo/appker/execs/src
wget https://github.com/intel/mpi-benchmarks/archive/IMB-v2019.6.tar.gz
tar -xf IMB-v2019.6.tar.gz
cd /lustre/projects/Buffalo/appker/execs/src/mpi-benchmarks-IMB-v2019.6
# remove -pedantic from src_cpp/Makefile
module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha slurm
export CC=mpicc
export CXX=mpicxx

make clean
make all -j 32

mkdir -p /lustre/projects/Buffalo/appker/execs/imb/2019.6_cray_mvapich
mv IMB-* /lustre/projects/Buffalo/appker/execs/imb/2019.6_cray_mvapich


#gcc/10.2.0 openmpi/4.0.5
cd /lustre/projects/Buffalo/appker/execs/src/mpi-benchmarks-IMB-v2019.6
module load slurm gcc/10.2.0 openmpi/4.0.5
export CC=mpicc
export CXX=mpicxx

make clean
make all -j 32

mkdir -p /lustre/projects/Buffalo/appker/execs/imb/2019.6_gcc_openmpi
mv IMB-* /lustre/projects/Buffalo/appker/execs/imb/2019.6_gcc_openmpi

#gcc/10.2.0 mvapich2/2.3.4
cd /lustre/projects/Buffalo/appker/execs/src/mpi-benchmarks-IMB-v2019.6
module load slurm gcc/10.2.0 mvapich2/2.3.4
export CC=mpicc
export CXX=mpicxx

make clean
make all -j 32

mkdir -p /lustre/projects/Buffalo/appker/execs/imb/2019.6_gcc_mvapich2
mv IMB-* /lustre/projects/Buffalo/appker/execs/imb/2019.6_gcc_mvapich2
```