#include <stdio.h>
#include <stdlib.h>
#include <iostream>


#include "defs.h"
#include "svar.h"
#include "debug.h"


void whatError( int en, const char *where) {
  DBE ("%s %s \n,",where,asl_error_msg (en));
}
//[EF]===================================================//


int sfree(void *ptr, char *name)
{
  int ok = SUCCESS;
   int i;

/// look up ptr in smem
/// find ptr in MT

   if (ptr == 0) {
      DBE( "free but ptr is NULL \n");
      return -1;
   }

    free (ptr);
  ptr = NULL;

      return 1;

}
///////////////////////////////////////
void sfree(void *ptr)
{

  free (ptr);
  ptr = NULL;
  
}

//[EF]===================================================//

void StrNCopy(char *to, const char *from, int maxn)

{
     // guarantees a null at to[maxn-1]
  // to MUST HAVE maxn chars in its array!! 
   strncpy(to,from,maxn);
    to[maxn-1] = 0;
}
//[EF]===================================================//


int strLen(const char *s)
  {
	     if (s == NULL) return 0;
             else return (strlen((const char*) s));
  }
//[EF]===================================================//
void *scalloc_id(int n, int msize, const char *key)
{
    void *ptr;
 
    if (msize <= 0) {
      dbp("warning neg size to calloc n size %d \n",msize);
      msize = 4;
    }

    if (n <= 0) {
      dbp("warning size to calloc n %d %s\n",n,key);
      n = 1;
    }

    ptr = calloc(n, msize);

    return ptr;
}
//[EF]===================================================//

void *srealloc_id(void *optr, int nbytes, const char *key)
{
  
  void *nptr = realloc(optr, nbytes);
  return nptr;
}
//[EF]===================================================//





char * AdvancePastWhite(char *t)
{
    while (*t == ' ' || *t == 9) {
	t++;
	if (*t == 0)
	    break;
    }

    return t;
}
//[EF]===================================================//


char * NextWhite(char *t)
{

  while (*t != ' ' && *t != 9 && *t != '\n') {
    t++;
    if (*t == 0)
      break;
  }

  return t;
}
//[EF]===================================================//
