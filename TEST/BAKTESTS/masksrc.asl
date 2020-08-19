//%*********************************************** 
//*  @script masksrc.asl 
//* 
//*  @comment test stripping src lines from exe 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sun Mar 15 07:18:03 2020 
//*  @cdate Sun Mar 15 07:18:03 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


//  start

proc foo( x,y)
{

   z = x * y

   return z;
}

//========================

a =2;
b =2;

c= a +b;

<<"$a + $b =$c\n"

N= 10

  for (i = 0; i< N; i++) {
   a = b * i
   c=foo(a,i)
   <<"$i  $a $b $c\n"
  }

// time to exit

exit()


///
///   proc statement - gives error

///














