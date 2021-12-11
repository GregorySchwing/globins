package require psfgen
topology top_all36_prot.rtf
topology toppar_all36_prot_heme.str
pdbalias residue HIS HSE
pdbalias residue HEM HEME
pdbalias atom ILE CD1 CD
segment HEME {
	pdb ./heme.pdb
}
coordpdb ./heme.pdb HEME
guesscoord

writepdb ./HEME.pdb
writepsf ./HEME.psf
