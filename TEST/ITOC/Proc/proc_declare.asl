//%*********************************************** 
//*  @script proc_declare.asl 
//* 
//*  @comment test procedure declare format 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                  
//*  @date Sat May  9 09:34:21 2020 
//*  @cdate Sat May  9 09:34:21 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();


#include "debug"

debugON()

//chkIn(_dblevel)

proc foo(int a)
{
<<"in $_proc\n"
 int s1 = a * 5

<<"in %V$a local a * 5 $s1\n"

 return s1
}


//===========================//
k= foo(3)

<<"foo returns $k\n"




int woo(int a)
{
<<"in $_proc\n"

 int s1 = a * 5

<<"in %V$a local a * 5 $s1\n"

 return s1
}

exit()
//===========================//




k= woo(5)


<<"woo returns $k\n"



exit()




















proc goo(int a)
{

 int s1;

 s1 = a * 5

<<"in %V$a local a * 5 $s1\n"

 return s1
}

proc moo(int a)
{

 int s2 =  5;

 s1 = s2 * a;
 
<<"in %V$a local a * 5 $s1\n"

 return s1
}


  m = foo(3)

<<"%V$m\n"

  chkN(m,15)
  m2 = foo(4 )

<<"%V$m2\n"
  chkN(m2,20)

 b = 16


  m3 = foo(b )

<<"%V$m3\n"

  chkN(m3,80)



  m = goo(3)

<<"%V$m\n"

  chkN(m,15)
  m2 = goo(4 )

<<"%V$m2\n"
  chkN(m2,20)

 b = 16


  m3 = goo(b )

<<"%V$m3\n"

    chkN(m3,80)


  m = moo(3)

<<"%V$m\n"

  chkN(m,15)
  m2 = moo(4 )

<<"%V$m2\n"
  chkN(m2,20)

 b = 16


  m3 = moo(b )

<<"%V$m3\n"

    chkN(m3,80)

//int b = 67;


chkOut()