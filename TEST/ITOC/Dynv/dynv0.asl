///////////////

CheckIn()

//setdebug(0,"step")


int J[] 

<<"$(Cab(J)) \n"


//J[30] = 30


<<"$J \n"

  J[0:20]->Set(10,1)

<<"$J \n"

  sum = J[1] + J[2] + J[3] 

<<"  %V$sum = $J[1] + $J[2] + $J[3]  \n"

  sum = J[1] + J[2] + J[3] + J[4]

<<"  %V$sum = $J[1] + $J[2] + $J[3] + $J[4] \n"

int I[20+]

  I->Set(0)

CheckNum(I[2],0)
sz = Caz(I)

<<" $sz \n"

I[5] = 10

CheckNum(I[5],10)

CheckNum(I[6],0)

<<"%(5,<,|,>\n)$I \n"

I[6] = 6

CheckNum(I[6],6)

<<"%(5,<,|,>\n)$I \n"

<<"/////////////////////\n"

///FIX XIC not using 0:10

 I[2:10:2] = 5

<<"%(10,<, ,>\n) $I \n"

 I[11:18:2] = 7

<<"%(10,<, ,>\n)$I \n"


CheckNum(I[2],5)



 I[12:19:2] = 8

CheckNum(I[12],8)
CheckNum(I[14],8)
CheckNum(I[18],8)
CheckNum(I[2],5)

<<"%(10,<, ,>\n)$I \n"

 I[12:-1:1] = 4

// I[-1:12:2] = 4

<<"%(10,<, ,>\n)$I \n"

CheckNum(I[19],4)


CheckNum(I[12],4)
CheckNum(I[14],4)
CheckNum(I[2],5)

<<"%(10,<, ,>\n)$I \n"


////////  FIX ME /////////
// default value if left unset should be array end?

 //I[12::2] = 3
I[12:-1:2] = 3

CheckNum(I[12],3)
CheckNum(I[14],3)
CheckNum(I[2],5)

<<"%(10,<, ,>\n)$I \n"



CheckNum(I[10],5)



// leaves lhsubscript range set?

<<"%(10,, ,\n)$I \n"

<<"/////////////////////\n"


<<"%(10,, ,\n)$I \n"

I[6] = 6

CheckNum(I[6],6)

<<"%(10,, ,\n)$I \n"

CheckNum(I[4],5)


 I[4:6:2] = 49

CheckNum(I[4],49)

<<"%(10,, ,\n)$I \n"

a = 6
b = 2


 I[0:a:b] = 59

CheckNum(I[4],59)

<<"%(10,, ,\n)$I \n"



// I[0:-4:b] = 57

//CheckNum(I[4],57)

CheckNum(I[18],3)

<<"%(10,, ,\n)$I \n"


CheckOut()
stop!


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

