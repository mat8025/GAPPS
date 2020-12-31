//%*********************************************** 
//*  @script dotp.asl 
//* 
//*  @comment test dotp -vec1 * vec2 summed 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.3.2 C-Li-He]                                
//*  @date Mon Dec 28 21:49:45 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
// test dotp


// dp =  dotp(v1,v2)
// sum of products of elements of vectors


 D1 = vgen(INT_,4,0,1)

 D2 = vgen(FLOAT_,4,1,2)

 <<"$D1 \n"

 <<"$D2 \n"


  dp = dotp(D1,D2)


<<"%V$dp \n"

<<"$(typeof(dp)) \n"

 chkR(dp,34)

 chkOut()



 