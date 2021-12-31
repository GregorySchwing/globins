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
	# Neccessary for patch
	mutate 93 HSD
	# Mytate back to native human from mutant crystal form
	mutate 45 LYS
}

segment HEME {
	pdb ./heme.pdb
}

patch PHEM MYO:93 HEME:154

coordpdb ./myoglobin.pdb MYO
coordpdb ./heme.pdb HEME

guesscoord

writepdb ./MYO_HEME.pdb
writepsf ./MYO_HEME.psf
