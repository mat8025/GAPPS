/* 
 *  @script exp1_cpp.asl  
 * 
 *  @comment  process to compile asl as c++ 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//



///  process to take asl script and compile via C++


//  DEFINES needed

#define ASL 0


#if ASL
#include "compile.asl"
#endif


////////////  INCLUDES   //////////////////



/////////////////// LOCAL  PROCEDURES ///////////////////

double dproc(double arg)
{
   double in = arg;
   in += 7;

   pa(in, arg);

   return in;
}

////////////////// GLOBALS //////////////////





#define CPP 1


#if CPP
#include "cppi.h"

#include "uac.h"




void Uac::exp1_cpp(Svarg * sarg) {
// cpp method define
#endif

// the code -- require procedures and globals used here

//  the main code here


////////////////
#if CPP
 cout << "running C++ \n";
#endif

 long lval = 1234567;
 double dout;

 dout = dproc(lval);


  pa(lval , dout);


  exit(0);


////  close out CPP method
#if CPP
}

//==============================//
//  add  function to Uac  DLL
//  so that wrapper asl can call and run the compiled
//  main code

 extern "C" int exp1cpp(Svarg * sarg)  {

    Str a0 = sarg->getArgStr(0) ;
 
    Uac *o_uac = new Uac;
    printf("calling uac method \n");

    cout << " command line  parameter is: "  << " a0 " <<  a0 << endl;

     o_uac->exp1_cpp(sarg);  // call the Uac method
   // which runs the above code
   
    return 1;
}

#endif




///////////////////////////////////////////////////////////////////////
/*
// preprocess steps to add this Uac method
// to Uac DLL

alter ASL and CPP defines

#define ASL 0
#define CPP 1


// add the line

#include "exp1_cpp.asl" 

to 
uac_apps.h

// add the line

"exp1cpp"

to uac_functions


then 

// add the line 

void Uac::exp1_cpp(Svarg * sarg);

to uac_methods.h



 go to src directory 
/home/mark/gasp-CARBON/APPS/uac

and issue command

 make install 2>&1 | grep -i error

if no errors

run the code via asl -s
using the bash script 
run_uac

echo  $*
asl -d -s 'Str dll = "uac" ; Str prg = _clarg[1]; Svar z=_clarg[2:-1:1]; Str sa="$z"; opendll("$dll"); <<"%V $prg "; ret = $prg (sa); exit(0); ' $*

e.g.

run_uac prog_name   parameters


*/
