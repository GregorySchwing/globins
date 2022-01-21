#will need to manually iterate thru the mindistOH and mindistWater setting to get the desired concentration.  likley not need adjust mindist
set mindist 2.4 ; # minimum required distance between all atoms

set SolventNamePDB ../1-4-solvate-protein/LIQ_BOX_NPT_EQ_SHIFTED
set SolventNamePSF ../1-4-solvate-protein/LIQ_BOX_NPT_EQ_SHIFTED
set SoluteName MYO_HEME_MUT_ALIGNED_SHIFTED

set output_pdb_psf_file_name MYO_HEME_MUT_ALIGNED_SHIFTED_SOLVATED
#***************************************************************************


# load solute molecule
set solute [mol new $SoluteName.psf waitfor all]
mol addfile $SoluteName.pdb mol $solute waitfor all

# load solvent molecule
set solvent [mol new $SolventNamePSF.psf waitfor all]
mol addfile $SolventNamePDB.pdb mol $solvent waitfor all

set all [atomselect top "all"]

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


