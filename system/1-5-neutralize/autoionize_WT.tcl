set input_pdb_psf_file_name MYO_HEME_WT_ALIGNED_SHIFTED_SOLVATED
set output_pdb_psf_file_name GCMC_water_O2_myoglobin_WT_ions

autoionize -psf ../1-4-solvate-protein/${input_pdb_psf_file_name}.psf -pdb ../1-4-solvate-protein/${input_pdb_psf_file_name}.pdb -neutralize

set sel [atomselect top all]
$sel writepdb ${output_pdb_psf_file_name}.pdb
$sel writepsf ${output_pdb_psf_file_name}.psf
