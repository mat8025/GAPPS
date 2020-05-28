///
///  atoi function
///

/{/*

  should work for a single str value
  or for a vector


/}*/

checkIn()
  str s = "407"
  i = atoi("407");

<<"%V $s $i \n"

checkNum(i,407);


<<"  INT VEC SET/GET \n"
 int IV[];

   W = Split("0,1,2,3,4,5,6,7,8,9",",");


  <<"%V $W[2] \n"
  IV = atoi(W); // TBF XIC

<<"%V$IV\n"

 checkNum(IV[3],3);


  checkOut()

  IG = vgen(INT_,10,0,1);

  <<"%V$IG[3:7]\n"

  IV2 = IG[2:7]

<<"%V$IV2\n"

 IV2[0:2] = IG[7:9]

<<"%V$IV2\n"