#!/usr/bin/env bash
# Gaussian 09 SLURM submission template with formatted-checkpoint generation.
# I/O: one GJF argument -> LOG and FCHK
# Requires: SLURM, Gaussian 09, formchk
# Note: Set G09_ROOT; this template intentionally contains no account- or machine-specific absolute paths.

#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 24
#SBATCH -o %j.log
#SBATCH -e %j.err

: "${G09_ROOT:?Set G09_ROOT to the Gaussian 09 installation root}"
INPUT="${1:?Usage: sbatch sub.sh job.gjf}"
BASE="${INPUT%.*}"
export g09root="$G09_ROOT"
export PATH="$g09root:$PATH"
source "$g09root/bsd/g09.profile"
export GAUSS_SCRDIR="${GAUSS_SCRDIR:-${TMPDIR:-$HOME/tmp}}"
export GAUSS_EXEDIR="$g09root"

srun -c "${SLURM_CPUS_PER_TASK:-24}" g09 "$INPUT" > "${BASE}.log"
srun -c "${SLURM_CPUS_PER_TASK:-24}" formchk "${BASE}.chk" "${BASE}.fchk"