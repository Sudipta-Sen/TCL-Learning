To use this package first copy the Stack.tcl and pkgIndex.tcl file in the default TCL package folder and 
import the package into your program with the command "package require Stack".

This package contains the implementation of one stack. There are 7 mehods within which 6 methods can be used 
by User and 1 method is for internal use:

1) create: It create a stack. If this method is called without an argument then 
           a stack is created with size 60,0000. User can also specify size of the stack. 

           Syntax: 
                    Stack::create <size>
                Size can be only positive natural number. If no size is specified then by default
                it takes the size 60,000
           
           Return Value:

                   a) A token is returned which is later used in push, pop, peek and delete method

2) push: This method insert an element into the stack.

            Syntax:
                    Stack::push <token element>
                    
            Return Value:

                    a) 1 if insertion is successful.
                    b) -1 if insertion fails i.e the stack is full.
                    c) -2 if token is invalid

3) pop: This method delete an element from the stack and return that element

            Syntax:
                    Stack::pop <token>
            
            Return Value:
                    a) Returns the element from the top of the stack
                    b) Return empty list if stack is empty
                    c) Return -2 if token is invalid

4) peek: This method returns the element from top of the stack but don't delete it from the stack

            Syntax:
                    Stack::peek <token>
            
            Return Value:
                    a) Returns the element from the top of the stack
                    b) Return empty list if stack is empty
                    c) Return -2 if token is invalid

5) show: This method returns the element of the stack as a list starting from top of the stack

            Syntax:
                    Stack::show <token>

            Return Value:
                    a) Elements of the Stack 
                    b) Return empty list if stack is empty
                    c) Return -2 if token is invalid

6) Delete: This method deletes a stack
            Syntax:
                    Stack::delete <token>
                
            Return Value:
                   a) 1 if successfully delete the stack
                   b) -2 if token is invalid

7) checkToken: checks the token is valid or not. Users can not use this method, this is for internal use only
            Syntax:
                    Stack::checkToken <token>
                
            Return Value:
                   a) interger part of the token if the token is valid
                   b) -1 if the token is invalid
