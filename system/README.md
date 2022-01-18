#1-1-build-protein
Two copies of 3rgk (human myoglobin mutant) are built.
The Mb is aligned so the Heme moeity is aligned with the Y axis and the Z axis.  
This results in the O2 binding site sitting directly above the Heme in the Y axis.
Both of these are mutated from the crystal structure mutant to native and the other is further mutated.
Both are patched at His 93 to create a HSD-Fe bond to hold open the O2 binding site.
Resulting in:
1) A native MB.
2) A His98Tyr mutant.

Commands:
vmd < BuildPDB.tcl
vmd < BuildHEME.tcl
vmd < BuildWTPSF.tcl
vmd < BuildMutantPSF.tcl
vmd < alignWTXY.tcl
vmd < alignMUTXY.tcl

Result:
MYO_HEME_WT_ALIGNED.pdb
MYO_HEME_WT_ALIGNED.psf
MYO_HEME_MUT_ALIGNED.pdb
MYO_HEME_MUT_ALIGNED.psf

#1-2-build-solvent-boxes
Two solvent boxes are created, a liquid and a resevoir.  The liquid is 98:2 TIP3:CharmmD O2 at 950 kg/m³.  The resevoir is 80:20 TIP3:CharmmD O2 at 950 kg/m³.  The size is based on the interal dimensions of the protein.  GOMC requires that the radius of gyration of a molecule not excede the (box length / 2) in any direction.  The maximal interal distance of Human MB is 26 Angstroms.

Recent work on HB, Hage et al 2018, showed a large box is required to generate the sufficient hydrophobic effect for accurate simulation.  This study stated HB requires a 150 Angstronm box for accurate simulation.  

A study of MB, Boechi et al 2013, found the hydrophobic effect sufficiently simulated with 12 Angstroms of water padding, since MB is much smaller than HB.  To be safe we used 20 Angstroms of padding.

Therefore, the box size is 2*(radius of gyration + 20 Angstroms), which results in a padding of 20 angstroms on each size, for a total of ~90 Angstroms.

finally, MosDef currently doesn't handle segment naming or custom atom type naming, so these are fixed with helper scripts.

Commands:
python create_solvent_boxes.py
python fixSegID.py
python fixSegID_res.py
python fixAtomTypes.py
python fixAtomTypes_res.py
cp GCMC_water_O2_liq.pdb GCMC_water_O2_liq_seg_fix_atom_type_fix.pdb
cp GCMC_water_O2_res.pdb GCMC_water_O2_res_seg_fix_atom_type_fix.pdb
Result:
GCMC_water_O2_FF.inp
GCMC_water_O2_FF_NAMD.inp
GCMC_water_O2_liq.pdb
GCMC_water_O2_liq.psf
GCMC_water_O2_liq_seg_fix.psf
GCMC_water_O2_liq_seg_fix_atom_type_fix.pdb
GCMC_water_O2_liq_seg_fix_atom_type_fix.psf
GCMC_water_O2_res.pdb
GCMC_water_O2_res.psf
GCMC_water_O2_res_seg_fix.psf
GCMC_water_O2_res_seg_fix_atom_type_fix.pdb
GCMC_water_O2_res_seg_fix_atom_type_fix.psf
in_GCMC_NVT.conf

#1-3-equilbrate-solvent-box
The solvent box is currently padded with 2 Angstroms of vacuum in every axis and the initial packing of H20 and O2 is not equilbrated.  Since we will simulate in the Grand Canonical Ensemble, we only need to equilibrate the liquid box.  The solvent is equilibrated before adding the protein to ensure the O2 is uniformly distributed within the H20.

Some files are renamed and copied into the current directory and then NAMD is run to equilibrate the box in NPT.

To analyze the equilibration, Radial distribution functions of O-O, W-O, and W-W are calculated.  Also the volume and total energy is plotted per MD step.

Finally, a PDB file with the restart coordinates is created.

Commands:
vmd < setBetaForColVars.tcl
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p4 step4_equilibration.inp > step4_equilibration.out

Result:
LIQ_BOX.pdb
LIQ_BOX.psf
LIQ_BOX_NPT_EQ.dcd
LIQ_BOX_NPT_EQ.pdb
LIQ_BOX_NPT_EQ.restart.coor
LIQ_BOX_NPT_EQ.restart.vel
LIQ_BOX_NPT_EQ.restart.xsc
LIQ_BOX_NPT_EQ.xst
o-o.agr
o-o.dat
o-w.agr
renameAndMove.tcl
RES_BOX.pdb
RES_BOX.psf
setBetaForColVars.tcl
step4_equilibration.out
tot.dat
vol.dat
w-w.agr

#1-4-solvate-protein
Since NAMD keeps the origin fixed when it changes the volume, the coordinates are no longer centered at 1/2 box length.  We shift the solvent box to ensure the geometric center is exactly [1/2 box length, 1/2 box length, 1/2 box length].  Then we shift the protein such that the geometric center of the protein is exactly [1/2 box length, 1/2 box length, 1/2 box length].  Finally, we merge the protein into the solvent, and remove all solvent molecules with 2.4 Angstroms of the protein.

Commands:
vmd < shift_solvent_box.tcl
bash ./shiftAndMergeMUT.sh
bash ./shiftAndMergeWT.sh

Results:
LIQ_BOX_NPT_EQ_SHIFTED.pdb
LIQ_BOX_NPT_EQ_SHIFTED.psf
log.txt
MYO_HEME_MUT_ALIGNED_SHIFTED.pdb
MYO_HEME_MUT_ALIGNED_SHIFTED.psf
MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED.pdb
MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED.psf
MYO_HEME_WT_ALIGNED_SHIFTED.pdb
MYO_HEME_WT_ALIGNED_SHIFTED.psf
MYO_HEME_WT_ALIGNED_SHIFTED_SOLVATED.pdb
MYO_HEME_WT_ALIGNED_SHIFTED_SOLVATED.psf

#1-5-neutralize
Waters are removed and replaced with ions to neutralize the system.

Commands:
vmd < autoionize_MUT.tcl
vmd < autoionize_WT.tcl

Results:
GCMC_water_O2_myoglobin_MUT_ions.pdb
GCMC_water_O2_myoglobin_MUT_ions.psf
GCMC_water_O2_myoglobin_WT_ions.pdb
GCMC_water_O2_myoglobin_WT_ions.psf
ionized.pdb
ionized.psf
log

#1-6-min-and-equil-MUT
Positional restraints are created for the protein, and the center of mass and rotational quaternion of the C-alpha chain is constrained.
The liquid box with the mutant protein is equilibrated in NVT.  

Commands:
vmd < createRestraintsFile.tcl
vmd < setBetaForColVars.tcl
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p6 step4_equilibration.inp > step4_equilibration.out

Results:

#1-6-min-and-equil-WT
Positional restraints are created for the protein, and the center of mass and rotational quaternion of the C-alpha chain is constrained.
The liquid box with the wildtype protein is equilibrated in NVT.  Positional restraints are created for the protein.

Commands:
vmd < createRestraintsFile.tcl
vmd < setBetaForColVars.tcl
~/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2 +p6 step4_equilibration.inp > step4_equilibration.out

Results:

