#!/bin/bash
python only_shift_prot.py -i implicit_solv_box -p ../1-1-build-protein/MYO_HEME_WT_ALIGNED -o MYO_HEME_WT_ALIGNED_SHIFTED
vmd < merge_WT_protein_and_solvent_box.tcl
