# Building

```bash
# launch batch job
cd /lustre/projects/global/testsuite/gromacs
sbatch build.job
# or run on compute node
cd /lustre/projects/global/testsuite/gromacs
./build.sh
```

# Running

There are 3 systems obtained from https://www.mpibpc.mpg.de/15101328/benchRIB.zip

| Name | Description                                        |
|------|----------------------------------------------------|
| mem  | 82k atoms, protein in membrane surrounded by water |
| pep  | 12 M atoms, peptides in water                      |
| rib  | 2 M atoms, ribosome in water                       |

## 1,2,4 and 8 nodes

To submit jobs use run_jobs_stress_1_to_8.sh script:

```bash
cd /lustre/projects/global/testsuite/gromacs
N_RUNS=<number of runs> ./run_jobs_stress_1_to_8.sh [Time to run] [system]
```

For example 
```bash
cd /lustre/projects/global/testsuite/gromacs
# default 20 runs each on 1,2,4 and 8 nodes for 24 hours
./run_jobs_stress_1_to_8.sh
# 10 runs on 1,2,4 and 8 nodes rib system for 1 hour
N_RUNS=10 ./run_jobs_stress_1_to_8.sh 1:00:00
```

## 24,32,64 and 80 nodes

To submit jobs use:

```bash
cd /lustre/projects/global/testsuite/gromacs
N_RUNS=<number of runs> ./run_jobs_stress_24_to_80.sh [Time to run] [system]
```

For example 
```bash
cd /lustre/projects/global/testsuite/gromacs
# default 20 runs each on 24,32,64 and 80 nodes for 8 hours
./run_jobs_stress_24_to_80.sh
# 10 runs on 24,32,64 and 80 nodes rib system for 1 hour
N_RUNS=10 ./run_jobs_stress_24_to_80.sh 1:00:00
```

# Cleaning
Cleaning workspace
```bash
cd /lustre/projects/global/testsuite/gromacs
./clean.sh
```
