#! /usr/local/GASP/bin/asl
#/* -*- c -*- */



// read this in from cfg/header
float mp_tambcor = 0.0
float mp_rhcor = 0.0

      double co_rh[] = { -0.340, 2.7E-2, -5.11e-4, 9.3e-7, 2.08e-9 }

<<"%v $(Cab(co_rh)) \n"
<<"%v $co_rh \n"



  double cg_rh[] = { 1.032914, -0.00273, 6.33e-5, -5.31e-7, 3.59e-9, -8.72e-12 }

<<"%v $(Cab(cg_rh)) \n"
<<" $cg_rh \n"


proc Rhcorr( tambk , rh)
 {
       //Apply Vaisala correction

  int i;

// <<"  $tambk $rh \n"

      tambc= tambk-273.160

      offset = 0.0

      for (i = 0 ; i <= 4 ; i++ ) {

        offset +=   ( co_rh[i] * tambc ^ i)

//	<<"$i $offset \n"

	  }

      gain = 0.0
 
      for (i = 0 ; i <= 5 ; i++ ) {

        gain += (cg_rh[i]  * tambc ^ i)

//	<<"$i $gain \n"

      }


//      <<"%V $offset $gain \n"

      rhcorr = gain * (rh - offset)
     
      return rhcorr
}



proc GetRh( tambk, vrh, vair)
{
   int i;

   arh = vrh * 100.0

<<"%V  $tambk, $vrh, $vair \n"

     if (vair < 2.0) {
	rh= arh + mp_rhcor
     }
     else {
<<" calling Rhcorr \n"

    rh= Rhcorr( tambk, arh)
  
     }

    rh += mp_rhcor

<<"%v $rh \n"

   if (rh < 0.0) {
      rh = 0.0
   }
   else {
    <<" rh > 0.0\n"
   }

//
//i = 3

   return rh
}


//SetDebug(0,"run")

 tak = 270.0

 vrh = 0.33

 va = 0.4

 xrh = GetRh(tak, vrh, va)


<<"%v $xrh \n"
 vrh = 0.35
 tak = 300
 va = 2.1

 xrh = GetRh(tak, vrh, va)

  va = 1.3
lv1=ofw("jnk")
<<[lv1]" into junk\n"

R= Fgen(1000,0,1.456789)
<<" $(Cab(R)) \n"


 T= R + 33
//<<" $T,\n"

Redimn(R,200,5)

//<<" $R[0][*], \n"


  for (j = 0; j < 10 ; j++) {
  tak += 2
  vrh += 0.1

  va += 0.1

   xrh = GetRh(tak, vrh, va)

<<" [${j}] %V $tak $vrh $va $xrh \n"

//<<[lv1]"%6.4f $tak $vrh $va $xrh %6.2f$R[j][*],\n"
<<"%6.4f$tak $vrh $va $xrh %6.2f$R[j][*],\n"

  }

STOP("DONE \n")