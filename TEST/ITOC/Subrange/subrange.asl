/* 
   *  @script subrange.asl
   *  @comment test lhs vector range assignment
   *  @release CARBON
   *  @vers 1.3 Li Lithium [asl 6.3.58 C-Li-Ce]
   *  @date 11/04/2021 20:56:27
   *  @cdate Sun Apr 26 10:20:19 2020
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *  \\-----------------<v_&_v>--------------------------//
 */ 

   
///
///  subrange vector assign
///

   chkIn(_dblevel);



   int L[24];



  L.pinfo()


void Hey(int V[])
{
<<"\nIN V: $V\n"

   L= 17; // set global vec to constant

   L.pinfo(); // show info on vector

   V = 18;
   
   V.pinfo()

  <<"V: $V\n"


}
//==========================


//==========================

   I = Vgen(INT_,40,0);

   pinfo(I);

   

   I[5:8] = 10;

   pinfo(I);

   chkR(I[0],0);

   chkR(I[5],10);

   chkR(I[8],10);

   <<"$I\n";

   I[20:28:2] = 79;

   <<"$I\n";

   I[16:14:-1] = 47;

   <<"$I\n";

   I[13:13] = 80;

   <<"$I\n";

   I = 0;

   <<"$I\n";

   <<"all zero ??\n";

   chkN(I[0],0);

   chkN(I[1],0);

   I[::] = 79;

   <<"$I\n";

   <<"all gold ??\n";

   chkN(I[8],79);

   <<"/////////\n";

   I = 47;

   <<"$I\n";

   <<"all silver ??\n";

   chkN(I[9],47);

   <<"/////////\n";

   I[::] = 80;

   <<"$I\n";

   <<"all fast ??\n";

   chkN(I[10],80);

   <<"/////////\n";

   I[0:5:] = 47;

   I[6:10:] = 79;

   chkN(I[9],79);

   I[11:15:] = 28;

   chkN(I[15],28);

   <<"$I\n";

   I[30:30] = 30;

   chkN(I[0],47);

   chkN(I[30],30);

   chkN(I[31],80);

   <<"$I\n";

   chkStage("subrange");

L.pinfo()



   chkN(L[0],0);

   chkN(L[23],0);

   <<"$L\n";

   L = 79;

   chkN(L[0],79);

   chkN(L[23],79);

   <<"$L\n";

   L = 0;

   chkN(L[0],0);

   chkN(L[23],0);

   <<"$L\n";

   L[5:8] = 1;

   chkN(L[0],0);

   chkN(L[23],0);

   chkN(L[5],1);

   chkN(L[8],1);

   Hey(L);

   <<"$L\n";

   pinfo(L);

   chkN(L[0],18);

   chkN(L[23],18);

   chkOut();

   L= 80;

   Hey(L);

   <<"$L\n";

   chkN(L[0],18);

   chkN(L[23],18);
//chkN(L[5],18)

   L[5:8] = 74;

   <<"$L\n";

   chkN(L[5],74);

   chkStage("subrange2");

   chkOut();
