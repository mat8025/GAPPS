//////////////////////////////////////////////////////////////////////////////////////////

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


  In order to compile and run script functions (sfunc)  : the original
  script line had to be parsed into two opertions.
  One to identify the arguments and prepare a format statement,
  and the other to call the internal script function via a cpp statement.
  e.g.

    an ASL function to take a coordinate specification and return 
    a equivalent decimal degree would be

     Ladeg =  coorToDeg(Lat,2);

     this is preprocessed into

Siv Ladeg(DOUBLE_);

    FMT[0] = '\0';
    strcat(FMT,typeid(Lat).name());
    strcat(FMT,",");
    strcat(FMT,typeid(2).name());
    strcat(FMT,",");

    cppargs(2,FMT,typeid(Lat).name(),typeid(2).name());

    cppargs(FMT,typeid(Lat).name(),typeid(2).name(),"last");

    Ladeg = cpp2asl ("coorToDeg",FMT,&Lat,1);


    Graphic commands require the plot library
    
    asl -d -s 'opendll("uac"); opendll("plot"); cinclude(2); '
