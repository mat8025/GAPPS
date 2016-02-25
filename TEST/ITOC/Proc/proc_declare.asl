
//

setdebug(1)

checkIn()

proc foo(a)
{

 int s1 = a * 5

<<"in %V$a local a * 5 $s1\n"

 return s1
}

proc goo(a)
{

 int s1;

 s1 = a * 5

<<"in %V$a local a * 5 $s1\n"

 return s1
}

proc moo(a)
{

 int s2 =  5;

 s1 = s2 * a;
 
<<"in %V$a local a * 5 $s1\n"

 return s1
}


  m = foo(3)

<<"%V$m\n"

  checkNum(m,15)
  m2 = foo(4 )

<<"%V$m2\n"
  checkNum(m2,20)

 b = 16


  m3 = foo(b )

<<"%V$m3\n"

  checkNum(m3,80)



  m = goo(3)

<<"%V$m\n"

  checkNum(m,15)
  m2 = goo(4 )

<<"%V$m2\n"
  checkNum(m2,20)

 b = 16


  m3 = goo(b )

<<"%V$m3\n"

    checkNum(m3,80)


  m = moo(3)

<<"%V$m\n"

  checkNum(m,15)
  m2 = moo(4 )

<<"%V$m2\n"
  checkNum(m2,20)

 b = 16


  m3 = moo(b )

<<"%V$m3\n"

    checkNum(m3,80)

checkOut()