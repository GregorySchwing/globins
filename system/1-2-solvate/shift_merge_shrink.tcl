#will need to manually iterate thru the mindistOH and mindistWater setting to get the desired concentration.  likley not need adjust mindist
set mindist 2.4 ; # minimum required distance between all atoms

set SolventName GCMC_water_O2_liq_seg_fix_atom_type_fix
set SoluteName MYO_HEME_MUT_ALIGNED_SHIFTED
#set SoluteName MYO_HEME_SHIFTED

set output_pdb_psf_file_name test
#***************************************************************************
# load solute molecule
set solute [mol new $SoluteName.psf waitfor all]
mol addfile $SoluteName.pdb mol $solute waitfor all

# load solvent molecule
set solvent [mol new $SolventName.psf waitfor all]
mol addfile $SolventName.pdb mol $solvent waitfor all

set allSolvent [atomselect $solvent all]
set minmax [measure minmax $allSolvent]
set vec [vecsub [lindex $minmax 1] [lindex $minmax 0]] 
puts "cellBasisVector1 [lindex $vec 0] 0 0"
puts "cellBasisVector2 0 [lindex $vec 1] 0"
puts "cellBasisVector3 0 0 [lindex $vec 2]"
set center [measure center $allSolvent]
puts "cellOrigin $center"
set a [lindex $vec 0] 
set b [lindex $vec 1] 
set c [lindex $vec 2] 


set boxCenter [vecsub [lindex $minmax 1] [lindex $minmax 0]] 
puts "boxCenter : $boxCenter"
set absCartOrigin [vecsub $absCartOrigin 0.5] 
puts "absCartOrigin : $absCartOrigin"
set transvecBox [vecsub $absCartOrigin $center] 
$allSolvent moveby $transvec

set prot [atomselect $solute all]
set centerProt [measure center $prot]
set transvec [vecsub $absCartOrigin $centerProt] 
$prot moveby $transvec
#mol addfile $SoluteName.pdb mol $solute waitfor all
# load solvent box, suitable sized and translated

#mol addfile $SolventName.pdb mol $solvent waitfor all
# merge and transfer solvent box dimensions
set combined [TopoTools::mergemols "$solute $solvent"]

molinfo $combined set {a b c alpha beta gamma} {$a $b $c 90 90 90}

# define a macro that make it easy to determine the solute
set sel [atomselect $solute all]
atomselect macro solute "index < [$sel num]"
$sel delete


set defInf [molinfo $solvent get {a b c alpha beta gamma}]

set defInf [lreplace $defInf 0 0 $a/2]
set defInf [lreplace $defInf 1 1 $b/2]
set defInf [lreplace $defInf 2 2 $c/2]

molinfo $combined set {a b c alpha beta gamma} $defInf]

# define a macro that make it easy to determine the solute
set sel [atomselect $solute all]
atomselect macro solute "index < [$sel num]"
$sel delete

set sel3 [atomselect $combined "(not (same fragment as (exwithin $mindist of solute)))"]

$sel3 writepsf $output_pdb_psf_file_name.psf
$sel3 writepdb $output_pdb_psf_file_name.pdb


