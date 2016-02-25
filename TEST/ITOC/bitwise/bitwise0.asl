

//  test the bitwise ops

int  j = 0xDEADBEEF
int  k = 0xCAFEBABE
int  l = 0x2FACE00F
int  d = 0xDEADC0DE

m = j & k

<<"%x$j\n$k\n$m\n"
<<"%x $j\n $k\n $m\n"
<<"%x\t$j\n\t$k\n\t$m\n"
<<"%X\t$j\n\t$k\n\t$m\n"
<<"%o\t$j\n\t$k\n\t$m\n"
<<"%u\t$j\n\t$k\n\t$m\n"
//<<"%b\t$j\n\t$k\n\t$m\n"
<<"%X\t$j\n\t$k\n\t%d$m\n"
<<"%X\t$j\n\t$k\n\t%u$m\n"


m = ( j | k )

<<"%x$j\n$k\n$m\n"
<<"%x $j\n $k\n $m\n"
<<"%x\t$j\n\t$k\n\t$m\n"
<<"%X\t$j\n\t$k\n\t$m\n"
<<"%o\t$j\n\t$k\n\t$m\n"
<<"%u\t$j\n\t$k\n\t$m\n"
//<<"%b\t$j\n\t$k\n\t$m\n"
<<"%X\t$j\n\t$k\n\t%d$m\n"
<<"%X\t$j\n\t$k\n\t%u$m\n"


m = ( j ^ k )

<<"\n    ^  \n"


<<"%x\t$j\n\t$k\n\t$m\n"
<<"\n%o\t$j\n\t$k\n\t$m\n"
<<"\n%u\t$j\n\t$k\n\t$m\n"


m = ~j

<<"\n    ~j  \n"

<<"%x\t$j\n\t$m\n"

m = ~k

<<"\n    ~k  \n"

<<"%x\t$k\n\t$m\n"
<<"%o\t$k\n\t$m\n"


m =  j << 1

<<"\n  j << 1  \n"

<<"\n%x\t$j\n\t$m\n"

m =  j << 4

<<"\n  j << 4  \n"

<<"\n%x\t$j\n\t$m\n"


m =  j >> 4

<<"\n  j >> 4  \n"

<<"\n%x\t$j\n\t$m\n"





STOP!