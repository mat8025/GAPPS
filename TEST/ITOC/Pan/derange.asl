//%*********************************************** 
//*  @script derange.asl 
//* 
//*  @comment test pan precision 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                               
//*  @date Sat May 23 16:55:29 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();




///
///
///  --> 1/e


chkIn()

float g;

g = 4.0 * atan(1.0);

<<"%V $g\n"

<<"$(typeof(g)) $g\n"

float f = 4.0 * exp(1.0);

<<"%V $f\n"

setap(100);


//pan denom;

pan denom = 1;

pan Re =  1.0;

pan e;
<<"%V$Re\n"

<<"$(typeof(Re)) $Re\n"
  tadd = 0;

int N;

    N = atoi(_clarg[1]);
if (N == 0) {
  N = 20;
}
<<"%V $N   $(typeof(N))\n"
N->info(1)


//setDebug(1,@filter,1,"vfree",@filterfile,2,"ds_svar.cpp")


e = exp(1.0);

<<"%V $e\n"

<<"$(typeof(e)) $e\n"

r = 1.0/exp(1.0)

<<"---->$(typeof(r)) $r \n"

s = Sin(0.999);

<<"---->$(typeof(s)) $s \n"


pan F = 1;

<<"$(typeof(F)) $F \n"

int i;

i = 1;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

     F = i * F;
<<"%V$i $F  \n"     
     i++;

<<"===========================\n"

F = 1;
i = 1;
pan R;

  while (i < N) {
  
     //F = i * F;
       F *= i;
   // R = i * F;
  //  F = R;
    
<<"%V$i $R $F \n"

     i += 1;
//ans = iread("$i ")
}


<<"===========================\n"
F = 1;
int  j = 1;

int tmp = 6;

double ReD = 1.0;
double FD = 1.0;
double ddenom;

// sdb(1,@step)
 
 for (j =0 ; j < N ; j++) {
 
//<<"%V $F *  $j +1 \n"

     F = F * (j+1);

     FD = FD * (j+1);

<<"%V$j $FD $F  \n"

     denom =  1.0/F;

     ddenom = 1.0/FD;

//<<"%V $ddenom $denom\n"   // TBF - have to reference denom here -- otherwise not known!?!

     if ( tadd) {
	  
           Re = Re + denom;
<<"add $denom to $Re\n"
           ReD = ReD + ddenom;
           tadd = 0;
     }
     else {
	 <<"sub $ddenom from $ReD\n"

         ReD = ReD - ddenom;	 
	 <<"sub $denom from $Re\n"
         Re = Re - denom;

         tadd = 1;
     }


<<"%V$j $(typeof(j)) $F $denom  $Re \n"
<<"%V$j  $FD %12.9f $ddenom   $ReD \n"

//ans=iread("$j")

}





pan pt = 1.0003450000;

<<"$(typeof(pt)) $pt\n"

chkR(pt,1.0003450,5)

testArgs(pt,1.000345000)

pt = 1.0/exp(1.0);
//pt = 0.3678794642857142857142857142857142857142857;

<<"%V$pt\n"

<<"%V$ReD\n"

<<"%V$Re\n"



chkR(Re,pt,3)

chkOut()
