// BUG_FIX 

SetPCW("writeexe","writepic")
SetDebug(1)


//  FIXME_PARSE         if ( alt < ICAO_SA[kk][0]) {
//  version 1.2.33



float ICAO_SA[40][8]



  for (i = 0; i < 40; i++) {

     ICAO_SA[i][0] = i 
     ICAO_SA[i][1] = i * 2.0
     ICAO_SA[i][3] = i * 3.0

  }




  float alt = 30.0

  kk = 0
  found = 0
  ns = 0

  while (1) {


 //          if ( alt > 100000) {
 //                    break
 //          }

     if ( alt < ICAO_SA[kk][0]) {
      <<" thres0 met \n"
<<"%V $kk  $alt $ICAO_SA[kk][0] $ICAO_SA[kk][3] $ICAO_SA[kk][4] \n"
        found = 1
        break
     }


     if ( alt <= ICAO_SA[kk][0]) {
      <<" thres1 met \n"
<<"%V $kk  $alt $ICAO_SA[kk][0] $ICAO_SA[kk][3] $ICAO_SA[kk][4] \n"
     }
    icao_alt = ICAO_SA[kk][0]

     if ( alt < icao_alt) {
      <<" thres2 met \n"
        found = 1
        break
     }

    kk++
    if (kk >= 35) 
       break
  }

<<"%V $kk  $found $ns\n"




// FIX is if (  exp)  -- is treated as LHS
//     a < V[kk][0]   --- treated as  LHS
//     a <= V[kk][0]   --- treat as RHS
#{
[39] <21> 16835  EXPRESSION   ( alt < ICAO_SA[kk][0]) 
	<21>  1 [ 12] PUSH_SIV :   alt 321 -1 0
	<21>  2 [ 12] PUSH_SIV :   kk 214 -1 0
	<21>  3 [  9] LOADRN : 0 
	<21>  4 [ 48] PUSH_LSIVELE :   ICAO_SA 527 -1 0
	<21>  5 [  6] OPERA :  LT
	<21>  6 [  7] ENDIC :
#}

//V[kk][0]   --- tread as RHS

  //FIX  ICAO_SA[0:39][3] = 7
  //FIX    ICAO_SA[0:39][4] = Fgen(40,0,3)

proc foo()
{
  kk = 0
  found = 0
  ns = 0
  while (1) {


 //          if ( alt > 100000) {
 //                    break
 //          }


     if ( alt < ICAO_SA[kk][0]) {
     ns = 1
     found = 1
     break
     }

//<<"%V $kk  $alt $ICAO_SA[kk][0] $ICAO_SA[kk][3] $ICAO_SA[kk][4] \n"

    kk++
    if (kk >= 35) 
       break
  }

<<"%V $kk  $found $ns\n"

}

       foo()

       foo()

STOP!

#{
//////////////  FIX ///////////////////////////////////
[40] <21> 451  EXPRESSION   ( alt < ICAO_SA[kk][0]) 
	<21>  1 [ 12] PUSH_SIV :   alt 321 -1 0
	<21>  2 [ 12] PUSH_SIV :   kk 214 -1 0
	<21>  3 [  9] LOADRN : 0 
	<21>  4 [ 17] PUSH_SIVELE :   ICAO_SA 527 -1 0
	<21>  5 [  6] OPERA :  LT
	<21>  6 [  7] ENDIC :
#}