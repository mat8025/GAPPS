//      crude de-convolution   of beam against reflectivity shape


//    32 pixel positions


//    input pattern

float Inpat[32]

//Inpat[15:19] = 20

Inpat[15] = 20
Inpat[16] = 30
Inpat[17] = 40
Inpat[18] = 40
Inpat[19] = 30
Inpat[20] = 20

<<"$Inpat \n"
nb = 5
float Beam[nb] = { 0.25, 0.5, 1.0, 0.5, 0.25 }

Ibeam = 1.0/Beam


<<"$Beam \n"

<<"$Ibeam \n"

 Outpat = lconvolve( Beam, Inpat)

<<"$Outpat \n"

sz= Caz(Outpat)

<<"$sz \n"

C=ofw("bds.dat")


float Rpat[40]

k = 0

  while (Outpat[k] == 0.0) {

    k++
    Rpat[k] = 0.0
  }

<<"$k $Outpat[k] \n"



// first restored point
  j = k; // restored edge

  Rpat[j] = Outpat[k] * Ibeam[nb-1]

<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;


// second restored point 

  Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])) * Ibeam[nb-2] ;

<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;

// third restored point
  Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])) * Ibeam[nb-3] ;

<<"%V$j    $Rpat[j] \n"



  j++ ; k++ ;

// fourth restored point

  Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])  - (Beam[nb-3] * Rpat[j-3])) * Ibeam[nb-4] ;

<<"%V$j    $Rpat[j] \n"


  j++ ; k++ ;

//  fifth restored point --- length of convolved beam

  Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])  - (Beam[nb-3] * Rpat[j-3])  - (Beam[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;

<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;


//  thereafter same eqn till  we get to end of Outpat array

 Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])  - (Beam[nb-3] * Rpat[j-3])  - (Beam[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;

 Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])  - (Beam[nb-3] * Rpat[j-3])  - (Beam[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"

 if (Rpat[j] < 0) {
     Rpat[j] = 0;
 }

  j++ ; k++ ;

  end = 0 


 while (end < 5) {

 Rpat[j] = (Outpat[k] - (Beam[nb-1] * Rpat[j-1])  - (Beam[nb-2] * Rpat[j-2])  - (Beam[nb-3] * Rpat[j-3])  - (Beam[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"
 if (Rpat[j] < 0) {
     Rpat[j] = 0;
 }

  j++ ; k++ ;

  end++
}


  for (i = 0; i < 32; i++) {

// FIXME
//<<[C],"$i $Inpat[i] $Outpat[i+5] \n"
  ip = Inpat[i]
  op = Outpat[i+2]
  rp = Rpat[i]
<<[C],"$i $ip $op $rp\n"

  }









stop!