/* 
 *  @script retype.asl 
 * 
 *  @comment Test Retype of vector 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Fri Feb  5 08:22:35 2021 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


chkIn()

F= vgen(DOUBLE_,10,0,0.25)
<<"$F\n"

dsz=Caz(F)


F->retype(INT_)

<<"$F\n"

I= F

<<"%X$I\n"
<<"$I\n"
isz=Caz(I)

<<"%V $isz $dsz\n" 



   F->retype(DOUBLE_)
dsz=Caz(F)
<<"$F\n"


   F->retype(SHORT_)
S=F
<<"$S\n"
ssz=Caz(S)
   F->retype(DOUBLE_)
dsz=Caz(F)
<<"%V $ssz $dsz\n" 



   A= cast(SHORT_,F)

asz=Caz(A)
<<"$A\n"
<<"$F\n"

  retype(CHAR_,F)
csz=Caz(F)

<<"$F\n"
<<"%V  $csz\n" 

chkN(asz,10)
chkN(isz,20)
chkN(dsz,10)
chkN(ssz,40)
chkN(csz,80)


chkOut()
exit()