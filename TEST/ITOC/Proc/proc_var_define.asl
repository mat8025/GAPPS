//%*********************************************** 
//*  @script proc_var_define.asl 
//* 
//*  @comment test assign within proc 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.45 C-He-Rh]                               
//*  @date Sun May 10 12:32:52 2020 
//*  @cdate Sun May 10 12:32:52 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
///
<|Use_=
  Demo  proc define
|>


#include "debug"




if (_dblevel >0) {
   debugON()
       <<"$Use_\n"   
}


allowErrors(-1)


int f = 7;

<<"%V $f \n"

chkIn();

chkR(f,7);

int poo(int x)
{

 y = x *2;
 return y;

}


void hdg(str atit)
{
  atit<-pinfo();

  int len = slen(atit)
  int rlen = 20- len;

<<"$_proc  $atit  $len\n"
}



z=54;

 poo(z)
 

str mtit = "Turquoise Lake"

int len = slen(mtit)

<<"$len $mtit\n"


 ok=hdg(mtit)





int N =   79;

<<"%V $f $N \n"


int c = atoi(_argv[1]);

d = atoi(_argv[1]);

<<" $_argv[1] $c $d\n"

chkN(c,d);


int M = (47*1);


chkN(M,47);




chkN(N,79);




e = -6;



<<"%V $f $N \n"


chkN(e,-6)

int b = 79;

chkN(b,79)

<<"%V $f $e\n"

b = f * e;

<<"%V$b\n"

chkN(b,-42);

// use float arg -
// Foo(int) will convert to call -- 

int Foo(float a)
 {

 int b;
 b = a;

 int e = a;

  c= e * 13;

  <<"%V$a $b $e\n"

  return c
}

    df=Foo(2.0);

df<-pinfo();


    d=Foo(2);

  chkN(d,2*13);

<<"%V $d\n"

    d=Foo(3);

<<"%V $d\n"

  chkN(d,3*13);


    mc= 7.0;
    

    d=Foo(mc );

  chkN(d,mc*13);
<<"%V $d\n"



chkOut();

