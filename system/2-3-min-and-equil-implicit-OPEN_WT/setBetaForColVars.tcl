set input_pdb_psf_file_name_box_0 ../2-2-neutralize-implicit-ligand-system/GCMC_water_myoglobin_OPEN_WT_ions 
set output_file_name_box_0 LIQ_BOX

# load liquid box
set system [mol new $input_pdb_psf_file_name_box_0.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_0.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0
$all set occupancy 0.0

set wat [atomselect top "water"]
$wat set beta 0.0

set fullRest [atomselect top "protein and alpha"]
$fullRest set beta 1.0

set ions [atomselect top "ions"]
$ions set beta 2.0

$all writepdb $output_file_name_box_0.pdb
$all writepsf $output_file_name_box_0.psf

