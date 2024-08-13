//%*********************************************** 
//*  @script mainvar.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sat May  9 08:55:28 2020 
//*  @cdate Tue Jan 28 07:47:40 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///

#define __CPP__ 0

#if __CPP__
#include "cpp_head.h" 
#endif


#include "debug"

if (_dblevel >0) {
   debugON()
}

 db_ask = 0;
  db_allow = 0

 checkMemory(0)
 alm =alignMemory(32)
 <<"%V $alm\n"

chkIn()

allowDB("spe,pex,array,vmf,list,spil,rdp,ic", db_allow)

<<" $(GREEN_) \n"

 FF = vgen(INT_,20,50,1);
<<"$FF\n"

chkN(FF[1],51)


S=functions()
S.sort()
//<<"%(1,,,\n)$S\n"

a= 23;

V=variables(1)
V.sort()
//<<"%(1,,,\n)$V\n"

D=defines()

sz= Caz(D)




void localv()
{

 int FF[20];

 
  FF[1] = 71;
 <<"$FF[1] \n"
 
  FF[2] = 82

  FF.pinfo()
  

 ::FF[2] = 584;

<<"%V $FF[2]\n"



  ::FF.pinfo()

  FF.pinfo()

  chkN(FF[2],82)

 chkN(::FF[2],584)

<<"%V $::FF[2]\n"

 j=0
  for (i= 5; i<10; i++) {
  
    FF[j] = i;
  ans = ask("<$i> $j local FF var set $FF[i]\n",db_ask)
j++
   if (j > 6)
    break
  }

 j = 0;
 for (i= 15; i<20; i++) {
    ::FF[i] = -i;
 j++
ans = ask("<$i><$j> Main var set $::FF[i]\n",db_ask)
 if (j > 6)
    break
}

 ::FF.pinfo()


 FF[2] = 28
 chkN(FF[2],28)
 <<"local %V $FF \n"
 FF.pinfo()

}
//EP//////////////////////////////

   FF[2] = 77

   val = FF[2]
 <<"%V $val\n"


  chkN(FF[2],77)
  
  FF.pinfo()
  val =FF[5]
 <<"%V $val\n"

chkN(FF[5],val)



  <<" now call localv  for :: ref\n"
  
  localv()


 <<"main %V $FF \n"
 FF.pinfo()

chkN(FF[1],51)

 val = -5
 <<"%V $val\n"

 FF.pinfo()
 
 val =FF[5]
<<"%V $val\n"
chkN(FF[5],val)


chkN(FF[19],-19) ; // TBF rdp unary bug?

chkN(FF[2],584)

 memUsed()

chkOut(1)





/* 

TBF 8/9/24

 TotalSivMem 580512 
 CountMemAlloc 603136  
 getTotalAllocated 9347808
 getTotalFreeded  8767296 
 CountMemBlock 5323 
 CountMemOps 22894
//  need to reduce MemOps


6.54 broke   not parsing ::FF ?

*/


