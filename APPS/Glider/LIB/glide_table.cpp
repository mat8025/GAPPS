/*//////////////////////////////////<**|**>///////////////////////////////////
//                        glide_table.cpp 
//		          
//    @comment  glide_table 
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

                                

#include "glide_table.h"
#include "glide.h"

const char ** si_glidet_init (int *cnt);

/**********************************************************************************************
/*///////////////////////////////////<**|**>///////////////////////////////////
//
// list of  includes which are
// asl scripts (preprocessed) to C++ source
// which will be  compiled via make install in this directory
//
//  add asl script - #include new.asl
//  and add func name in the script to funclist in si_glide_init
// to run/execute
// asl -s 'opendll("glide"); xxx();'
// where xxx is the function name in the script
// see tmat.asl  example
// 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

//#include "glide_apps.h"

#include "glidetask.asl"
#include "showtask.asl"




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
#run glide
echo "bash args" $*
asl  -s 'Svar z=_clarg[1:-1:1]; Str sa="$z";   opendll("glide");  <<"$sa \n"; glider_task(sa); exit(0); ' $*
*/

// asl uses the -s option to run the commands
// set up an Svar to contain command line args
// open this Dll glide, open the plot Dll
// run the asl function wex_task (sa)  with the command line args
// the asl function is the cpp compiled code for this wex app
// the src for the app is ~/gapps/APPS/Wex/LIB
// and is a subset of C++
// and which also can be run as an asl script
//
//  So
// ./run_glide jamest aspen cuch boulder
// produces 
/*
Leg   TP      ID   LAT      LONG      FGA    MSL   PC   Dist  Hdg   Dur RTOT   RTIM  Radio   
0 JamesTwn    JAMSTWN   40,06.828,N 105,23.154,W   41948ft   23409ft      0.00%   0.0        0    0.00   0.00   0.00 
1 Aspen       ASE       39,13.390,N 106,52.130,W   48005ft   25656ft     23.32% 161.0      233    1.24 160.99   1.24    118.850
2 CucharaVly  07v       37,31.429,N 105,00.556,W   44830ft   23468ft     36.06% 249.0      139    1.92 409.94   3.16    122.900
3 Boulder     1V5       40,02.366,N 105,13.549,W   18549ft   17349ft     40.61% 280.4      356    2.16 690.29   5.32    122.720
Total distance     690.29 km      428.95 sm     372.51  nm  LOD   35.0  
totalD  690.29 km to fly -   5.32 hrs - bon voyage!
 */

// showTask produces a graphical interactive version


uint32_t  Glide::GLIDEID = 0;

extern "C" const char **
glide_init (int *cnt)
{
  const char **functable;
  // fprintf (stderr,"doing init of glide_table - Cwid %d\n",Cwid);
  functable = si_glidet_init (cnt);
  return functable;
}
//[EF]===========================================////

// list of funtions for this Dll - which are avaliable when the dll is opened and linked in to asl
const char **
si_glidet_init (int *cnt)
{

  static const char *funclist[] = {
    //#include "glide_functions.h"
     "glidertask",
     "showtask",
    //
    // add new app here 
    
  };

  int k = sizeof (funclist) / sizeof (char *);
  *cnt = k;

  return funclist;
}

 //======================================

