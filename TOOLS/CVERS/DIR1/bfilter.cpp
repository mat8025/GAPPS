/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                     bfilter   
///   CopyRight   - RootMeanSquare          
//    Mark Terry  - 1995 -->                
/////////////////////////////////////////<v_%_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

/*************************************************************
 *   bfilter --- build a module for command line piping      *
 *                                                           *
 ************************************************************/


#include <gasp-conf.h>

#include<sys/socket.h>   
#include<arpa/inet.h> 
#include "si.h"
#include "gshm.h"
#include "win.h"
#include "wcom.h"
#include "sam.h"
#include "gstime.h"
#include "ctype.h"
#include "chem.h"
#include "clock.h"
#include "debug.h"
#include "externs.h"
#include "vsh.h"
#include "sig.h"
#include "fop.h"
#include "prep.h"
#include "wcom.h"
#include "thread_w.h"


int  buildFilter (int argc, char *argv[],char *envp[], FILE *sfp, int starg)
{
 /// this will take code lines
 /// and insert them into a template filter
 ///
 /*
  *     Svar ipline;
  *     Svar Fs;
  *     while (1) {
  *           Fs=readline();
  *           if (feof())) break;
  *           Fs= Split(ipline);
  *        
  *     // insert code from cl_args
  *     //
  *
  *     }
  */
  
  int ok = 0;
  int ka;

      fprintf(sfp,"/// \n//// asl filter code\n\n");
      fprintf(sfp,"Svar Ip;\n");
      fprintf(sfp,"Svar F;\n");
      fprintf(sfp,"fs= ' ';\n\n");
      /// Begin section
      fprintf(sfp,"/// Begin Section\n\n");

        for (ka = starg; ka < argc ; ka++) {
	  if (strncmp("begin:",argv[ka],6) ==0)
	   fprintf(sfp,"   %s\n",argv[ka]);
         }

      
      fprintf(sfp,"/// Main Input Loop\n\n");
      fprintf(sfp,"  while (1) { \n");
      fprintf(sfp,"      Ip=readline(); \n");
      fprintf(sfp,"      if (feof()) break; \n");
      fprintf(sfp,"      F= Split(Ip,fs); \n");
      fprintf(sfp,"\n\n///>>> code insert  \n\n");

///
/// proc/function code
/// needs to rearrange out of the
/// use begin: label
/// can also include set of LIB procs
/// begin: include "Filter.asl"
/// main while loop
///
	for (ka = starg; ka < argc ; ka++) {
	  if ((strncmp("end:",argv[ka],4) !=0)
	      && (strncmp("begin:",argv[ka],6) !=0))
	        fprintf(sfp,"   %s\n",argv[ka]);
         }

	fprintf(sfp,"\n\n///<<< end code insert  \n\n");
      fprintf(sfp," } /// end filter  \n\n");

      /// End section
      fprintf(sfp,"/// End Section\n\n");

        for (ka = starg; ka < argc ; ka++) {
	  if (strncmp("end:",argv[ka],4) ==0)
	   fprintf(sfp,"   %s\n",argv[ka]);
         }

      fflush(sfp);
      fclose(sfp);
      ok = 1;
      

      return ok;
}


///
