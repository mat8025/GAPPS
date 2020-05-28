//  test the bitwise ops
setdebug(1,@~step)

int  j = 5
int  k = 1

m = j & k

CheckNum(m,1)

<<"%V $j & $k BAND  $m \n"

k = 2
m = j & k

<<"%V $j & $k BAND  $m \n"

CheckNum(m,0);

k = 4
m = j & k

<<"%V $j & $k BAND  $m \n"

CheckNum(m,4)

m = ( j | k )

<<"$j | $k BOR  $m \n"

CheckNum(m,5)
k = 2
m = ( j | k )

<<"%V $j | $k BOR  $m \n"

CheckNum(m,7)

k = 4

m = ( j ^^ k )

<<"$j ^^ $k BXOR_  $m\n"


CheckNum(m,1);

m = ( j BXOR_ k )

<<"$j BXOR_ $k  $m\n"

CheckNum(m,1);


k = 1

m = ( j ^^ k )

<<"$j ^^ $k XOR  $m\n"

CheckNum(m,4)




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

CheckNum(m,2)

<<"\n  j << 1  \n"

<<"\n%x\t$j\n\t$m\n"

m =  j << 4

<<"\n  j << 4  \n"

<<"\n%d\t$j\n\t$m\n"
//ans= i_read("6")

j = 32

m =  j >> 4

CheckNum(m,2)

<<"\n  $j >> 4  = m \n"

<<"\n%d\t$j\n\t$m\n"

//ans= i_read("7")

checkOut();

