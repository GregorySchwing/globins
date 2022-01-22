#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH -A greg
#
# Number of cores
#SBATCH -c 4 -w, --nodelist=potoff41
#
# Runtime of this jobs is less then 12 hours.
#SBATCH --time=168:00:00
#
#SBATCH --mail-user=go2432@wayne.edu

#SBATCH -o output_%j.out

#SBATCH -e errors_%j.err


# Clear the environment from any previously loaded modules
cd /home6/greg/globins/system/2-3-min-and-equil-implicit-OPEN_MUT
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p6 step4_equilibration.inp > step4_equilibration.out

# End of submit file
