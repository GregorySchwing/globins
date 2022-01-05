set input MYO_HEME_WT

set solute [mol new $input.psf waitfor all]
mol addfile $input.pdb mol $solute waitfor all

set FE [atomselect top "name FE"]
set DUM [atomselect top "name DU"]
set H [atomselect top "resname HSD and resid 93 and name NE2"]

set NA [atomselect top "name NA"]
set NB [atomselect top "name NB"]
set NC [atomselect top "name NC"]
set ND [atomselect top "name ND"]

set FE_COOR [lindex [$FE get {x y z}] 0]
set DUM_COOR [lindex [$DUM get {x y z}] 0]

set NA_COOR [lindex [$NA get {x y z}] 0]
set NB_COOR [lindex [$NB get {x y z}] 0]
set NC_COOR [lindex [$NC get {x y z}] 0]
set ND_COOR [lindex [$ND get {x y z}] 0]

set ND_2_NC [vecsub $ND_COOR $NC_COOR]
set ND_2_NA [vecsub $ND_COOR $NA_COOR]
set NC_x_ND_x_NA [veccross $ND_2_NC $ND_2_NA]
set NC_x_ND_x_NA_unit [vecscale -2.5 [vecnorm $NC_x_ND_x_NA]]
#set NC_x_ND_x_NA_unit_flipped [vecscale -1 $NC_x_ND_x_NA_unit]
#set ND_2_box [vecadd $ND_COOR $NC_x_ND_x_NA_unit_flipped]
set ND_2_box [vecadd $ND_COOR $NC_x_ND_x_NA_unit]

set NC_2_NB [vecsub $NC_COOR $NB_COOR]
set NC_2_ND [vecsub $NC_COOR $ND_COOR]
set NB_x_NC_x_ND [veccross $NC_2_NB $NC_2_ND]
set NB_x_NC_x_ND_unit [vecscale -2.5 [vecnorm $NB_x_NC_x_ND]]
#set NB_x_NC_x_ND_unit_flipped [vecscale -1 $NB_x_NC_x_ND_unit]
#set NC_2_box [vecadd $NC_COOR $NB_x_NC_x_ND_unit_flipped]
set NC_2_box [vecadd $NC_COOR $NB_x_NC_x_ND_unit]

set NB_2_NC [vecsub $NB_COOR $NC_COOR]
set NB_2_NA [vecsub $NB_COOR $NA_COOR]
set NC_x_NB_x_NA [veccross $NB_2_NC $NB_2_NA]
set NC_x_NB_x_NA_unit [vecnorm $NC_x_NB_x_NA]
set NC_x_NB_x_NA_unit_flipped [vecscale -2.5 [vecscale -1 $NC_x_NB_x_NA_unit]]
set NB_2_box [vecadd $NB_COOR $NC_x_NB_x_NA_unit_flipped]

set NA_2_NB [vecsub $NA_COOR $NB_COOR]
set NA_2_ND [vecsub $NA_COOR $ND_COOR]
set NB_x_NA_x_ND [veccross $NA_2_NB $NA_2_ND]
set NB_x_NA_x_ND_unit [vecnorm $NB_x_NA_x_ND]
set NB_x_NA_x_ND_unit_flipped [vecscale -2.5 [vecscale -1 $NB_x_NA_x_ND_unit]]
set NA_2_box [vecadd $NA_COOR $NB_x_NA_x_ND_unit_flipped]

draw line "$NA_COOR" "$NA_2_box" width 5
draw line "$NB_COOR" "$NB_2_box" width 5
draw line "$NC_COOR" "$NC_2_box" width 5
draw line "$ND_COOR" "$ND_2_box" width 5

draw line "$NA_2_box" "$NB_2_box" width 5
draw line "$NB_2_box" "$NC_2_box" width 5
draw line "$NC_2_box" "$ND_2_box" width 5
draw line "$ND_2_box" "$NA_2_box" width 5

draw line "$NA_COOR" "$NB_COOR" width 5
draw line "$NB_COOR" "$NC_COOR" width 5
draw line "$NC_COOR" "$ND_COOR" width 5
draw line "$ND_COOR" "$NA_COOR" width 5

set representation1 [atomselect top "resname HSD or resname HSE or heme or resname DUM"]

