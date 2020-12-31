//%*********************************************** 
//*  @script dec2.asl 
//* 
//*  @comment test dec2hex,dec2oct ... SF  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Wed Dec 30 13:19:27 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///


chkIn()

 a=dec2Oct(8)
 <<"$a\n"
 chkStr(a,"10")

o=dec2Oct(10)
 <<"$o  $(typeof(o))\n"

h=dec2hex(12)
 <<"$h $(typeof(h))\n"
chkStr(h,"C")

b=dec2bin(7)
 <<"$b $(typeof(b))\n"
chkStr(b,"00000000000000000000000000000111");

//r=dec2pan(7)
// <<"$r $(typeof(r))\n"

pan p = 123456789876543217;

 <<"%p $p $(typeof(p))\n"

 
d = 10
a= dec2oct(d)

<<"dec $d -> oct $a\n"

chkStr(a,"12")

chkOut()