/* 
 *  @script lharraysubsrange.asl 
 * 
 *  @comment test sub vector range specification and subset value setting 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.11 C-Li-Na]                                
 *  @date Sat Jan 16 21:57:31 2021 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
//
// test sub vector range specification and subset value setting
//




chkIn(_dblevel)



float vreal[]  // dynamic array

 wlen = 10


 vreal[1:wlen] = 77.0

<<"%V6.2f$vreal \n"


chkN(wlen,10);

chkR(vreal[0],0,1)   

chkR(vreal[2],77,1)   


// FIX float YS[] = Fgen(32,0,1)

YS = vgen(FLOAT_,32,0,1)

<<"%V6.2f$YS \n"

<<"$wlen \n"

chkR(YS[1],1,1)
chkR(YS[31],31,1)   




float swin[wlen];
   
   swin = 1.0

<<"%V$swin \n"

chkR(swin[0],1,1)

chkR(swin[wlen-1],1,1)   


rwlm = wlen -1;

ki = 2
ji = ki + wlen -1

  vreal[0:wlen-1] = YS[ki:ji] 

<<"%V $ki $ji $wlen \n"

<<"%V %6.2f$vreal \n"

   chkR(vreal[2],4.0,1)   
   chkR(vreal[9],11.0,1)   




ki = 4
ji = ki + wlen -1

  vreal[0:wlen-1] = YS[ki:ji] 

<<"$ki %6.2f$vreal \n"




  for (j=0;j<3;j++) {

   ki = j
   ji = ki + wlen -1

  vreal[0:wlen-1] = YS[ki:ji] 
<<"$ki %6.2f$vreal \n"
   chkR(vreal[0],j,1)   


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

    vreal[0:wlen-1] = YS[ki:ji] 

    av = vreal;

<<"%V$wlen \n"
<<"%V$av \n"

    tv = sum(vreal);

<<"Num Dims $(Cab(tv))\n"

    <<"%V6.2f $tv is sum of vec\n"  

    chkN(tv,142)  

<<"$j %6.2f$vreal \n"



   }



<<" //FIX   vreal[0:(wlen-1)] = YS[ki:ji]  \n"

<<"last loop \n"
  for (j=0;j<3;j++) {

    vreal[0:(wlen-1)] = YS[ki:ji] 

   tv = sum(vreal)

   <<" $tv[0] \n"
    chkN(tv,142)  

<<"%V$j %$vreal \n"

   }

   tv = sum(vreal)

<<" $tv \n"  



   chkOut()



