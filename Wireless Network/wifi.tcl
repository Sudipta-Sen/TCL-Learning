#=======================================================================================
# Name: createWLANProfile
#
# Args: 
#       fp:                     filepointer of the xml file
#       SSID:                   SSID of the network
#       Authentication Type:    Authentication Type of the wireless network
#       password:               Password to connect to the wireless network
#
# Return: 
#       Null
#
# Purpose:
#       Create configuration file for wireless network
#=======================================================================================

proc createWLANProfile { fp SSID Authentication password} {
    puts $fp "<?xml version=\"1.0\"?>"
    puts $fp "<WLANProfile xmlns=\"http://www.microsoft.com/networking/WLAN/profile/v1\">"
    puts $fp "\t<name>$SSID</name>"
    puts $fp "\t<SSIDConfig>"
    puts $fp "\t\t<SSID>"
    puts $fp "\t\t\t<hex>[stringToHex $SSID]</hex>"
    puts $fp "\t\t\t<name>$SSID</name>"
    puts $fp "\t\t</SSID>"
    puts $fp "\t</SSIDConfig>"
    puts $fp "\t<connectionType>ESS</connectionType>"
    puts $fp "\t<connectionMode>auto</connectionMode>"
    puts $fp "\t<MSM>"
    puts $fp "\t\t<security>"
    puts $fp "\t\t\t<authEncryption>"
    puts $fp "\t\t\t\t<authentication>$Authentication</authentication>"
    puts $fp "\t\t\t\t<encryption>AES</encryption>"
    puts $fp "\t\t\t\t<useOneX>false</useOneX>"
    puts $fp "\t\t\t</authEncryption>"
    puts $fp "\t\t\t\t<sharedKey>"
    puts $fp "\t\t\t\t\t<keyType>passPhrase</keyType>"
    puts $fp "\t\t\t\t\t<protected>false</protected>"
    puts $fp "\t\t\t\t\t<keyMaterial>$password</keyMaterial>"
    puts $fp "\t\t\t\t</sharedKey>"
    puts $fp "\t\t\t</security>"
    puts $fp "\t</MSM>"
    puts $fp "</WLANProfile>"
}

#=======================================================================================
# Name:  stringToHex
#
# Args:
#        stringValue:         string to convert to hexadecimal value
#
# Return:
#        Hexadecimal value to the given string
#
# Purpose:
#        Convert a string to its hexadecimal value
#=======================================================================================

proc stringToHex { stringValue } {
    set hexvalue ""
    foreach char [split $stringValue ""] {
        append hexfilename [format %2.2x [scan $char %c]]
    }
    return [string map {" " ""} $hexfilename]
}

#=======================================================================================
# Name:  AddToProfile
#
# Args:
#       filename:   Name of the configuration file of wireless network
#       interface:  Interface name where the network will be added
#
# Return:
#       Error string if fails otherwise 1 in success
#
# Purpose:
#       Add a wireless network to the profile
#=======================================================================================
proc AddToProfile { filename interface } {
    set directory [file dirname [file normalize [info script]]]
    append filepath $directory "/"
    append filepath $filename
    set filepath [string map {"/" "\\"} $filepath]
    #puts $filepath
    if { [catch {exec netsh wlan add profile filename=$filepath interface=$interface user=all} errMsg] } {
        return "ErrorMsg: [lindex [split $errMsg "\n"] 0]"
    }
    return 1
}

#=======================================================================================
# Name: ConnectToWifi
#
# Args:
#       profileName: profile name of the network to which its wants to connect
#
# Return:
#       Error string if fails otherwise 1 in success
#
# Purpose:
#       Connect to a network which is already added to the profile
#=======================================================================================
proc ConnectToWiFi { profileName } {
    if { [catch {exec netsh wlan connect name=$profileName} errMsg] } {
        return "ErrorMsg: [lindex [split $errMsg "\n"] 0]"
        #puts "ErrorCode: $::errorCode"
    }
    return 1
}

if { $argc == 0 } {
    puts "Please provide correct arguments"
    puts "1. To Add a wireless network to the profile"
    puts "2. Connect with a wireless network which is already added to the profile"
}


if { [lindex $argv 0] == 2} {
    if { $argc != 5 } {
        puts "Provide more arguments. The Program takes 4 more arguments"
        puts "1. SSID"
        puts "2. Authentication Type"
        puts "3. Password"
        puts "4. Interface Name"
        exit
    } else {
        set SSID [lindex $argv 1]
        append filename $SSID .xml
        set Authentication [lindex $argv 2]
        set Password [lindex $argv 3]
        set interface [lindex $argv 4]
        set fp [open $filename w]
        createWLANProfile $fp $SSID $Authentication $Password
        close $fp
        set ret [AddToProfile $filename $interface]
        if { $ret != 1 } {
            puts $ret
        } else {
            puts "Wireless network is added to the profile"
        }
        file delete $filename
    }
} elseif { [lindex $argv 0] == 1} {
    if { $argc != 2 } {
        puts "Provide more arguments. The Program takes 1 more arguments"
        puts "1. Profile name of the network in which to connect"
    } else {
        set SSID [lindex $argv 1]
        set ret [ConnectToWiFi $SSID]
        if { $ret != 1 } {
            puts $ret
        } else {
            puts "Connect with $SSID successfully"
        }
    }
} else {
    puts "Wrong choice"
    puts "1. To Add a wireless network to the profile"
    puts "2. Connect with a wireless network which is already added to the profile"
}