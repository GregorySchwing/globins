#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH -A greg
#
# Number of cores
#SBATCH -c 4 -w, --nodelist=potoff35
#
# Runtime of this jobs is less then 12 hours.
#SBATCH --time=168:00:00
#
#SBATCH --mail-user=go2432@wayne.edu

#SBATCH -o output_%j.out

#SBATCH -e errors_%j.err


# Clear the environment from any previously loaded modules
cd /home6/greg/globins/system/1-7-production-OPEN_WT
vmd < setBetaForColVars.tcl
python3 run_NAMD_GOMC.py -f user_input_NAMD_GOMC.json > log
# End of submit file
