package require solvate

set molname step3_input_O2

mol new ${molname}.psf
mol addfile ${molname}.pdb

### Determine the geometric center of the molecule and store the coordinates
set cen [measure center [atomselect top all]]
puts "CENTER: " $cen
set x1 [lindex $cen 0]
set y1 [lindex $cen 1]
set z1 [lindex $cen 2]
set max 0

### Determine the distance of the farthest atom from the geometric center of the protein
foreach atom [[atomselect top protein] get index] {
  set pos [lindex [[atomselect top "index $atom"] get {x y z}] 0]
  set x2 [lindex $pos 0]
  set y2 [lindex $pos 1]
  set z2 [lindex $pos 2]
  set dist [expr pow(($x2-$x1)*($x2-$x1) + ($y2-$y1)*($y2-$y1) + ($z2-$z1)*($z2-$z1),0.5)]
  puts $dist
  if {$dist > $max} {set max $dist}
  }
puts "MAX: " 
puts $max
set max_plus_1 [expr $max + 1]
puts "MAX + 1: " 
puts $max_plus_1
set molnameSolv MYO_HEME_WATER

set box [pbc get]
regexp -- {\{(\S+) (\S+) (\S+)} $box null xAx yAx zAx
set halfX [expr $xAx/2]
set halfY [expr $yAx/2]
set halfZ [expr $zAx/2]
set newOrigin [list $halfX $halfY $halfZ]
puts "cen $cen"
puts "newOrigin $newOrigin"
set transformationVector [vecsub $newOrigin $cen]
set sel [atomselect top all]
$sel moveby $transformationVector
set molnameShifted MYO_HEME_WATER_SHIFTED

$sel writepdb ${molnameShifted}.pdb
$sel writepsf ${molnameShifted}.psf




