set input_pdb_psf_file_name ../2-2-neutralize-implicit-ligand-system/GCMC_water_myoglobin_OPEN_MUT_ions 
set output_restraints_file_name prot_posres.ref

# load 
set system [mol new $input_pdb_psf_file_name.psf waitfor all]
mol addfile $input_pdb_psf_file_name.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0

set fullRest [atomselect top "protein and alpha"]
$fullRest set beta 1.0

set halfRest [atomselect top "protein and not alpha and noh"]
$halfRest set beta 0.5

$all writepdb restraints/$output_restraints_file_name


