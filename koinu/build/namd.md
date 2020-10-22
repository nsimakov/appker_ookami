```bash
# Download source from https://www.ks.uiuc.edu/Development/Download/download.cgi
# and copy it to koinu
scp NAMD_2.14_Source.tar.gz koinu-compute:/gpfs/ookami/projects/appker/build
```

```bash
cd /gpfs/ookami/projects/appker/build
tar xzf NAMD_2.14_Source.tar.gz
cd NAMD_2.14_Source
tar xf charm-6.10.2.tar

module load openmpi fftw3

cd charm-6.10.2

CHARMARCH=multicore-linux-aarch64gcc

cp -R src/arch/multicore-linux64 src/arch/$CHARMARCH

./build charm++ multicore-linux-aarch64gcc --with-production

fail
```
```
jump_i386_sysv_elf_gas.S: Assembler messages:
jump_i386_sysv_elf_gas.S:33: Error: unknown mnemonic `leal' -- `leal -0x18(%esp),%esp'
jump_i386_sysv_elf_gas.S:36: Error: unknown mnemonic `stmxcsr' -- `stmxcsr (%esp)'
jump_i386_sysv_elf_gas.S:37: Error: unknown mnemonic `fnstcw' -- `fnstcw 0x4(%esp)'
```


netlrts-linux-arm8

multicore-arm8

```bash
cd ..
rm -rf charm-6.10.2
tar xf charm-6.10.2.tar
cd charm-6.10.2

./build charm++ multicore-arm8 --with-production

cd multicore-arm8/tests/charm++/megatest
make pgm
./pgm +p4
cd ../../../../..

```

```bash
cd ..
rm -rf charm-6.10.2
tar xf charm-6.10.2.tar
cd charm-6.10.2

multicore-arm8

CHARMARCH=multicore-linux-aarch64gcc

cp -R src/arch/multicore-linux64 src/arch/$CHARMARCH
# Didn't do it yet
FILE=src/arch/$CHARMARCH/conv-mach.sh
sed -i "s|^CMK_CPP_CHARM=.*|CMK_CPP_CHARM='cpp -P'|g" $FILE
sed -i "s|^CMK_NATIVE_CC=.*|CMK_NATIVE_CC='$CC '|g" $FILE
sed -i "s|^CMK_NATIVE_CXX=.*|CMK_NATIVE_CXX='$CXX '|g" $FILE
sed -i "s|^CMK_NATIVE_LD=.*|CMK_NATIVE_LD='$CC '|g" $FILE
sed -i "s|^CMK_NATIVE_LDXX=.*|CMK_NATIVE_LDXX='$CXX '|g" $FILE
sed -i "s|^CMK_QT=.*|CMK_QT='generic64-light '|g" $FILE
sed -i "s|^CMK_CF77=.*|CMK_CF77='$FC '|g" $FILE
sed -i "s|^CMK_CF90=.*|CMK_CF90='$FC '|g" $FILE
sed -i "s|^CMK_CF90_FIXED=.*|CMK_CF90_FIXED='$FC -Mfixed '|g" $FILE

# currently 0
sed -i "/#endif/i #define CMK_THREADS_USE_CONTEXT                            1" ${FILE%%.sh}.h
# already set to that
sed -i "/#endif/i #define CMK_THREADS_USE_PTHREADS                           0" ${FILE%%.sh}.h
# already set to that
sed -i "/#endif/i #define CMK_64BIT                                          1" ${FILE%%.sh}.h

sed -i "s|cc-gcc|cc-armclang|g" $FILE

cp src/arch/common/cc-gcc.sh src/arch/common/cc-armclang.sh
sed -i "s|gcc|armclang|g" src/arch/common/cc-armclang.sh
sed -i "s|g++|armclang++|g" src/arch/common/cc-armclang.sh

./build charm++ multicore-linux-aarch64gcc --with-production

cd multicore-linux-aarch64gcc/tests/charm++/megatest
make pgm
./pgm +p4
cd ../../../../..

```


<versions>: 
gemini_gni-crayxe       multicore-arm8          netlrts-linux-x86_64
gni-crayxc              multicore-darwin-x86_64 netlrts-win-x86_64
gni-crayxe              multicore-linux         ofi-linux-x86_64
mpi-bluegeneq           multicore-linux32       pami-bluegeneq
mpi-crayxc              multicore-linux64       pami-linux-ppc64le
mpi-crayxe              multicore-linux-ppc     pamilrts-bluegeneq
mpi-darwin-x86_64       multicore-linux-ppc64le pamilrts-linux-ppc64le
mpi-linux               multicore-linux-x86_64  shmem-crayxe
mpi-linux-amd64         multicore-win64         sim-linux
mpi-linux-mips64        multicore-win-x86_64    ucx-linux-arm8
mpi-linux-ppc           netlrts-darwin-x86_64   ucx-linux-x86_64
mpi-linux-ppc64le       netlrts-linux           uth-linux
mpi-linux-x86_64        netlrts-linux-arm7      uth-linux-x86_64
mpi-win64               netlrts-linux-arm8      verbs-linux-ppc64le
mpi-win-x86_64          netlrts-linux-ppc       verbs-linux-x86_64
multicore-arm7          netlrts-linux-ppc64le   win


