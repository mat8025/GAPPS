
///  --> 1/e
setap(100)

//setdebug(1,"pline")

pan denom;
pan Re =  1;


<<"$Re \n"


  tadd = 0;

N = atoi(_clarg[1]);

e = exp(1.0)
<<"$(typeof(e)) $e\n"

r = 1.0/exp(1.0)

<<"---->$(typeof(r)) $r \n"

s = Sin(0.999)

<<"---->$(typeof(s)) $s \n"

//double F = 1;
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
checkIn()
//
//for (j =1 ; j < N ; j += 1) {
//while (i < N) {
//

 for (j =1 ; j < N ; j++) {


 
<<"%V $F *  $j \n"

     F = F * j;

<<"%V$j $F  \n"

     denom =  1/F;
     
     if ( tadd) {
	  <<"add $denom to $Re\n"
           Re = Re + denom;
          tadd = 0;

     }
     else {
	 <<"sub $denom from $Re\n"
         Re = Re - denom;
         tadd = 1;
     }

<<"%V$j $(typeof(j)) $F $denom  $Re \n"
//
        //   j += 1;
       //    tmp = tmp +1;
//

}

pan pt = 1.0003450000;

<<"$(typeof(pt)) $pt\n"

checkFnum(pt,1.0003450000000000000,5)

testArgs(pt,1.00034500000000000000000000)


 pt= 0.367879188712522045000;


<<"$(typeof(pt)) $pt\n"

checkFnum(Re,pt,5)

checkOut()
