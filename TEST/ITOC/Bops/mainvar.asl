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

checkIn(_dblevel)

<<" $(GREEN_) \n"

 FF = vgen(INT_,10,50,1);
<<"$FF\n"

checkNum(FF[1],51)


S=functions()
S->sort()
//<<"%(1,,,\n)$S\n"

a= 23;

V=variables(1)
V->sort()
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



proc localv()
{

 int FF[10];
 FF[1] = 71;
 <<"$FF[1] \n"
 ::FF[2] = 584;
 for (i= 5; i<10; i++) {
  FF[i] = i;
  }

 for (i= 5; i<10; i++) {
  ::FF[i] = -i;
  }



 FF[2] = 28
 <<"$FF \n"
}

localv()


 <<"$FF \n"

checkNum(FF[1],51)
checkNum(FF[5],-5)
checkNum(FF[2],584)

CheckOut()