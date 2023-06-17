/* 
 *  @script scmp.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.46 C-Li-Pd]                               
 *  @date 08/10/2021 08:34:25 
 *  @cdate 08/10/2021 08:34:25 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//

/*
scmp()

/////
scmp(w1,w2,{n},{case},{difference})
string compare of w1,w2 variables returns 1 if same 0 if different.
will compare up to n characters default all. 
If case set to zero a case independent match is made.
If difference set to 1 - return is as C routine strcmp.
If n is zero all the string is compared, else the first n characters.
if n less than zero the tails are compared for n elements.
Use VMF variation if S is a array of strings and you want the operation to be applied to all elements 
rv=S->scmp("and")
would return into a integer vector rv the results of a scmp operation on all elements (strings) of the
svar vector. 
(see strcmp)

/////
rv=S->scmp("and")
*/


Str Use_ = " check scmp     scmp(s1,s2)";


#include "debug.asl"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn(_dblevel)


s1 = "hey"

s2 = "hey"


if (scmp(s1,s2)) {

<<"%V $s1 $s2  scmp ==\n"

chkT(1)

}
else {

  chkT(0)

}


s2 = "hex"


if (scmp(s1,s2,2)) {

<<"%V $s1 $s2  scmp ==\n"

chkT(1)

}
else {

  chkT(0)

}

s2 = "ney"


if (scmp(s1,s2,-2)) {

<<"%V $s1 $s2  scmp ==\n"

chkT(1)

}
else {

  chkT(0)

}

s2 = "heY"

if (scmp(s1,s2,0,0)) {

<<"%V $s1 $s2  scmp == case independent\n"

chkT(1)

}
else {

  chkT(0)

}



chkOut()





