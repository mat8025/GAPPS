//
// test sub vector range specification and subset value setting
//

CheckIn()

setDebug(1)

float real[20+]  // dynamic array

 wlen = 10


 real[1:wlen] = 77.0

<<"%V6.2f$real \n"

   CheckFNum(real[2],77,1)   

// FIX float YS[] = Fgen(32,0,1)

  YS = Fgen(32,0,1)

<<"%V6.2f$YS \n"

<<"$wlen \n"



float swin[wlen]
   
   swin = 1.0

<<"%V$swin \n"

rwlm = wlen -1

ki = 2
ji = ki + wlen -1

  real[0:wlen-1] = YS[ki:ji] 

<<"%V $ki $ji $wlen \n"

<<"%V %6.2f$real \n"

   CheckFNum(real[2],4.0,1)   
   CheckFNum(real[9],11.0,1)   


ki = 4
ji = ki + wlen -1

  real[0:wlen-1] = YS[ki:ji] 

<<"$ki %6.2f$real \n"




  for (j=0;j<3;j++) {

   ki = j
   ji = ki + wlen -1

  real[0:wlen-1] = YS[ki:ji] 
<<"$ki %6.2f$real \n"
   CheckFNum(real[0],j,1)   
   }



<<"%V $ki $ji $wlen\n"
<<" $YS[ki:ji] \n"
<<"%V $YS \n"

 sr = YS[ki:ji]
 sz = Caz(sr)

<<"%V$sz \n"

<<"%V %6.2f$sr \n"

tv= sum(sr)

<<" $(Caz(tv))\n"

<<"$tv is sum of $sr\n"



  for (j=0;j<3;j++) {

    real[0:wlen-1] = YS[ki:ji] 

    av = real
    
<<"%V$av \n"

    tv = sum(real)

<<"Num Dims $(Cad(tv))\n"

    <<"%V$tv is sum of vec\n"  

    CheckNum(tv,142)  

<<"$j %6.2f$real \n"

   }


<<" //FIX   real[0:(wlen-1)] = YS[ki:ji]  \n"

<<"last loop \n"
  for (j=0;j<3;j++) {

    real[0:(wlen-1)] = YS[ki:ji] 

   tv = sum(real)

   <<" $tv[0] \n"
    CheckNum(tv,142)  

<<"%V$j %$real \n"

   }

   tv = sum(real)

<<" $tv \n"  

   CheckOut()


STOP("DONE")
