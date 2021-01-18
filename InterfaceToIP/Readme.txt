This is a program to get ip address from a interface name in both linux and windows. This program 
contains three methods - 

1) InterfaceToIPv4AddressWindows - Provide ip address of given interface in windows
    Return value:
        a) ip: If the given interface name is present and there is an ipv4 address assosiated 
               with that interface
        b) -1: If the given interface name is not presnt
        c) -2: If the given interface name is present but there is no ipv4 address assosiated 
               with that interface

    Syntax:
            InterfaceToIPv4AddressWindows <interface name>

2) InterfaceToIPv4AddressLinux - Provide ip address of given interface in linux
    Return value:
        a) ip: If the given interface name is present and there is an ipv4 address assosiated 
               with that interface
        b) -1: If the given interface name is not presnt
        c) -2: If the given interface name is present but there is no ipv4 address assosiated 
               with that interface

    Syntax:
            InterfaceToIPv4AddressLinux <interface name>

3) returnValue - This function is internaly used by InterfaceToIPv4AddressWindows and 
                 InterfaceToIPv4AddressLinux for code reuse.