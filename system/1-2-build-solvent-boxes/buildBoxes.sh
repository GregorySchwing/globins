#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH -q primary
# Request one node
#SBATCH -N 1
# Total number of cores, in this example it will 1 node with 1 core each. 
#SBATCH -n 4
# Request memory
#SBATCH --mem=16G
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
cd /home6/greg/globins/system/1-2-build-solvent-boxes
python create_solvent_boxes.py
python fixSegID.py
python fixAtomTypes.py
python fixSegID_res.py
python fixAtomTypes_res.py
cp GCMC_water_O2_liq.pdb GCMC_water_O2_liq_seg_fix_atom_type_fix.pdb
cp GCMC_water_O2_res.pdb GCMC_water_O2_res_seg_fix_atom_type_fix.pdb
