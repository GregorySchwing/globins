set input_pdb_psf_file_name_box_0 MYO_ONE_DIOX
set rot_trans TRAJ_ROT_FILE
set iron_group FE
set oxy_group ON

# load liquid box
set system [mol new $input_pdb_psf_file_name_box_0.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_0.pdb mol $system waitfor all

set all [atomselect top all] 

$all set beta 0.0

set fullRest [atomselect top "protein and alpha"]
$fullRest set beta 1.0

$all writepdb $rot_trans.pdb

$all set beta 0.0

set FE [atomselect top "name FE"]
$FE set beta 1.0

$all writepdb $iron_group.pdb

$all set beta 0.0

set ON [atomselect top "name ON and resname DIOX"]
$ON set beta 1.0

$all writepdb $oxy_group.pdb
