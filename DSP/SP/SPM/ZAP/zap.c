static char     rcsid[] = "$Id: zap.c,v 1.1 1999/07/05 15:23:57 mark Exp mark $";
/* zap : process killer */

#include <gasp-conf.h>
#include <stdio.h>
#include <signal.h>
#include "machine.h"

char *progname;

/* char *ps = "ps -e"; */

#if __FreeBSD__
char *ps = "ps -ux";
#endif

#if __linux__
/* char *ps = "ps ux"; */
char *ps = "ps ax";
#endif

#if __sun__
char *ps = "ps -ae";
#endif

#if __bsdi__
char *ps = "ps -x";
#endif

#if   __rtu__
char *ps = "ps -ef";
#endif

#if   mc68000
char *ps = "ps -ef";
#endif


main(argc,argv)
int argc;
char *argv[];

{
	FILE *fin, *popen();
	char buf[BUFSIZ];
	char nbuf[BUFSIZ];	
        char pname[1024];
        char ptime[1024];
        char ptty[1024];
        char pstat[1024];
        char pstart[1024];
        char vsz[32];
        char rss[32];
        char cpu[32];
        char mem[32];

	int pid;
	int k;
	char ans[2];
	char owner[32];
        int print_out = 1;
        int killed = 0;

	progname = argv[0];

	if ((fin = popen(ps,"r")) == NULL) {
		fprintf(stderr,"%s: can't run %s\n",progname,ps);
		exit(1);
	}

	fgets(buf, sizeof buf,fin);

	/*  printf("%s %s\n",progname,argv[1]);  */
	
     while (fgets(buf, sizeof buf, fin) != NULL)

		for (k = 1; k < argc ; k++) {

		strcpy(nbuf,buf);

			nbuf[strlen(nbuf)-1] = '\0';

#ifdef RTU
				sscanf(nbuf, "%s %d",owner, &pid);
#endif

#ifdef SUN
				sscanf(nbuf,"%d  %s",&pid,owner);
#endif

#if __bsdi__
				sscanf(nbuf,"%d  %s %s %s %s",&pid,ptty,pstat,ptime,pname);
#endif

#if __linux__
/* sscanf(nbuf,"%s %d  %s %s %s %s %s %s %s %s %s",owner,&pid,cpu,mem,vsz,rss,ptty,pstat,pstart,ptime,pname);
 printf("%s %d  %s %s %s %s %s %s %s %s %s\n",owner,pid,cpu,mem,vsz,rss,ptty,pstat,pstart,ptime,pname);
*/
 sscanf(nbuf,"%d  %s %s %s %s ",&pid,ptty,pstat,ptime,pname);
#endif

#if __FreeBSD__
 sscanf(nbuf,"%s %d  %s %s %s %s %s %s %s %s %s",owner,&pid,cpu,mem,vsz,rss,ptty,pstat,pstart,ptime,pname);
#endif

	if(strindex(pname, argv[k]) >= 0) {
                killed++;
	  if (print_out) {
		  printf("%s %s %s\n",nbuf,pname,argv[k]); 		
		  printf("killing  %s pid %d %d\n",pname,pid,killed); 
	  }

		kill (pid, SIGKILL); 
		}
	}
		exit(0);

}

strindex(s,t)
char *s,*t;
{
	int i,n;
	
	n = strlen(t);
	for (i =0; s[i] != '\0'; i++) {
   		if (strncmp(s+i,"zap",3) ==0)
			return -1;
		if (strncmp(s+i,t,n) ==0)
			return i;
         }
			return -1;
}

ttyin(ans)
char ans[];
{
	scanf("%s", ans);
}
