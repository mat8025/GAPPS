//%*********************************************** 
//*  @script atoi.asl 
//* 
//*  @comment Test atoi SF 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.98 C-He-Cf]                               
//*  @date Mon Dec 21 21:00:15 2020 
//*  @cdate Mon Dec 21 21:00:15 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  atoi function
///

/*

  should work for a single str value
  or for a vector


*/

chkIn(_dblevel)

A= vgen(INT_,10,-1,1)

<<"$A\n"

k = A[2]

<<"$k\n"

chkN(k,1)
  str s = "407"
  i = atoi("407");

<<"%V $s $i \n"

chkN(i,407);


<<"  INT VEC SET/GET \n"
 int IV[];

   W = Split("-1,0,1,2,3,4,5,6,7,8,9",',');


  <<"%V $W[2] \n"
  IV = atoi(W); // TBF XIC

<<"%V$IV\n"




   chkN(IV[3],2);
  chkN(IV[8],7);

  iv3 = IV[3]
  
  iv8 = IV[8]


<<"%V $iv3 $iv8\n"

  chkOut()

  IG = vgen(INT_,10,0,1);

  <<"%V$IG[3:7]\n"

  IV2 = IG[2:7]

<<"%V$IV2\n"

 IV2[0:2] = IG[7:9]

<<"%V$IV2\n"