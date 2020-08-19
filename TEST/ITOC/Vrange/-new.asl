//%*********************************************** 
//*  @script vrange 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat Feb  1 09:50:58 2020 
//*  @cdate Sat Feb  1 09:50:58 2020 
//*  @author Mark Terry 
//*  @Copyright Â© RootMeanSquare  2010,2020 â†’ 
//* 
//***********************************************%
#! /usr/local/GASP/bin/asl -x 
setDebug(1,@pline)
@chkIn()
I = Vgen(3,30,-10,1)
<<"$I \n"
*chkR(I[0],-10)
@chkR(I[29],19)
@R = vrange(I,0,10,100,500);
<<"$R \n"
*chkR(R[0],100)
@chkR(R[29],500)
@……SI = I[0:10:1]
<<"I[0:10:1]   $SI\n"
*chkN(SI[0],-10)
@chkN(SI[10],0)
@SI = I[0:10:2]
S<<"I[0:10:2]   $SI\n"
*chkN(SI[0],-10)
@chkN(SI[5],0)
@SI = I[0:-1:2]
S<<"I[0:-1:2]   $SI\n"
*sz=Caz(SI)
chkN(sz,15)
chkN(SI[0],-10)
@chkN(SI[14],18)
@SI = I[10:20:1]
S<<"I[10:20:1]   $SI\n"
*sz=Caz(SI)
S<<"%V $sz\n"
*chkN(sz,11)
chkN(SI[0],0)
@chkN(SI[10],10)
@SI = I[20:10:-1]
S<<"I[20:10:-1]   $SI\n"
*<<"%V$I[20]\n"
*<<"%V$I[10]\n"
*sz=Caz(SI)
S<<"%V $sz\n"
*chkN(sz,11)
I = Vgen(3,30,0,1)
S<<"%V$I \n"
*SI= I[20:10:1] ;
S<<"I[20:10:1]   $SI\n"
*<<"%V$I[20]\n"
*<<"%V$I[10]\n"
*sz=Caz(SI)
S<<"%V $sz\n"
*chkN(sz,21)
chkN(SI[0],20)
@chkN(SI[20],10)
@<<"%V$I[20:10:1] \n"
*SI= I[::] ;
S// all
sz=Caz(SI)
S<<"%V $sz\n"
*<<"%V$SI\n"
*<<"%V$I[::]\n"
*chkN(sz,30)
„chkN(SI[0],0)
@chkN(SI[29],29)
@chkOut();
_codeend();
ECB
