set input_pdb_psf_file_name GCMC_water_O2_myoglobin_ions 
set output_file_name MYO 

# load 
set system [mol new $input_pdb_psf_file_name.psf waitfor all]
mol addfile $input_pdb_psf_file_name.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0

set colVarRef [atomselect top "protein and alpha"]
$colVarRef set beta 2.0

set fixInGOMC [atomselect top "protein and not alpha and noh"]
$fixInGOMC set beta 1.0

set wat [atomselect top "water or resname DIOX"]
$wat set beta 0.0

set ions [atomselect top "ions"]
$ions set beta 2.0

$all writepdb $output_file_name.pdb
$all writepsf $output_file_name.psf
