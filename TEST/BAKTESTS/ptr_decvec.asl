
include "debug"
debugON()

  sdb(1,@trace)

i = 47

int  c[] = { 0,1,2,3,77,85,13,66 }

<<"$c\n"

int e = 79;

int j = 85;


vn = "c"

<<"c[] ? $($vn) \n"



int  d[] = { e, i, c}

<<" d[] = $d\n"
<<"%V $d[1] \n"

int  v[] = { $vn}

<<" v[] = $v\n"


<<" $v[3] \n"
