//%*********************************************** 
//*  @script proc.asl 
//* 
//*  @comment test proc syntax/operation 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.50 C-He-Sn]                              
//*  @date Sat May 23 23:27:05 2020 
//*  @cdate Fri Apr 17 23:49:26 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
/// test proc
///

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


double Foo(double a)
{
 <<" IN $_proc $a \n"

// float tmp;

 tmp = a/2.0;
 tmp2 = a * 2.0;

<<"%V $a $tmp $tmp2\n"

 return tmp;

}
//===================


double Goo(real a)
{
 <<" IN $_proc $a \n"
/*
   a->info(1);


  tmp = a/2.0;
  tmp->info(1)
  tmp2 = a * 2.0;
  tmp2->info(1)
<<"%V $tmp $tmp2 \n"
*/
  d =a * 2.0;

  d->info(1);

 return d;

}
//===================


 x = 20.2

<<"%V $x\n"
 x->info(1)

 cy = Cos(x)
 
 cy->info(1)

 y = Sin(cy)

 y->info(1)

<<"%V $y \n"

y /= 2.0;

y->info(1)

//double gr =Goo(x)

//double gr;

gr =Goo(x)

<<"%V $x $gr \n"

gr->Info(1)

!a
chkR(gr, (x*2))

gr->Info(1)

chkOut()

x = 14.89

gr=Goo(x)

 <<"%V  $gr $x \n"

chkR(gr, (x*2))






<<" $cy \n"

 y = Sin(cy)

<<" $y \n"

  y->info(1)
  y /= 2.0;
  y->info(1)
  
  t = Foo(x)

<<"$x $t \n"


  t = Foo(Cos(x))

<<"$x $t \n"


  t = Foo(Sin(Cos(x)))

<<"$t \n"

  t = Goo(x)

<<"%V $t \n"

  y->info(1)


  y = x/2.0;

  y->info(1)
  t = Foo(x)
  
 t->info(1)
<<"%V $x $y $t\n"

  chkR (t,y,6)



x = -20.2;

 <<"%V $_proc $x \n"

 y = Cos(x)

<<" $y \n"

 y = Sin(y)

<<" $y \n"

 y /= 2


  t = Foo(Sin(Cos(x)))

<<"$x $t \n"

  chkR(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

<<" $y \n"

 y /= 2

  t = Foo(Cos(Sin(x)))

<<"$x $t \n"

  chkR (t,y,6)

 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y /= 2

  t = Foo(Sin(Cos(Sin(x))))

<<"$x $t \n"

  chkR(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y = Sqrt(y)

 y /= 2

  t = Foo(Sqrt(Sin(Cos(Sin(x)))))

<<"$x $t \n"

  chkR (t,y,6)






//FIXME   t = foo(Cos(x))

t = Foo(Cos(x))

 <<"$x $t \n"

chkOut()


N = _clargs[1]

<<" $_clargs[::] \n"

int k = 1

<<" START $k $N \n"

 a = 2
 y = a

<<" $y = $a \n"

proc poo()
{
// increments global k
// does calc and returns that value   
   k++
   a= k * 2
<<" in $_cproc %v $k $a\n" 
}


proc noo()
{
   k++
   a= k * 4
<<" in $_cproc %v $k $a\n" 
    return a 
}


 k = 0
 while ( k < N) {

<<" before poo call k is $k\n"

    poo()

<<" after poo call \n"
<<" 2 after poo call \n"

 <<" poo a is $a k is now $k\n"

 }


<<" DONE $k $N \n"

exit()



////  TODO/FIX /////////////
// does not move to statement after proc call
// immediate statement after proc return is not executed

