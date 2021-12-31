#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH -A greg
#
# Number of cores
#SBATCH -c 6 -w, --nodelist=potoff33
#
# Runtime of this jobs is less then 12 hours.
#SBATCH --time=168:00:00
#
#SBATCH --mail-user=go2432@wayne.edu

#SBATCH -o output_%j.out

#SBATCH -e errors_%j.err


# Clear the environment from any previously loaded modules
cd /home6/greg/globins/system/1-4-min-and-equil-90A
./namd2 +p6 step4_equilibration.inp > step4_equilibration.out

# End of submit file
