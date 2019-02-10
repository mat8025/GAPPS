//%*********************************************** 
//*  @script ptrvec.asl 
//* 
//*  @comment test array args and dynamic vec declarations 
//*  @release CARBON 
//*  @vers 1.6 C Carbon                                                   
//*  @date Sat Feb  9 17:59:30 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

include "debug.asl"
debugON()
setdebug(1,@keep,@pline)
FilterFileDebug(REJECT_,"storetype_e","ds_storevar")


proc foov ()
{
  <<"no tanto \n"
}
//====================

proc fvec (int Z[], int X[], int Y[], int n) // OK ?

{
<<"$Z[0] $Z[1]\n"
int k= n;
for (i = 0; i < n ; i++) {

  Z[i] = X[i] + Y[i];
   zsz = Caz(Z);
   znd = Cab(Z);
<<"%V$i $zsz $znd $X[i] $Y[i] $Z[i]\n"

}


<<"no tanto $k $n\n"
<<"%V $X\n"

//<<"$X\n"

R = X;
rsz= Caz(R)
<<"%V$rsz $R\n" 
<<"%V $Y\n"
//<<"%V $Z[::]\n" // xic

<<"%V $Z[0] $Z[1] \n"

<<"%V $Z[::]\n" // xic

<<" proc exit\n";


}


checkIn(0)

sz = 15

int XV[] = vgen(INT_,sz,0,1)   //   PASS

xsz= Caz(XV)

<<"%V$xsz $XV\n"

checkNum(XV[2],2)

x = vgen(INT_,sz,0,1)   //   PASS

xsz= Caz(x)

<<"%V$xsz $x\n"
  
<<"%V$x \n"
checkNum(x[1],1)

y= vgen(INT_,sz,sz,1)

ysz= Caz(y)
<<"%V$ysz $y\n"



int c[];  //  TBF - WORKS

//int c[2+]; // WORKS

nd = Cab(c)
csz= Caz(c)
<<"%V $csz $nd\n"




c[0] = 79;
c[1]= 47;
c[2]= 80;

nd = Cab(c)
csz= Caz(c)
<<"%V $csz $nd\n"


foov()

<<"$c\n"

fvec(c,x,y,sz);

<<"done proc \n"

<<"%V $c[0] $c[sz-1]\n"

<<"%V $c\n"


checkNum(c[0],sz)
val = sz-1 + 2*sz-1;
<<"%V $val\n"
checkNum(c[sz-1],val)

checkOut()

/{
// TBF

1 int c[] //  DONE

2 int x[] = vgen(INT_,sz,0,1)   // fix should be a dynamic array  DONE

3 proc fvec (int Z[], int X[], int Y[], n) // works   

4 ? proc fvec (generic Y[],  gnum X[], gnum Z[], n) // not coded


  5 <<"%V $X[::]\n" // works

  6 xic fails @ proc end!! // fixed --was xic oncorrect stack problem

/}