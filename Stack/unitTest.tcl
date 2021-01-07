package require mStack

#Procedure to check Create funtion
proc CheckCreate {{value 60000}} {
    set tokenId [mStack::create $value]
    return $tokenId 
}

#Procedure to check push funtion
proc CheckPush {token value} {
    return [mStack::push $token $value]
}

set passTest 0
set FailTest 0

#Code To check create function
if {[string equal [CheckCreate 5] "TokenNo1"] == 1} {
    if {[string equal [CheckCreate 4] "TokenNo2"]} {
        set passTest [expr $passTest + 1]
    }
}

#Code To check delete and checkToken function
if {[mStack::delete "TokenNo1"] == 1} {
    if {[CheckPush "TokenNo1" 50] == -2} {
        set passTest [expr $passTest + 2]
    }
}

#code To check push and pop function 
for {set i 0} {$i < 4} {incr i} {
    if {[CheckPush "TokenNo2" $i] != 1 } {
        break
    }
}
if {$i == 4 && [CheckPush "TokenNo2" 5] == -1} {
    set i [expr $i-1]
    for {set j 3} {$j>=0} {incr j -1} {
        if {[mStack::pop "TokenNo2"] != $i} {
            break
        }
        set i [expr $i-1]
    }
    if {$i == -1 && $j == -1} {
        set passTest [expr $passTest + 4]
    }
}
if {$passTest == 7} {
    puts "All Test are successfull"
} elseif {$passTest == 3} {
    puts "Defect in either push or pop"
} elseif {$passTest == 1} {
    puts "Defect in either push or pop and either delete or checkToken"
} elseif {$passTest == 0} {
    puts "Defect in all functions"
}