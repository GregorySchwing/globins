#will need to manually iterate thru the mindistOH and mindistWater setting to get the desired concentration.  likley not need adjust mindist
set mindist 2 ; # minimum required distance between all atoms

set SolventName GEMC_NVT_water_O2_liq
set SoluteName MYO_HEME_SHIFTED

set output_pdb_psf_file_name MYO_HEME_SHIFTED_SOLVATED
#***************************************************************************


# load solute molecule
set solute [mol new $SoluteName.psf waitfor all]
mol addfile $SoluteName.pdb mol $solute waitfor all

# load solvent molecule
set solvent [mol new $SolventName.psf waitfor all]
mol addfile $SolventName.pdb mol $solvent waitfor all


mol addfile $SoluteName.pdb mol $solute waitfor all
# load solvent box, suitable sized and translated

mol addfile $SolventName.pdb mol $solvent waitfor all
# merge and transfer solvent box dimensions
set combined [TopoTools::mergemols "$solute $solvent"]
molinfo $combined set {a b c alpha beta gamma} [molinfo $solvent get {a b c alpha beta gamma}]


# define a macro that make it easy to determine the solute
set sel [atomselect $solute all]
atomselect macro solute "index < [$sel num]"
$sel delete


set sel3 [atomselect $combined "(not (same fragment as (exwithin $mindist of solute)))"]
delatom $sel3


$sel3 writepsf $output_pdb_psf_file_name.psf
$sel3 writepdb $output_pdb_psf_file_name.pdb


