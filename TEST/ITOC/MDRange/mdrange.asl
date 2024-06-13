/* 
 *  @script mdrange.asl                                                 
 * 
 *  @comment check md range ops                                         
 *  @release Carbon                                                     
 *  @vers 1.2 He Helium [asl 6.29 : C Cu]                               
 *  @date 06/13/2024 18:56:15                                           
 *  @cdate Mon Feb 3 08:48:06 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

<|Use_=
   Demo  of MD  range
///////////////////////
|>

#include "debug";

   if (_dblevel >0) {

        debugON();

        <<"$Use_\n";

   }

   chkIn();

   int MD[5][20];

   MD.pinfo();
//!p MD

   MD[0][1] = 77;

   <<"%V $MD[0][1]\n";

   chkN(MD[0][1],77);

   chkN(MD[0][1],77, "init Array zero ");

   chkN(MD[0][-1],0);

   chkN(MD[0][-1],0,"init Array zero ");

   MD[0][1] = 79;

   chkN(MD[0][1],79,"Set element");

   MD[0][0:19:1] = 79;

   chkN(MD[0][2],79,"set subset of elements");

   MD[1][::] = 80;

   chkN(MD[1][1],80,"set default range");

   <<"$MD\n";

   MD[0][5:10:1] = 54;

   chkN(MD[0][5],54,"set subset of eles");

   MD[1][6:11:1] = 28;

   chkN(MD[1][6],28,"set subset of eles");

   MD[1][6:11:] = 28;

   chkN(MD[1][6],28,"set subset of eles-default step");

   <<"$MD\n";

   MD[2:4:1][6:11:1] = 77;

   <<"$MD\n";

   chkN(MD[3][6],77,"set subset of eles");

   MD[2:4:1][6:11:] = 78;

   chkN(MD[3][6],78,"set subset of eles-default stride");
/////////////////////////////////////////   3D /////////////////////////////////////////

   int M3D[3][5][20];

   <<"$M3D \n";

   M3D[1][1][1] = 16;

   M3D[2][2][2] = 18;

   <<"$M3D \n";

   chkN(M3D[1][1][1],16,"3D ele set");

   chkN(M3D[2][2][2],18,"3D ele set");

   M3D[1][1][2:10:1] = 6;

   <<"$M3D \n";

   chkN(M3D[1][1][2],6,"3D inner range set");

   M3D[1][1:3][2:10:1] = 15;

   <<"$M3D \n";

   chkN(M3D[1][1][2],15,"3D middle & inner range set");

   chkN(M3D[1][1][10],15,"3D middle & inner range set");

   chkN(M3D[1][2][2],15,"3D middle & inner range set");

   chkN(M3D[1][2][10],15,"3D middle & inner range set");

   chkN(M3D[1][3][10],15,"3D middle & inner range set");

   M3D[2][1:3][2:10:1] = 17;

   chkN(M3D[2][1][2],17,"3D middle & inner range set");

   chkN(M3D[2][1][10],17,"3D middle & inner range set");

   chkN(M3D[2][2][2],17,"3D middle & inner range set");

   chkN(M3D[2][2][10],17,"3D middle & inner range set");

   chkN(M3D[2][3][10],17,"3D middle & inner range set");

   <<"$M3D \n";

   M3D[1:2][1:3][2:10:1] = 18;

   <<"$M3D \n";

   chkN(M3D[2][1][2],18,"3D outer  middle & inner range set");

   chkN(M3D[2][1][10],18);

   chkN(M3D[2][2][2],18);

   chkN(M3D[2][2][10],18);

   chkN(M3D[2][3][10],18);

   M3D[::][1:3][2:10:1] = 19;

   <<"$M3D \n";

   chkN(M3D[0][1][2],19,"3D outer all");

   chkN(M3D[1][1][10],19,"3D outer all");

   chkN(M3D[2][2][2],19,"3D outer all");

   chkN(M3D[0][2][10],19,"3D outer all");

   chkN(M3D[1][3][10],19,"3D outer all");

   chkN(M3D[2][3][10],19,"3D outer all middle & inner range set");

   I = vgen(INT_,20,0,1);

   <<"$I\n";

   M3D[::][1:3][2:10:1] = I[2:10];

   <<"$M3D \n";
///////////////////////////////// M4D //////////////////////////////////////

   int M4D[2][3][5][20];
//M4D = vgen(INT_,600,0,1);

   sz=Caz(M4D);

   bd = Cab(M4D);

   <<"%V $sz $bd\n";

   M4D.info(1);
//M4D.redimn(2,3,5,20)

   sz=Caz(M4D);

   bd = Cab(M4D);

   <<"%V $sz $bd\n";

   <<"$M4D \n";

   M4D[0][1][1][1] = 16;

   M4D[1][2][2][2] = 18;

   <<"$M4D \n";

   chkN(M4D[0][1][1][1],16,"4D ele set");

   chkN(M4D[1][2][2][2],18,"4D ele set");

   M4D[0][1:2][1:3][2:12:1] = 47;

   chkN(M4D[0][1][2][10],47,"4D outer ele middle & inner range set");

   <<"$M4D \n";

   M4D[1][1:2][1:3][2:12:1] = 47;

   chkN(M4D[1][1][2][10],47,"4D outer ele middle & inner range set");

   <<"$M4D \n";
//chkOut(); exit();

   M4D[::][1:2][1:3][2:18:1] = 48;

   chkN(M4D[1][1][2][10],48,"4D outer ele middle & inner range set");

   <<"$M4D \n";

   M4D[::][1:2][1:4][2:18:1] = 50;

   chkN(M4D[1][1][2][10],50,"4D outer ele middle & inner range set");

   <<"$M4D \n";
// bug - XIC does not check bounds - fixed?
//M4D[::][1:3][1:4][2:18:1] = 51

   M4D[::][1:2][1:4][2:18:1] = 51;

   nb = Cab(M4D);

   <<"%V $nb \n";

   chkN(M4D[1][1][2][10],51,"4D outer ele middle & inner range set");

   M4D[::][0:2][1:4][2:18:1] = 52;

   chkN(M4D[1][1][2][10],52,"4D outer ele middle & inner range set");

   <<"$M4D \n";

   M4D[::][0:2][0:4][2:18:1] = 53;

   M4D[1][2][4][19] = 90;

   chkN(M4D[1][1][2][10],53,"4D outer ele middle & inner range set");

   chkN(M4D[1][2][4][10],53,"4D outer ele middle & inner range set");

   chkN(M4D[1][2][4][18],53,"4D outer ele middle & inner range set");

   chkN(M4D[1][2][4][19],90,"4D outer ele middle & inner range set");

   <<"$M4D \n";

   M4D[0][0][0:4][2:18:1] = I[2:18];

   I += 1;

   M4D[0][1][0:4][2:18:1] = I[2:18];

   I += 1;

   M4D[0][2][0:4][2:18:1] = I[2:18];

   I += 1;

   M4D[1][0][0:4][2:18:1] = I[2:18];

   I += 1;

   M4D[1][1][0:4][2:18:1] = I[2:18];

   I += 1;

   M4D[1][2][0:4][2:18:1] = I[2:18];

   I += 1;
//M4D[1][0:2][0:4][2:18:1] = I[2:18]

   <<"$M4D \n";

   chkN(M4D[0][2][4][2],4,"4D outer ele middle & inner range set");

   chkN(M4D[1][2][4][2],7,"4D outer ele middle & inner range set");

   chkN(M4D[0][2][4][18],20,"4D outer ele middle & inner range set");

   chkN(M4D[1][2][4][18],23,"4D outer ele middle & inner range set");

   M4D.pinfo();

   chkOut();

   exit();

   M4D[1][1][1][5:15] = 86;

   <<"$M4D \n";

   chkOut();
   
/*

 Should be able to specify a subset of a MD array for operations







*/

//==============\_(^-^)_/==================//
