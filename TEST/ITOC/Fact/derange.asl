

///  --> 1/e
setap(100)


double denom;


double Re =  1;


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
pan i;
  for (i =1 ; i < N ; i++) {
<<"%V $F *  $i \n"
//     F = F*i;
     F = i * F;
<<"%V$i $F  \n"     
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

<<"%V$i $F $denom  $Re \n"

   }

