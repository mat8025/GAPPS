///
///
///



proc foo( x,y)
{

   z = x * y

   return z;
}


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


exit()