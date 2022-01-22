#will need to manually iterate thru the mindistOH and mindistWater setting to get the desired concentration.  likley not need adjust mindist
set mindist 2.4 ; # minimum required distance between all atoms

set SoluteName DIOX
set SolventName ../2-3-min-and-equil-implicit-OPEN_WT/LIQ_BOX_EQ
set input_bin_file_name_box_0 ../2-3-min-and-equil-implicit-OPEN_WT/LIQ_BOX_equilibrated.restart
set output_pdb_psf_file_name MYO_ONE_DIOX
#***************************************************************************


# load solute molecule
set solute [mol new $SoluteName.psf waitfor all]
mol addfile $SoluteName.pdb mol $solute waitfor all

# load solvent molecule
set solvent [mol new $SolventName.psf waitfor all]
mol addfile $SolventName.pdb mol $solvent waitfor all
set pdbCRYST [molinfo $solvent get {a b c alpha beta gamma}]
mol addfile $input_bin_file_name_box_0.coor mol $solvent waitfor all
molinfo $solvent set {a b c alpha beta gamma} $pdbCRYST

set DIOX [atomselect 0 "resname DIOX"]
set DIOX_COOR [lindex [$DIOX get {x y z}] 0]
puts "DIOX_COOR $DIOX_COOR"

set FE [atomselect top "name FE"]
set NC [atomselect top "name NC"]

set FE_COOR [lindex [$FE get {x y z}] 0]
set NC_COOR [lindex [$NC get {x y z}] 0]
puts "NC_COOR $NC_COOR"
puts "FE_COOR $FE_COOR"
set FE_2_NC [vecsub $FE_COOR $NC_COOR ]
set normVecOutOfProt [vecnorm $FE_2_NC]
puts "normVecOutOfProt $normVecOutOfProt"
set 10AFromFe [vecscale 15.0 $normVecOutOfProt]
puts "10AFromFe $10AFromFe"
set newO2Pos [vecadd $FE_COOR $10AFromFe]
puts "newO2Pos $newO2Pos"

$DIOX moveto $newO2Pos

#mol addfile $SoluteName.pdb mol $solute waitfor all
# load solvent box, suitable sized and translated

#mol addfile $SolventName.pdb mol $solvent waitfor all
# merge and transfer solvent box dimensions
set combined [TopoTools::mergemols "$solute $solvent"]
molinfo $combined set {a b c alpha beta gamma} [molinfo $solvent get {a b c alpha beta gamma}]


# define a macro that make it easy to determine the solute
set sel [atomselect $solute all]
atomselect macro solute "index < [$sel num]"
$sel delete


set sel3 [atomselect $combined "(not (same fragment as (exwithin $mindist of solute)))"]

$sel3 writepsf $output_pdb_psf_file_name.psf
$sel3 writepdb $output_pdb_psf_file_name.pdb


