#include <stdio.h>
#include <sys/types.h>


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


  bool b = true;

  printf("bool %d  %d \n",b,sizeof(bool));

  u_int32_t wd =1;

    printf(" %x %o %l %d\n",wd,wd,wd,wd );
  wd = -1;

  printf(" %x %o %l %d\n",wd,wd,wd,wd);

  u_int32_t swd =1;
  u_int32_t twd =0;
    u_int32_t awd =0;

       for (i = 0; i < 32 ; i++) {
	 twd += swd;
       printf("[%d] %x %o %ld %d\n",i,swd,swd,swd,swd);
       printf("[%d] %x %o %ld %d\n",i,twd,twd,twd,twd);       
       swd = swd << 1;
       }
       i--;
       printf("select bits 31=>1\n");
       swd = 020000000000;
       for (i=31; i>=0; i--) {
       awd = twd & swd;
              printf("[%d] %x %o %ld %d\n",i,awd,awd,awd,awd);
       awd = twd & ~swd;
              printf("[%d] %x %o %ld %d\n",i,awd,awd,awd,awd);       	      
	      swd = swd >> 1;
       }
       
}
