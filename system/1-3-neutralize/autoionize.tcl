set input_pdb_psf_file_name MYO_HEME_SHIFTED_SOLVATED
set output_pdb_psf_file_name MYO_HEME_SHIFTED_SOLVATED_NEUTRALIZED

autoionize -psf ../1-2-solvate/${input_pdb_psf_file_name}.psf -pdb ../1-2-solvate/${input_pdb_psf_file_name}.pdb -neutralize

$sel writepdb ${output_pdb_psf_file_name}.pdb
$sel writepsf ${output_pdb_psf_file_name}.psf
