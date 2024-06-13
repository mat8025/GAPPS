/* 
 *  @script shift.asl                                                   
 * 
 *  @comment Test shiftL shiftR SF                                      
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.28 : C Ni]                              
 *  @date 06/12/2024 18:06:45                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

<|Use_=
   shiftL()
   I.shiftL(newval,[nplaces],[vecsize])
   An  VMF operation to shift elements of an vector one place to the left
   and replace the last element with a  new val.
   Can be repeated nplaces.
   If vector size is specified as less than actual size the element can
   be inserted at the specified 'end'. (same for shiftR)
|>


   void showUse()
   {

        <<"$Use_\n";
   }
//==================================
#include "debug"

   if (_dblevel >0) {

        debugON();

        showUse();

   }

   chkIn();

   I = vgen(INT_,10,0,1);

   <<"$I \n";

   chkN(I[0],0);

   I.shiftL(I[0]);

   chkN(I[0],1);

   <<"$I \n";

   I.shiftL(I[0]);

   chkN(I[0],2);

   chkN(I[9],1);

   <<"$I \n";

   I.shiftL();

   <<"$I \n";

   I.shiftL(10);

   <<"$I \n";

   D = vgen(DOUBLE_,10,0,1);

   <<"%6.2f$D \n";

   D.shiftL(10);

   chkN(D[0],1);

   <<"%6.2f$D \n";

   I.shiftR(-1);

   <<"$I \n";

   chkN(I[0],-1);

   chkN(I[9],0);

   D.shiftR(-47);

   chkN(D[0],-47);

   <<"%6.2f$D \n";

   D.shiftR(79);

   chkN(D[0],79);

   chkN(D[1],-47);

   <<"%6.2f$D \n";

   I.shiftR(-79,5);

   <<"$I \n";

   I.shiftR();

   chkN(I[0],0);

   <<"$I \n";

   chkOut();

//==============\_(^-^)_/==================//
