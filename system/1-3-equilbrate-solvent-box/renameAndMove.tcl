set input_pdb_psf_file_name_box_0 ../1-2-build-solvent-boxes/GCMC_water_O2_liq_seg_fix_atom_type_fix 
set output_file_name_box_0 LIQ_BOX
set input_pdb_psf_file_name_box_1 ..1-2-build-solvent-boxes/GCMC_water_O2_res_seg_fix_atom_type_fix 
set output_file_name_box_1 RES_BOX
# load liquid box
set system [mol new $input_pdb_psf_file_name_box_0.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_0.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0
$all set occupancy 0.0

$all writepdb $output_file_name_box_0.pdb
$all writepsf $output_file_name_box_0.psf

resetpsf

# load resevoir box
set system [mol new $input_pdb_psf_file_name_box_1.psf waitfor all]
mol addfile $input_pdb_psf_file_name_box_1.pdb mol $system waitfor all

set all [atomselect top all]
$all set beta 0.0
$all set occupancy 0.0

$all writepdb $output_file_name_box_1.pdb
$all writepsf $output_file_name_box_1.psf
