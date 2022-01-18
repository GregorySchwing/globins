#1-1-build-protein
Two copies of 3rgk (human myoglobin mutant) are built.
The Mb is aligned so the Heme moeity is aligned with the Y axis and the Z axis.  
This results in the O2 binding site sitting directly above the Heme in the Y axis.
Both of these are mutated from the crystal structure mutant to native and the other is further mutated.
Both are patched at His 93 to create a HSD-Fe bond to hold open the O2 binding site.
Resulting in:
1) A native MB.
2) A His98Tyr mutant.

Commands: <br />
vmd < BuildPDB.tcl <br />
vmd < BuildHEME.tcl <br />
vmd < BuildWTPSF.tcl <br />
vmd < BuildMutantPSF.tcl <br />
vmd < alignWTXY.tcl <br />
vmd < alignMUTXY.tcl <br />

Result: <br />
MYO_HEME_WT_ALIGNED.pdb <br />
MYO_HEME_WT_ALIGNED.psf <br />
MYO_HEME_MUT_ALIGNED.pdb <br />
MYO_HEME_MUT_ALIGNED.psf <br />

#1-2-build-solvent-boxes
Two solvent boxes are created, a liquid and a resevoir.  The liquid is 98:2 TIP3:CharmmD O2 at 950 kg/m³.  The resevoir is 80:20 TIP3:CharmmD O2 at 950 kg/m³.  The size is based on the interal dimensions of the protein.  GOMC requires that the radius of gyration of a molecule not excede the (box length / 2) in any direction.  The maximal interal distance of Human MB is 26 Angstroms. 

Recent work on HB, Hage et al 2018, showed a large box is required to generate the sufficient hydrophobic effect for accurate simulation.  This study stated HB requires a 150 Angstronm box for accurate simulation.  

A study of MB, Boechi et al 2013, found the hydrophobic effect sufficiently simulated with 12 Angstroms of water padding, since MB is much smaller than HB.  To be safe we used 20 Angstroms of padding. 

Therefore, the box size is 2*(radius of gyration + 20 Angstroms), which results in a padding of 20 angstroms on each size, for a total of ~90 Angstroms. 

Finally, MosDef currently doesn't handle segment naming or custom atom type naming, so these are fixed with helper scripts. 

Commands: <br />
python create_solvent_boxes.py <br />
python fixSegID.py <br />
python fixSegID_res.py <br />
python fixAtomTypes.py <br />
python fixAtomTypes_res.py <br />
cp GCMC_water_O2_liq.pdb GCMC_water_O2_liq_seg_fix_atom_type_fix.pdb <br />
cp GCMC_water_O2_res.pdb GCMC_water_O2_res_seg_fix_atom_type_fix.pdb <br />
Result: <br />
GCMC_water_O2_FF.inp <br />
GCMC_water_O2_FF_NAMD.inp <br />
GCMC_water_O2_liq.pdb <br />
GCMC_water_O2_liq.psf <br />
GCMC_water_O2_liq_seg_fix.psf <br />
GCMC_water_O2_liq_seg_fix_atom_type_fix.pdb <br />
GCMC_water_O2_liq_seg_fix_atom_type_fix.psf <br />
GCMC_water_O2_res.pdb <br />
GCMC_water_O2_res.psf <br />
GCMC_water_O2_res_seg_fix.psf <br />
GCMC_water_O2_res_seg_fix_atom_type_fix.pdb <br />
GCMC_water_O2_res_seg_fix_atom_type_fix.psf <br />
in_GCMC_NVT.conf <br />

#1-3-equilbrate-solvent-box
The solvent box is currently padded with 2 Angstroms of vacuum in every axis and the initial packing of H20 and O2 is not equilbrated.  Since we will simulate in the Grand Canonical Ensemble, we only need to equilibrate the liquid box.  The solvent is equilibrated before adding the protein to ensure the O2 is uniformly distributed within the H20.

Some files are renamed and copied into the current directory and then NAMD is run to equilibrate the box in NPT.

