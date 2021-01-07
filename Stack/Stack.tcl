namespace eval ::Stack {
    
    # Export Procedure
    namespace export create
    namespace export push
    namespace export pop
    namespace export show
    namespace export peek
    namespace export delete

    #Variables
    set version 1.0
    set id 0
    variable stack
    variable stackPointer
    set validId [list]

    #Create a new Stack
    proc create {{size 60000}} {
        variable ::Stack::stack
        variable ::Stack::id
        variable ::Stack::validId
        variable ::Stack::stackPointer

        #Create Token, stack and maximum elements
        set token "TokenNo[incr id]"
        set stack($token) [list]
        set stackPointer($token) $size

        #Add TokenId into the list of valid TokenIds
        lappend validId $id

        #Return the token
        return $token
    }

    #Push Element into the stack
    proc push {token value} {
        variable ::Stack::stack
        variable ::Stack::stackPointer

        #Check validity of the token
        set valid [::Stack::checkToken $token]
        if {$valid == -1} {
            return -2
        }

        #Check the size of the list reaches maximum or not
        if {[llength $stack($token)] == $stackPointer($token)} {
            return -1
        }

        #Append the value with the list
        lappend stack($token) $value

        return 1
    }

    #Pop element form stack
    proc pop {{token}} {
        variable ::Stack::stack

        #Check validity of the token
        set valid [::Stack::checkToken $token]
        if {$valid == -1} {
            return -2
        }

        if {[llength $stack($token)] == 0} {
            return [list]
        }

        #Delete top of the stack i.e last element from list
        set element [lindex $stack($token) [expr [llength $stack($token)] - 1]]
        set stack($token) [lreplace $stack($token) [expr [llength $stack($token)] - 1] [expr [llength $stack($token)] - 1]]; #TODO:: Improve the algo

        return $element
    }

    #Print the stack elements
    proc show {{token}} {
        variable ::Stack::stack

        #Check validity of the token
        set valid [::Stack::checkToken $token]
        if {$valid == -1} {
            return -2
        }

        if {[llength $stack($token)] == 0} {
            return [list]
        }

        #Reverse the list and return such as top of stack is the first element of the list
        return [lreverse $stack($token)]
    }

    #Print element at the top of the stack
    proc peek {} {
        variable ::Stack::stack

        #Check the list is empty or not
        if { [llength $stack($token)] == 0} {
            return [list]
        }

        #Return last element in the list
        return [lindex $stack($token) [expr [llength $stack($token)] - 1]]
    }

    #Delete a stack
    proc delete {{token}} {
        variable ::Stack::stack
        variable ::Stack::stackPointer
        variable ::Stack::validId

        #Check validity of the token
        set valid [::Stack::checkToken $token]
        if {$valid == -1} {
            return -2
        }

        #Delete the stack and stack pointer
        unset stack($token)
        unset stackPointer($token)

        #Remove the Id from list of valid id's
        set idx [lsearch $validId $valid]
        set validId [lreplace $validId $idx $idx]

        return 1
    }

    #Check the token is valid or not
    proc checkToken {token} {
        variable ::Stack::id
        variable ::Stack::validId

        if {[regexp TokenNo((0|1|2|3|4|5|6|7|8|9)+) $token strValue numValue] == 1} {
            if {[lsearch $validId $numValue] > -1} {
                
                #The token is valid
                return $numValue
            }
        }

        #Invalid Token
        return -1
    }

}
package provide Stack $Stack::version
package require Tcl 8.0