


checkIn(_dblevel)

proc goo()
{

short c = 3;

c->info(1)

ci = c->info()


<<"%V $c  $ci\n"
checkNum(c,3)
}


int a = 1;

a->info(1)

ai = a->info()


<<"%V $a  $ai\n"
checkNum(1,a)

float b = 2;

b->info(1)

bi = b->info()


<<"%V $b  $bi\n"
checkNum(b,2)

goo()


IV = vgen(INT_,10,0,1)

IV->info(1)

k = IV[3]

checkNum(k,3)
IVi = IV->info()

<<"$IVi \n"
vid = IV->varid()
<<"%V $vid \n"
obid = IV->objid()
<<"%V $obid \n"
checkNum(obid,-1)

offs = IV->varoffsets()

<<"%V $offs \n"
checkNum(offs[1],3)
checkOut()