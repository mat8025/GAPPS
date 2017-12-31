///
///
///

setDebug(1,"trace");


int f = 7;

<<"%V $f \n"

checkin();

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









 proc foo(a)
 {

  //int b = a;
 int b;
 b = a;

 int e = a;
  
  <<"%V$a $b $e\n"

  c= e * 13;

  return c
}


    d=foo(2);

  checkNum(d,2*13);

<<"%V $d\n"

    d=foo(3);

  checkNum(d,3*13);
<<"%V $d\n"

    mc= 7.0;
    

    d=foo(mc );

  checkNum(d,mc*13);
<<"%V $d\n"



checkOut();

