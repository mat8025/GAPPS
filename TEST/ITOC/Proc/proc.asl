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
include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

setdebug(1,@pline,@~trace)

//#define ASK ans=iread("->");
#define ASK ;

CheckIn(1)

Proc foo(a)
{
 <<" IN $_proc $a \n"

 float tmp;

 tmp = a/2.0;
 tmp2 = a * 2.0
<<"%V $a $tmp $tmp2\n"
 return tmp

}
//===================
Proc goo(double a)
Proc goo(real a)
//Proc goo(gen a)
{
 <<" IN $_proc $a \n"

 a->info(1);
// d= atof(a)
 d =a;
 d->info(1);
 real tmp;
 real tmp2;
 
 tmp = d/2.0;
 tmp2 = d *2.0;
<<"%V $tmp $tmp2 \n"
 tmp2->info(1)
 return tmp2;

}
//===================


x = 20.2

 <<"%V  $x \n"

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

<<"$x $t \n"
  t = goo(x)

<<"$t \n"

  t = goo(x)

<<"$t \n"

  y = x/2.0;

<<"%V $x $y \n"

  t = foo(x)

exit()

  CheckFNum(t,y,6)


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



N = _clargs[1]

<<" $_clargs[::] \n"


//FIXME   t = foo(Cos(x))

t = foo(Cos(x))

 <<"$x $t \n"

CheckOut()

exit()



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

