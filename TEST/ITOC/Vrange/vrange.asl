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

/*
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
*/

Str Use_ = "Demo  of vector range [start:stop:stride]  selection\n";




#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

  // TBF range spec ops need to validated   (20,10,1)
  // should move forward till end and then restart at 0 until 10
  // a circular wrap ??

chkIn()

// I = Vgen(INT_,30,-10,1)


Vec<int> I(30,-10,1);

<<"$I \n"
//!a
chkR(I[0],-10)
chkR(I[29],19)

 R = vrange(I,0,10,100,500);

<<"$R \n"

chkR(R[0],100)
chkR(R[29],500)

<<"I.rng(0,30,2)   $I.rng(0,30,2)   \n"
//!a
 I.pinfo();

SI = I.rng(0,12,1);

SI.pinfo()

<<"%V $SI\n"
//!a
chkN(SI[0],-10)
chkN(SI[10],0)



SI = I.rng(0,10,2)
<<"$I \n"
<<"   $SI\n"

chkN(SI[0],-10)
chkN(SI[5],0)



SI = I.rng(0,-1,2);

<<"I.rng(0,-1,2)   $SI\n"
sz=Caz(SI)
chkN(sz,15)

chkN(SI[0],-10)
chkN(SI[14],18)



SI = I.rng(10,20,1)

<<"$(lastStatement(3))   $SI\n"
sz=Caz(SI)
<<"%V $sz\n"
chkN(sz,11)

chkN(SI[0],0)
chkN(SI[10],10)



SI = I.rng(20,10,-1)



<<"I.rng(20,10,-1)   $SI\n"
<<"%V$I[20]\n"
<<"%V$I[10]\n"

sz=Caz(SI)
<<"%V $sz\n"
chkN(sz,11)

lastStatement(9);

// should do a circular buffer
 Vec <int> I2(30,0,1);




<<"%V$I2 \n"
 I.pinfo()

SI= I.rng(20,10,1) ;
   SI.pinfo()


<<" $SI\n"

ans=ask(" SI OK?",0)

<<"%V $I[20]\n"

<<"%V $I[10]\n"



sz=Caz(SI)
<<"%V $sz\n"
chkN(sz,21)

 chkN(SI[0],10)

  chkN(SI[20],0)



<<"%V $I.rng(20,10,1) \n"
// TBF print out not working

 I.pinfo()
 SI= I ;   // all ?? TBF 6/13/24 xic bug?

 SI.pinfo()
 sz=Caz(SI)


 <<"%V $sz\n"
ans=ask(" SI OK?",0)


<<"%V$SI\n"
<<"%V$I\n"

chkN(sz,30)

chkN(SI[0],-10)

chkN(SI[29],19)


chkOut();



exit(-1);

//  start from 2

SI= I[2::] ;   // 
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[2::]\n"

chkN(sz,28)
chkN(SI[0],2)
chkN(SI[27],29)


//  start from 2

SI= I[2:10:] ;   // 
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[2:10:]\n"

chkN(sz,9)
chkN(SI[0],2)
chkN(SI[-1],10)

isz= Caz(I)

SI= I[::2] ;   // all skip every other
sz=Caz(SI)

<<"%V$isz $sz\n"
<<"%V$SI\n"
<<"%V$I[::2]\n"

chkN(sz,15)



chkN(SI[0],0)
chkN(SI[-1],28)

chkOut() ; exit()

SI= I[1::2] ;   // start 1 skip very other
<<"%V$SI\n"
SI= I[1:-1:2] ;   // start 1 skip very other
<<"%V$SI\n"

sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[1::2]\n"

chkN(sz,15)
chkN(SI[0],1)
chkN(SI[-1],29)


SI= I[:10:] ;   // defs  specify end
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[:10:]\n"


// -1 means end
chkN(sz,11)
chkN(SI[0],0)
chkN(SI[-1],10)
chkN(SI[10],10)
<<"%V$SI[-1]\n"
<<"%V$SI[-2]\n"

SI= I[-1:-10:-1] ;  
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"

// wrap around till last -10 position
SI= I[-1:-10:1] ;  
sz=Caz(SI)
<<"%V $sz\n"
<<"%V$SI\n"
<<"%V$I[-1] $I[-10]\n"


SI= I[:10:] ;  
sz=Caz(SI)
<<"%V $sz\n"

chkN(sz,11)

<<"%V$SI\n"
<<"%V$I[0] $I[10]\n"

int G[20]


<<"$G\n"


G[5:10]  = I[5:10]

<<"$G\n"

int H[2][20]


H[0][5:10]  = I[5:10]

<<"$H\n"

H[::][5:10]  = I[7:12]

<<"$H\n"


chkOut();
exit()




int MD[2][20];


MD[0][::] = 79

MD[1][::] = 80


<<"$MD\n"

MD[0][5:10] = 54

MD[1][6:11] = 28


<<"$MD\n"

chkOut();