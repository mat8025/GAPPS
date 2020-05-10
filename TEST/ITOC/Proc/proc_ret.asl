//%*********************************************** 
//*  @script proc_ret.asl 
//* 
//*  @comment test return type vs proc args 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                    
//*  @date Sat May  9 10:35:36 2020 
//*  @cdate Sat May  9 10:35:36 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
checkIn(_dblevel)


proc Foo(real x,real  y)
{

   z = x * y

   return z
}




  a = Foo(2,3)
 checkFnum(a,6)
a->info(1)

  b = Foo(4.0,3.0)
 checkFnum(b,12)
b->info(1)

<<"%v $b \n"


int a1 = 2;
int a2 = 4;

  c = Foo(a1,a2)
 checkFnum(c,8)
c->info(1)

<<"%v $b \n"



   j = 1
   n = 12
   while (j < 4) {

      a = Foo(j,n)


<<" $j * $n  = $a\n"
    j++
   }


checkOut()




