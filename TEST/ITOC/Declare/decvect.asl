
/* 
 *  @script decvect.asl 
 * 
 *  @comment test vec declare 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Fri Feb  5 14:12:52 2021 
 *  @cdate 2/19/2022 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

//Str Use_ = "Demo  of Vec declare Vec<INT> V(10,0,1)";



#include "debug.asl";



if (_dblevel >0) {
   debugON()
   //<<"$Use_\n"
}


chkIn()



////
////  declare our vector class -- compatible with cpp declaration
////  Vec<T> V(10,0,1)
////
////  Vec  V(INT,10,0,1)


// Vec <DOUBLE> V(10,0,1)

 Vec V(DOUBLE_,10,0,1);

  V[3] = 85.45;
<<"$V\n"
   V.pinfo()

 Vec <INT> D(10,0,1);

   D.pinfo();



   D[3] = 67;

<<"$D\n"
   D.pinfo()

chkN(D[3],67);
chkOut()
