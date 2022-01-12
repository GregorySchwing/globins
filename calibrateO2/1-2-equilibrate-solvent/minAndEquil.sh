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
cd /home6/greg/globins/calibrateO2/1-2-equilibrate-solvent
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p4 step4_equilibration.inp > step4_equilibration.out

# End of submit file
