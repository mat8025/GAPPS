# test ASL function bscan
CheckIn()

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE }

<<" $C \n"
<<"%x $C \n"

D = C


<<" $D \n"
<<"%x $D \n"


recast(D,"int")


<<" $D \n"
<<"%x $D \n"


uint k
uint j

// what is endian ?

//uint wbo = getByteOrder()

uint wbo

wbo = getByteOrder()

<<"%V %X $wbo %d $wbo \n"

if (wbo == 4321) {
 swab = 0
}
else {
 swab = 1
}

 na = bscan(&C[1],!swab,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"

CheckNum(na,2)
// depends on endian

uint t = 0xfabebafe

<<"%V$t $k \n"

<<"%x$t %x$k \n"

CheckNum(k,t)

 na = bscan(&C[2],swab,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"
t = 0xbabeface
CheckNum(k,t)

index = 3

 na = bscan(&C[index],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xbefacebe
CheckNum(k,t)


 na = bscan(&C[index+1],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xfacebead



CheckNum(k,t)

 na = bscan(&C[index*2],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xbeaddead

CheckNum(k,t)

uint k1
uint j1

 na = bscan(&C[index*2],swab,&k1,&j1)

<<"%V $na $k1 $j1 \n"
<<"%x $k1 $j1 \n"



CheckOut()


STOP!

 na = bscan(&C[0],1,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"


 na = bscan(&C[1],0,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"

 na = bscan(&C[1],1,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"

n = 2
 na = bscan(&C[n++],1,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"

<<"%v $n \n"

STOP!


<<"%I $s1   $g \n"
CheckStr(s1,"baby")

CheckStr(g,"hey")

<<"%I $s1   $g \n"

CheckStr(s1,"baby")

<<"%I $s1   $g \n"


CheckOut()

STOP!




