/* 
 *  @script ptr.asl 
 * 
 *  @comment test ptr ops 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.30 C-Li-Zn] 
 *  @date 03/13/2021 09:40:47 
 *  @cdate Mon Aug 10 10:50:42 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
   



<|Use_=
Demo  of ptr type

///////////////////////
|>


                                                                        
#include "debug"
#include "hv.asl"


if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}

 allowErrors(-1)


I = vgen(INT_,10,0,1)

chkN(I[1],1)
chkN(I[9],9)

<<"$I \n"

I<-pinfo()

p = &I[3];

p<-pinfo();
I<-pinfo();

int G[10]

G[3] = 77;

G<-pinfo();

nc= vvcopy(G,I,ALL_);

<<"$nc elements copied\n"

<<"%V $G\n"

chkN(G[1],1)


nc= vvcopy(G,&I[3], ALL_);

<<"$nc elements copied\n"
p<-pinfo();
<<"%V $G\n"

nc= vvcopy(G,p, ALL_);

<<"$nc elements copied\n"

p = &I[3];
<<"%V $G\n"
p<-info()

 p = 56; // p is ptr to a vec -- this says set all vector elements to 56
// but using is lhoffset of 3 into vec I -- TBF
<<"$I \n"
 chkN(I[0],0)
 chkN(I[3],56)
 
 p = vgen(INT_,3,-1,1)

<<"$I \n"

  J= p;  // copy ptr
<<"%V $J\n"
  J<-pinfo()




int a = 2

a<-pinfo()

    d = &a
    d = 3

<<"%v $a \n"

<<"%v $d \n"

d<-info();

chkT(1)
chkOut()