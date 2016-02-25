#include <stdio.h>
#include <math.h>


int foo (int x, int y)
{
  int z;

  z = x + y;

  printf("foo() %d = %d + %d \n",z,x,y);

  return z;

}


main()
{
  int a,b,c;

  a= 2;
  b = 2;

  c = a + b;
  printf ("c = a + b;\n");
  printf("c %d a %d b %d\n",c,a,b);
  c = a++ + b++;
  printf ("c = a++ + b++;\n");
  printf("c %d a %d b %d\n",c,a,b);


  c = ++a + --b;
  printf ("c = ++a + --b;\n");
  printf("c %d a %d b %d\n",c,a,b);

  c = (++a) + (--b);
  printf ("c = ++a + --b;\n");
  printf("c %d a %d b %d\n",c,a,b);


  c = (++a) + (--b);
  printf ("c = ++a + --b;\n");
  printf("c %d a %d b %d\n",c,a,b);


  a =2; b= 2;

  c = foo(a++, b++);

  printf("c %d a %d b %d\n",c,a,b);

}
