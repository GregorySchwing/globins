from Bio.PDB.PDBParser import PDBParser
from Bio.PDB.PDBIO import PDBIO
import numpy as np
import shutil
parser = PDBParser(PERMISSIVE=1)
structure_id = "3rgk"
filename = "../1-1-build/MYO_HEME.pdb"
structure = parser.get_structure(structure_id, filename)
atoms = structure.get_atoms()
listOfCoords = []
for atom in atoms:
	coords = atom.get_coord()
	listOfCoords.append(coords)
coorNP = np.asarray(listOfCoords)
geoCenter = coorNP.mean(axis=0)
print("Geometric Center:", geoCenter)

# calculating Euclidean distance
# using linalg.norm()
maxDistMan = 0
maxDistL2 = 0
for atom in coorNP:
	#manDist = np.sqrt((atom[0] - geoCenter[0])**2 + (atom[1] - geoCenter[1])**2 + (atom[2] - geoCenter[2])**2)
	dist = np.linalg.norm(geoCenter - atom)
	#print ("manDist {} dist {}".format(manDist,dist))

	#print(dist)	
	if (dist > maxDistL2):
		maxDistL2 = dist
	#if (manDist > maxDistMan):
	#	maxDistMan = manDist
print ("maxDistL2 {}".format(maxDistL2))
maxDistL2_padded = maxDistL2+100


shutil.copyfile("../1-1-build/MYO_HEME.psf", "MYO_HEME_SHIFTED.psf")

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
                                    compound_ratio=[0.8, 0.2] ,
                                    box=[2*maxDistL2_padded/10, 2*maxDistL2_padded/10, 2*maxDistL2_padded/10])

water_O2_box_vap = mb.fill_box(compound=[water,O2],
                                    density= 100,
                                    compound_ratio=[0.8, 0.2],
                                    box=[8, 8, 8])

charmm = mf_charmm.Charmm(water_O2_box_liq,
                          'GEMC_NVT_water_O2_liq',
                          structure_box_1=water_O2_box_vap,
                          filename_box_1='GEMC_NVT_water_O2_vap',
                          ff_filename="GEMC_NVT_water_O2_FF",
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


charmm.write_pdb()


gomc_control.write_gomc_control_file(charmm, 'in_GEMC_NVT.conf', 'GEMC_NVT', 100, 300,
                                     input_variables_dict={"VDWGeometricSigma": True,
                                                           "Rcut": 12,
                                                           "RcutCoulomb_box_1": 20,
                                                           "DisFreq": 0.20,
                                                           "RotFreq": 0.20, 
                                                           "IntraSwapFreq": 0.10,
                                                           "SwapFreq": 0.20,
                                                           "RegrowthFreq": 0.20,
                                                           "CrankShaftFreq": 0.09,
                                                           "VolFreq": 0.00,
                                                           "MultiParticleFreq": 0.01,
                                                           }
                                    )

print('Completed: GOMC FF file, and the psf and pdb files')


structure_id = "box"
filename = "./GEMC_NVT_water_O2_liq.pdb"
structure_box = parser.get_structure(structure_id, filename)
atoms = structure_box.get_atoms()
listOfCoords = []
for atom in atoms:
	coords = atom.get_coord()
	listOfCoords.append(coords)
coorNP = np.asarray(listOfCoords)
geoCenterBox = coorNP.mean(axis=0)
print("Geometric Center:", geoCenter)

translationArray = np.abs(geoCenterBox - geoCenter)
atoms = structure.get_atoms()
for atom in atoms:
	newCoords = atom.get_coord()+translationArray
	atom.set_coord(newCoords)
io = PDBIO()
io.set_structure(structure)
io.save("MYO_HEME_SHIFTED.pdb")
