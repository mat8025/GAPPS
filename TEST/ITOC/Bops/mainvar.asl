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


int db_allow = 0


chkIn()

allowDB("spe,pex,vmf,list,ds_sivlist,spil,rdp,ic", db_allow)

<<" $(GREEN_) \n"

 FF = vgen(INT_,10,50,1);
<<"$FF\n"

chkN(FF[1],51)


S=functions()
S->sort()
//<<"%(1,,,\n)$S\n"

a= 23;

V=variables(1)
V.sort()
//<<"%(1,,,\n)$V\n"

D=defines()
//D->sort()
//<<"%(1,,,\n)$D[0:10]\n"
sz= Caz(D)
/{
for (i=0;i<sz;i++) {
C=split(D[i])
if (!scmp(C[0],"PC_",3)) {
<<"$D[i]\n"
}

}
/}



void localv()
{

 int FF[10];
 FF[1] = 71;
 <<"$FF[1] \n"
 FF[2] = 82
 ::FF[2] = 584;

<<"%V $FF[2]\n"


<<"%V $::FF[2]\n"


  for (i= 5; i<10; i++) {
  
    FF[i] = i;
  ans = ask("<$i> local var set $FF[i]\n",0)
}
 j = 0;
 for (i= 5; i<10; i++) {
    ::FF[i] = -i;
 j++
ans = ask("<$i><$j> Main var set $::FF[i]\n",0)
 if (j > 6)
    break
}



 FF[2] = 28
 chkN(FF[2],28)
 <<"local %V $FF \n"
}

  localv()


 <<"main %V $FF \n"
 FF.pinfo()

chkN(FF[1],51)

 val = -5
 <<"%V $val\n"

val =FF[5]

chkN(FF[5],val)


chkN(FF[5],-5) ; // TBF rdp unary bug?

chkN(FF[2],584)

chkOut(1)