
CheckIn()

//  FIXME_PARSE         if ( alt < ICAO_SA[kk][0]) {
//  version 1.2.33



float ICAO_SA[10][4]

ICAO_SA[0][0] = 3 

<<"%I $ICAO_SA[0][0] \n"

ICAO_SA[0][3] = 7 

<<"%I $ICAO_SA[0][3] \n"

ICAO_SA[2][3] = 18 

<<"%I $ICAO_SA[2][3] \n"


 CheckFNum(ICAO_SA[2][3],18,6)
 CheckFNum(ICAO_SA[0][3],7,6)


 i = 1
 k = 2


ICAO_SA[i][k] = 69 

ICAO_SA[k][i] = 73 

<<"%I $ICAO_SA[i][k] \n"

<<"%I $ICAO_SA[k][i] \n"


CheckFNum(ICAO_SA[i][k],69,6)
CheckFNum(ICAO_SA[k][i],73,6)

y = k * 2 

<<"%I $y \n"

ICAO_SA[k][i] = (k * 2) 

<<"$ICAO_SA[k][i]  should be 4 !\n"

<<"$ICAO_SA\n"

CheckFNum(ICAO_SA[k][i],4,6)

ICAO_SA[k][i] = 5

<<"$ICAO_SA\n"

<<"%V$ICAO_SA[k][i]  should be 5 !\n"

ICAO_SA[k][i] = (k * 3) 

<<"$ICAO_SA[k][i]  should be 6 !\n"

<<"$ICAO_SA\n"
j= (k * 3) 
ICAO_SA[k][i] = 707

<<"$ICAO_SA\n"
j = 787
ICAO_SA[k][i+1] = j

<<"$ICAO_SA\n"

CheckFNum(ICAO_SA[k][i+1],787,3)


ICAO_SA[k][i] = k

<<"%I $ICAO_SA[k][i]  should be $k !\n"


CheckNum(ICAO_SA[k][i],k)





i = 5

    ICAO_SA[i][k] = i * 2;

<<"%I $ICAO_SA[i][k] \n"

CheckNum(ICAO_SA[i][k], (i *2))


<<" ///////////// \n"
  k = 3;

  for (i = 1; i < 10; i++) {

<<" $i $k \n"

    ICAO_SA[i][k] = i * 2;

<<"%v $ICAO_SA[i][k] \n"

    z = i * 2;

    y = ICAO_SA[i][k];

<<"%v $y \n"

<<"$i $k $z $y \n"

//FIXME   <<" %4r${ICAO_SA[i][0:2]} \n"

  }




i = 6

<<"%I $ICAO_SA[i][k] \n"
<<" ///////////// \n"
//FIXME <<"%4r $ICAO_SA \n"

<<" %(\t->\s,,\s<-\n)$ICAO_SA \n"

CheckOut()






STOP()

STOP!

  for (i = 0; i < 10; i++) {

     ICAO_SA[i][0] = i 
     ICAO_SA[i][1] = i * 1.0
     ICAO_SA[i][2] = i * 2.0
     ICAO_SA[i][3] = i * 3.0

<<" $ICAO_SA[i][1] \n"
  }

//<<" $ICAO_SA \n"

STOP!




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

CheckNum(kk,31)

  CheckOut()



STOP!

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