


chkIn(_dblevel)

proc goo()
{

short c = 3;

c->info(1)

ci = c->info()


<<"%V $c  $ci\n"
chkN(c,3)
}


int a = 1;

a->info(1)

ai = a->info()


<<"%V $a  $ai\n"
chkN(1,a)

float b = 2;

b->info(1)

bi = b->info()


<<"%V $b  $bi\n"
chkN(b,2)

goo()


IV = vgen(INT_,10,0,1)

IV->info(1)

k = IV[3]
chkN(k,3)
IV->info(1)
offs = varoffsets(IV)

<<"%V $offs \n"
chkN(offs[1],3)


IVi = IV->info()

<<"$IVi \n"
vid = IV->varid()
<<"%V $vid \n"
obid = IV->objid()
<<"%V $obid \n"
chkN(obid,-1)


chkOut()