set input_pdb_psf_file_name GCMC_water_O2_myoglobin_ions 
set output_restraints_file_name prot_posres.ref 
set output_colvars_file_name alphaC.ref

# load 
set system [mol new $input_pdb_psf_file_name.psf waitfor all]
mol addfile $input_pdb_psf_file_name.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0

set GOMCFIXED [atomselect top "protein or heme"]
$GOMCFIXED set beta 1.0

set GOMCFIXEDINBOX [atomselect top "ions"]
$GOMCFIXEDINBOX set beta 2.0

set fullRest [atomselect top "protein and alpha"]
$fullRest set occupancy 1.0

$all writepdb restraints/$output_colvars_file_name

set halfRest [atomselect top "protein and not alpha and noh"]
$halfRest set occupancy 0.5

$all writepdb restraints/$output_restraints_file_name


