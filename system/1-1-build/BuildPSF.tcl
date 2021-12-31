package require psfgen
topology top_all36_prot.rtf
topology toppar_all36_prot_heme.str
pdbalias residue HIS HSE
pdbalias residue HEM HEME
pdbalias atom ILE CD1 CD
segment MYO {
	first ACE
	last CTER
	pdb ./myoglobin.pdb
}
segment HEME {
	pdb ./heme.pdb
}
#Fixes heme at distance for O2 to coordinate with HIS 63
patch PHEM MYO:93 HEME:154 
#patch PHEM MYO:64 HEME:154 
#segment SO4 {
#	pdb ./sulfate.pdb
#}
coordpdb ./myoglobin.pdb MYO
coordpdb ./heme.pdb HEME
#coordpdb ./sulfate.pdb SO4
guesscoord
#writepdb ./MYO_HEME_SO4.pdb
#writepsf ./MYO_HEME_SO4.psf
writepdb ./MYO_HEME3pdb
writepsf ./MYO_HEME3.psf
