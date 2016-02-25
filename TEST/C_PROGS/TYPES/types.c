#include <stdio.h>


main()
{

  short s = 12345;

  printf("short %d %d \n",s,sizeof(s));


  int i = 1234567;

  printf("int %d %d \n",i,sizeof(i));


  long l = 2;

  printf("long %ld %d \n",l,sizeof(l));

  float f = 2.123456789;

  printf("float %f %d \n",f,sizeof(float));

  double d = 2.123456789;

  printf("double %f %g %d \n",d,d,sizeof(double));



}
