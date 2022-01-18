package require solvate

set molname MYO_HEME_WT_ALIGNED
set molnameSolv implicit_solv_box
set molnameSolvShifted implicit_solv_box_SHIFTED

mol new ../1-1-build-protein/${molname}.psf
mol addfile ../1-1-build-protein/${molname}.pdb

### Determine the geometric center of the molecule and store the coordinates
set cen [measure center [atomselect top all]]
puts "CENTER: $cen" 
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
set max_plus_20_doubled [expr 2*($max + 20)]
puts "MAX + 20: " 
puts $max_plus_20_doubled
set min [format "{%.4f %.4f %.4f}" 0.0 0.0 0.0]
set max [format "{%.4f %.4f %.4f}" $max_plus_20_doubled $max_plus_20_doubled $max_plus_20_doubled]
set minmaxArg [format "{{%.4f %.4f %.4f} {%.4f %.4f %.4f}}" 0.0 0.0 0.0 $max_plus_20_doubled $max_plus_20_doubled $max_plus_20_doubled]
solvate -minmax {{1.0000 1.0000 1.0000} {94.2443 94.2443 93.2443}} -o $molnameSolv

mol delete top

mol new ${molnameSolv}.psf
mol addfile ${molnameSolv}.pdb

set box [pbc get]
regexp -- {\{(\S+) (\S+) (\S+)} $box null xAx yAx zAx
set halfX [expr $xAx/2]
set halfY [expr $yAx/2]
set halfZ [expr $zAx/2]
set transformationVector [list $halfX $halfY $halfZ]
set sel [atomselect top all]
$sel moveby $transformationVector
$sel writepdb ${molnameSolvShifted}.pdb
$sel writepsf ${molnameSolvShifted}.psf
