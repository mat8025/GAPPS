
include "debug"
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_","proc");


int DEFS[20][10];


vrow = vgen(INT_,10,0,1)


 <<"%V$vrow\n"

 DEFS->info(1)

 DEFS[0][::] = vrow

 DEFS->info(1)

 <<"%(10,, ,\n)$DEFS\n"

vrow2 = vgen(INT_,10,0,-1)

 DEFS->info(1)
 DEFS[10][::] = vrow2

 DEFS->info(1)
vrow2 = vgen(INT_,10,20,1)

 DEFS[19][::] = vrow2

vrow3 = vgen(INT_,10,72,1)

 DEFS[5][::] = vrow3

 <<"%(10,, ,\n)$DEFS\n"

