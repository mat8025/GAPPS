//
// test sub vector range specification and subset value setting
//

proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
   ans=iread(); 
}


//#define  ASK ask();
#define  ASK ;


CheckIn()

setDebug(1,"pline")

float real[]  // dynamic array

 wlen = 10


 real[1:wlen] = 77.0

<<"%V6.2f$real \n"


checkNum(wlen,10);

CheckFNum(real[0],0,1)   

CheckFNum(real[2],77,1)   


ASK

// FIX float YS[] = Fgen(32,0,1)

YS = vgen(FLOAT_,32,0,1)

<<"%V6.2f$YS \n"

<<"$wlen \n"

CheckFNum(YS[1],1,1)
CheckFNum(YS[31],31,1)   


ASK

float swin[wlen];
   
   swin = 1.0

<<"%V$swin \n"

CheckFNum(swin[0],1,1)

CheckFNum(swin[wlen-1],1,1)   


rwlm = wlen -1;

ki = 2
ji = ki + wlen -1

  real[0:wlen-1] = YS[ki:ji] 

<<"%V $ki $ji $wlen \n"

<<"%V %6.2f$real \n"

   CheckFNum(real[2],4.0,1)   
   CheckFNum(real[9],11.0,1)   


ASK

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

ASK
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

    av = real;

<<"%V$wlen \n"
<<"%V$av \n"

    tv = sum(real);

<<"Num Dims $(Cab(tv))\n"

    <<"%V6.2f $tv is sum of vec\n"  

    CheckNum(tv,142)  

<<"$j %6.2f$real \n"

ASK

   }



<<" //FIX   real[0:(wlen-1)] = YS[ki:ji]  \n"

<<"last loop \n"
  for (j=0;j<3;j++) {

    real[0:(wlen-1)] = YS[ki:ji] 

   tv = sum(real)

   <<" $tv[0] \n"
    CheckNum(tv,142)  

<<"%V$j %$real \n"
ASK
   }

   tv = sum(real)

<<" $tv \n"  

ASK

   CheckOut()



