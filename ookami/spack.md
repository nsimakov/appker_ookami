```yaml
packages:
  mvapich2:
    externals:
    - spec: "mvapich2@2.3.4  arch=cray-centos8-aarch64"
      prefix: /opt/cray/pe/cray-mvapich2_nogpu_svealpha/2.3.4/infiniband/cray/10.0
      modules:
      - cpe-cray
      - cce-sve/10.0.1
      - craype/2.7.0
      - craype-arm-nsp1
      - craype-network-infiniband
      - cray-libsci/20.10.1.2
      - cray-mvapich2_nogpu_svealpha
    buildable: False
  intel-mpi:
    externals:
    - spec: "intel-mpi@2019.8.254  arch=linux-ubuntu20.04-x86_64"
      prefix: /opt/intel/compilers_and_libraries_2020.2.254/linux/mpi/intel64
      modules: [intel_parallel_studio_xe/2020_update2]
    buildable: False
```

cray-libsci/20.10.1.2


salloc -t 24:00 -p long -q long -N 1 -w fj008


lscpu 
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  1
Core(s) per socket:  12
Socket(s):           4
NUMA node(s):        4
Vendor ID:           0x46
Model:               0
Stepping:            0x1
BogoMIPS:            200.00
NUMA node0 CPU(s):   0-11
NUMA node1 CPU(s):   12-23
NUMA node2 CPU(s):   24-35
NUMA node3 CPU(s):   36-47
Flags:               fp asimd evtstrm sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm fcma dcpop sve

lets make 48 comparable to 64

module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha
module load slurm

srun -N 1 --ntasks-per-node=48



