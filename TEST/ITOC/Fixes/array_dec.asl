//%*********************************************** 
//*  @script array-dec.asl 
//* 
//*  @comment test/fix array/svar dec 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat May  2 13:28:48 2020 
//*  @cdate Sat May  2 13:28:48 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript()



//<<"trying include \n"
//myscript = getScript()
//<<"%V $myscript \n"
///
///

#include "debug.asl"
#include "hv.asl"




#define YAB 2
<<"$(YAB)\n"
scriptDBON();


vp0 = -1
vp1 = 1
vp2 = 2

<<"%V $vp0 $vp1 $vp2\n"

int allwin1[3] = {vp0,vp1,vp2}

<<"$allwin1\n"

//sdb(1,@steptrace)

int allwin[] = {vp0,vp1,vp2}

<<"$allwin \n"


svar Mo[] = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}

<<"$Mo \n"

<<"$Mo[1] $Mo[2] \n"

