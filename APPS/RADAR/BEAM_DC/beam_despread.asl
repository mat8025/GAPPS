//      crude de-convolution   of beam against reflectivity shape

//    32 pixel positions


//    input pattern

float Inpat[64]

//Inpat[10:12] = 12

Inpat[15:17] = 10

//Inpat[20:23] = 7


//Inpat[30:35] = 5


/{
Inpat[15] = 20
Inpat[16] = 30
Inpat[17] = 40
Inpat[18] = 40
Inpat[19] = 30
Inpat[20] = 20
/}

////////////////////////////////////////////  ORIGINAL SIGNAL  /////////////////////////////////////////////
<<"$Inpat \n"


nb = 5

//  what does the beam antenna gain look like ---- symmetrical

float Bm[nb] = { 0.25, 0.5, 1.0, 0.5, 0.25 }


half_bw = 2 ; // skirts are two elements long and symmetrical

int mp 

 mp = nb/2

<<"%V$half_bw $mp \n"

Ibeam = 1.0/Bm


<<"$Bm \n"

<<"$Ibeam \n"

/////////////////////////////  STEP 0  --- convolve with the BEAM antenna pattern //////////////////////////////////////


 Op = lconvolve( Bm, Inpat)

<<"$Op \n"

sz= Caz(Op)

<<"$sz \n"




float R[100]   // recovered signal

R = 0.0

k = 0

//////////////////////// STEP 1 ---  FIND the LH EDGE of the convolved 'smeared' signal  //////////////////////////////////

  while (Op[k] == 0.0) {
    k++
  }

<<"$k $Op[k] \n"

// first restored point
//  j = k + half_bw; // restored edge


//////////////////////////////////////  setup indexes   /////////////////////////////////////////////////

  j = k
<<"%V$j \n"

 if ((j - nb) < 0) {
   <<"no LH edge\n"
   stop!
 }

// so outside right ele would be over intial input left-hand edge !?

<<"%V$j    $R[j] \n"
  rpt = 1

///  first recovered point ////////////

  R[j] = (Op[k] - (R[j-4] *Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] *Bm[mp]) - (R[j-1] *Bm[mp+1])) * Ibeam[mp+half_bw]

<<"$rpt %V$j    $R[j] \n"

  j++ ; k++ ; rpt++ ;

///  now run the deconvolution  until beam RH edge runs upto end of smeared signal - 

  for (i = 0; i < 40; i++) {


    R[j] = (Op[k] - (R[j-4] * Bm[mp-half_bw]) - (R[j-3] * Bm[mp-1]) - (R[j-2] * Bm[mp]) - (R[j-1] * Bm[mp+1])) * Ibeam[mp+half_bw]

    <<"$rpt %V$j    $R[j] \n"

    j++ ; k++ ; rpt++ ;


  }


////////////////////////////////  output recovered signal ////////////////////////////////////////

C=ofw("bds.dat")


  for (i = 0; i < 62; i++) {

// FIXME
//<<[C],"$i $Inpat[i] $Op[i+5] \n"
  ip = Inpat[i]
  op = Op[i] -2
  rp = R[i] - 1
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