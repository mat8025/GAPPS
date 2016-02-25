
/{
packb
packb (UCV,[swapbytes],"I,F,UC,C,L",i,f,uc,c,l)
will take a uchar vec and format string "I,F,UC,C,L"
and following args/constants convert according to the format specifier
and then pack them into the uchar vector according to sizeof of the format specifier
if optional second argument is 1, then pairs of bytes are swapped
/}




int i = 4
float f = 3.1
uchar uc = 234
char c = 127

long l = 123456789


<<"%V$i $f $uc $c $l \n"


uchar UCV[]

packb (UCV,"I,F,UC,C,L",i,f,uc,c,l)


<<"$UCV\n"

