#include <stdio.h>
#include <dlfcn.h>
#include <string.h>

#define MAX_STRING    80

// unresolved symbols
FILE *Jf = NULL;
//


void invoke_method( char *lib, char *method, float argument )
{
  void *dl_handle;
  float (*func)(float);
  char* (*cfunc)();
  char *error;

  /* Open the shared object */
  dl_handle = dlopen( lib, RTLD_LAZY );
  if (!dl_handle) {
    printf( "!!! %s\n", dlerror() );
    return;
  }

  /* Resolve the symbol (method) from the object */


  if (strcmp(method,"checkLib") == 0) {
  cfunc = dlsym( dl_handle, method );
  error = dlerror();
  if (error != NULL) {
    printf( "!!! %s\n", error );
    return;
  }
    printf("  %s\n", (*cfunc)() );

  }
  else {
  func = dlsym( dl_handle, method );
  error = dlerror();
  if (error != NULL) {
    printf( "!!! %s\n", error );
    return;
  }
  /* Call the resolved method and print the result */
  printf("  %f\n", (*func)(argument) );
  }
  /* Close the object */
  dlclose( dl_handle );

  return;
}


int main( int argc, char *argv[] )
{
  char line[MAX_STRING+1];
  char lib[MAX_STRING+1];
  char method[MAX_STRING+1];
  float argument;

  while (1) {

    printf("> ");

    line[0]=0;

    fgets( line, MAX_STRING, stdin);

    if (!strncmp(line, "bye", 3)) break;

    sscanf( line, "%s %s %f", lib, method, &argument);

    invoke_method( lib, method, argument );

  }

}

