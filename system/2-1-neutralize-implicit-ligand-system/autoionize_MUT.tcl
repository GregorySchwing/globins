set input_pdb_psf_file_name MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED
set output_pdb_psf_file_name GCMC_water_myoglobin_MUT_ions

autoionize -psf ../2-1-build-implicit-ligand-system/${input_pdb_psf_file_name}.psf -pdb ../2-1-build-implicit-ligand-system/${input_pdb_psf_file_name}.pdb -neutralize

set sel [atomselect top all]
$sel writepdb ${output_pdb_psf_file_name}.pdb
$sel writepsf ${output_pdb_psf_file_name}.psf
