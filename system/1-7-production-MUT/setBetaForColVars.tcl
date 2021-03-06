set input_pdb_psf_file_name_box_0 ../1-6-min-and-equil-MUT/LIQ_BOX 
set input_bin_file_name_box_0 ../1-6-min-and-equil-MUT/LIQ_BOX_equilibrated.restart
set output_file_name_box_0 LIQ_BOX_EQ
set input_pdb_psf_file_name_box_1 ../1-3-equilbrate-solvent-box/RES_BOX
set output_file_name_box_1 RES_BOX
# load liquid box
set system [mol new $input_pdb_psf_file_name_box_0.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_0.pdb mol $system waitfor all
set pdbCRYST [molinfo $system get {a b c alpha beta gamma}]
mol addfile $input_bin_file_name_box_0.coor mol $system waitfor all
molinfo $system set {a b c alpha beta gamma} $pdbCRYST

set all [atomselect top all frame 1] 

$all set beta 0.0
$all set occupancy 0.0

set wat [atomselect top "water or resname DIOX"]
$wat set beta 0.0

set fullRest [atomselect top "protein and alpha"]
$fullRest set beta 1.0

set ions [atomselect top "ions"]
$ions set beta 2.0

set diox [atomselect top "resname DIOX"]
$diox set occupancy 1.0

set FE [atomselect top "name FE"]
$FE set occupancy 2.0

$all writepdb required_data/eq/$output_file_name_box_0.pdb
$all writepsf required_data/eq/$output_file_name_box_0.psf

resetpsf

# load resevoir box
set system [mol new $input_pdb_psf_file_name_box_1.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_1.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0
$all set occupancy 0.0

set wat [atomselect top "water or resname DIOX"]
$wat set beta 0.0

set ions [atomselect top "ions"]
$ions set beta 2.0

set diox [atomselect top "resname DIOX"]
$diox set occupancy 1.0

$all writepdb required_data/reservoir/$output_file_name_box_1.pdb
$all writepsf required_data/reservoir/$output_file_name_box_1.psf
