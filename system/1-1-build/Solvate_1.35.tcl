package require solvate
solvate ./1-1-build/myc_max/myc_max_1.35_a_out.psf ./1-1-build/myc_max/myc_max_1.35_a_out.pdb -t 2 -o ./1-1-build/myc_max/solvated/myc_max_1.35_a_out_solvated

solvate ./1-1-build/myc_max/myc_max_1.35_b_out.psf ./1-1-build/myc_max/myc_max_1.35_b_out.pdb -t 2 -o ./1-1-build/myc_max/solvated/myc_max_1.35_b_out_solvated
