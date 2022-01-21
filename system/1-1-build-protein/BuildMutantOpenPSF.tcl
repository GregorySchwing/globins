package require psfgen
topology top_all36_prot.rtf
topology toppar_all36_prot_heme.str
# Chen et al,
pdbalias residue HIS HSE
pdbalias residue HEM HEME
pdbalias atom ILE CD1 CD

segment MYO {
	first ACE
	last CTER
	pdb ./myoglobin.pdb
	# Open configuration
	mutate 63 HSP
	# Neccessary for patch
	mutate 93 HSD
	# Mytate back to native human from mutant crystal form
	mutate 45 LYS
	# His98Tyr Mutation
	mutate 97 TYR
}

segment HEME {
	pdb ./heme.pdb
}

patch PHEM MYO:93 HEME:154

coordpdb ./myoglobin.pdb MYO
coordpdb ./heme.pdb HEME

guesscoord

writepdb ./MYO_HEME_OPEN_MUT.pdb
writepsf ./MYO_HEME_OPEN_MUT.psf
