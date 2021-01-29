```bash
module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles

module restore PrgEnv-cray
module load slurm cray-mvapich2_nogpu_svealpha/2.3.4 cray-hdf5-parallel/1.12.0.2
#cray-parallel-netcdf/1.12.1.0

wget https://github.com/hpc/ior/releases/download/3.3.0rc1/ior-3.3.0rc1.tar.gz
tar -xf ior-3.3.0rc1.tar.gz
cd ior-3.3.0rc1/
mkdir build_cray_mvapich
cd build_cray_mvapich


../configure --prefix=/lustre/home/xdmod/appker/Ookami/execs/ior/3.3.0rc1_cray_mvapich MPICC=cc CC=cc --with-hdf5 CPPFLAGS="-I/opt/cray/pe/hdf5-parallel/1.12.0.2/cray/10.0/include" LDFLAGS="-L/opt/cray/pe/hdf5-parallel/1.12.0.2/cray/10.0/lib"
make -j 32
make install

```