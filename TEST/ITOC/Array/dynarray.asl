
setdebug(1,@keep,@filter,0,@~trace);

checkIn()

  int ival;

 int IV[4+];

  sz = Caz(IV);
  <<"%V$sz\n"

 checkNum(sz,4);

  IV[1] = ptan("AT");
<<"$IV\n"

checkNum(IV[1],85);

  IV[5] = ptan("Ac");
<<"$IV\n"

checkNum(IV[5],89);

float FV[5];

 FV[2] = ptan("Rh");

  sz = Caz(FV);
  <<"%V$sz\n"
  
<<"$FV\n"

  checkFnum(FV[2],45);

checkOut()

exit()