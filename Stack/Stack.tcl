namespace eval ::Stack {
    
    # Export Procedure
    namespace export create
    namespace export push
    namespace export pop
    namespace export show
    namespace export TOS

    #Variables
    set TOS 60000
    set lst {}
    set version 1.0

    #Defination Of the procedure create
    proc create { {size 60000} } {

        variable ::Stack::lst
        if {$size <= 0} {
            return -1
        }
        if { [llength $lst] > 0 } {
            return -1
        }
        variable ::Stack::TOS
        
        #Set the maximum stack size
        set TOS $size
        
        return 1
    }

    #Defination Of the procedure push
    proc push {value} {
    
        variable ::Stack::lst
        variable ::Stack::TOS

        #Check the size of the list reaches maximum or not
        if {[llength $lst] == $TOS} {
            return -1
        }

        #Append the value with the list
        lappend lst $value

        return 1
    }
    proc pop {} {
        variable ::Stack::lst

        #Check the list is empty or not
        if { [llength $lst] == 0} {
            return "failed"
        }

        #Delete top of the stack i.e last element from list
        set element [lindex $lst [expr [llength $lst] - 1]]
        set lst [lreplace $lst [expr [llength $lst] - 1] [expr [llength $lst] - 1]]

        return $element
    }

    proc show {} {
        variable ::Stack::lst

        #Check the list is empty or not
        if { [llength $lst] == 0} {
            return "failed"
        }

        #Reverse the list and return such as top of stack is the first element of the list
        return [lreverse $lst]
    }

    proc TOS {} {
        variable ::Stack::lst

        #Check the list is empty or not
        if { [llength $lst] == 0} {
            return "failed"
        }

        #Return last element in the list
        return [lindex $lst [expr [llength $lst] - 1]]
    }
}
package provide Stack $Stack::version
package require Tcl 8.0