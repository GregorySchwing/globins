set input_pdb_psf_file_name ../1-5-neutralize/GCMC_water_O2_myoglobin_OPEN_WT_ions 
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

$all writepdb required_data/eq/$output_restraints_file_name


