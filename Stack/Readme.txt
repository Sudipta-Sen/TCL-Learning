To use this package first copy the Stack.tcl and pkgIndex.tcl file in the default TCL package folder and 
import the package into your program with the command "package require Stack".

This package contains the implementation of one stack. There are 5 mehod to use:

1) create: It create a stack. If this method is not called or called without an argument then 
           a stack is created with size 60,0000. User can also specify size of the stack. This 
           method is successfully execute only when there is no element already present in the stack.

           Syntax: 
                    Stack::create <size>
                Size can be only positive natural number. If no size is specified then by default
                it takes the size 60,000
           
           Return Value:

                   a) 1 when the stack is successfully created.
                   b) -1 if there is an error.

2) push: This method insert an element into the stack.

            Syntax:
                    Stack::push <element>
                    
            Return Value:

                    a) 1 if insertion is successful.
                    b) -1 if insertion fails i.e the stack is full.

3) pop: This method delete an element from the stack and return that element

            Syntax:
                    Stack::pop
            
            Return Value:
                    a) Returns the element from the top of the stack
                    b) Return a string "failed" if there is no element in the stack

4) TOS: This method returns the element from top of the stack but don't delete it from the stack

            Syntax:
                    Stack::TOS
            
            Return Value:
                    a) Returns the element from the top of the stack
                    b) Return a string "failed" if there is no element in the stack

5) show: This method returns the element of the stack as a list starting from top of the stack

            Syntax:
                    Stack::show
            Return Value:
                    a) Elements of the Stack 
                    b) Returns a string "failed" if the stack is empty.