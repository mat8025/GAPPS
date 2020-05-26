//%*********************************************** 
//*  @script bitwise.asl 
//* 
//*  @comment test bit ops & | ~  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                               
//*  @date Sat May 23 15:44:41 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();


//  test the bitwise ops

int  j = 5
int  k = 1

m = j & k

checkNum(m,1)

<<"%V $j & $k BAND  $m \n"

k = 2
m = j & k

<<"%V $j & $k BAND  $m \n"

checkNum(m,0);

k = 4
m = j & k

<<"%V $j & $k BAND  $m \n"

checkNum(m,4)

m = ( j | k )

<<"$j | $k BOR  $m \n"

checkNum(m,5)
k = 2
m = ( j | k )

<<"%V $j | $k BOR  $m \n"

checkNum(m,7)

k = 4

m = ( j ^^ k )

<<"$j ^^ $k BXOR_  $m\n"


checkNum(m,1);

m = ( j BXOR_ k )

<<"$j BXOR_ $k  $m\n"

checkNum(m,1);


k = 1

m = ( j ^^ k )

<<"$j ^^ $k XOR  $m\n"

checkNum(m,4)




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

checkNum(m,2)

<<"\n  j << 1  \n"

<<"\n%x\t$j\n\t$m\n"

m =  j << 4

<<"\n  j << 4  \n"

<<"\n%d\t$j\n\t$m\n"
//ans= i_read("6")

j = 32

m =  j >> 4

checkNum(m,2)

<<"\n  $j >> 4  = m \n"

<<"\n%d\t$j\n\t$m\n"

//ans= i_read("7")

checkOut();



