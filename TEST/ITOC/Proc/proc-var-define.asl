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

checkin(_dblevel);

CheckFNum(f,7);

int N =   79;

<<"%V $f $N \n"


int c = atoi(_argv[1]);

d = atoi(_argv[1]);

<<" $_argv[1] $c $d\n"

checkNum(c,d);


int M = (47*1);


checkNum(M,47);




checkNum(N,79);




e = -6;



<<"%V $f $N \n"








CheckNum(e,-6)

int b = 79;

CheckNum(b,79)

<<"%V $f $e\n"

b = f * e;

<<"%V$b\n"

CheckNum(b,-42);



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

  checkNum(d,2*13);

<<"%V $d\n"

    d=Foo(3);

<<"%V $d\n"

  checkNum(d,3*13);


    mc= 7.0;
    

    d=Foo(mc );

  checkNum(d,mc*13);
<<"%V $d\n"



checkOut();