mol modselect 0 0 heme or resid 64 or resid 93 or resname DUM
rotate x by -0.666667
rotate y by -11.333334
rotate x by -0.266667
rotate y by -4.533334
rotate y by -5.666667
rotate y by -2.266667
rotate x by -1.000000
rotate y by -1.666667
rotate x by -0.400000
rotate y by -0.666667
rotate y by -7.333333
rotate y by -2.933333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by -1.666667
rotate x by -0.133333
rotate y by -0.666667
rotate x by -1.000000
rotate x by -0.400000
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate y by -1.000000
rotate x by -0.133333
rotate y by -0.400000
rotate x by -0.333333
rotate y by -0.666667
rotate x by -0.133333
rotate y by -0.266667
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -2.333333
rotate y by -0.933333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -1.333333
rotate y by -0.533333
rotate y by -1.666667
rotate y by -0.666667
rotate y by -3.000000
rotate y by -1.200000
rotate y by -2.333333
rotate y by -0.933333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -2.333333
rotate y by -0.933333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.666667
rotate y by -0.666667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -12.333334
rotate y by 2.666667
rotate x by -4.933334
rotate y by 1.066667
rotate x by -1.666667
rotate y by 1.666667
rotate x by -0.666667
rotate y by 0.666667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -2.333333
rotate x by -0.933333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -1.000000
rotate y by 0.666667
rotate x by -0.400000
rotate y by 0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by -18.000000
rotate y by -9.333334
rotate x by -7.200000
rotate y by -3.733334
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -1.333333
rotate x by 0.266667
rotate y by -0.533333
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -1.333333
rotate x by 0.133333
rotate y by -0.533333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -2.666667
rotate x by 0.133333
rotate y by -1.066667
rotate x by 0.333333
rotate y by -1.000000
rotate x by 0.133333
rotate y by -0.400000
rotate x by 0.666667
rotate y by -0.666667
rotate x by 0.266667
rotate y by -0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 1.000000
rotate y by -1.333333
rotate x by 0.400000
rotate y by -0.533333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 1.666667
rotate y by -0.666667
rotate x by 0.666667
rotate y by -0.266667
rotate x by 2.333333
rotate y by -0.666667
rotate x by 0.933333
rotate y by -0.266667
rotate x by 3.333333
rotate x by 1.333333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 4.333333
rotate y by 0.666667
rotate x by 1.733333
rotate y by 0.266667
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 0.333333
rotate x by 0.400000
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate x by 2.666667
rotate y by 2.666667
rotate x by 1.066667
rotate y by 1.066667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.666667
rotate y by 1.000000
rotate x by 0.266667
rotate y by 0.400000
rotate y by 1.666667
rotate y by 0.666667
rotate y by 1.666667
rotate y by 0.666667
rotate y by 2.333333
rotate y by 0.933333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -1.000000
rotate y by 0.666667
rotate x by -0.400000
rotate y by 0.266667
rotate x by -1.333333
rotate y by 0.666667
rotate x by -0.533333
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by -1.000000
rotate y by 1.666667
rotate x by -0.400000
rotate y by 0.666667
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 1.000000
rotate x by -0.133333
rotate y by 0.400000
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -1.666667
rotate y by 2.666667
rotate x by -0.666667
rotate y by 1.066667
rotate y by 1.333333
rotate y by 0.533333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -1.000000
rotate y by 0.666667
rotate x by -0.400000
rotate y by 0.266667
rotate x by -1.000000
rotate y by 0.333333
rotate x by -0.400000
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate y by 1.000000
rotate y by 0.400000
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.666667
rotate x by -0.133333
rotate y by 0.266667
rotate x by -1.000000
rotate y by 1.000000
rotate x by -0.400000
rotate y by 0.400000
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 4.000000
rotate y by 2.000000
rotate x by 1.600000
rotate y by 0.800000
rotate x by 1.000000
rotate y by 6.666667
rotate x by 0.400000
rotate y by 2.666667
rotate x by 0.666667
rotate y by 1.666667
rotate x by 0.266667
rotate y by 0.666667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 0.333333
rotate x by 0.400000
rotate y by 0.133333
rotate y by 1.333333
rotate y by 0.533333
rotate y by 1.333333
rotate y by 0.533333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 1.333333
rotate x by 0.400000
rotate y by 0.533333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 2.333333
rotate x by 0.133333
rotate y by 0.933333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate y by 2.333333
rotate x by 0.133333
rotate y by 0.933333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.666667
rotate y by 2.000000
rotate x by 0.266667
rotate y by 0.800000
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate x by 0.666667
rotate y by 2.666667
rotate x by 0.266667
rotate y by 1.066667
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 0.666667
rotate x by 0.400000
rotate y by 0.266667
rotate x by 2.333333
rotate y by 5.666667
rotate x by 0.933333
rotate y by 2.266667
rotate x by 1.333333
rotate y by 11.666667
rotate x by 0.533333
rotate y by 4.666667
rotate x by 0.333333
rotate y by 8.666667
rotate x by 0.133333
rotate y by 3.466667
rotate y by 2.000000
rotate y by 0.800000
rotate y by 2.333333
rotate y by 0.933333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 3.333333
rotate y by 1.333333
rotate y by 2.333333
rotate y by 0.933333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 1.333333
rotate y by 1.666667
rotate x by 0.533333
rotate y by 0.666667
rotate x by 1.666667
rotate y by 2.333333
rotate x by 0.666667
rotate y by 0.933333
rotate x by 2.000000
rotate y by 2.000000
rotate x by 0.800000
rotate y by 0.800000
rotate x by 0.666667
rotate y by 1.000000
rotate x by 0.266667
rotate y by 0.400000
rotate x by 1.666667
rotate y by 1.666667
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.666667
rotate y by 0.333333
rotate x by 0.266667
rotate y by 0.133333
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.266667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 0.333333
rotate x by 0.400000
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate y by 1.666667
rotate x by 0.133333
rotate y by 0.666667
rotate x by 2.000000
rotate y by 0.333333
rotate x by 0.800000
rotate y by 0.133333
rotate x by 1.333333
rotate y by 1.000000
rotate x by 0.533333
rotate y by 0.400000
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate x by 0.400000
rotate y by 0.666667
rotate y by 0.266667
rotate x by 1.666667
rotate y by 0.333333
rotate x by 0.666667
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 1.000000
rotate x by 0.400000
rotate y by 1.000000
rotate y by 0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.666667
rotate y by 0.333333
rotate x by 0.266667
rotate y by 0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 2.000000
rotate x by 0.800000
rotate y by 1.333333
rotate y by 0.533333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.666667
rotate y by 1.333333
rotate x by 0.666667
rotate y by 0.533333
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.266667
rotate y by 0.266667
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.266667
rotate y by 0.266667
rotate x by 3.333333
rotate y by 4.000000
rotate x by 1.333333
rotate y by 1.600000
rotate x by 1.333333
rotate y by 1.333333
rotate x by 0.533333
rotate y by 0.533333
rotate x by 1.666667
rotate y by 0.333333
rotate x by 0.666667
rotate y by 0.133333
rotate x by 0.666667
rotate y by 3.000000
rotate x by 0.266667
rotate y by 1.200000
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -2.666667
rotate y by -1.066667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -3.333333
rotate y by -1.333333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.666667
rotate y by -0.666667
rotate x by -0.333333
rotate y by -2.666667
rotate x by -0.133333
rotate y by -1.066667
rotate y by -1.000000
rotate y by -0.400000
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate y by -2.333333
rotate y by -0.933333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -1.000000
rotate y by -3.000000
rotate x by -0.400000
rotate y by -1.200000
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
scale by 1.200000
scale by 1.200000
scale by 1.200000
scale by 1.200000
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.666667
rotate x by 0.133333
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -2.000000
rotate x by 0.133333
rotate y by -0.800000
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -0.666667
rotate x by 0.133333
rotate y by -0.266667
rotate y by -1.333333
rotate y by -0.533333
rotate x by 0.333333
rotate y by -1.000000
rotate x by 0.133333
rotate y by -0.400000
rotate x by -0.666667
rotate x by -0.266667
rotate x by -1.333333
rotate x by -0.533333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate y by 0.333333
rotate x by 0.400000
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -1.000000
rotate x by 0.266667
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate y by -0.666667
rotate x by -0.266667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.666667
rotate y by -1.000000
rotate x by -0.266667
rotate y by -0.400000
rotate x by -0.333333
rotate y by -0.666667
rotate x by -0.133333
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate y by -0.333333
rotate x by -0.266667
rotate y by -0.133333
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate y by 1.333333
rotate y by 0.533333
rotate x by 0.666667
rotate x by 0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -1.333333
rotate y by -0.533333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -0.333333
rotate x by 0.266667
rotate y by -0.133333
rotate x by 0.333333
rotate y by -1.666667
rotate x by 0.133333
rotate y by -0.666667
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -9.000000
rotate y by -3.600000
rotate y by -1.333333
rotate y by -0.533333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.666667
rotate y by -0.666667
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
scale by 1.200000
rotate x by 0.133333
scale by 1.200000
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
rotate z by -0.333333
rotate z by -0.133333
rotate z by -0.333333
rotate z by -0.133333
rotate z by -1.000000
rotate z by -0.400000
rotate z by -0.333333
rotate z by -0.133333
rotate z by 1.000000
rotate z by 0.400000
rotate z by 0.666667
rotate z by 0.266667
rotate z by 1.000000
rotate z by 0.400000
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.666667
rotate z by 0.266667
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by 0.666667
rotate z by 0.266667
rotate z by 0.666667
rotate z by 0.266667
rotate z by 0.666667
rotate z by 0.266667
rotate z by -0.666667
rotate z by -0.266667
rotate z by -0.333333
rotate z by -0.133333
rotate z by -1.333333
rotate z by -0.533333
rotate z by -1.666667
rotate z by -0.666667
rotate z by -1.333333
rotate z by -0.533333
rotate z by -0.333333
rotate z by -0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 8.000000
rotate x by 3.200000
rotate x by 4.000000
rotate x by 1.600000
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 3.333333
rotate x by 1.333333
rotate x by 7.000000
rotate y by -0.666667
rotate x by 2.800000
rotate y by -0.266667
rotate x by 2.000000
rotate x by 0.800000
rotate x by 1.000000
rotate x by 0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.666667
rotate x by -0.266667
rotate x by -2.666667
rotate x by -1.066667
rotate x by -4.333333
rotate x by -1.733333
rotate x by -4.000000
rotate x by -1.600000
rotate x by -7.666667
rotate x by -3.066667
rotate x by -2.000000
rotate x by -0.800000
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.000000
rotate x by -0.400000
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -5.000000
rotate y by 1.333333
rotate x by -2.000000
rotate y by 0.533333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.666667
rotate y by 0.333333
rotate x by -0.666667
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 1.000000
rotate x by 0.400000
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 1.000000
rotate y by 0.400000
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 1.000000
rotate y by 0.400000
rotate y by 1.666667
rotate y by 0.666667
rotate y by 1.000000
rotate y by 0.400000
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 1.666667
rotate y by 0.666667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.666667
rotate x by 0.133333
rotate y by -0.266667
rotate y by -1.333333
rotate y by -0.533333
rotate y by -2.666667
rotate y by -1.066667
rotate y by -1.666667
rotate y by -0.666667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
scale by 1.200000
scale by 1.200000
scale by 1.200000
scale by 1.200000
scale by 1.200000
scale by 1.200000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 1.200000
menu graphics off
scale by 1.002000
scale by 1.028000
scale by 1.001000
scale by 1.001000
scale by 1.003000
scale by 1.001000
scale by 1.001000
scale by 1.001000
scale by 1.001000
scale by 1.002000
scale by 1.001000
scale by 1.006000
scale by 1.003000
scale by 1.007000
scale by 1.002000
scale by 1.026000
scale by 1.008000
scale by 1.007000
scale by 1.005000
scale by 1.009000
scale by 1.014000
scale by 1.013000
scale by 1.012000
scale by 1.019000
scale by 1.013000
scale by 1.015000
scale by 1.015000
scale by 1.007000
scale by 1.004000
scale by 1.024000
scale by 1.023000
scale by 1.002000
scale by 1.001000
scale by 1.019000
scale by 1.012000
scale by 1.004000
scale by 1.007000
scale by 1.002000
scale by 1.018000
scale by 1.001000
scale by 1.002000
scale by 1.014000
scale by 1.003000
scale by 1.027000
scale by 1.015000
scale by 1.014000
scale by 1.011000
scale by 1.055000
scale by 1.010000
scale by 1.006000
scale by 1.001000
scale by 1.001000
scale by 1.023000
scale by 1.021000
scale by 1.006000
scale by 1.009000
scale by 1.005000
scale by 1.039000
scale by 1.026000
scale by 1.111000
scale by 1.055000
scale by 1.006000
scale by 1.003000
scale by 1.005000
scale by 1.009000
scale by 1.003000
scale by 1.010000
scale by 1.005000
scale by 1.007000
scale by 1.004000
scale by 1.013000
scale by 1.008000
scale by 1.007000
scale by 1.003000
scale by 1.011000
scale by 1.006000
scale by 1.005000
scale by 1.027000
scale by 1.007000
scale by 1.010000
scale by 1.004000
scale by 1.005000
scale by 1.008000
scale by 1.006000
scale by 1.001000
scale by 1.004000
scale by 1.001000
scale by 1.003000
scale by 1.003000
scale by 1.005000
scale by 1.004000
scale by 1.013000
scale by 1.011000
scale by 1.016000
scale by 1.022000
scale by 1.007000
scale by 1.005000
scale by 1.008000
scale by 1.001000
scale by 1.003000
scale by 1.001000
translate by 0.010000 -0.000000 0.000000
translate by 0.060000 0.020000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.040000 0.020000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.010000 0.020000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.030000 0.010000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.040000 0.020000 0.000000
translate by 0.050000 0.010000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.030000 0.010000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.030000 0.010000 0.000000
scale by 1.200000
scale by 1.200000
scale by 1.200000
translate by 0.010000 -0.000000 0.000000
translate by 0.110000 0.110000 0.000000
translate by 0.540000 0.040000 0.000000
translate by 0.030000 0.010000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.040000 0.020000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 0.010000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
translate by -0.050000 -0.000000 0.000000
translate by -0.020000 -0.000000 0.000000
translate by -0.040000 -0.000000 0.000000
translate by -0.030000 -0.000000 0.000000
translate by -0.030000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
scale by 0.833000
rotate x by 0.333333
rotate x by 0.133333
rotate x by 1.000000
rotate y by -6.333333
rotate x by 0.400000
rotate y by -2.533334
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.333333
rotate y by -1.333333
rotate x by 0.133333
rotate y by -0.533333
rotate x by 0.333333
rotate y by -2.333333
rotate x by 0.133333
rotate y by -0.933333
rotate x by 0.666667
rotate y by -1.333333
rotate x by 0.266667
rotate y by -0.533333
rotate x by 1.000000
rotate y by -1.333333
rotate x by 0.400000
rotate y by -0.533333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.666667
rotate y by -0.266667
rotate x by 1.000000
rotate x by 0.400000
rotate y by -1.666667
rotate y by -0.666667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by 1.666667
rotate y by 0.666667
rotate x by 2.333333
rotate x by 0.933333
rotate y by 7.333333
rotate y by 2.933333
rotate x by 2.666667
rotate y by 3.000000
rotate x by 1.066667
rotate y by 1.200000
rotate x by 1.333333
rotate y by 2.000000
rotate x by 0.533333
rotate y by 0.800000
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 1.666667
rotate x by 0.133333
rotate y by 0.666667
rotate y by 2.000000
rotate y by 0.800000
rotate x by 0.333333
rotate y by 1.666667
rotate x by 0.133333
rotate y by 0.666667
rotate x by 1.000000
rotate y by 3.333333
rotate x by 0.400000
rotate y by 1.333333
rotate x by 0.333333
rotate y by 3.333333
rotate x by 0.133333
rotate y by 1.333333
rotate y by 3.333333
rotate y by 1.333333
rotate y by 1.000000
rotate y by 0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate y by 3.000000
rotate y by 1.200000
rotate y by 1.666667
rotate y by 0.666667
rotate y by 6.666667
rotate y by 2.666667
rotate x by 0.333333
rotate y by 1.000000
rotate x by 0.133333
rotate y by 0.400000
rotate y by 1.333333
rotate y by 0.533333
rotate y by 2.666667
rotate y by 1.066667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 4.333333
rotate y by 1.733333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 1.666667
rotate y by 0.666667
rotate x by -2.000000
rotate x by -0.800000
rotate y by 2.333333
rotate y by 0.933333
rotate x by -2.333333
rotate y by 2.000000
rotate x by -0.933333
rotate y by 0.800000
rotate x by -1.000000
rotate y by 1.000000
rotate x by -0.400000
rotate y by 0.400000
rotate y by 1.666667
rotate y by 0.666667
rotate y by 1.333333
rotate y by 0.533333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -1.333333
rotate y by -0.533333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -1.000000
rotate y by -0.400000
rotate x by 1.333333
rotate y by -1.000000
rotate x by 0.533333
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate x by 1.333333
rotate y by -1.000000
rotate x by 0.533333
rotate y by -0.400000
rotate x by 1.333333
rotate x by 0.533333
rotate x by 1.333333
rotate y by -1.666667
rotate x by 0.533333
rotate y by -0.666667
rotate x by 1.000000
rotate y by -0.666667
rotate x by 0.400000
rotate y by -0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -0.333333
rotate x by 0.266667
rotate y by -0.133333
rotate x by 0.333333
rotate y by -1.000000
rotate x by 0.133333
rotate y by -0.400000
rotate x by 0.666667
rotate x by 0.266667
rotate x by 1.000000
rotate x by 0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.666667
rotate x by 0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate x by 1.666667
rotate y by 2.333333
rotate x by 0.666667
rotate y by 0.933333
rotate x by 1.000000
rotate x by 0.400000
rotate y by 1.666667
rotate y by 0.666667
rotate x by 1.000000
rotate y by 2.666667
rotate x by 0.400000
rotate y by 1.066667
rotate x by 1.333333
rotate y by 1.666667
rotate x by 0.533333
rotate y by 0.666667
rotate x by 2.666667
rotate y by 8.000000
rotate x by 1.066667
rotate y by 3.200000
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.266667
rotate y by 0.266667
rotate y by 2.666667
rotate y by 1.066667
rotate x by 0.333333
rotate y by 1.666667
rotate x by 0.133333
rotate y by 0.666667
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by -1.000000
rotate x by -0.133333
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate y by -6.000000
rotate y by -2.400000
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -1.666667
rotate x by 0.133333
rotate y by -0.666667
rotate x by 1.333333
rotate y by -2.000000
rotate x by 0.533333
rotate y by -0.800000
rotate y by -1.333333
rotate y by -0.533333
rotate x by 0.666667
rotate y by -1.666667
rotate x by 0.266667
rotate y by -0.666667
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -1.000000
rotate x by 0.133333
rotate y by -0.400000
rotate x by 1.000000
rotate y by -1.000000
rotate x by 0.400000
rotate y by -0.400000
rotate y by -1.333333
rotate y by -0.533333
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.666667
rotate x by 0.266667
rotate x by 1.000000
rotate y by -0.333333
rotate x by 0.400000
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by 1.000000
rotate y by -0.666667
rotate x by 0.400000
rotate y by -0.266667
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -1.333333
rotate y by -0.533333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -6.333333
rotate y by -2.533334
rotate x by -0.666667
rotate x by -0.266667
rotate x by -1.333333
rotate y by -1.666667
rotate x by -0.533333
rotate y by -0.666667
rotate x by -0.333333
rotate y by -0.666667
rotate x by -0.133333
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.666667
rotate x by -0.666667
rotate x by -0.666667
rotate y by -1.666667
rotate x by -0.266667
rotate y by -0.666667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -2.666667
rotate y by -8.000000
rotate x by -1.066667
rotate y by -3.200000
rotate x by -0.666667
rotate y by -4.333333
rotate x by -0.266667
rotate y by -1.733333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 2.666667
rotate y by 18.000000
rotate x by 1.066667
rotate y by 7.200000
rotate x by 3.000000
rotate y by 3.666667
rotate x by 1.200000
rotate y by 1.466667
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 5.000000
rotate y by 1.000000
rotate x by 2.000000
rotate y by 0.400000
rotate x by 1.000000
rotate y by 8.000000
rotate x by 0.400000
rotate y by 3.200000
rotate x by 5.333333
rotate y by 10.000001
rotate x by 2.133333
rotate y by 4.000000
rotate x by 1.333333
rotate y by 2.333333
rotate x by 0.533333
rotate y by 0.933333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.666667
rotate y by 0.266667
rotate x by 0.333333
rotate y by 1.333333
rotate x by 0.133333
rotate y by 0.533333
rotate x by 2.000000
rotate y by 2.000000
rotate x by 0.800000
rotate y by 0.800000
rotate x by 0.333333
rotate y by 0.666667
rotate x by 0.133333
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -5.333333
rotate y by -4.000000
rotate x by -2.133333
rotate y by -1.600000
rotate y by -7.000000
rotate y by -2.800000
rotate x by -1.000000
rotate y by -0.666667
rotate x by -0.400000
rotate y by -0.266667
rotate y by -1.333333
rotate y by -0.533333
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate x by -4.333333
rotate y by -17.333334
rotate x by -1.733333
rotate y by -6.933334
rotate x by -1.000000
rotate y by -2.666667
rotate x by -0.400000
rotate y by -1.066667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -1.333333
rotate y by -0.533333
rotate x by -0.666667
rotate x by -0.266667
rotate y by -2.666667
rotate y by -1.066667
rotate y by -1.000000
rotate y by -0.400000
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate y by -0.666667
rotate x by -0.133333
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -2.333333
rotate x by -0.933333
rotate x by -2.000000
rotate y by -1.000000
rotate x by -0.800000
rotate y by -0.400000
rotate x by -1.000000
rotate x by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by -6.000000
rotate x by -2.400000
rotate y by -0.666667
rotate y by -0.266667
rotate x by -2.000000
rotate x by -0.800000
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.666667
rotate x by -0.666667
rotate x by -0.333333
rotate x by -0.133333
scale by 1.079000
scale by 1.067000
scale by 1.038000
scale by 1.021000
scale by 1.012000
scale by 1.002000
scale by 1.001000
scale by 1.002000
scale by 1.001000
scale by 1.001000
scale by 1.001000
scale by 1.004000
scale by 1.001000
scale by 1.005000
scale by 1.002000
scale by 1.003000
scale by 1.020000
scale by 1.017000
scale by 1.006000
scale by 1.001000
scale by 1.017000
scale by 1.003000
scale by 1.003000
scale by 1.001000
scale by 1.001000
scale by 1.001000
scale by 1.008000
scale by 1.001000
scale by 1.002000
scale by 1.001000
scale by 1.003000
scale by 1.005000
scale by 1.016000
scale by 1.009000
scale by 1.004000
scale by 1.004000
scale by 1.005000
scale by 1.002000
scale by 1.001000
scale by 1.046000
scale by 1.026000
scale by 1.016000
scale by 1.040000
scale by 1.036000
scale by 1.028000
scale by 1.018000
scale by 1.037000
scale by 1.027000
scale by 1.008000
scale by 1.003000
scale by 1.006000
scale by 1.005000
scale by 1.001000
scale by 1.001000
scale by 0.999000
scale by 1.001000
scale by 1.004000
scale by 1.010000
scale by 1.013000
scale by 1.014000
scale by 1.028000
scale by 1.014000
scale by 1.039000
scale by 1.024000
scale by 1.010000
scale by 1.004000
scale by 1.011000
scale by 1.005000
scale by 1.009000
scale by 1.008000
scale by 1.056000
scale by 1.012000
scale by 1.010000
scale by 1.012000
scale by 1.016000
scale by 1.020000
scale by 1.025000
scale by 1.006000
scale by 1.008000
scale by 1.008000
scale by 1.020000
scale by 1.026000
scale by 1.036000
scale by 1.038000
scale by 1.014000
scale by 1.002000
scale by 1.005000
scale by 1.001000
scale by 1.003000
scale by 1.002000
scale by 1.005000
scale by 1.003000
scale by 1.004000
scale by 1.005000
scale by 1.004000
scale by 1.018000
scale by 1.025000
scale by 1.004000
scale by 1.009000
scale by 1.007000
scale by 1.007000
scale by 1.004000
scale by 1.014000
scale by 1.002000
scale by 1.006000
scale by 1.003000
scale by 1.001000
scale by 0.990000
scale by 0.940000
scale by 0.980000
scale by 0.940000
scale by 0.920000
translate by -0.140000 -0.000000 0.000000
translate by -0.340000 -0.000000 0.000000
translate by -0.170000 -0.000000 0.000000
translate by -0.060000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
translate by -0.060000 -0.000000 0.000000
translate by -0.010000 -0.010000 0.000000
translate by -0.030000 -0.000000 0.000000
translate by -0.020000 -0.040000 0.000000
translate by -0.110000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
translate by -0.010000 -0.000000 0.000000
translate by -0.020000 -0.000000 0.000000
translate by -0.020000 -0.030000 0.000000
translate by 0.000000 -0.010000 0.000000
translate by 0.000000 -0.040000 0.000000
translate by 0.000000 -0.320000 0.000000
translate by 0.000000 -0.080000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.010000 0.020000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.080000 0.060000 0.000000
translate by 0.000000 0.050000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.010000 0.020000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.000000 0.010000 0.000000
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -2.333333
rotate x by -0.933333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -1.333333
rotate x by -0.533333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 1.000000
rotate y by 0.400000
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 1.333333
rotate y by 0.533333
rotate y by 1.333333
rotate y by 0.533333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 2.333333
rotate y by 0.933333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -0.666667
rotate x by 0.133333
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -1.000000
rotate x by 0.133333
rotate y by -0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -6.333333
rotate y by -2.533334
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate y by -0.666667
rotate x by 0.133333
rotate y by -0.266667
rotate x by 0.666667
rotate y by -1.333333
rotate x by 0.266667
rotate y by -0.533333
rotate x by 0.666667
rotate y by -1.000000
rotate x by 0.266667
rotate y by -0.400000
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -1.333333
rotate x by 0.133333
rotate y by -0.533333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 1.666667
rotate x by 0.666667
rotate x by 1.666667
rotate x by 0.666667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 1.000000
rotate x by 0.400000
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.666667
rotate x by 0.266667
rotate x by 3.000000
rotate y by 0.666667
rotate x by 1.200000
rotate y by 0.266667
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate x by 0.666667
rotate y by 0.666667
rotate x by 0.266667
rotate y by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 1.666667
rotate x by 0.666667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -3.333333
rotate y by 0.333333
rotate x by -1.333333
rotate y by 0.133333
rotate x by -0.666667
rotate y by 9.333334
rotate x by -0.266667
rotate y by 3.733334
rotate y by 0.666667
rotate y by 0.266667
rotate x by -1.000000
rotate y by 1.666667
rotate x by -0.400000
rotate y by 0.666667
rotate y by 0.666667
rotate y by 0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.666667
rotate y by 1.666667
rotate x by -0.266667
rotate y by 0.666667
rotate x by -0.333333
rotate x by -0.133333
rotate y by 1.333333
rotate y by 0.533333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 1.666667
rotate y by 0.666667
rotate y by 0.666667
rotate y by 0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate y by -0.333333
rotate x by -0.133333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.666667
rotate y by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.666667
rotate y by -0.666667
rotate y by -0.666667
rotate y by -0.266667
rotate x by 0.333333
rotate x by 0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate x by 0.666667
rotate y by -0.666667
rotate x by 0.266667
rotate y by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -1.000000
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -1.000000
rotate x by 0.266667
rotate y by -0.400000
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.666667
rotate y by -1.333333
rotate x by 0.266667
rotate y by -0.533333
rotate y by -0.333333
rotate y by -0.133333
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -2.000000
rotate y by -0.800000
rotate y by -2.666667
rotate y by -1.066667
rotate x by 0.333333
rotate y by -0.333333
rotate x by 0.133333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.666667
rotate x by -0.266667
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by -0.333333
rotate y by -0.133333
rotate x by -0.666667
rotate x by -0.266667
rotate x by -0.333333
rotate x by -0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate x by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.333333
rotate y by 0.333333
rotate x by 0.133333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.666667
rotate y by 0.266667
rotate y by 0.333333
rotate y by 0.133333
rotate x by 0.666667
rotate x by 0.266667
rotate y by 1.000000
rotate y by 0.400000
rotate y by 0.333333
rotate y by 0.133333
rotate x by -1.000000
rotate y by 2.000000
rotate x by -0.400000
rotate y by 0.800000
rotate y by 0.333333
rotate y by 0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 1.000000
rotate x by -0.133333
rotate y by 0.400000
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 1.000000
rotate x by -0.133333
rotate y by 0.400000
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate x by -0.133333
rotate y by 0.333333
rotate y by 0.133333
rotate x by -0.333333
rotate y by 0.333333
rotate x by -0.133333
rotate y by 0.133333
rotate z by 0.333333
rotate z by 0.133333
rotate z by -1.333333
rotate z by -0.533333
rotate z by -0.666667
rotate z by -0.266667
rotate z by -0.333333
rotate z by -0.133333
rotate z by -0.333333
rotate z by -0.133333
rotate z by -0.333333
rotate z by -0.133333
rotate z by -0.333333
rotate z by -0.133333
rotate z by -0.333333
rotate z by -0.133333
scale by 1.200000
scale by 1.200000
translate by 0.010000 0.010000 0.000000
translate by 0.010000 0.010000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.030000 0.020000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.040000 0.010000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.000000 0.010000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.030000 -0.000000 0.000000
translate by 0.020000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
translate by 0.010000 -0.000000 0.000000
