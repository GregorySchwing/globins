from Bio.PDB.PDBParser import PDBParser
from Bio.PDB.PDBIO import PDBIO
import numpy as np
import shutil

import sys
import getopt

inputprefix = ''
proteinprefix = ''
outputprefix = ''
def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:],"hi:p:o:",["ifile=","pfile=","ofile="])
    except getopt.GetoptError:
        print ('only_shift_prot.py -i <solventprefix> -p <proteinprefix> -o <outputprefix>')
        print ('prefix{.psf/pdb}')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('only_shift_prot.py -i <solventprefix> -p <proteinprefix> -o <outputprefix>')
            print ('prefix{.psf/pdb}')
            sys.exit()
        elif opt in ("-i", "--iprefix"):
            inputprefix = arg
        elif opt in ("-p", "--pprefix"):
            proteinprefix = arg
        elif opt in ("-o", "--oprefix"):
            outputprefix = arg
    print ('Input prefix is "', inputprefix)
    print ('Protein prefix is "', inputprefix)
    print ('Output prefix is "', outputprefix)
    shutil.copyfile(proteinprefix+".psf", outputprefix+".psf")
    f = open("log.txt", "a")

    parser = PDBParser(PERMISSIVE=1)
    structure_id = "3rgk"
    filename = proteinprefix+".pdb"
    structure = parser.get_structure(structure_id, filename)
    atoms = structure.get_atoms()
    listOfCoords = []
    for atom in atoms:
        coords = atom.get_coord()
        listOfCoords.append(coords)
    coorNP = np.asarray(listOfCoords)
    geoCenterProt = coorNP.mean(axis=0)
    log = "Geometric Center: {}\n".format(geoCenterProt)
    f.write(log)

    # calculating Euclidean distance
    # using linalg.norm()
    maxDistMan = 0
    maxDistL2 = 0
    for atom in coorNP:
        #manDist = np.sqrt((atom[0] - geoCenterProt[0])**2 + (atom[1] - geoCenterProt[1])**2 + (atom[2] - geoCenterProt[2])**2)
        dist = np.linalg.norm(geoCenterProt - atom)
        #print ("manDist {} dist {}".format(manDist,dist))

        #print(dist)	
        if (dist > maxDistL2):
            maxDistL2 = dist
        #if (manDist > maxDistMan):
        #	maxDistMan = manDist

    log = "maxDistL2 {}\n".format(maxDistL2)
    f.write(log)

    parser = PDBParser(PERMISSIVE=1)
    structure_id = "box"
    filenameBox = inputprefix+".pdb"
    structureBox = parser.get_structure(structure_id, filenameBox)
    atomsBox = structureBox.get_atoms()
    listOfCoords_box = []
    for atom in atomsBox:
        coords = atom.get_coord()
        listOfCoords_box.append(coords)
    coorNPBox = np.asarray(listOfCoords_box)
    geoCenterBox = coorNPBox.mean(axis=0)
    log = "GEOMETRIC CENTER BOX: {}\n".format(geoCenterBox)
    f.write(log)

    log = "PROTEIN GEOMETRIC CENTER: {}\n".format(geoCenterProt)
    f.write(log)

    translationArrayProt = geoCenterBox - geoCenterProt
    log = "PROTEIN TRANSLATION VECTOR : {}\n".format(translationArrayProt)
    f.write(log)

    atoms = structure.get_atoms()
    for atom in atoms:
        newCoords = atom.get_coord()+translationArrayProt
        atom.set_coord(newCoords)
    io = PDBIO()
    io.set_structure(structure)
    io.save(outputprefix+".pdb")

if __name__ == "__main__":
    main()
