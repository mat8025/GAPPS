///
///   test the bitwise ops

///
setdebug(1,@keep,@filter,0,@~step)

uchar  j = 5
uchar  k = 1

m = j & k

chkN(m,1)

<<"%V $j & $k BAND  $m \n"

k = 2
m = j & k

<<"%V $j & $k BAND  $m \n"

chkN(m,0);

k = 4
m = j & k

<<"%V $j & $k BAND  $m \n"

chkN(m,4)

m = ( j | k )

<<"$j | $k BOR  $m \n"

chkN(m,5)
k = 2
m = ( j | k )

<<"%V $j | $k BOR  $m \n"

chkN(m,7)

k = 4

m = ( j ^^ k )

<<"$j ^^ $k BXOR_  $m\n"


chkN(m,1);

m = ( j BXOR_ k )

<<"$j BXOR_ $k  $m\n"

chkN(m,1);


k = 1

m = ( j ^^ k )

<<"$j ^^ $k XOR  $m\n"

chkN(m,4)




j = 1

//ans= i_read("3")

m = ~j

<<"\n $m   ~$j  \n"



<<"%x\t$j\n\t$m\n"

//ans= i_read("4")

m = ~k

<<"\n    ~k  \n"

<<"%x\t$k\n\t$m\n"
<<"%o\t$k\n\t$m\n"

//ans= i_read("5")

m =  j << 1

chkN(m,2)

<<"\n  j << 1  \n"

<<"\n%x\t$j\n\t$m\n"

m =  j << 4

<<"\n  j << 4  \n"

<<"\n%d\t$j\n\t$m\n"
//ans= i_read("6")

j = 32

m =  j >> 4

chkN(m,2)

<<"\n  $j >> 4  = m \n"

<<"\n%d\t$j\n\t$m\n"

//ans= i_read("7")


uchar h = 0x40;

uchar p = 0xF0;


m = h & p

<<"%V %X $h & $p BAND  $m \n"

chkN(m,0x40)

chkN(m,0,GT_)

chkN(m,0,NEQ_)


chkOut();

