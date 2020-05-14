///
///
///  --> 1/e


 checkIn(_dblevel)

float g;

g = 4.0 * atan(1.0);

<<"%V $g\n"

<<"$(typeof(g)) $g\n"

float f = 4.0 * exp(1.0);

<<"%V $f\n"

setap(100);


//pan denom;

pan denom = 1;

pan Re =  1;

pan e;
<<"%V$Re\n"

<<"$(typeof(Re)) $Re\n"
  tadd = 0;



  N = atoi(_clarg[1]);

<<"%V $N\n"

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
   }


<<"===========================\n"
F = 1;
int  j = 1;

int tmp = 6;

double ReD = 1.0;
double FD = 1.0;
double ddenom;

 for (j =0 ; j < N ; j++) {
 
//<<"%V $F *  $j +1 \n"

     F = F * (j+1);
     FD = FD * (j+1);

<<"%V$j $FD $F  \n"

     denom =  1.0/F;

     ddenom = 1.0/FD;

//<<"%V $ddenom $denom\n"   // TBF - have to reference denom here -- otherwise not known!?!

     if ( tadd) {
	  <<"add $denom to $Re\n"
           Re = Re + denom;
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
//ans=iread()

}

pan pt = 1.0003450000;

<<"$(typeof(pt)) $pt\n"

checkFnum(pt,1.0003450000000000000,5)

testArgs(pt,1.00034500000000000000000000)

pt = 1.0/exp(1.0);
//pt = 0.3678794642857142857142857142857142857142857;

<<"%V$pt\n"

<<"%V$ReD\n"

<<"%V$Re\n"



checkFnum(Re,pt,5)

checkOut()
