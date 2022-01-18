package require solvate

set molname MYO_HEME_WT_ALIGNED
set molnameSolv implicit_solv_box
set molnameSolvShifted implicit_solv_box_SHIFTED
set molnameSoluteMUT MYO_HEME_MUT_ALIGNED
set molnameSoluteShiftedMUT MYO_HEME_MUT_ALIGNED_SHIFTED
set molnameSoluteWT MYO_HEME_WT_ALIGNED
set molnameSoluteShiftedWT MYO_HEME_WT_ALIGNED_SHIFTED

set system [mol new ../1-1-build-protein/${molname}.psf waitfor all]
mol addfile ../1-1-build-protein/${molname}.pdb mol $system waitfor all
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
solvate -minmax {{1.0000 1.0000 1.0000} {93.2443 93.2443 93.2443}} -o $molnameSolv

mol delete top
resetpsf 

set system [mol new ${molnameSolv}.psf waitfor all]
mol addfile ${molnameSolv}.pdb mol $system waitfor all

set box [pbc get]
regexp -- {\{(\S+) (\S+) (\S+)} $box null xAx yAx zAx
set halfX [expr $xAx/2]
set halfY [expr $yAx/2]
set halfZ [expr $zAx/2]
set trueOrigin [list $halfX $halfY $halfZ]
set cen [measure center [atomselect top all]]
puts "CENTER: $cen" 
set x1 [lindex $cen 0]
set y1 [lindex $cen 1]
set z1 [lindex $cen 2]
puts "x1 $x1"
puts "y1 $y1"
puts "z1 $z1"

set max 0

set geoCenter [list $x1 $y1 $z1]

set transformationVector [vecsub $trueOrigin $geoCenter]
set all [atomselect top "all"]
$all moveby $transformationVector
$all writepdb ${molnameSolvShifted}.pdb
$all writepsf ${molnameSolvShifted}.psf

mol delete top
resetpsf 

set system [mol new ${molnameSolvShifted}.psf waitfor all]
mol addfile ${molnameSolvShifted}.pdb mol $system waitfor all

set box [pbc get]
regexp -- {\{(\S+) (\S+) (\S+)} $box null xAx yAx zAx
set halfX [expr $xAx/2]
set halfY [expr $yAx/2]
set halfZ [expr $zAx/2]
set trueOrigin [list $halfX $halfY $halfZ]
puts " trueOrigin $trueOrigin"

set prot [mol new ../1-1-build-protein/${molnameSoluteMUT}.psf waitfor all]
mol addfile ../1-1-build-protein/${molnameSoluteMUT}.pdb mol $prot waitfor all

set cen [measure center [atomselect top "protein or heme"]]
puts "CENTER: $cen" 
set x1 [lindex $cen 0]
set y1 [lindex $cen 1]
set z1 [lindex $cen 2]
puts "x1 $x1"
puts "y1 $y1"
puts "z1 $z1"
set geoCenter [list $x1 $y1 $z1]
puts " geoCenter $geoCenter"
puts " trueOrigin $trueOrigin"
set transformationVector [vecsub $trueOrigin $geoCenter]
puts "transformationVector $transformationVector"
set protShift [atomselect top "protein or heme"]
$protShift moveby $transformationVector
$protShift writepdb ${molnameSoluteShiftedMUT}.pdb
$protShift writepsf ${molnameSoluteShiftedMUT}.psf

mol delete top
resetpsf 

set system [mol new ${molnameSolvShifted}.psf waitfor all]
mol addfile ${molnameSolvShifted}.pdb mol $system waitfor all

set box [pbc get]
regexp -- {\{(\S+) (\S+) (\S+)} $box null xAx yAx zAx
set halfX [expr $xAx/2]
set halfY [expr $yAx/2]
set halfZ [expr $zAx/2]
set trueOrigin [list $halfX $halfY $halfZ]
puts " trueOrigin $trueOrigin"

set prot [mol new ../1-1-build-protein/${molnameSoluteWT}.psf waitfor all]
mol addfile ../1-1-build-protein/${molnameSoluteWT}.pdb mol $prot waitfor all

set cen [measure center [atomselect top "protein or heme"]]
puts "CENTER: $cen" 
set x1 [lindex $cen 0]
set y1 [lindex $cen 1]
set z1 [lindex $cen 2]
puts "x1 $x1"
puts "y1 $y1"
puts "z1 $z1"
set geoCenter [list $x1 $y1 $z1]
puts " geoCenter $geoCenter"
puts " trueOrigin $trueOrigin"
set transformationVector [vecsub $trueOrigin $geoCenter]
puts "transformationVector $transformationVector"
set protShift [atomselect top "protein or heme"]
$protShift moveby $transformationVector
$protShift writepdb ${molnameSoluteShiftedWT}.pdb
$protShift writepsf ${molnameSoluteShiftedWT}.psf

