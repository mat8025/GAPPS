/* 
 *  @script mainvar.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.2 6.3.76 C-Li-Os 
 *  @date 01/25/2022 09:55:47          
 *  @cdate Tue Jan 28 07:47:40 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                       
///
///
///
#include "debug.asl"

if (_dblevel >0) {
  debugON()
}

int FF[10];

FF[1] = 51;

 <<"$FF[1] \n"

chkIn(_dblevel)


chkN(FF[1],51)

void localv()
{

 int FF[10];
 FF[1] = 71;
 <<"$FF[1] \n"
 ::FF[2] = 54;
 for (i= 5; i<10; i++) {
  FF[i] = i;
  }

 for (i= 5; i<10; i++) {
  ::FF[i] = -i;
  }



 FF[2] = 28
 <<"$FF \n"
}

void localmv()
{

 int ::GF[10];
 GF= igen(10,0,1);
 GF[1] = 75;
 <<"$GF[1] \n"
}


localv()


 <<"$FF \n"

chkN(FF[1],51)
chkN(FF[5],-5)

<<"$FF\n "

FF.delete();

//exit()

int ::FF[10]

FF[1] = 51;

 <<"$FF[1] \n"

localmv()

 <<"$GF[1] \n"

chkN(GF[1],75)

GF.delete()

localmv()

 <<"$GF[1] \n"

GF.delete()

localmv()

 <<"$GF \n"


chkOut()