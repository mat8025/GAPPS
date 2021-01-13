//%*********************************************** 
//*  @script bscan.asl 
//* 
//*  @comment test scan of vars 
//*  @release CARBON 
//*  @vers 1.65 Tb Terbium [asl 6.2.73 C-He-Ta]                            
//*  @date Wed Sep 23 06:48:47 2020 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  bscan
///


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE }

 <<" $C \n"

 <<"$C[1] \n"

  chkN(C[1],0xFE)
  chkN(C[1],254)


 val = C[1];
 
 <<"$val\n"
<<"%x $C \n"



D = C


<<" $D \n"
<<"%x $D \n"

//recast(D,"int")
    cast(INT_,D)
    
<<" $D \n"
<<"%x $D \n"


uint k
uint j

// what is endian ?

//uint wbo = getByteOrder()

uint wbo

wbo = getByteOrder()



if (wbo == 4321) {
 swab = 0
}
else {
 swab = 1
}

<<"%V %X $wbo %d $wbo $swab\n"

<<"$C[1] $C[2]\n"

na = bscan(&C[1],swab,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"





chkN(na,8)
// depends on endian

uint t1 = 12345;

<<"%V$t1 \n"

uint t = 0xfebabefa

<<"%V$t  \n"

<<"%x $t \n"
<<"%x $k \n"
chkN(k,t)

 na = bscan(&C[2],swab,&k,&j)

<<"%V $na $k $j \n"

<<"%x $k $j \n"
t = 0xbabeface
chkN(k,t)

index = 3

 na = bscan(&C[index],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xbefacebe
chkN(k,t)


 na = bscan(&C[index+1],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xfacebead



chkN(k,t)

 na = bscan(&C[index*2],swab,&k,&j)

<<"%V $na $k $j \n"
<<"%x $k $j \n"
t = 0xbeaddead

chkN(k,t)

uint k1
uint j1

 na = bscan(&C[index*2],swab,&k1,&j1)

<<"%V $na $k1 $j1 \n"
<<"%x $k1 $j1 \n"





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




<<"%I $s1   $g \n"
chkStr(s1,"baby")

chkStr(g,"hey")

<<"%I $s1   $g \n"

chkStr(s1,"baby")

<<"%I $s1   $g \n"


chkOut()





