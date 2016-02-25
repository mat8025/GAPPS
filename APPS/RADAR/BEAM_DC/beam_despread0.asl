//      crude de-convolution   of beam against reflectivity shape

//    32 pixel positions


//    input pattern

float Inpat[32]

Inpat[15:17] = 10


Inpat[15] = 20
Inpat[16] = 30
Inpat[17] = 40
Inpat[18] = 40
Inpat[19] = 30
Inpat[20] = 20


<<"$Inpat \n"
nb = 5
float Bm[nb] = { 0.25, 0.5, 1.0, 0.5, 0.25 }


half_bw = 2 ; // skirts are two elements long and symmetrical

int mp 

 mp = nb/2

<<"%V$half_bw $mp \n"

Ibeam = 1.0/Bm


<<"$Bm \n"

<<"$Ibeam \n"



 Op = lconvolve( Bm, Inpat)

<<"$Op \n"

sz= Caz(Op)

<<"$sz \n"




float R[40]

R = 0.0

k = 0

  while (Op[k] == 0.0) {

    k++
//    Rpat[k] = 0.0
  }

<<"$k $Op[k] \n"



// first restored point
//  j = k + half_bw; // restored edge
  j = k
<<"%V$j \n"

 if (j < 0) {
 <<"no LH edge\n"
  stop!
 }

// so outside right ele would be over intial input left-hand edge !?

<<"%V$j    $R[j] \n"
rpt = 1

  R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


// second restored point 

 R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


// third restored point 

 R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


// forth restored point 

 R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


// fifth restored point 

 R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


  for (i = 0; i < 10; i++) {


 R[j] = (Op[k] - (R[j-4] * Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] * Bm[mp]) - (R[j-1] * Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;


  }


////////////////////////////////  output recovered signal ////////////////////////////////////////

C=ofw("bds.dat")


  for (i = 0; i < 32; i++) {

// FIXME
//<<[C],"$i $Inpat[i] $Op[i+5] \n"
  ip = Inpat[i]
  op = Op[i+2]
  rp = R[i]
<<[C],"$i $ip $op $rp\n"

  }

















/{
// first go -
// second restored point 

  Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])) * Ibeam[nb-2] ;

<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;

// third restored point
  Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])) * Ibeam[nb-3] ;

<<"%V$j    $Rpat[j] \n"



  j++ ; k++ ;

// fourth restored point

  Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])  - (Bm[nb-3] * Rpat[j-3])) * Ibeam[nb-4] ;

<<"%V$j    $Rpat[j] \n"


  j++ ; k++ ;

//  fifth restored point --- length of convolved beam

  Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])  - (Bm[nb-3] * Rpat[j-3])  - (Bm[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;

<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;


//  thereafter same eqn till  we get to end of Op array

 Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])  - (Bm[nb-3] * Rpat[j-3])  - (Bm[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"

  j++ ; k++ ;

 Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])  - (Bm[nb-3] * Rpat[j-3])  - (Bm[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"

 if (Rpat[j] < 0) {
     Rpat[j] = 0;
 }

  j++ ; k++ ;

  end = 0 


 while (end < 5) {

 Rpat[j] = (Op[k] - (Bm[nb-1] * Rpat[j-1])  - (Bm[nb-2] * Rpat[j-2])  - (Bm[nb-3] * Rpat[j-3])  - (Bm[nb-4] * Rpat[j-4] )) * Ibeam[nb-5] ;
 
<<"%V$j    $Rpat[j] \n"
 if (Rpat[j] < 0) {
     Rpat[j] = 0;
 }

  j++ ; k++ ;

  end++
}

/}






stop!