//%*********************************************** 
//*  @script fscanv.asl 
//* 
//*  @comment data read into list of vectors 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Apr  1 08:44:21 2019 
//*  @cdate Mon Apr  1 08:44:21 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

/{/*
fscanv     

 search for fscanv 
 fscanv
 fscanv(Fh,swapbytes,'fmt',&cv,&sv,&iv,&fv,&dv,&xv)
 fscanv(A,swapbytes,'C4,S4,I4,F4,D4,X4',&cvec,&svec,&ivec,&fvec,&xvec)
 reads from binary data file as directed by format string into variables.
 C char, S short , I int, F float, D double, X cmplx
 the number following the type designation allows 
 mulitple item read into a supplied vector.
 A single read C1 into a scalar is also allowed.
 returns total number of bytes read.
/}*/




include "debug.asl"
debugON()
chkIn()

cmplx x;

x->info(1)

<<"$x\n"

x->set(1.2,-3.4)

<<"$x\n"


chkR(x->getReal(),1.2)


IV=vgen(INT_,10,0,1)
FV=vgen(FLOAT_,10,20,0.5)

//XV=vgen(CMPLX_10,0,0.1)

cmplx XV[+10]

XV->setReal(FV)

<<"$XV\n"

XV->setImag(vgen(FLOAT_,10,-10,0.5))

<<"XV: $XV\n"

A=ofw("data.dat")
wdata(A,IV)
wdata(A,FV)
wdata(A,XV)
cf(A)




A=ofr("data.dat")


int RIV[>10];
float RFV[>10];
cmplx RXV[>10];

RFV->info(1)
dyn = RFV->isdynamic()
<<"%V $dyn\n"



fscanv(A,"I10,F10,X10",RIV,RFV,RXV);

//<<"%6.2f$RXV\n" // TBF fixed breaks cmplx {1.0,-1.0} format
<<"$RXV\n"


RFV=XV->getImag()

<<"%6.2f$RFV\n"

RFV=XV->getReal()

<<"%6.2f$RFV\n"




//fscanv(A,"I10,F10,X10",RIV,RFV,RXV);

<<"$RIV\n"
<<"$RFV\n"


for(i=0;i<10;i++) {
chkN(RIV[i],i)
}

fv=20.0;
for(i=0;i<10;i++) {
chkN(RFV[i],fv)
fv +=0.5
}




chkOut()



////////////// TBD ////////////////////
///  double complex
///  set cmplx
///  print cmplx