/* 
 *  @script dynv.asl 
 * 
 *  @comment test dynamic array ops 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.11 C-Li-Na] 
 *  @date Sat Jan 16 20:05:29 2021 
 *  @cdate Wed Apr 3 13:09:11 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                   

/*
Set(),set ~ sets values in a vector or a scalar()
V->set(value)
V[3]->set(value)
V[1:20:2]->set(value_vec)
V[1:20:2]->set(value_vec,incr)
sets elements of a variable to supplied value vector.
if the variable is a scalar then just its value is set.
Can be used to set a specified element of the variable array,
or a subrange or the entire array.
The initial vaue can be incremented at each set step to create a series.
//===================================//

a vector is tagged as dynamic ( allowed resize on access)
via the declare statement

int Veci[>10];

which sets the initial size of Vec to ten but allows
runtime resize when needed 
e.g.
Veci[12] = 47;

the size of the Veci is increased to 13 plus;

*/


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


int Veci[>10];

Veci[3] = 79;

Veci->info(1)

Veci[12] = 47;

sz=Caz(Veci);

<<"%V $sz \n"

Veci->info(1);

chkT (sz>=13)



int J[] 

 J->info(1)
<<"$(Cab(J)) \n"


<<"$J \n"

  J[0:20]->Set(10,1)

<<"$J \n"

  sum = J[1] + J[2] + J[3] 

<<"  %V$sum = $J[1] + $J[2] + $J[3]  \n"

  sum = J[1] + J[2] + J[3] + J[4]

<<"  %V$sum = $J[1] + $J[2] + $J[3] + $J[4] \n"

int I[>20]

  I->Set(0)

chkN(I[2],0)
sz = Caz(I)

<<" $sz \n"

I[5] = 10

chkN(I[5],10)

chkN(I[6],0)

<<"%(5,<,|,>\n)$I \n"

I[6] = 6

chkN(I[6],6)

<<"%(5,<,|,>\n)$I \n"

<<"/////////////////////\n"

///FIX XIC not using 0:10

 I[2:10:2] = 5

<<"%(10,<, ,>\n) $I \n"

 I[11:18:2] = 7

<<"%(10,<, ,>\n)$I \n"


chkN(I[2],5)



 I[12:19:2] = 8

chkN(I[12],8)
chkN(I[14],8)
chkN(I[18],8)
chkN(I[2],5)

<<"%(10,<, ,>\n)$I \n"

 I[12:-1:1] = 4

// I[-1:12:2] = 4

<<"%(10,<, ,>\n)$I \n"

chkN(I[19],4)


chkN(I[12],4)
chkN(I[14],4)
chkN(I[2],5)

<<"%(10,<, ,>\n)$I \n"


////////  FIX ME /////////
// default value if left unset should be array end?

 //I[12::2] = 3
I[12:-1:2] = 3

chkN(I[12],3)
chkN(I[14],3)
chkN(I[2],5)

<<"%(10,<, ,>\n)$I \n"



chkN(I[10],5)



// leaves lhsubscript range set?

<<"%(10,, ,\n)$I \n"

<<"/////////////////////\n"


<<"%(10,, ,\n)$I \n"

I[6] = 6

chkN(I[6],6)

<<"%(10,, ,\n)$I \n"

chkN(I[4],5)


 I[4:6:2] = 49

chkN(I[4],49)

<<"%(10,, ,\n)$I \n"

a = 6
b = 2


 I[0:a:b] = 59

chkN(I[4],59)

<<"%(10,, ,\n)$I \n"



// I[0:-4:b] = 57

//chkN(I[4],57)

chkN(I[18],3)

<<"%(10,, ,\n)$I \n"


chkOut()



////////////////  TBD /////////////////
/{
  Array range

  if range value missing should go to default

  [start:end:step]

  missing start  value should be 0
  missing end  value should be end index
  missing step  value should be 1


  a start or end value of negative indicates a postion relative to end of array
  N.B -1 is the end index ultimate, -2 penultimate ...

  negative step backwards iteration -- array is treated as a ring
/}

