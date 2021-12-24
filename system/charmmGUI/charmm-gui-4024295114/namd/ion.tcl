  set pdbfile step3_input.pdb
  set psffile step3_input.psf
  set prefix step3_input_O2
  set mode "neutralize"
  set gasList {OP}
  set chargeList {0.021 -0.021}
  set sel [atomselect top "water and noh"]
  set nWater [$sel num]
  $sel delete
  set O2Frac 0.20
  set nGas [expr round($nWater*O2Frac)]
  set from 5
  set between 2
  set nIonsList { }
  set segname DIOX
  lappend nIonsList [list $gasList $chargeList $nGas]

# Read in system
  puts "Autoionize) Reading ${psffile}/${pdbfile}..."
  resetpsf
  readpsf $psffile
  coordpdb $pdbfile
  mol new $psffile type psf waitfor all
  mol addfile $pdbfile type pdb waitfor all

  # Get pbc info for later
  set xdim [molinfo top get a]
  set ydim [molinfo top get b]
  set zdim [molinfo top get c]

  # Compute net charge of the system
  set sel [atomselect top all]
  set netCharge [eval "vecadd [$sel get charge]"]
  set roundNetCharge [expr round($netCharge)]
  $sel delete
  puts "Autoionize) System net charge before adding ions: ${netCharge}e."

  set done 0 ;# flag to tell if there are ions to be placed
  set nCation 0
  set nAnion 0

  # For each ion placement mode, calculate the number of each ion
  # and set the nIonsList accordingly.

  ###
  ### Ion placement mode 'neutralize'. Also called in combination 
  ### with other modes.
  ###
  if {$mode != "nions"} {

    # XXX - The following implementation will work only for ions with 
    #       charge -2, -1, +1, and +2. 

    set errflag 0
    if {$roundNetCharge > 0} {
      if {$anionCharge == -1} {
        set nAnion $roundNetCharge
        set nCation 0
      } elseif {$anionCharge == -2} {
        if {[expr {$roundNetCharge % 2}] == 0} { ;# total charge is even
          set nAnion [expr {$roundNetCharge / 2}]
          set nCation 0
        } else { ;# total charge is odd
          if {$cationCharge == 1} {
            set nAnion [expr {1+int($roundNetCharge/2)}]
            set nCation 1
          } else {
            set errflag 1
          }
        }
      }
    } elseif {$roundNetCharge < 0} {
      set roundNetChargeAbs [expr {-1*$roundNetCharge}]
      if {$cationCharge == 1} {
        set nAnion 0
        set nCation $roundNetChargeAbs
      } elseif {$cationCharge == 2} {
        if {[expr {$roundNetChargeAbs % 2}] == 0} { ;# total charge is even
          set nAnion 0
          set nCation [expr {$roundNetChargeAbs / 2}]
        } else { ;# total charge is odd
          if {$anionCharge == -1} {
            set nAnion 1
            set nCation [expr {1+int($roundNetChargeAbs/2)}]
          } else {
            set errflag 1
          }
        }
      }
    } elseif {$mode == "neutralize"} { ;# we were only requested to neutralize
      puts "Autoionize) The system is already neutral."
      set done 1
    }

    # FIXME -- Maybe do the best possible job instead of bailing out...
    if {$errflag == 1} {
      error "Autoionize) ERROR: Could not neutralize system."
    }

    if {$done == 0} {
      puts "Autoionize) Number of ions required for neutralizing the system: $nCation $cation and $nAnion $anion."
      set newTotalCharge [expr $nAnion * $anionCharge + $nCation * $cationCharge + $roundNetCharge]
      if {$newTotalCharge != 0} {
        error "Autoionize) ERROR: Could not neutralize system."
      }
    }
    #puts "DEBUG:   Ionized system would have charge $newTotalCharge"

  }

  ###
  ### Ion placement modes 'sc' = salt concentration
  ###                     'is' = ionic strength
  ###
  if {$mode == "sc"} {
    puts "Autoionize) Desired salt concentration: ${saltConcentration} mol/L."
  } elseif {$mode == "is"} {
    puts "Autoionize) Desired ionic strength: ${ionicStrength} mol/L."
  }
  
  if {$mode == "sc" || $mode == "is"} {

    set sel [atomselect top "water and noh"]
    set nWater [$sel num]
    $sel delete

    if {$nWater == 0} {
      error "Autoionize) ERROR: Cannot add ions to unsolvated system."
    }

    # Guess chemical formula. 
    # XXX - We currently only support ions with charge -2, -1, +1, and +2.
    if {$cationCharge == 1 && $anionCharge == -1} { ;# e.g., NaCl, KCl, ...
      set cationStoich 1
      set anionStoich 1
    } elseif {$cationCharge == 2 && $anionCharge == -1} { ;# e.g., MgCl2
      set cationStoich 1
      set anionStoich 2
    } elseif {$cationCharge == 1 && $anionCharge == -2} {
      set cationStoich 2
      set anionStoich 1
    } elseif {$cationCharge == 2 && $anionCharge == -2} {
      set cationStoich 1
      set anionStoich 1
    } else {
      error "Autoionize) ERROR: Unsupported ion charge; cannot guess chemical formula."
    }

    if {$mode == "is"} { ;# convert ionic strength to salt concentration
      set cationConcentration [expr {2 * $ionicStrength / ( sqrt($cationCharge * $cationCharge * $anionCharge * $anionCharge) + $cationCharge * $cationCharge)}]
      set saltConcentration [expr {$cationConcentration * $cationStoich}]
    }

    # As long as saltConcentration and ionicStrength are non-negative,
    # no error checking is needed here...
    set num [expr {int(0.5 + 0.0187 * $saltConcentration * $nWater)}]
    set nCation [expr {$nCation + $cationStoich * $num}]
    set nAnion [expr {$nAnion + $anionStoich * $num}]

  }

  if {$mode != "nions"} {
    if {$nCation > 0} {
      lappend nIonsList [list $cation $cationCharge $nCation]
    } 
    if {$nAnion > 0} {
      lappend nIonsList [list $anion $anionCharge $nAnion]
    }
    if {$nCation == 0 && $nAnion == 0} {
      # Just in case the system is neutral and the requested ionic
      # strength or salt concentration is zero, in which case the
      # behavior is the same as -neutralize, i.e., copy files and exit
      # normally.
      set done 1
    }
    if {$nCation < 0 || $nAnion < 0} {
      error "Autoionize) ERROR: Internal error; negative number of ions."
    }
  }
  set done 0
  if {$done == 1} {
    puts "Autoionize) Nothing to be done; copying system to ${prefix}.psf/${prefix}.pdb..."
    file copy -force $psffile ${prefix}.psf
    file copy -force $pdbfile ${prefix}.pdb
  } else {

    puts "Autoionize) Ions to be placed:"
    set nIons 0
    foreach ion $nIonsList {
      puts "Autoionize)   [lindex $ion 2] [lindex $ion 0]"
      set nIons [expr {$nIons + [lindex $ion 2]}]
    }
    puts "NIONS $nIons"
    puts "Autoionize) Required min distance from molecule: ${from}A."
    puts "Autoionize) Required min distance between ions: ${between}A."
    puts "Autoionize) Output file prefix \'${prefix}\'."

    # Make sure requested segname does not already exist
    set seltest [atomselect top "segname $segname"]
    if { [$seltest num] != 0 } {
      set segnameOK 0
      set segnameWarn 1
    } else {
      set segnameOK 1
      set segnameWarn 0
    }
    $seltest delete
  
    # If segname is duplicate, try using instead ION1, ION2, ...
    if {$segnameOK == 0} {
      for {set i 1} {$i <= 9} {incr i} { 
        set tryseg "ION${i}"
        set seltest [atomselect top "segname $tryseg"]
        if { [$seltest num] == 0 } {
          set segname $tryseg
          set segnameOK 1
          $seltest delete
          break
        }
        $seltest delete
      }
    }
  
    # If segname is still duplicate, try using instead IN1, IN2, ...
    if {$segnameOK == 0} {
      for {set i 1} {$i <= 99} {incr i} {
        set tryseg "IN${i}"
        set seltest [atomselect top "segname $tryseg"]
        if { [$seltest num] == 0 } {
          set segname $tryseg
          set segnameOK 1
          $seltest delete
          break
        }
        $seltest delete
      }
    }
  
    if {$segnameWarn} {
      if {$segnameOK} {
        puts "Autoionize) WARNING: Ions will be added to segname $segname to avoid duplication."
      } else {
        error "Autoionize) ERROR: Could not determine a segname to avoid duplication."
      }
    } else {
      puts "Autoionize) Ions will be added to segname $segname."
    }

    # Find water oxygens to replace with ions

    set nTries 0
    while {1} {
      set ionList {}
      set ionList2 {}
      set sel [atomselect top "noh and water and not (within $from of not water)"]
      set watIndex [$sel get index]
      set watSize [llength $watIndex]
  
      set count 0
  
      while {[llength $ionList] < $nIons} {
        if {!$watSize} {break}
        set thisIon [lindex $watIndex [expr int($watSize * rand())]]
        if {[llength $ionList]} {
          set tempsel [atomselect top "index [concat $ionList] and within $between of (index $thisIon)"]
        } else {
          set tempsel [atomselect top "water and not water"]
        }
        if {![$tempsel num]} {
          lappend ionList $thisIon
	  lappend ionList2 [expr $thisIon + 1]
        }
        $tempsel delete
      }
      $sel delete
      if {[llength $ionList] == $nIons} {break}
      incr nTries
      if {$nTries == $maxTries} {
        puts "Autoionize) ERROR: Failed to add ions after $maxTries tries"
        puts "Autoionize) Try decreasing -from and/or -between parameters,"
        puts "Autoionize) decreasing ion concentration, or adding more water molecules..."
        exit
      }	
    }
    puts "Autoionize) Obtained positions for $nIons ions."

    # Select and delete the waters but store the coordinates!
    set sel [atomselect top "index $ionList"]
    set sel2 [atomselect top "index $ionList2"]

    set waterPos [$sel get {x y z}]
    set hPos [$sel2 get {x y z}]
    set newHPos {}
    set O2BondLength 1.16
	### TOPOGLOGY SPECIFIC CODE - X - O
	#https://math.stackexchange.com/questions/175896/finding-a-point-along-a-line-a-certain-distance-away-from-another-point
    foreach pos1 [lrange $waterPos 0 20] pos2 [lrange $hPos 0 20] {
	# stretch bond vector isotropically
	# Norm(x2-x1) = v/||v||
	set normalizedVec [vecnorm [vecsub $pos2 $pos1]]
	# c*v/||v||
	set scaled [vecscale $O2BondLength $normalizedVec]
	# x2* = x1 + c*v/||v||, dist(x2*, x1) = O2BondLength
	set newCoords [vecadd $pos1 $scaled]
	### TOPOGLOGY SPECIFIC CODE - X - O
 	lappend newHPos $newCoords
    }	
    set num1 [llength $waterPos]
    puts "Autoionize) Tagged ${num1} water molecules for deletion."
  
    set num1 0
    foreach segid [$sel get segid] resid [$sel get resid] {
      delatom $segid $resid
      incr num1
    }
    puts "Autoionize) Deleted ${num1} water molecules."

    # Read in topology file
    puts "Autoionize) Reading CHARMM topology file..."
    set topfile [file join $env(CHARMMTOPDIR) top_all27_prot_lipid_na.inp]
    topology $topfile
    topology ./DIOX.top
    # Make topology entries
    set resid 1
    segment $segname {
      first NONE
      last NONE
      foreach ion $nIonsList {
        set resname DIOX
        set num [lindex $ion 2]
        for {set i 0} {$i < $num} {incr i} {
          residue $resid $resname
          incr resid
        }
      }
    }

    # Assign ion coordinates
    puts "Autoionize) Assigning ion coordinates..."
    set resid 1
    foreach ion $nIonsList {
      set name [lindex $ion 0]
      set startpos [expr {$resid - 1}]
      set endpos [expr {[lindex $ion 2] - 1 + $startpos}]
      foreach pos [lrange $waterPos $startpos $endpos] pos2 [lrange $newHPos $startpos $endpos] {
        puts "DEBUG: coord $segname $resid $name $pos"
        coord $segname $resid OP $pos
        coord $segname $resid ON $pos2
        incr resid
      }
    }
    
    writepsf $prefix.psf
    writepdb $prefix.pdb

  }

  # Update displayed molecule
  puts "Autoionize) Loading new system with added ions..."
  mol delete top
  mol new $prefix.psf type psf waitfor all
  mol addfile $prefix.pdb type pdb waitfor all

  # Re-write the pdb including periodic cell info
  molinfo top set a $xdim
  molinfo top set b $ydim
  molinfo top set c $zdim
  set sel [atomselect top all]
  $sel writepdb $prefix.pdb 

  # Re-compute net charge of the system
  set netCharge [eval "vecadd [$sel get charge]"]
  $sel delete
  puts "Autoionize) System net charge after adding ions: ${netCharge}e."
  if {[expr abs($netCharge - round($netCharge))] > 0.001} {
    if {[winfo exists .autoigui]} {
      tk_messageBox -icon warning -message "System has a non-integer total charge. There was likely a problem in the process of building it."
    } else {
      puts "Autoionize) WARNING: System has a non-integer total charge. There was likely a problem in the process of building it."
    }
  }
    
  puts "Autoionize) All done."

