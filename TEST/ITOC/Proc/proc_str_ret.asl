///
///   test proc str return
///

proc say()
  {
   <<"$_proc hey there I exist\n"
   isay="hey hey"
   <<"$isay $(typeof(isay))\n"
   return isay;
  }

//setDebug(1,"trace","keep","~stderr")

checkIn()
ws = say()


<<"$ws $(typeof(ws))\n"

checkStr(ws,"hey hey");

checkOut();