#!/bin/bash
python only_shift_prot.py -i ../1-4-solvate-protein/LIQ_BOX_NPT_EQ_SHIFTED -p ../1-1-build-protein/MYO_HEME_MUT_ALIGNED -o MYO_HEME_MUT_ALIGNED_SHIFTED
vmd < merge_MUT_protein_and_solvent_box.tcl
