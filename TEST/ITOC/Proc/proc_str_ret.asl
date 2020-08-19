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

chkIn()
ws = say()


<<"$ws $(typeof(ws))\n"

chkStr(ws,"hey hey");

chkOut();