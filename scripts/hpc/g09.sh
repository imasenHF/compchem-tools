#!/usr/bin/env bash
# Gaussian 09 cluster-run template using a scheduler-specific launcher.
# I/O: one GJF argument -> Gaussian output
# Requires: Gaussian 09 and a launcher command such as yhrun
# Note: Set G09_ROOT for the target installation; adjust scheduler directives to the local cluster.

#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 24

: "${G09_ROOT:?Set G09_ROOT to the Gaussian 09 installation root}"
INPUT="${1:-test.gjf}"
export g09root="$G09_ROOT"
export PATH="$g09root:$PATH"
source "$g09root/bsd/g09.profile"
export GAUSS_SCRDIR="${GAUSS_SCRDIR:-$HOME/tmp}"
export GAUSS_EXEDIR="$g09root"

yhrun -c "${SLURM_CPUS_PER_TASK:-24}" g09 "$INPUT"