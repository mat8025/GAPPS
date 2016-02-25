#/* -*- c -*- */


# script for a one line command input : can be use as a calculator
DB = 1

// set arbitary precision to 50 places (radix 256)

SetAP(50)

openDll("math")

// for different versions -- want an alias 
// use the GS_SYS env variable

ldp= GetEnv("LD_LIBRARY_PATH")

<<" $ldp \n"


gssys= GetEnv("GS_SYS")

<<" %v $gssys \n"

  if (gssys @="") {
    lib = "/usr/local/GASP/gasp/LIB/"
<<" setting $lib \n"
  }
  else {
    lib = "$gssys/LIB/"
    }

<<" %v $lib \n"


include "$lib/consts.asl"


//<<" %v $PI_  %v $E_ \n"

//constants()


proc help()
{
<<"you are using a command line calculator with arbitary precision" 
<<" expression ( e.g 2*2 or a = 5^2 + sin(0.5)) \n"
<<"then a (RETURN) to print value \n"
<<"or type variable to print variable value \n"
<<" emacs style editing on command line and history"
<<"quit to exit \n"
<<"help for help \n"
<<"FUN for list of functions \n"
<<"CON for list of Constants \n"
<<"UNITS for list of Unit Conversions \n"
<<"learn ABC - for example usage e.g. learn types, learn loops \n"
}

proc learn(what)
{
<<" in learning mode\n"

#{
  if (what @= "types") 
    {
      //<<"int n = 2 set variable n integer type to two\n"
      //<<"int n = 2 ; // set variable n integer type to two\n"
	int n = 2;
	int m = 2;
        p = n + m
    <<"%V $n + $m = $p \n"





    }
#}

}

 
proc funcs()
{
<<"math functions known are :- \n"
<<"Sin - Sine argument in radians \n"
<<"Cos - Cosine \n"
<<"atan - arctan \n"
<<"sinh,cosh,tanh - hyperbolic \n"
<<"Atan2 - arctan(y/x \n"
<<"Asin - arcsine \n"
<<"Acos - arccosine \n"
<<"Log - natural log \n"
<<"Log10 - base 10 log \n"
<<"Exp - exponential \n"
<<"Sqrt - square root \n"
<<"Abs  - absolute value of integer \n"
<<"Fabs  - absolute value of float \n"
<<"d2r - degrees to radians \n"
<<"r2d - radians to degrees \n"
<<"% - modulus operator \n"
<<"/ - division \n"
<<" time - secs "
<<"\n"
}

// arbitary precision routines broke - FIX -11-30-2002



# conversion routines

proc pc(x,y)
{
 c = x/y * 100.0
 return (c)
}


# set up some aliases

# using history and line editing via readline GNU lib

//constants()

//<<" Calc - with readline \n"

stype = "XX"




SetPCW("writepic")

//setap(20)
na= getArgc()

//<<" na $na \n"
 ia = 0
 from_cl = 0
if (na > 1) {
  from_cl = 1
}

int nsp = 0

SetAP(0)  // don't use AP library

<<"vers $(version())\n\n"

proc qhandler()
{
<<" script $_cproc Caught QUIT signal - \n"
<<" Skip this instruction ??\n"

}

proc GetStat()
{
gs = 1

     if (from_cl) {

         if (nsp >= (na-1) ) { 
               return 0
         }

         fa = GetArgStr()

         ia++         
         Stat = fa
         stype = CheckState(fa)

	 //<<"Cl%V $stype $fa \n"

	 <<"$fa \n"

     }
     else {
      
         Stat = readln(":-) ",stype)
	
	// <<"%V  $stype $Stat \n"
     }

	    if (Stat @= "quit")  {
                    <<" exit\n"
                   STOP!
              }

	    if (scmp("help ",Stat,5)) {
                hc =ssub(Stat,"help","sinfo")
                !!"$hc "
                <<"done help !\n"
                gs = 0
	    }

       return gs
}



//SigHandler("qhandler", "QUIT")



Stat = "d2r(45)"
foores =""
<<"%v $Stat \n"
	    Xstate(Stat)  
<<" CALC \n"

  while (1) {


          if ( GetStat() ) {

	    //<<"%v $stype $Stat \n"

            if (stype @= "PRINT") {
	      //             <<"PRINT  $($Stat) \n"
             <<"$($Stat) \n"
              }
	    elif (scmp("\$",Stat,1)) {
              <<"ind $Stat \n"
	    }
            else {

                if (stype @= "FUNCTION") {         
		  //    <<"func eval $($Stat)\n"
    <<"$($Stat)\n"

		} 
                elif (stype @= "PFUNC") {
		     foores = $Stat()
		     if ( ! (foores @= "")) {
		       //                       <<"PFUNC $foores \n"
                       <<"$foores \n"
                     }
	        }
	        else {

		  //  	<<" executing   $Stat \n"

		    Xstate(Stat)  
		    if ( !(typeof(_lastr) @= "SVAR")) {
		      //<<"Stat $(typeof(_lastr)) $_lastr \n"
                           <<"$_lastr \n"
                    }

	       }

	    }

   nsp++
       }
       else {
           break
       }
  }



//<<"%v $nsp \n"
//<<"EXIT CALC \n"
<<"\n"
;
STOP!

//////////////////////////// TBD ///////////////////////////////////////
// set up interrupt handle to break out of Xstate current instruction(loop)
// get next instruction





///////////////////////////  DEBUG //////////////////////////////////////////////
