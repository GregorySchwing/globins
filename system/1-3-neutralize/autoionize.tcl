#set input_pdb_psf_file_name MYO_HEME_MUT_SHIFTED_SOLVATED
set input_pdb_psf_file_name MYO_HEME_WT_SHIFTED_SOLVATED
set output_pdb_psf_file_name GCMC_water_O2_myoglobin_MUT_ions

autoionize -psf ../1-2-solvate/${input_pdb_psf_file_name}.psf -pdb ../1-2-solvate/${input_pdb_psf_file_name}.pdb -neutralize

set sel [atomselect top all]
$sel writepdb ${output_pdb_psf_file_name}.pdb
$sel writepsf ${output_pdb_psf_file_name}.psf
