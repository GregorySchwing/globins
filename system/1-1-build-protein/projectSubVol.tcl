package require Orient 1.0
namespace import Orient::orient
set input MYO_HEME_MUT
set output MYO_HEME_MUT_ALIGNED

set solute [mol new $input.pdb waitfor all]
mol addfile $input.pdb mol $solute waitfor all
set all [atomselect top "all"]
set sel [atomselect top "name FE or name NA or name NB or name NC or name ND"]

set FE [atomselect top "name FE"]
set wrongDir [atomselect top "resname HSD and resid 93 and name NE2"]

set FE_COOR [lindex [$FE get {x y z}] 0]
set wrongDir_COOR  [lindex [$wrongDir get {x y z}] 0]

set I [draw principalaxes $sel]  
puts "show/calc the principal axes"   


puts "wrong dir vector [lindex $I 0]"
set Neg_z [vecscale -1.0 [lindex $I 0]]
set Pos_z [vecscale 1.0 [lindex $I 0]]

#Determine which direction to project the z axes
set FE_if_dir [vecadd $FE_COOR $Neg_z]
set FE_else_dir [vecadd $FE_COOR $Pos_z]

#calculate vec distance between the two projections in the z dim
set if_dir_z_dir [vecdist $wrongDir_COOR $FE_if_dir]
set else_z_dir [vecdist $wrongDir_COOR $FE_else_dir]

puts "if_dir_z_dir $if_dir_z_dir"
puts "else_z_dir $else_z_dir"


if {$if_dir_z_dir > $else_z_dir} {
	draw line "$FE_COOR" "$FE_if_dir" width 500
} else {
	draw line "$FE_COOR" "$FE_else_dir" width 500
}

$all writepdb ${output}.pdb


