from Bio.PDB.PDBParser import PDBParser
from Bio.PDB.PDBIO import PDBIO
import numpy as np
import shutil

f = open("log.txt", "a")

import mbuild as mb
import numpy as np
from foyer import Forcefield
import mbuild.formats.charmm_writer as mf_charmm
import mbuild.formats.gomc_conf_writer as gomc_control

FF_file_O2 = './FFs/charmmD_molecular_oxygen.xml'
O2 = mb.load('./FFs/DIOX.mol2')
O2.name = 'DIOX'
#O2.energy_minimize(forcefield=FF_file_O2, steps=10**5)
FF_file_water = './FFs/charmm_tip3p.xml'
water = mb.load('O', smiles=True)
water.name = 'TIP3'
#water.energy_minimize(forcefield=FF_file_water, steps=10**5)

FF_dict = {water.name: FF_file_water, O2.name: FF_file_O2}
residues_list = [water.name, O2.name]
fix_bonds_angles_residues = [water.name, O2.name]
bead_to_atom_name_dict = { '_ON':'ON', '_OP':'OP'}

# Build the main simulation liquid box (box 0) and the vapor (box 1) for the simulation [1, 2, 13-17]


water_O2_box_liq = mb.fill_box(compound=[water,O2],
                                    density= 950,
                                    compound_ratio=[0.98, 0.02] ,
                                    box=[3.0, 3.0, 3.0])


water_O2_box_res = mb.fill_box(compound=[water,O2],
                                    density= 100,
                                    compound_ratio=[0.5, 0.5],
                                    box=[2.0, 2.0, 2.0])


charmmNAMD = mf_charmm.Charmm(water_O2_box_liq,
                          'GCMC_water_O2_liq_NAMD',
                          structure_box_1=water_O2_box_res,
                          filename_box_1='GCMC_water_O2_res_NAMD',
                          ff_filename="GCMC_water_O2_FF_NAMD",
                          forcefield_selection=FF_dict,
                          residues=residues_list,
                          bead_to_atom_name_dict=bead_to_atom_name_dict,
                          fix_residue=None,
                          gomc_fix_bonds_angles=None,
                          reorder_res_in_pdb_psf=True
                          )


charmm = mf_charmm.Charmm(water_O2_box_liq,
                          'GCMC_water_O2_liq',
                          structure_box_1=water_O2_box_res,
                          filename_box_1='GCMC_water_O2_res',
                          ff_filename="GCMC_water_O2_FF",
                          forcefield_selection=FF_dict,
                          residues=residues_list,
                          bead_to_atom_name_dict=bead_to_atom_name_dict,
                          fix_residue=None,
                          gomc_fix_bonds_angles=fix_bonds_angles_residues,
                          reorder_res_in_pdb_psf=True
                          )


charmm.write_inp()

charmm.write_psf()

charmm.write_pdb()

charmmNAMD.write_inp()

gomc_control.write_gomc_control_file(charmm, 'in_GCMC_NVT.conf', 'GCMC', 100, 310,
                                     input_variables_dict={"VDWGeometricSigma": True,
                                                           "Rcut": 12,
                                                           "DisFreq": 0.00,
                                                           "RotFreq": 0.00, 
                                                           "IntraSwapFreq": 0.00,
                                                           "SwapFreq": 1.00,
                                                           "RegrowthFreq": 0.00,
                                                           "CrankShaftFreq": 0.00,
                                                           "VolFreq": 0.00,
                                                           "MultiParticleFreq": 0.00,
                                                           "ChemPot" : {"TIP3" : -4166, "DIOX" : -8000}
                                                           }
                                    )
