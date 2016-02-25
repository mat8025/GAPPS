#include <stdio.h>
#include <string.h>


        typedef char * pc;    /* pointer to char */
        typedef pc fpc();    /* function returning pointer to char */
        typedef fpc *pfpc;    /* pointer to above */
        typedef pfpc fpfpc();    /* function returning... */
        typedef fpfpc *pfpfpc;    /* pointer to... */

#define N 10

char *s="abc";

char * foo()
{
  char *cp = &s[1];
  return cp;
}

pfpc goo()
{
  // pfpfpc fp2;
  pfpc fp = &foo; 

  return fp;
}


int main()
{


  pc cp = s;

  printf("pc %s \n",cp);

  pfpc fp = &foo; 
  pfpc gp;
  cp = fp();

   printf("fp %s \n",cp);

   pfpfpc fp2 = &goo;
   gp = fp2();

     cp = gp();

   printf("gpfp %s \n",cp);
        pfpfpc a[N];         /* array of... */



}
