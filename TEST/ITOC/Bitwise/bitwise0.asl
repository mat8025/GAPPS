//  test the bitwise ops

int  j = 0xDEADBEEF
int  k = 0xCAFEBABE
int  l = 0x2FACE00F
int  d = 0xDEADC0DE


ans =iread(" band & ")

m = j & k

<<"%x$j\t$k\t$m\n"
<<"%X$j\t$k\t$m\n"
<<"%o$j\t$k\t$m\n"
<<"%u$j\t$k\t$m\n"

ans= i_read("bor | ")

m = ( j | k )

<<"%x$j\t$k\t$m\n"
<<"%X$j\t$k\t$m\n"
<<"%o$j\t$k\t$m\n"
<<"%u$j\t$k\t$m\n"



ans= i_read("bxor ^^")
m = ( j XOR k )

<<"%x$j\t$k\t$m\n"
<<"%X$j\t$k\t$m\n"
<<"%o$j\t$k\t$m\n"
<<"%u$j\t$k\t$m\n"


ans= i_read("3")

m = ~j

<<"\n    ~j  \n"

<<"%x\t$j\n\t$m\n"

ans= i_read("4")

m = ~k

<<"\n    ~k  \n"

<<"%x\t$k\n\t$m\n"
<<"%o\t$k\n\t$m\n"

ans= i_read("5")

m =  j << 1

<<"\n  j << 1  \n"

<<"\n%x\t$j\n\t$m\n"

m =  j << 4

<<"\n  j << 4  \n"

<<"\n%x\t$j\n\t$m\n"
ans= i_read("6")

m =  j >> 4

<<"\n  j >> 4  \n"

<<"\n%x\t$j\n\t$m\n"

ans= i_read("7")
exit()
