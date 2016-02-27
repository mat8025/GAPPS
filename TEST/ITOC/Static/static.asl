// test static statement


//setdebug(1,"pline")

checkIn()

proc  foo ( x)
{
  static int a = 5;
  int k = 2 ;

<<" entered $_proc %V$a $k\n"

  checkNum(k,2)

<<"%V$a $A\n"
  checkNum(a,A)


<<"%V$a\n"
<<"$(typeof(a)) $a \n"
    k = k + 1
//    a++

<<"%V$k  $x\n"

<<"%V$a  $x\n"


//<<"%V$k $a $x\n"
     a++;
     A++;
     
<<"exiting $_proc %V$a $A\n"

}

proc  goo ( x)
{
static int a = 14; // does not work for xic
static int b = 79;

int k;
 k = 2; 
<<" entered $_proc $x\n"
<<"%V$a\n"

<<"$(typeof(a)) $a \n"

    k = k + 1

<<"%V$k  $x\n"

<<"%V$a  $x\n"

     a++;

<<"exit $_proc %V$a $b\n"

}
//==================================

int A = 5;   

<<"%V$A\n"

 checkNum(A,5)

 foo(1)

 checkNum(A,6)

 foo(2)

 checkNum(A,7)

 goo(2)

 foo(3)

 checkNum(A,8)

 goo(3)

 checkOut()

stop!