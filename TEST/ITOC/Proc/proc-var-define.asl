//%*********************************************** 
//*  @script proc-var-define.asl 
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
myScript = getScript();///
///
///




int f = 7;

<<"%V $f \n"

chkIn(_dblevel);

chkR(f,7);

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



proc Foo(int a)
 {

 int b;
 b = a;

 int e = a;
  


  c= e * 13;

  <<"%V$a $b $e\n"

  return c
}


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

