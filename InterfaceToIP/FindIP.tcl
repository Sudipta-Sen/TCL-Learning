#Procedure to find ipv4 address in windows
proc InterfaceToIPv4AddressWindows {interafceName} {

        set InterfaceFound 0
        set ipv4Found 0
        set interafceName [string map {* .} $interafceName]
        append interafceName ":"

        # Iterate through the output of the command ipconfig /all
        foreach Tline [split [exec ipconfig /all] "\n"] {
                
                set line [string map {* .} $Tline]
                
                #This if block is executed only after the given interface is found
                if {$InterfaceFound == 1} {

                        #Find the line with IPv4 address
                        if { [regexp "IPv4 Address" $line] == 1} {
                                
                                #pick up the ip with regular expression
                                regexp "(((0|1|2|3|4|5|6|7|8|9){1,3}\.){3}(0|1|2|3|4|5|6|7|8|9){1,3})" $line ip
                                set ipv4Found 1
                                set skipBlankLine  1

                                #break the for loop as we have found the desired IPv4 address
                                break

                        }
                        if {[regexp "^ " $line] == 0 } {

                                #Skip the Blank line that appears after the interface name
                                if {$skipBlankLine == 0} {
                                        set skipBlankLine  1
                                } else {
                                        #Break the loop after the 2nd blank line found
                                        #2nd blank line means the interface details are finished 
                                        break
                                }
                        }
                }
                
                if {[regexp $interafceName $line] == 1} {

                        #When the interface name is found, set InterfaceFound variable to true i.e 1
                        set InterfaceFound 1
                        set skipBlankLine 0
                }
        }

        set ret [returnValue $InterfaceFound $ipv4Found]
        if {$ret == 1} {
                return $ip
        } else {
                return $ret
        }

}

#Procedure to find ipv4 address in linux
proc InterfaceToIPv4AddressLinux {interafceName} {

        set InterfaceFound 0
        set ipv4Found 0

        append interafceName ":"
        # Iterate through the output of the command ifconfig -a
        foreach line [split [exec ifconfig -a] "\n"] {

                #This if block is executed only after the given interface is found
                if {$InterfaceFound == 1} {

                        #Find the line with IPv4 address
                        if {[regexp "inet " $line] == 1} {

                                #pick up the ip with regular expression
                                regexp "inet (((0|1|2|3|4|5|6|7|8|9){1,3}\.){3}(0|1|2|3|4|5|6|7|8|9){1,3})" $line match ip
                                set ipv4Found 1

                                #break the for loop as we have found the desired IPv4 address
                                break
                        }
                        if {[regexp "^ " $line] == 0} {

                                #break the loop when details of another interafce appears
                                break
                        }
                }
                if {[regexp $interafceName $line] == 1} {

                        #When the interface name is found, set InterfaceFound variable to true i.e 1
                        set InterfaceFound 1
                }
        }

        set ret [returnValue $InterfaceFound $ipv4Found]
        if {$ret == 1} {
                return $ip
        } else {
                return $ret
        }
        
}

proc returnValue {InterfaceFound ipv4Found} {

        if { $InterfaceFound == 0} {

                # -1 means interface with the given name is not present
                return -1
        } elseif {$ipv4Found == 0} {

                # -2 means the interface is present but no IPv4 address is present 
                return -2
        } else {

                # the interface is present and IPv4 address is also assigned
                return 1
        }
}
set ostype $tcl_platform(os)
if {$argc == 0} {
        # If number of command line argument is 0, the print ip addresses of available interfaces
        if { [regexp -nocase "Linux" $ostype match] == 1} {
                foreach line [split [exec ifconfig -a] "\n"] {
                        if { [regexp "^ " $line] == 0 && [string length $line] > 0} {
                                set temp [split $line]
                                set details [split $temp ":"]
                                set interfaceName [lindex $details 0]
                                set output [InterfaceToIPv4AddressLinux [lindex $details 0]]
                                if { $output == -2 } {
                                        set ipv4 "No ipv4 address assigned"
                                        puts "$interfaceName $ipv4"
                                } elseif {$output != -1} {
                                        set ipv4 $output
                                        puts "$interfaceName: $ipv4"
                                }
                                
                        }
                }
        } elseif { [regexp -nocase "Windows" $ostype match] == 1} {
                foreach line [split [exec ipconfig /all] "\n"] {
                        if { [regexp "^ " $line] == 0 && [string length $line] > 0} {
                                set details [split $line ":"]
                                set interfaceName [lindex $details 0]
                                set output [InterfaceToIPv4AddressWindows [lindex $details 0]]
                                if { $output == -2 } {
                                        set ipv4 "No ipv4 address assigned"
                                        puts "$interfaceName: $ipv4"
                                } elseif {$output != -1} {
                                        set ipv4 $output
                                        puts "$interfaceName: $ipv4"
                                }
                                
                        }
                }
        } else {
                puts "OS is not recognized"
        }
        
} elseif {$argc == 1} {
        # If user passes an interface name as command line argument then print the ip of that interface only
        if { [regexp -nocase "Linux" $ostype match] == 1} {
                set output [InterfaceToIPv4AddressLinux [lindex $argv 0]] 
        } elseif { [regexp -nocase "Windows" $ostype match] == 1} {
                set output [InterfaceToIPv4AddressWindows [lindex $argv 0]]
        }

        if {$output == -1} {
                puts "[lindex $argv 0]: Interface is not present"
        } elseif {$output == -2} {
                puts "[lindex $argv 0]: No ipv4 address assigned"
        } else {
                puts "[lindex $argv 0]: $output"
        }
} else {
        # If more than one argument is passed then print a error message
        puts "Invalid Number of arguments"
}