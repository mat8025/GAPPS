/* 
 *  @script swab.asl 
 * 
 *  @comment test swab function 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.11 C-Li-Na] 
 *  @date Sat Jan 16 21:19:58 2021 
 *  @cdate 1/1/2002 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                   


#include "debug.asl";


chkIn(_dblevel)

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE };


<<" $C[0]  $C[1]\n"
<<" $(typeof(C)) \n"
<<" $C \n"

<<"%x $C \n"

C.pinfo()

 allowDB("spe,rdp,ds",0)
uchar c0 =0xAF

<<"%V %x $c0  $(0xCA)\n"


 c0 = 0xCA;

<<"%V $c0\n"

<<"%V %x $c0  $(0xCA)\n"

chkN(c0,0xCA)

uint  k = 0xcafe

<<"%V $k  %x $k\n"





chkN(C[0],0xCA)
chkN(C[11],0xDE)


swab(C)

<<"%x $C \n"

swab(C)

<<"%x $C \n"




// just copy
<<" just assign/copy to new vector \n"
D = C
<<"D $D\n"
// convert

   retype(D,INT_)

<<" $(typeof(D)) \n"
<<"D[]  $D \n"
<<"D[]  %x $D \n"
D.pinfo()

  swab(D)

<<"D[]  %x $D \n"

E=D
<<" $(typeof(E)) \n"
<<"E[]  %x $E \n"
   retype(E,CHAR_)
<<" $(typeof(E)) \n"
<<"E[]  %x $E \n"
E.pinfo()

uchar U[] ;
U = E;
U.pinfo()
<<"U[]  %x $U \n"


uchar c1 = 0xFE;
uchar c2;
<<" $(0xCA)  $(0x1) $(0xFE) \n"




//c1 = 0xBE;




bscan(U,0,&c0,&c1,&c2)

<<"%x $c0 $c1 $c2\n"

<<"%V $c0\n"

<<"%V %x $c0\n"


c0.pinfo()
c1.pinfo()


chkN(c1,0xBA)
chkN(c0,0xBE)

ushort s1
ushort s2


bscan(U,0,&s1,&s2)

<<"%x $s1 $s2\n"


bscan(U,1,&s1,&s2)

<<"%x $s1 $s2\n"

chkN(s1,0xbeba)



chkOut(1)

exit()
