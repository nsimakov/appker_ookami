#!/usr/bin/env bash
WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $WORKSPACE
rm slurm*.out
[[ -d "fftw" ]] && rm -rf fftw
[[ -d "gromacs" ]] && rm -rf gromacs
[[ -d "modulefiles" ]] && rm -rf modulefiles
[[ -d "src" ]] && rm -rf src
[[ -d "run" ]] && rm -rf run
