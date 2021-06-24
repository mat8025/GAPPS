/* 
 *  @script array-subvec.asl 
 * 
 *  @comment test array range subscript via vector 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.28 C-Li-Ni]                                
 *  @date 02/27/2021 14:33:27 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
<|Use_=
Demo  of vector set via nested array index
S = YV[P]
where P is vec
///////////////////////
|>



#include "debug"

if (_dblevel >0) {
   debugON()
     <<"$Use_\n"   
}

chkIn(_dblevel)


// test array indexing

 N = 20

 YV = vgen(INT_,N,20,1)

<<" %V$YV \n"

 vi = 5

<<"%V$vi\n"

int P[5]

  P[0] = 1
  P[1] = 2  
  P[2] = 3
  P[3] = 8
  P[4] = 16

<<"%V$P\n"

 chkN(P[2],3);
 chkN(P[4],16);


 
 S = YV[{P,6,7,12,13}]

<<"%V$S\n"
  S->pinfo()
  
!a
 chkN(S[0],YV[1])
 chkN(S[1],YV[2])
 chkN(S[2],YV[3])
 chkN(S[3],YV[8])

// even better

// try recurse

/*
 C = igen(2,1,1)
<<"$C\n"

 W = YV[{P[C]}]

<<"$W\n"
*/

 chkOut()

