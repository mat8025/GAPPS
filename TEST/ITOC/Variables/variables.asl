/* 
 *  @script variables.asl 
 * 
 *  @comment test variables SF -list out current variables 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.31 C-Li-Ga]                                
 *  @date 03/14/2021 11:07:48 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

/*

  Variables (fn, [type,values])

*/

#include "debug"


if (_dblevel >0) {
   debugON()
}


#define OAL (2,-->,,\n)

str FirstName = "Lauren";

pan p = 1.23456789;

<<" $(vinfo(p)) \n"

pan P[10];

   P[0] = 80;
   

int i = 1;

float f = 3.14159;

I=vgen(INT_,10,10,-1);

C=vgen(CHAR_,10,10,-1);

double D[];

D[3]= atan(1) * 4;

<<"$D\n"

<<" $(vinfo(p)) \n"

 T= vinfo(&p,P,C,I,&f);

<<"%(1,,,\n)$T\n"

<<"/////////////////\n"

<<" %$OAL \n"

//<<"$(OAL) $T\n"

<<"/////////////////\n"

 S=Variables(0);

<<"%(1,,,\n)$S\n"

chkStr(S[0],"C, CHAR, 10")


//chkStr(S[6],"p, PAN, 0")

<<"%(1,,,\n)$S\n"

 S=Variables(1)

<<"////\n"
<<"%(1,,,\n)$S\n"

 T= vinfo(&p,P,C,D,I,&f);

<<"%(1,,,\n)$T\n"


FirstName->info(1)

chkOut()