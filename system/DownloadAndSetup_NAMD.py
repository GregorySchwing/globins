# -*- coding: utf-8 -*-
# Req pdb-tools
# Crystal Structure of human myoglobin at 2.8 Å resolution - 3RGK 
# Crystal Structure of Physeter catodon oxymyoglobin at 1.6 Å resolution - 1MBO
import os
import subprocess
import sys
result = subprocess.run(['which', 'pdb_fetch'], stdout=subprocess.PIPE)
result.stdout.decode('utf-8')
blank = ''
if (result.stdout.decode('utf-8') is blank):
	print("This script requires pdb-tools")
	print("pip install pdb-tools")
	sys.exit(0)

print("Downloading 3RGK") # Crystal Structure of human myoglobin at 2.8 Å resolution - 3RGK 
os.system('pdb_fetch 3RGK > ./1-0-download/3RGK.pdb')  # 2.8 Å Resolution
print("3RGK Done")

#print("Downloading 1MBO") # Crystal Structure of human oxymyoglobin at 1.6 Å resolution - 1MBO
#os.system('pdb_fetch 1MBO > ./1-0-download/1MBO.pdb')  # 1.6 Å Resolution
#print("1MBO Done")

# Req BRMB module
# NMR Data
"""
import pynmrstar
ent27571 = pynmrstar.Entry.from_database(27571) # c-MYC:MAX bHLHZip complex,
ent12033 = pynmrstar.Entry.from_database(12033) # c-MYC bHLHZip free protein
ent27571.write_to_file("c-MYC:MAX bHLHZip complex.str")
ent12033.write_to_file("c-MYC bHLHZip free protein.str")
"""

print("Making \'./1-1-solvate/3RGK_solvated\' directory")
os.system('mkdir -p ./1-1-solvate/3RGK_solvated')

#1-1-build
print("Solvating 3RGK")
os.system('vmd < ./1-1-build/BuildPDB_2.25.tcl  > ./1-1-build/BuildPDB_2.25.log')  # 2.25 Å Resolution
print("mycmax_2.25 Done")
print("Building myc_2.25")
# A,C - Myc ; B,D - Max
# Dimer 1 - A,B
# Dimer 2 - C,D
os.system('pdb_delchain -B,C,D ./1-1-build/mycmax_2.25.pdb > ./1-1-build/mycs/myc_2.25_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,D ./1-1-build/mycmax_2.25.pdb > ./1-1-build/mycs/myc_2.25_b.pdb')  # 2.25 Å Resolution
print("myc_2.25 Done")
print("Building max_2.25")
os.system('pdb_delchain -A,C,D ./1-1-build/mycmax_2.25.pdb > ./1-1-build/maxs/max_2.25_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C ./1-1-build/mycmax_2.25.pdb > ./1-1-build/maxs/max_2.25_b.pdb')  # 2.25 Å Resolution
print("max_2.25 Done")

#1-1-build
print("Building mycmax_1.35")
os.system('vmd < ./1-1-build/BuildPDB_1.35.tcl  > ./1-1-build/BuildPDB_1.35.log')  # 1.35 Å Resolution
print("mycmax_1.35 Done")
print("Building myc_1.35")
# A,C - Myc ; B,D - Max
# Dimer 1 - A,B
# Dimer 2 - C,D
os.system('pdb_delchain -B,C,D ./1-1-build/mycmax_1.35.pdb > ./1-1-build/mycs/myc_1.35_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,D ./1-1-build/mycmax_1.35.pdb > ./1-1-build/mycs/myc_1.35_b.pdb')  # 2.25 Å Resolution
print("myc_1.35 Done")
print("Building max_1.35")
os.system('pdb_delchain -A,C,D ./1-1-build/mycmax_1.35.pdb > ./1-1-build/maxs/max_1.35_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C ./1-1-build/mycmax_1.35.pdb > ./1-1-build/maxs/max_1.35_b.pdb')  # 2.25 Å Resolution
print("max_1.35 Done")

#1-1-build
print("Building mycmax_2.20")
os.system('vmd < ./1-1-build/BuildPDB_2.20.tcl > ./1-1-build/BuildPDB_2.20.log')  # 2.20 Å Resolution
print("mycmax_2.20 Done")
print("Building myc_2.20")
# A,C,E,G - Myc ; B,D,F,H - Max
# Dimer 1 - A,B
# Dimer 2 - C,D
# Dimer 3 - E,F
# Dimer 4 - G,H
os.system('pdb_delchain -B,C,D,E,F,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/mycs/myc_2.20_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,D,E,F,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/mycs/myc_2.20_b.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C,D,F,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/mycs/myc_2.20_c.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C,D,E,F,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/mycs/myc_2.20_d.pdb')  # 2.25 Å Resolution
print("myc_2.20 Done")
print("Building max_2.20")
os.system('pdb_delchain -A,C,D,E,F,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/maxs/max_2.20_a.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C,E,F,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/maxs/max_2.20_b.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C,D,E,G,H ./1-1-build/mycmax_2.20.pdb > ./1-1-build/maxs/max_2.20_c.pdb')  # 2.25 Å Resolution
os.system('pdb_delchain -A,B,C,D,E,F,G ./1-1-build/mycmax_2.20.pdb > ./1-1-build/maxs/max_2.20_d.pdb')  # 2.25 Å Resolution
print("max_2.20 Done")

print("Making \'myc_max\' directory")
os.system('mkdir -p ./1-1-build/myc_max')

#print("Making \'invacuo\' directory")
#os.system('mkdir -p ./1-1-build/myc_max/invacuo')

#1-1-build
print("Building myc_max_*_1.35 pdb and psf")
os.system('vmd < ./1-1-build/BuildPSF_1.35.tcl > ./1-1-build/BuildPSF_1.35.log')  # 2.20 Å Resolution
#os.system('vmd < ./1-1-build/BuildPSF_1.35_CG.tcl > ./1-1-build/BuildPSF_1.35.log')  # 2.20 Å Resolution
print("myc_max_*_1.35 pdb and psf Done")
print("Building myc_max_*_2.20 pdb and psf")
os.system('vmd < ./1-1-build/BuildPSF_2.20.tcl > ./1-1-build/BuildPSF_2.20.log')  # 2.20 Å Resolution
print("myc_max_*_2.20 pdb and psf Done")
print("Building myc_max_*_2.25 pdb and psf")
os.system('vmd < ./1-1-build/BuildPSF_2.25.tcl > ./1-1-build/BuildPSF_2.25.log')  # 2.20 Å Resolution
print("myc_max_*_2.25_pdb and psf Done")

"""
print("Making \'solvated\' directory")
os.system('mkdir -p ./1-1-build/myc_max/solvated')

print("Solvating myc_max_*_1.35 pdb and psf")
os.system('vmd < ./1-1-build/Solvate_1.35.tcl > ./1-1-build/Solvate_1.35.log')  # 2.20 Å Resolution
print("Solvating myc_max_*_1.35 pdb and psf Done")
print("Solvating myc_max_*_2.20 pdb and psf")
os.system('vmd < ./1-1-build/Solvate_2.20.tcl > ./1-1-build/Solvate_2.20.log')  # 2.20 Å Resolution
print("Solvating myc_max_*_2.20 pdb and psf Done")
print("Solvating myc_max_*_2.25 pdb and psf")
os.system('vmd < ./1-1-build/Solvate_2.25.tcl > ./1-1-build/Solvate_2.25.log')  # 2.20 Å Resolution
print("Solvating myc_max_*_2.25_pdb and psf Done")
"""

