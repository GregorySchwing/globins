set input MYO_HEME
set inputDummy dummy

set solute [mol new $input.pdb waitfor all]
mol addfile $input.pdb mol $solute waitfor all

set representation1 [atomselect top "resname HSD or resname HSE or heme"]

set all [atomselect top "all"]

set FE [atomselect top "name FE"]
set H [atomselect top "resname HSD and resid 93 and name NE2"]

set NA [atomselect top "name NA"]
set NB [atomselect top "name NB"]
set NC [atomselect top "name NC"]
set ND [atomselect top "name ND"]

set FE_COOR [lindex [$FE get {x y z}] 0]
set H_COOR  [lindex [$H get {x y z}] 0]

set NA_COOR [lindex [$NA get {x y z}] 0]
set NB_COOR [lindex [$NB get {x y z}] 0]
set NC_COOR [lindex [$NC get {x y z}] 0]
set ND_COOR [lindex [$ND get {x y z}] 0]

set ND_2_NC [vecsub $ND_COOR $NC_COOR]

set ND_2_NC_list [join $ND_2_NC " "]
puts ($ND_2_NC_list)

set ND_2_NC_x [lindex $ND_2_NC_list 0]
set ND_2_NC_y [lindex $ND_2_NC_list 1]
set ND_2_NC_z [lindex $ND_2_NC_list 2]

puts "$ND_2_NC_x $ND_2_NC_y $ND_2_NC_z"

set newcoords {}

lappend newcoords $ND_2_NC_x
lappend newcoords $ND_2_NC_y
lappend newcoords $ND_2_NC_z

set moveM [transmult [transvec $newcoords] [transvecinv $newcoords]]

$all move $moveM 

set FE_COOR [lindex [$FE get {x y z}] 0]
set H_COOR  [lindex [$H get {x y z}] 0]

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

set FE_2_H [vecsub $FE_COOR $H_COOR]
set FE_2_H_unit [vecnorm $FE_2_H]
set FE_2_H_unit_flipped [vecscale 1.25 $FE_2_H_unit]

set dum_COOR_cen [vecadd $FE_COOR $FE_2_H_unit_flipped]

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



