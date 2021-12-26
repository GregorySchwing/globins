#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH --qos=primary
#
# Number of cores
#SBATCH -c 8 -w, 
#SBATCH --nodelist=wsu208
#SBATCH --mem=400G
#
# Runtime of this jobs is less then 12 hours.
#SBATCH --time=168:00:00
#
#SBATCH --mail-user=go2432@wayne.edu

#SBATCH -o output_%j.out

#SBATCH -e errors_%j.err

# Clear the environment from any previously loaded modules
source ~/conda/etc/profile.d/conda.sh
conda activate mosdef_signac 
echo $CONDA_ENV
cd /wsu/home/go/go24/go2432/globins/system/1-2-solvate
python3 shift_PDB_and_create_solvent_boxes.py 
