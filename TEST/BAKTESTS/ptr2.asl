
bo = endian()

<<"$bo \n"

i = 6789

<<"$i   %x$i\n"


I = vgen(INT_,500,0,1)

<<"$I[0:9] \n"

int i0
int i1
int i2

bscan(&I[0],0,&i0,&i1,&i2)

<<"$i0 $i1 $i2\n"


bscan(&I[1],0,&i0,&i1,&i2)

<<"$i0 $i1 $i2\n"


bscan(&I[2],0,&i0,&i1,&i2)

<<"$i0 $i1 $i2\n"

uchar c0
uchar c1
uchar c2
uchar c3

bscan(&I[2],0,&c0,&c1,&c2,&c3)

<<"$c0 $c1 $c2 $c3\n"


for (j = 0; j < 500; j++) { 
  bscan(&I[j],0,&c0,&c1,&c2,&c3)
  <<"[${j}] $c0 $c1 $c2 $c3\n"
}
