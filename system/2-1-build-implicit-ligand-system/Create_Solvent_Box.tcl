package require solvate

set molname MYO_HEME_WT_ALIGNED

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
solvate -minmax {{0.0000 0.0000 0.0000} {92.2443 92.2443 92.2443}} -o implicit_solv_box
