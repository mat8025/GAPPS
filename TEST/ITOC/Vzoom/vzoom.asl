/* 
 *  @script vzoom.asl 
 * 
 *  @comment test vzoom SF 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.6 C-Li-C]                                 
 *  @date Mon Jan  4 16:51:54 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

/*
R=vzoom(A,newsz,{"spline"})
linearly interpolates vector  A to newsz, return result to new vector R 
optionally a cubic spline interpolation can be used.
*/
chkIn(_dblevel)
 F = Vgen(DOUBLE_,8,0,1)

 fsz = Caz(F)

<<"%V$fsz $(typeof(F))\n"

chkR(F[6],6.0)
<<"$F \n"

 G = vzoom(F,15)

 gsz = Caz(G)

<<"%V$gsz $(typeof(G))\n"

<<"$G\n"
chkR(G[13],6.5);
chkOut()
exit()