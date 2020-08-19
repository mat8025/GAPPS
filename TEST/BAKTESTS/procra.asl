
CheckIn()
setdebug(1)

proc foo(a) 
{
 ret = 0;
<<" $_proc foo $a \n"

  if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret =  1    // FIX?? needs a ; statement terminator
  }

  else if (a < 0) {
<<" $a < 0 should be returning -1 !\n"

    ret =  -1

  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }
  return ret ;

}
////////////////////////////////////////

proc foo2(a) 
{
int ret = 0;
<<" $_proc foo2 $a \n"

    if (a > 300) {
<<" $a > 300 foo2 should be returning 30 !\n"
    ret =30
    }

    else if (a > 200) {
<<" $a > 200 foo2 vshould be returning 20 !\n"
    ret = 20
    }

    else if (a > 100) {
<<" $a > 100 foo2 should be returning 10 !\n"
    ret = 10
    }

//////////////////////////////////////////////

  else if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret=  1;
  }

  else if (a < 0) {
<<" $a > 1 should be returning 1 !\n"
    ret=  -1;
  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }

   return ret;
}
//////////////////////////////////

proc foo3(a) 
{
int ret = 0;
<<" $_proc foo2 $a \n"

    if (a > 300) {
<<" $a > 300 foo3 should be returning 30 !\n"
    ret = 30;
    }

    else if (a > 200) {
<<" $a > 200 foo3 vshould be returning 20 !\n"
    ret = 20
    }

    else  if (a > 100) {
<<" $a > 100 foo3 should be returning 10 !\n"
    ret = 10;
    }

    return ret;
}

in = 2

   c = foo(in)

<<" $in $c \n"

   chkN(c,1)


   c = foo(in) * 2

   <<" $in $c \n"

   chkN(c,2)


in = 1

   c = foo(in)

<<" $in $c \n"

   chkN(c,0)

 in = 3

 c = foo(in)

<<" $in out $c \n"

   chkN(c,1)

 c = foo(in) * 6

<<" $in $c \n"

   chkN(c,6)

  in = -4

 c = foo(in) * 6

<<" $in $c \n"

   chkN(c,-6)

   in = 110

   d = foo2(in) 

<<"ret will be  $d\n"


   in = 210

   d = foo2(in) 

<<"ret will be  $d\n"

   e = foo3(in) 

<<"ret will be  $e\n"


   //c = foo2(in) * 6
   c = 6 * foo2(in) 

  <<" $in $c \n"

   chkN(c,120)


  in = 310

   d = foo2(in) 

<<"ret will be $d\n"

   e = foo3(in) 

<<"ret will be  $e\n"


   c = foo2(in) * 7

<<"%V $in $c \n"
    
  chkN(c,210)


  for (j = 0 ; j < 3; j++) {

      in = 3

      c = foo(in) * (j + 1)

      <<" $in  returned * 3  $c \n"

      chkN(c,(j+1))

  }


   CheckOut()

STOP!



