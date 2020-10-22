# Using Spack

```bash
cd $SPACK_ROOT
spack install -v --keep-stage --log-file nwchem.log nwchem >& nwchem.out

```

## Running Tests
```bash
mkdir -p /gpfs/ookami/projects/appker/tests/nwchem
cd /gpfs/ookami/projects/appker/tests/nwchem

wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.0-release/nwchem-7.0.0-release.revision-2c9a1c7c-nonsrconly.2020-02-26.tar.bz2
tar xvfj nwchem-7.0.0-release.revision-2c9a1c7c-nonsrconly.2020-02-26.tar.bz2

module load nwchem-7.0.0-gcc-8.3.1-ar6yb2c
module load openmpi

export NWCHEM_EXECUTABLE=`which nwchem`

nohup ./doqmtests.mpi 4 >& doqmtests.log &
```

