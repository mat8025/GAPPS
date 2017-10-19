
/{
packb
packb (UCV,[swapbytes],"I,F,C,C,L",i,f,uc,c,l)
will take a uchar vec and format string "I,F,U,C,L"
and following args/constants convert according to the format specifier
and then pack them into the uchar vector according to sizeof of the format specifier
if optional second argument is 1, then pairs of bytes are swapped
/}
setdebug(1)

checkIn()

int i = 5
float f = 3.1
uchar uc = 79
char c = 127

long l = 1234;


int i2 
float f2 
uchar uc2 
char c2
long l2


<<"%V$i $f $uc $c $l \n"


uchar UCV[64]
uchar UCV2[64]
UCV[0] = 7;

<<"$UCV\n"

nc = packb (UCV,"I",i)

<<"$nc  :: $UCV\n"

nc = packb (UCV,"F",f)

<<"$nc  :: $UCV\n"

nc = packb (UCV,"L",l)

<<"$nc  :: $UCV\n"


packb (UCV,"I,F,U,C,L",i,f,uc,c,l)


<<"$UCV\n"



unpackb (UCV,"I,F,C,C,L",&i2,&f2,&uc2,&c2,&l2)


checkNum(i,i2)

checkNum(f,f2)
<<" $c $c2 \n"
checkNum(c,c2)
<<" $uc $uc2 \n"

checkNum(uc,uc2)


checkNum(l,l2)

<<"$UCV\n"

<<"%V$i2 $f2 $uc2 $c2 $l2 \n"

<<" now vec \n"

 I = vgen(INT_,4,0,1)


packb (UCV,"I4",I)

<<"$UCV\n"

int T[5];
float F2[8];

unpackb (UCV,"I4",T)

 F= vgen(FLOAT_,4,-4,1)
 
packb (UCV2,"F4",F)

unpackb (UCV2,"F4",F2)

<<"///////////\n"

<<"$I\n"


<<"T: $T\n"

<<"F2: $F2\n"

double D[];

  <<"$i2 $f2 $l2\n"

  packv(D,i2,f2,l2)

<<"$D \n"



checkOut()