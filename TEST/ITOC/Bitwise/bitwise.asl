/* 
 *  @script bitwise.asl 
 * 
 *  @comment test bit ops & | ~ 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 12:46:19 2021 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                             
myScript = getScript();

<<"Running $myScript $_script\n"
//  test the bitwise ops
#include "debug"
debugON()

chkIn(_dblevel)

int  j = 5
int  k = 1

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

m = ( j ^ k )

<<"$j ^ $k BXOR_  $m\n"


chkN(m,1);

m = ( j BXOR_ k )

<<"$j BXOR_ $k  $m\n"

chkN(m,1);


k = 1

m = ( j ^ k );

<<"$j ^ $k XOR  $m\n"

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



uchar  jc = 5
uchar  kc = 1

m = jc & kc

chkN(m,1)

<<"%V $jc & $kc BAND  $m \n"

kc = 2
m = jc & kc

<<"%V $jc & $kc BAND  $m \n"

chkN(m,0);

kc = 4
m = jc & kc

<<"%V $jc & $kc BAND  $m \n"

chkN(m,4)

m = ( jc | kc )

<<"$jc | $kc BOR  $m \n"

chkN(m,5)
kc = 2
m = ( jc | kc )

<<"%V $jc | $kc BOR  $m \n"

chkN(m,7)

kc = 4

m = ( jc ^ kc )

<<"$jc ^ $kc BXOR_  $m\n"


chkN(m,1);

m = ( jc BXOR_ kc )

<<"$jc BXOR_ $kc  $m\n"

chkN(m,1);


kc = 1

m = ( jc ^ kc )

<<"$jc ^ $kc XOR  $m\n"

chkN(m,4)




jc = 1

//ans= i_read("3")

m = ~jc

<<"\n $m   ~$jc  \n"



<<"%x\t$jc\n\t$m\n"

//ans= i_read("4")

m = ~kc

<<"\n    ~kc  \n"

<<"%x\t$kc\n\t$m\n"
<<"%o\t$kc\n\t$m\n"

//ans= i_read("5")

m =  jc << 1

chkN(m,2)

<<"\n  jc << 1  \n"

<<"\n%x\t$jc\n\t$m\n"

m =  jc << 4

<<"\n  jc << 4  \n"

<<"\n%d\t$jc\n\t$m\n"
//ans= i_read("6")

jc = 32

m =  jc >> 4

chkN(m,2)

<<"\n  $jc >> 4  = m \n"

<<"\n%d\t$jc\n\t$m\n"

//ans= i_read("7")


uchar h = 0x40;

uchar p = 0xF0;


m = h & p

<<"%V %X $h & $p BAND  $m \n"

chkN(m,0x40)

chkN(m,0,GT_)

chkN(m,0,NEQ_)


chkOut()



/////////////////////////////////// TBD /////////////////////
/*

1. Add more

*/