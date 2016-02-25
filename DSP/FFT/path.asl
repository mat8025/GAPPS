///
///  fft  - butterfly graph -- path for 
///  frequency calculation
///

setdebug(1)

proc sbitrev( ival, n)
{

int I[n]
int j;

     k = 1

     for (j = 0; j < n ; j++) {
        b = (ival & k);
        k = ( k << 1);
        I[j] = !(b ==0);
     }

     I->reverse()

     c = 0;
     k = 1;
     for (j = 0; j < n ; j++) {
       if (I[j] == 1) {
         c = c + k
       }
         k = (k << 1)
     }
     return c;
}

/////////////////////////////////////////


Class Path {

  int nstages;
  int si;
  int fi
  int Twk[]
  int TwN[]
  int signs[]
  int gates[]

  int sdest[]
  int i;

   Cmf Path() 
    {
//<<"cons Path \n"
    nstages = 0
    }


   Cmf setSi( j)
     { 
      // si = nbitrev(j, nstages)
       si = bitrev(j, nstages)
       fi = j
     }

   Cmf setStages( ns) 
    {
       nstages = ns

  <<"$nstages \n"
       
       signs[ns] = 0;
       gates[ns] = 0;
       sdest[ns] = 0;
       Twk[ns] = 0;
       TwN[ns] = 0;

       for (i = 1; i <= nstages; i++) {
          signs[i] = 1; 
          gates[i] = 2 ^^ (i)
   //     <<"$i $gates[i] \n"
          TwN[i] = -1; // flag if > -1 then use
        }
    }

   Cmf setDest( ws, dest)
     {
       sdest[ws] = dest;
     }

   Cmf setTwf( ws, k, n)
     {
       Twk[ws] = k;
       TwN[ws] = n;
     }

   Cmf setSignMinus( ws)
     {
       signs[ws] = -1;
     }


   Cmf Show()
     {

      <<"x($si) "

       for (i = 1; i <= nstages; i++) {

         //<<" $gates[i] $sdest[i]  "

      
        if ( (TwN[i]) > -1) { /// class->vec bug??
//           val = TwN[i] ; // work around FIX
//           if (val > -1) {

           <<" W($Twk[i]/$TwN[i]) ($signs[i]) $sdest[i]  "
           }
           else {
           <<"  $sdest[i]  "
           }

     }
      <<"f($fi)\n"

     }
}


//////////////

 N = atoi (_clarg[1])

 if (N <= 0) {
 <<"bad N \n"
  exitsi()
 }
// is it power of 2 ?

 int n = log2(N)

 M = 2^^n

<<"%V$N $n  $M\n"

 if (M != N) {
<<"not power of 2\n"
  exitsi()
 }


 npaths = N
 n_stages = n

 Path fpath[npaths]

 for (i = 0; i < npaths ; i++) {
   fpath[i]->setStages(n_stages)
   fpath[i]->setSi(i)

 }




/////////   BUTTERFLIES   ////////////////////////////////

// how many stage 1 butterflies ?

  stage = 0
  for (j = 1 ; j <= n_stages ; j++) {
     
      stage = j
      nos = j

      p2 = 2^^nos
      nbfis = N / p2

      nlib = p2

      ntbl = nlib/2

<<"\n%V$stage $nbfis $nlib $ntbl \n"

      //ty =  1 - goy

    for (i = 0; i < nbfis ; i++ ) {

<<"butterfly $(i+1) \n"

      // top lines
      sigi = i* nlib
      for (k = 0 ; k < ntbl ; k++) {

<<"path $sigi $(sigi+nlib/2)\n"

      fpath[sigi]->setDest(stage, (sigi+nlib/2))
      sigi += 1
      }

      // bottom lines

      sigi = (i * nlib) +ntbl

      for (k = 0 ; k < ntbl ; k++) {

       <<"path $sigi W$k/$p2  $(sigi -nlib/2)\n"
       fpath[sigi]->setDest(stage, (sigi-nlib/2))
       fpath[sigi]->setTwf(stage, k, p2)
       fpath[sigi]->setSignMinus(stage)
       sigi += 1  

      }
    }

   }


 for (i = 0; i < npaths ; i++) {
  fpath[i]->Show()
 }



exit_si()