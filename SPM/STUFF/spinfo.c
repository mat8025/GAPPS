
/*********************************************************************************
 *			info							 *
 *********************************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"

main (argc, argv)
int   argc;
char *argv[];
{
char  module [120];
char  program[120];
int i, man_page ;
int debug = 0;
/* process command line for specifications */

   for (i = 2 ; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'M': 
		  man_page = 1;
		  break;

	       case 'Y':
 	          debug = atoi( argv[++i]) ;
	          break;

	       default: 
		  return (-1);
	    }
	    break;
      }
   }

   strcpy( program, argv[1]);
   printf("%s :\n",program);

if ((debug == HELP) || (strcmp(program,"info") == 0))
	sho_use();

   sprintf(module,"%s -Y %d",program,HELP);
   system(module);
   
}

sho_use()
{
 printf("info provides useage for modules\n");
 printf("e.g. try \n");
 printf("info sg\n");
 exit (-1);
}
