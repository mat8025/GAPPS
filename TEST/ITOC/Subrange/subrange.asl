//%*********************************************** 
//*  @script subrange.asl 
//* 
//*  @comment test lhs vector range assignment 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sun Apr 26 22:12:02 2020 
 
//*  @cdate Sun Apr 26 10:20:19 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  subrange vector assign
///



chkIn(_dblevel)

 I = Vgen(INT_,40,0)

<<"$I \n"

 I[5:8] = 10;

 <<" $(info(I)) \n"
<<"$I\n"

chkR(I[0],0)
chkR(I[5],10)
chkR(I[8],10)



 I[20:28:2] = 79;

<<"$I\n"

 I[16:14:-1] = 47;

<<"$I\n"

 I[13:13] = 80;

<<"$I\n"


 I = 0;
<<"$I\n"
<<"all zero ??\n"
checknum(I[0],0)
checknum(I[1],0)

 I[::] = 79;

<<"$I\n"
<<"all gold ??\n"
checknum(I[8],79)
<<"/////////\n"
 I = 47;
<<"$I\n"
<<"all silver ??\n"
checknum(I[9],47)
<<"/////////\n"
 I[::] = 80;

<<"$I\n"
<<"all fast ??\n"
checknum(I[10],80)

<<"/////////\n"

 I[0:5:] = 47;
  I[6:10:] = 79;
checknum(I[9],79)


  I[11:15:] = 28;

checknum(I[15],28)
<<"$I\n"
  I[30:30] = 30;
checknum(I[0],47)

checknum(I[30],30)
checknum(I[31],80)
<<"$I\n"

chkStage("subrange")


int L[24];

chkN(L[0],0)
chkN(L[23],0)
<<"$L\n"

L = 79;
chkN(L[0],79)
chkN(L[23],79)

<<"$L\n"


L = 0;

chkN(L[0],0)
chkN(L[23],0)

<<"$L\n"

L[5:8] = 1;

chkN(L[0],0)
chkN(L[23],0)
chkN(L[5],1)
chkN(L[8],1)

proc Hey(int V[])
{
<<"\nIN V: $V\n"

 L= 17;

<<"L: $L\n"

 V = 18;

<<"V: $V\n"

}
//==========================

Hey(L);

<<"$L\n"

chkN(L[0],18)
chkN(L[23],18)


L= 80;

Hey(L);

<<"$L\n"

chkN(L[0],18)
chkN(L[23],18)
//chkN(L[5],18)

L[5:8] = 74;
<<"$L\n"


chkN(L[5],74)

chkStage("subrange2")



chkOut();