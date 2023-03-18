
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



//////////////////  DEFINES ///////////////////

#define ASL 1
#define CPP 0

#if ASL
#include "compile.asl"
// if script is compiled via make install in uac directory
// compile asl  will redifine CPP to 1 and ASL to 0
#endif

#if USE_ASL
<<"Using ASL \n"
#endif


/////////////////  INCLUDES //////////////////////




/////////////////// LOCAL  PROCEDURES ///////////////////
// these have to have a namespace - so they do not clash
// with other pre-compiled routines
// TBD - using exp1 -- exp1_procname -- through out

double dproc(double arg)
{
   double in = arg;
   in += 7;

   pra(in, arg);

   return in;
}

////////////////// GLOBALS for this code //////////////////




/////////////////////////////////////////////////////


#if CPP
#include "cppi.h"
#include "uac.h"

 int Uac:: exp1 (Svarg * sarg) {
// cpp method define

 cout << "running as C++ \n";
 Str a0 = sarg->getArgStr(0) ;
 Svar sa;
 cout << " paras are:  "  << a0.cptr(0) << endl;
 sa.findWords(a0.cptr());

cout << " The  Task parameters are:  "  << sa << endl;


#else

 int  asl_main () {

 Svar sa;
 <<" na $_clargc \n"
 int na = _clargc;
 
 <<" $na $_clarg[1]  $_clarg[2] \n"

 sa = _clarg[1:-1:1];

<<" running as ASL parameters are $sa \n"

#endif

  int main_rtval = 0;
  int i;
  printf("doing main method <|%s|> <|%s|>\n",sa.cptr(0), sa.cptr(1));
  printf("doing main method <|%s|> <|%s|>\n",sa[0], sa[1]);


 // long k= atol(sa.cptr(0));

Str sv = sa.cptr(1);

//<<"%V $sv\n";

sv.pinfo();


/// args - have to be able to process vmf dot    sa.cptr(1)

     long k0= atol(sa.cptr(0));

     long k1= atol(sa[0]);

     long k= atol(sa.cptr(1));

     long k2= atol(sa.cptr(2));
   


  //<<"%V $k0 $k $k1 $k2\n"

   //k1.pinfo();

   //k.pinfo();
   
   //k2.pinfo();

  //long lval = 1234567;
  
  long lval = k;

  printf(" k %ld k1 %ld %ld\n",k,k1,lval);

  //lval.pinfo();
  double dout;

  dout = dproc(lval);

  pra(lval , dout);

  lval = k1;


  dout = dproc(lval);

  pra(lval , dout);

  for (i= 0; i < 7 ; i++) {
     k= atol(sa.cptr(i));
     lval = k;
     dout = dproc(lval);
     //<<"%V $i $k $lval $dout\n"
     printf(" i %d k %d lval %d dout %f\n",i ,k ,lval ,dout);
#if ASL
    <<"$k $(pt(k)) \n";
#else    
    cout << k << " " << pt(k) << endl;
#endif
     pra(lval , dout);
  }

  return main_rtval;
}

#if ASL
  int rv = asl_main ();

  printf ( "done asl_main returns %d \n", rv);
#endif


#if CPP
//==============================//
//  add  function to Uac  DLL
//  so that wrapper asl can call and run the compiled
//  main code

 extern "C" int exp1(Svarg * sarg)  {

    Str a0 = sarg->getArgStr(0) ;
 
    Uac *o_uac = new Uac;
    printf("calling uac method \n");

    cout << " command line  parameter is: "  << " a0 " <<  a0 << endl;


//a0.pinfo();
 Svar sa;

cout << " paras are:  "  << a0.cptr(0) << endl;
 sa.findWords(a0.cptr());

cout << " The   parameters for this module are:  "  << sa << endl;

cout << " para[0] is:  "  << sa.cptr(0) << endl;

     int rv =o_uac->exp1(sarg);  // call the Uac method
   // which runs the above code
    printf("uac method returns %d\n",rv);
    return rv;
}

#endif


  //exit(0);
 
 

///////////////////////////////////////////////////////////////////////
/*
// preprocess steps to add this Uac method
// to Uac DLL



// add the line

#include "exp1.asl" 

to 
uac_apps.h

// add the line

"exp1"

to uac_functions


then 

// add the line 

int Uac::exp1(Svarg * sarg);

to uac_methods.h



 go to src directory 
/home/mark/gasp-CARBON/APPS/uac

and issue command

 make install 2>&1 | grep -i error

if no errors

run the code via asl -s
using the bash script 
run_uac
#===================
echo  $*
asl -d -s 'Str dll = "uac" ; Str prg = _clarg[1]; Svar z=_clarg[2:-1:1]; Str sa="$z"; opendll("$dll"); <<"%V $prg "; ret = $prg (sa); exit(0); ' $*
#============================



run_uac prog_name   parameter1 parameter2 ...
e.g.
run_uac exp1    17 19 

*/
