/*//////////////////////////////////<**|**>///////////////////////////////////
//                        rgt_table.cpp 
//		          
//    @comment  rgt_table 
//    @release   Beryllium  
//    @vers 1.4 Be Beryllium 6.4.48 C-Be-Cd 
//    @date 07/24/2022 09:22:11    
//    @cdate 07/23/2022        
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2022 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

                                

//#include "rgt_table.h"
#include "rgt.h"

const char ** si_rgtt_init (int *cnt);

/**********************************************************************************************
/*///////////////////////////////////<**|**>///////////////////////////////////
//
// list of  includes which are
// asl scripts (preprocessed) to C++ source
// which will be  compiled via make install in this directory
//
//  add asl script - #include new.asl
//  and add func name in the script to funclist in si_rgt_init
// to run/execute
// asl -s 'opendll("rgt"); xxx();'
// where xxx is the function name in the script
// see tmat.asl  example
// 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

#include "rgt_apps.h"





extern int Cglid;
extern int Cwoid;
extern int Cwid;

// makefile shows where this code is included
// most APPS will run using asl
// e.g. asl glidetask  longmont laramie
// but if compiled sucessfully  by making this Dll
// will run as cpp code via command line or a bash script
//
/*
#run rgt
echo "bash args" $*
asl  -s 'Svar z=_clarg[1:-1:1]; Str sa="$z";   opendll("rgt");  <<"$sa \n"; rgt_task(sa); exit(0); ' $*
*/

// asl uses the -s option to run the commands
// set up an Svar to contain command line args
// open this Dll rgt, open the plot Dll
// run the asl function rgt_task (sa)  with the command line args
// the asl function is the cpp compiled code for this wex app
// the src for the app is ~/gapps/TEST/RGT/LIB
// and is a subset of C++
// and which also can be run as an asl script
//


uint32_t  Rgt::RGTID = 0;

extern "C" const char **
rgt_init (int *cnt)
{
  const char **functable;
  // fprintf (stderr,"doing init of rgt_table - Cwid %d\n",Cwid);
  functable = si_rgtt_init (cnt);
  return functable;
}
//[EF]===========================================////

// list of funtions for this Dll - which are avaliable when the dll is opened and linked in to asl
const char **
si_rgtt_init (int *cnt)
{

  static const char *funclist[] = {
    #include "rgt_functions.h"

    //
    // add new app here 
    
  };

  int k = sizeof (funclist) / sizeof (char *);
  *cnt = k;

  return funclist;
}

 //======================================

