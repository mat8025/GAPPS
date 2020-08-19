
proc foo( a, b)
{

 c = a + b;
 <<"%V $a $b $c\n"

a++;
b++;

 c = a + b;
 <<"%V $a $b $c\n"

}
//==============

proc fvec (int Y[], int X[])
{

<<"%V $X[::]\n"
<<"%V $Y[::]\n"
 X[1] = 47;
 Y[1] = 79;
<<"%V $X[::]\n"
<<"%V $Y[::]\n"

}

int a_3 = 66;

vn = "a_3"

k = $vn

$vn = 77

<<"%V$vn $k $a_3 \n"
// output is :-

//vn a_3 k 66 a_3 77 


int y[4] = {7,8,9};

int x[4] = {4,5,6};



<<"%V $x $y\n"
//foo(x,y)

<<"%V $x $y\n"

ptr r = &x;
ptr q =&y;

//foo($r,$q)

<<"%V $x $y\n"



<<"%V $x $y\n"


fvec(x,y)


fvec(y,x)



fvec(r,q)
exit()

