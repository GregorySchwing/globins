import mbuild as mb
import numpy as np
from foyer import Forcefield
import mbuild.formats.charmm_writer as mf_charmm
import mbuild.formats.gomc_conf_writer as gomc_control

FF_file_O2 = '../FFs/charmmD_molecular_oxygen.xml'
O2 = mb.load('../FFs/DIOX.mol2')
O2.name = 'DIOX'
FF_file_water = '../FFs/charmm_tip3p.xml'
water = mb.load('O', smiles=True)
water.name = 'WAT'
#DIOX.energy_minimize(forcefield = FF_file_O2 , steps=10**5)

FF_Dict = {O2.name: FF_file_O2}

residues_List = [O2.name]

Fix_bonds_angles_residues = [ O2.name ]
#Fix_bonds_angles_residues = None



print('Running: filling liquid box')
O2_box = mb.fill_box(compound=[O2],
                                    density= 996 ,
                                    box=[3.0, 3.0, 3.0] )
print('Completed: filling liquid box')


print('Running: GOMC FF file, and the psf and pdb files')
charmm = mf_charmm.Charmm(O2_box,
                          'NVT_water',
                          structure_box_1 = None,
                          filename_box_1 = None,
                          ff_filename = 'NVT_water',
                          forcefield_selection = FF_Dict,
                          residues= residues_List ,
                          bead_to_atom_name_dict = None,
                          fix_residue = None,
                          gomc_fix_bonds_angles = Fix_bonds_angles_residues,
                          reorder_res_in_pdb_psf = True
                          )



charmm.write_inp()

charmm.write_psf()

charmm.write_pdb()


gomc_control.write_gomc_control_file(charmm, 'in_NVT.conf',  'NVT', 10, 300,
                                     input_variables_dict={"VDWGeometricSigma": False,
                                                           }
                                     )

print('Completed: GOMC FF file, and the psf and pdb files')


