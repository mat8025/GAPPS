//%*********************************************** 
//*  @script proc.asl 
//* 
//*  @comment test proc syntax/operation 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr 17 23:49:26 2020 
//*  @cdate Fri Apr 17 23:49:26 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
/// test proc
///


checkIn(_dblevel)

Proc foo(double a)
{
 <<" IN $_proc $a \n"

// float tmp;

 tmp = a/2.0;
 tmp2 = a * 2.0;

<<"%V $a $tmp $tmp2\n"

 return tmp;

}
//===================
//Proc goo(double a)


Proc goo(real a)
{
 <<" IN $_proc $a \n"
//  real d;
 a->info(1);
// d= atof(a)

  tmp = a/2.0;
  tmp->info(1)
 tmp2 = a * 2.0;
   tmp2->info(1)
<<"%V $tmp $tmp2 \n"

 d =a * 2.0;

d->info(1);

// real tmp;
// real tmp2;
 
 
 tmp2->info(1)
 return tmp2;

}
//===================


x = 20.2

gr=goo(x)
<<"$x $gr \n"

checkFnum(gr, (x*2))



x = 14.89

gr=goo(x)

 <<"%V  $gr $x \n"

checkFnum(gr, (x*2))


exit()

 cy = Cos(x)

<<" $cy \n"

 y = Sin(cy)

<<" $y \n"

 y /= 2.0;

  t = foo(x)

<<"$x $t \n"


  t = foo(Cos(x))

<<"$x $t \n"


  t = foo(Sin(Cos(x)))

<<"$t \n"

  t = goo(x)

<<"$t \n"

  y = x/2.0;

  t = foo(x)
t->info(1)
<<"%V $x $y $t\n"

  CheckFNum(t,y,6)



exit()
x = -20.2;

 <<"%V $_proc $x \n"

 y = Cos(x)

<<" $y \n"

 y = Sin(y)

<<" $y \n"

 y /= 2


  t = foo(Sin(Cos(x)))

<<"$x $t \n"

  CheckFNum(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

<<" $y \n"

 y /= 2

  t = foo(Cos(Sin(x)))

<<"$x $t \n"

  CheckFNum(t,y,6)

exit()


 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y /= 2

  t = foo(Sin(Cos(Sin(x))))

<<"$x $t \n"

  CheckFNum(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y = Sqrt(y)

 y /= 2

  t = foo(Sqrt(Sin(Cos(Sin(x)))))

<<"$x $t \n"

  CheckFNum(t,y,6)






//FIXME   t = foo(Cos(x))

t = foo(Cos(x))

 <<"$x $t \n"

CheckOut()

exit()

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

