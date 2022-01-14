#set filename [format $fileformat [expr $start]] 
mol new ./3rgk.pdb
set myo [atomselect top protein]
$myo writepdb ./myoglobin.pdb
set heme [atomselect top heme]
$heme writepdb ./heme.pdb
#set sulfate [atomselect top "resname SO4"]
#$sulfate writepdb ./sulfate.pdb
