# Ookami-ARM

Based on ARM software stack

```bash

cd /lustre/home/xdmod/appker/Ookami-ARM/execs/hpcc
module use /lustre/projects/global/software/a64fx/modulefiles
module load cmake/3.18.4 arm/arm-linux-compiler/20.3 arm/arm-linux-compiler/armpl/20.3.0 openmpi/arm/4.1.0

# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=arm_compiler_armpl_openmpi -j 32
```


07-13-2021

```bash

cd /lustre/home/xdmod/appker/Ookami-ARM/execs/hpcc
module use /lustre/projects/global/software/a64fx/modulefiles
module load arm-modules/21
module load arm21/21.0 armpl-AArch64-SVE/21.0.0
module load openmpi/arm21/4.1.1

# edit hpl/Make.gcc_openblas_fftw_openmpi
make arch=arm_compiler_armpl_openmpi -j 32
```
