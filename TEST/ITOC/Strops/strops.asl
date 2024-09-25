/* 
 *  @script strops.asl                                                  
 * 
 *  @comment  ,sel,scat, splice, paste                                  
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.54 : C Xe]                            
 *  @date 09/19/2024 02:06:30                                           
 *  @cdate 09/19/2024 02:03:19 Lithium [asl 6.54 : C Xe]                
 *  @author Mark Terry Lithium [asl 6.54 : C Xe]                        
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



#define __CPP__ 0

#if __ASL__

   db_ask = 0;
   db_allow = 1;


 allowDB("str,",db_allow)

 Str Use_= " Demo  of sops ,sel,scat, splice, paste ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();

/*
#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 
*/
   allowErrors(-1); // set number of errors allowed -1 keep going 



#endif       

// CPP main statement goes after all procs
#if __CPP__
#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
    init_cpp(argv[0]) ; 

#endif       


  chkIn(1) ;

  chkT(1);
///
///
///

 astr = "Cheese and Pickle"

<<"%V $astr \n"

chkStr(astr, "Cheese and Pickle")

Svar name = { "Mark Terry", "use standard libraries!" }

<<" $(typeof(name)) $name \n"

<<" $name \n"

<<"assignment: $name[0] \n"

<<"%v $name[1] \n"

 subname = sele(name[0],3,5) ;  // index 3 get 5 chars

<<"%V $subname \n"

 chkStr(subname,"k Ter")



 subname = sele(name[1],3,5)

<<" $subname \n"

 subname = sele(name[1],0,-2)

<<"sele(name[1],0,-2) $subname \n"


 subname = name[1].trimStr(0,-4)

<<" trimstr (0,-4) $subname \n"

 subname = name[1].trimStr(4,-5)

<<" trimstr (4,-5) $subname \n"

 subname2 = name.GetSubStr(3,5)


<<"GetSubStr:  $subname2 \n"


 subname1 = name[1].GetSubStr(3,5)


<<"%I $subname1 \n"



 subname0 = name[0].GetSubStr(3,5)

<<"%v $subname0 \n"


 subname0 = name[0].GetSubStr(-6,4)


<<"%v <$subname0> \n"

 subname0 = name[0].GetSubStr(-6,-4)


<<"%v <$subname0> \n"

 subname0 = name[0].GetSubStr(3,5)

<<"%v $subname0 \n"
 subname0 = name[1].GetSubStr(3,5)

<<"%v $subname0 \n"


 mkname = name[0].GetSubStr(3,5) @+ name[1].GetSubStr(3,5)


<<"addition vi @+ operator: %v $mkname \n"



 mkname = name[1].Getsubstr(3,5) @+ name[0].GetSubStr(3,5)


<<"%v $mkname \n"


// SPLICE


 name[0].Splice("splice this",3)


<<" $name[0] \n"

 name[0].Splice("and this at end__",-1)

<<"Splice: $name[0] \n"

//  PASTE


 name[0].Paste("paste this ON",3)


<<"Paste: $name[0] \n"



// STRCAT

 name[2].Cat("this ", " is ", "the ", "place ","to be")

<<"Cat:  $name[2] \n"


 name[8].Cpy("into record 8 ")

<<"Cpy:  $name[8] \n"

// SUBSTITUTE


name[0].Substitute("paste this ON"," Substitute my truth with lies ") 
 
<<"Substitute: $name[0] \n"



/////////////////////


/// TBD /////


// subscript the svar variable
// name[0:5:2].DoSomething()
// ns = name[0:5:2].GetSomething()


///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