To analyze the equilibration, Radial distribution functions of O-O, W-O, and W-W are calculated.  Also the volume and total energy is plotted per MD step.

Finally, a PDB file with the restart coordinates is created.

Commands: <br />
vmd < setBetaForColVars.tcl <br />
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p4 step4_equilibration.inp > step4_equilibration.out <br />

Result: <br />
LIQ_BOX.pdb <br />
LIQ_BOX.psf <br />
LIQ_BOX_NPT_EQ.dcd <br />
LIQ_BOX_NPT_EQ.pdb <br />
LIQ_BOX_NPT_EQ.restart.coor <br />
LIQ_BOX_NPT_EQ.restart.vel <br />
LIQ_BOX_NPT_EQ.restart.xsc <br />
LIQ_BOX_NPT_EQ.xst <br />
o-o.agr <br />
o-o.dat <br />
o-w.agr <br />
RES_BOX.pdb <br />
RES_BOX.psf <br />
step4_equilibration.out <br />
tot.dat <br />
vol.dat <br />
w-w.agr <br />

#1-4-solvate-protein
Since NAMD keeps the origin fixed when it changes the volume, the coordinates are no longer centered at 1/2 box length.  We shift the solvent box to ensure the geometric center is exactly [1/2 box length, 1/2 box length, 1/2 box length].  Then we shift the protein such that the geometric center of the protein is exactly [1/2 box length, 1/2 box length, 1/2 box length].  Finally, we merge the protein into the solvent, and remove all solvent molecules with 2.4 Angstroms of the protein.

Commands: <br />
vmd < shift_solvent_box.tcl <br />
bash ./shiftAndMergeMUT.sh <br />
bash ./shiftAndMergeWT.sh <br />

Results: <br />
LIQ_BOX_NPT_EQ_SHIFTED.pdb <br />
LIQ_BOX_NPT_EQ_SHIFTED.psf <br />
log.txt <br />
MYO_HEME_MUT_ALIGNED_SHIFTED.pdb <br />
MYO_HEME_MUT_ALIGNED_SHIFTED.psf <br />
MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED.pdb <br />
MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED.psf <br />
MYO_HEME_WT_ALIGNED_SHIFTED.pdb <br />
MYO_HEME_WT_ALIGNED_SHIFTED.psf <br />
MYO_HEME_WT_ALIGNED_SHIFTED_SOLVATED.pdb <br />
MYO_HEME_WT_ALIGNED_SHIFTED_SOLVATED.psf <br />

#1-5-neutralize
Waters are removed and replaced with ions to neutralize the system.

Commands: <br />
vmd < autoionize_MUT.tcl <br />
vmd < autoionize_WT.tcl <br />

Results: <br />
GCMC_water_O2_myoglobin_MUT_ions.pdb <br />
GCMC_water_O2_myoglobin_MUT_ions.psf <br />
GCMC_water_O2_myoglobin_WT_ions.pdb <br />
GCMC_water_O2_myoglobin_WT_ions.psf <br />
ionized.pdb <br />
ionized.psf <br />
log <br />

#1-6-min-and-equil-MUT
Positional restraints are created for the protein, and the center of mass and rotational quaternion of the C-alpha chain is constrained.
The liquid box with the mutant protein is equilibrated in NVT.  

Commands: <br />
vmd < createRestraintsFile.tcl <br />
vmd < setBetaForColVars.tcl <br />
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p6 step4_equilibration.inp > step4_equilibration.out <br />

Results:

#1-6-min-and-equil-WT
Positional restraints are created for the protein, and the center of mass and rotational quaternion of the C-alpha chain is constrained.
The liquid box with the wildtype protein is equilibrated in NVT.  Positional restraints are created for the protein.

Commands: <br />
vmd < createRestraintsFile.tcl <br />
vmd < setBetaForColVars.tcl <br />
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p6 step4_equilibration.inp > step4_equilibration.out <br />

Results:

