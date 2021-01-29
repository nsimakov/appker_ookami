# HPCG

```bash
cd /lustre/projects/Buffalo/appker/execs/src


mkdir -p /lustre/projects/Buffalo/appker/execs/hpcg
cd /lustre/projects/Buffalo/appker/execs/hpcg
wget http://www.hpcg-benchmark.org/downloads/hpcg-3.1.tar.gz
tar -xf hpcg-3.1.tar.gz
mv hpcg-3.1 3.1

cd /lustre/projects/Buffalo/appker/execs/hpcg/3.1/setup
cp Make.Linux_MPI Make.Linux_gcc_mpi
# edit Make.Linux_gcc_mpi largely CXXFLAGS
# CXXFLAGS     = $(HPCG_DEFS) -O3 -ffast-math -ftree-vectorize -ftree-vectorizer-verbose=0 -mtune=native -mcpu=native -march=armv8.2-a+sve -msve-vector-bits=512

mkdir -p  /lustre/projects/Buffalo/appker/execs/hpcg/3.1/3.1_gcc_openmpi
cd /lustre/projects/Buffalo/appker/execs/hpcg/3.1/3.1_gcc_openmpi
module load slurm gcc/10.2.0 openmpi/4.0.5
../configure Linux_gcc_mpi
make -j 32


mkdir -p  /lustre/projects/Buffalo/appker/execs/hpcg/3.1/3.1_gcc_mvapich2
cd /lustre/projects/Buffalo/appker/execs/hpcg/3.1/3.1_gcc_mvapich2
module load gcc/10.2.0 mvapich2/2.3.4
../configure Linux_gcc_mpi
make -j 32

```

48 cores:
ls
Final Summary::HPCG result is VALID with a GFLOP/s rating of=19.9973
Final Summary::HPCG result is VALID with a GFLOP/s rating of=22.4261

768
