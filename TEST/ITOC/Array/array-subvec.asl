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



#include "debug"

if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)


// test array indexing

N = 20

 YV = Igen(N,21,1)

<<" %V$YV \n"

 vi = 5

<<"%V$vi\n"

int P[10]

  P[1] = 1
  P[2] = 3
  P[3] = 8
  P[4] = 16

<<"%V$P\n"

 
 S = YV[P]

<<"%V$S\n"

 chkN(S[1],YV[1])

 chkN(S[2],YV[3])

 chkN(S[3],YV[8])

// even better

 C = igen(2,1,1)
<<"$C\n"

 W = YV[P[C]]

<<"$W\n"

 chkOut()

