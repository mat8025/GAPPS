//%*********************************************** 
//*  @script vrange.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat Feb  1 09:51:06 2020 
//*  @cdate Sat Feb  1 09:51:06 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
////
////
////

/{/*
vrange()

/////
vrange(A,floor,ceil,newrange_lower,newrange_upper)
rescales values in vector A that are equal to floor and between or equal to ceil to a
a different range (using linear extrapolation) that is from  newrange_lower to newrange_upper.
Any value in the original vector below floor is set to newrange_lower any value above ceil in the original
vector is set to newrange_upper. 
If newrange_upper is not specified then zero is assummed for newrange_lower
and the third parameter is taken  as newrange_upper.
The function returns a new vector (float, double) with the transformed values.

/////
/}*/
include "debug"
debugON()
setdebug(1,@pline,@trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");

setDebug(1,@pline)

checkIn()
 I = Vgen(INT_,30,-10,1)

<<"$I \n"

checkFnum(I[0],-10)
checkFnum(I[29],19)

 R = vrange(I,0,10,100,500);

<<"$R \n"

checkFnum(R[0],100)
checkFnum(R[29],500)



SI = I[0:10:1]

<<"I[0:10:1]   $SI\n"

checkNum(SI[0],-10)
checkNum(SI[10],0)


SI = I[0:10:2]

<<"I[0:10:2]   $SI\n"

checkNum(SI[0],-10)
checkNum(SI[5],0)

//checkOut();
//exit()

SI = I[0:-1:2]

<<"I[0:-1:2]   $SI\n"
sz=Caz(SI)
checkNum(sz,15)

checkNum(SI[0],-10)
checkNum(SI[14],18)



SI = I[10:20:1]

<<"I[10:20:1]   $SI\n"
sz=Caz(SI)
<<"%V $sz\n"
checkNum(sz,11)

checkNum(SI[0],0)
checkNum(SI[10],10)

SI = I[20:10:-1]



<<"I[20:10:-1]   $SI\n"
<<"%V$I[20]\n"
<<"%V$I[10]\n"

sz=Caz(SI)
<<"%V $sz\n"
checkNum(sz,11)



// should do a circular buffer
 I = Vgen(INT_,30,0,1)

<<"%V$I \n"

SI= I[20:10:1] ;

<<"I[20:10:1]   $SI\n"
<<"%V$I[20]\n"
<<"%V$I[10]\n"



sz=Caz(SI)
<<"%V $sz\n"
checkNum(sz,21)
checkNum(SI[0],20)
checkNum(SI[20],10)



<<"%V$I[20:10:1] \n"
// TBF print out not working


SI= I[::] ;   // all
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[::]\n"

checkNum(sz,30)
checkNum(SI[0],0)
checkNum(SI[29],29)

//  start from 2

SI= I[2::] ;   // 
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[2::]\n"

checkNum(sz,28)
checkNum(SI[0],2)
checkNum(SI[27],29)


//  start from 2

SI= I[2:10:] ;   // 
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[2:10:]\n"

checkNum(sz,9)
checkNum(SI[0],2)
checkNum(SI[-1],10)


SI= I[::2] ;   // all skip every other
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[::2]\n"

checkNum(sz,15)
checkNum(SI[0],0)
checkNum(SI[-1],28)

//checkOut()
//exit()

SI= I[1::2] ;   // start 1 skip very other
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[1::2]\n"

checkNum(sz,15)
checkNum(SI[0],1)
checkNum(SI[-1],29)


SI= I[:10:] ;   // defs  specify end
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[:10:]\n"


// -1 means end
checkNum(sz,11)
checkNum(SI[0],0)
checkNum(SI[-1],10)
checkNum(SI[10],10)
<<"%V$SI[-1]\n"
<<"%V$SI[-2]\n"

SI= I[-1:-10:-1] ;  
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"

// warp around till last -10 position
SI= I[-1:-10:1] ;  
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[-1] $I[-10]\n"

checkOut();