#include <stdio.h>
#include <string.h>

main()
{
  char s[10] = "abcdef";
  char *cp;
  char *sp = "123\n";
  printf("%s %d\n",sp,sizeof(sp));


float j;
j=1000*1000;
printf("%6.2f\n",j);

  int m = 5;

  int n = m++ * ++m;

  printf("m %d n %d\n",m,n);

  const char sc[10] = "abcdef";

  const char * ccp = sc;
  char const * vcp = sc;

  char * const cpc = s;


  const char * const cppc = sc;

  cp = s;
  printf(" %s \n",cp);
  strcpy(cp,"12345");
  printf(" %s \n",cp);
  cp++;
  printf(" %s \n",cp);



  ccp = sc;
  printf(" %s \n",ccp);
  //strcpy(ccp,"12345"); // error can't copy over to readonly char ptr
  printf(" %s \n",ccp);
  ccp++;  // ok can move ptr
  printf(" %s \n",ccp);

  
  printf(" %s \n",cpc);
  //cpc++; // error ptr is const can't move it
  strcpy(cpc,"AH-HAH");  // but it is point to non-readonly and can change contents
  printf(" %s \n",cpc);

  // can't move the pointer - can't change the contents
   printf(" %s \n",cppc);


   printf("vcp %s\n",vcp);
   vcp++;
   printf("vcp %s\n",vcp);
   //strcpy(vcp,"12345"); // error can't copy over to readonly char ptr
}
