//%*********************************************** 
//*  @script procret0.asl 
//* 
//*  @comment test procedure return 
//*  @release CARBON 
//*  @vers 1.23 V Vanadium                                                
//*  @date Sun Jan 27 21:50:27 2019 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug"

<<"%V $_dblevel\n"

if (_dblevel >0) {
   debugON()
}



checkIn(_dblevel)

proc foo(real a) 
{
 ret = 0;
<<" $_proc foo $a \n"

  if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret =  1    // FIX?? needs a ; statement terminator
  }

  else if (a < 0) {
<<" $a < 0 should be returning -1 !\n"

    ret =  -1;

  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }
  return ret;

}
////////////////////////////////////////

proc foo2(real a) 
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

proc foo3(real a) 
{
int ret = 0;
<<" $_proc foo2 $a \n"
  a->info(1)
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

proc goo(ptr a)
//proc goo(int a)
{
<<"$_proc $a\n"
  a->info(1)
  $a += 1;
  a->info(1)
// does,nt really return anything
// return on own crash TBF crash
   return;
}
//==================================//

proc hoo(real a)
{
<<"$_proc $a\n"
  a->info(1)
  a += 1;

// does'nt really return anything
     return;  // TBD crash
 //   return ; // OK
}
//==================================//

proc moo(double a)
{
<<"$_proc $a\n"
  a += 1;
<<"%V $a\n"


 a->info(1)
 
 if (a >1) a += 1;

// if (a >10)  return; // TBF needs {}

  int mb = a;
  mb += 2;
  
<<"%V $a\n"

  mb->info(1);
  
  return mb;  // TBD crash
}
//==================================//
proc roo(ptr a)
{
<<"$_proc $($a)\n"
  $a += 1;
<<"%V $a\n"


 a->info(1)
 
 if ($a >1) $a += 1;

// if (a >10)  return; // TBF needs {}

  int mb = $a;

<<"%V $mb \n"
  mb += 2;
  
<<"%V $a\n"

  mb->info(1);
  
  return mb;  // TBD crash
}
//==================================//

in = 2

   c = foo(in)

<<" $in $c \n"

   checkNum(c,1)


   c = foo(in) * 2

   <<" $in $c \n"

   checkNum(c,2)


in = 1

   c = foo(in)

<<" $in $c \n"

   checkNum(c,0)

 in = 3

 c = foo(in)

<<" $in out $c \n"

   checkNum(c,1)

 c = foo(in) * 6

<<" $in $c \n"

   checkNum(c,6)

  in = -4

 c = foo(in) * 6

<<" $in $c \n"

   checkNum(c,-6)

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

   checkNum(c,120)


  in = 310

   d = foo2(in) 

<<"ret will be $d\n"

   e = foo3(in) 

<<"ret will be  $e\n"


   c = foo2(in) * 7

<<"%V $in $c \n"
    
  checkNum(c,210)


  for (j = 0 ; j < 3; j++) {

      in = 3

      c = foo(in) * (j + 1)

      <<" $in  returned * 3  $c \n"

      checkNum(c,(j+1))

  }

   x =1;
   goo(&x)

<<"goo $x\n"

   checkNum(x,2);

   hoo(x)

   checkNum(x,2);


   double xm=14.0

   mr= moo(xm)
   
<<"%V $xm $mr\n"

   checkNum(mr,18);

   int ixm = 14;
   
   mr= roo(&ixm)

<<"%V $ixm $mr\n"



   checkOut()




