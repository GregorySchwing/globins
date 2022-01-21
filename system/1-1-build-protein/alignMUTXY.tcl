package require Orient 1.0
namespace import Orient::orient
set input MYO_HEME_MUT
set output MYO_HEME_MUT_ALIGNED

set solute [mol new $input.psf waitfor all]
mol addfile $input.pdb mol $solute waitfor all
set all [atomselect top "all"]
set sel [atomselect top "name FE or name NA or name NB or name NC or name ND"]


set I [draw principalaxes $sel]  
puts "show/calc the principal axes"   
set A [orient $sel [lindex $I 0] {0 1 0}]
puts "rotate axis 1 to match Y"
$all move $A
puts "recalc principal axes to check"
set I [draw principalaxes $sel]
puts "rotate axis 2 to match X"
set A [orient $sel [lindex $I 1] {1 0 0}]
$all move $A
puts "recalc principal axes to check"
set I [draw principalaxes $sel]

$all writepdb ${output}.pdb
$all writepsf ${output}.psf

