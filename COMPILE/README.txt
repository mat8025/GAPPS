   ASL   ==>  C++ compile


 With some restrictions an asl script can be put into a form
 that C++ can compile and by wrapping the code inside an external C function,
 then that function can be added to the UAC dynamic library.



The code is added via an include line in uac_table.cpp

#include "classtest.asl"

and by adding the name of the function to call
into the funclist array.

 static const char *funclist[] = {

    "bops",
    "tarray",
    "tmat",
    "classtest",     // new code to compile


}

inside the function 
si_uact_init (int *cnt)

 If the function compiles then it can be accessed from ASL script

 using the statement

 classtest(arg1 );

 or via command line 

asl -s 'opendll("uac"); class_cpp(2,2); '


the opendll function  loads the uac library containing the compiled script
and the code is executed via calling the named extern C function.

  


 The follwing mods to asl scripts  have to be made in order to compile them
 via C++.

  Preprocessing the asl script with sindent.asl will take care of some
  of the modifications.

  The script will have a .cas  extension instead of .asl.


  All statements end with ; .

  print statements  e.g.   <<" value is $v \n"
  transformed to C style
     printf("value is %d\n",v);
  or C++ cout
    cout << "value is "  << v  << endl;

  in class definitions  of member functions replace cmf with void or return type.
  This function/procedure definition syntax is standard already for  asl.
