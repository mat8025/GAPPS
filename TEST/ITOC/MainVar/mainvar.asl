//%*********************************************** 
//*  @script mainvar.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Tue Jan 28 07:47:40 2020 
//*  @cdate Tue Jan 28 07:47:40 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
include "debug.asl"

debugON()
setdebug(1,@pline,@trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


int FF[10]

FF[1] = 51;

 <<"$FF[1] \n"

checkIn(0)


checkNum(FF[1],51)

proc localv()
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

proc localmv()
{

 int ::GF[10];
 GF= igen(10,0,1);
 GF[1] = 75;
 <<"$GF[1] \n"
}


localv()


 <<"$FF \n"

checkNum(FF[1],51)
checkNum(FF[5],-5)

<<"$FF\n "

FF->delete()

//exit()

int ::FF[10]

FF[1] = 51;

 <<"$FF[1] \n"

localmv()

 <<"$GF[1] \n"

checkNum(GF[1],75)

GF->delete()

localmv()

 <<"$GF[1] \n"

GF->delete()

localmv()

 <<"$GF \n"


CheckOut()