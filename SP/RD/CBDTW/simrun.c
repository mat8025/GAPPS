/****************************************************************
* Simrun File Generator                                         *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      11.11.96 *
****************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define MAXELE  10


char    *elelist[] =   {"cs3","ecH","ecG","ecN","ecA","ecI","ecU",
			"evA","evI","evU"};

struct
{
  char name[8];
  int simreal;
} eleinfo[MAXELE];


FILE	*outr100, *outrun;
int     percent, false, outof, full;
int     simul, realop, rnum, snum;
long    ranseed;
char    simstr[MAXELE][8], realstr[MAXELE][8];


void 	getflags(int argc, char *argv[]);
void    openfiles(void);
void    dotemplate(void);
void 	checkflags(void);



int main(int argc, char *argv[])
{
  percent = 100;
  false = 0;
  outof = 0;
  ranseed = 29;

  if (argc < 2)
  {
    printf("Usage : simrun [...] {1.11}\n");
    printf(" -h H : hit percentage (100)\n");
    printf(" -f F : in-class false alarm percentage (0)\n");
    printf(" -c C : out-of-class false alarm percentage (0)\n");
    printf(" -r R : real elements\n");
    printf(" -s S : simulated elements\n");
    printf(" -t T : template type FULL, QUICK (QUICK)\n");
    printf(" -R R : random generator seed (29)\n");
    exit(0);
  }

  getflags(argc,argv);

  openfiles();
  dotemplate();

  fclose(outr100);
  fclose(outrun);

  system("chmod a+x r100_sim run_sim");

  return(0);
}


void getflags(int argc, char *argv[])
{
  int i;

  rnum = 0;
  snum = 0;

  for (i=1; i<argc; i++)
  {
    if (*argv[i] == '-')
    {
      switch (*++(argv[i]))
      {
        case 'h' : percent = atoi(argv[++i]);
                   break;
        case 'f' : false = atoi(argv[++i]);
                   break;
        case 'c' : outof = atoi(argv[++i]);
                   break;
        case 'r' : realop = 1;
	           simul = 0;
                   break;
        case 's' : simul = 1;
	           realop = 0;
                   break;
        case 't' : if (!strcmp(argv[++i],"FULL")) full = 1;
	           else full = 0;
                   break;
        case 'R' : ranseed = atol(argv[++i]);
                   break;
        default  : printf("Warning : flag -%c ignored\n",*argv[i]);
      }
    }
    else if (simul)
      {
	strcpy(simstr[snum++],argv[i]);
      }
    else if (realop)
      {
	strcpy(realstr[rnum++],argv[i]);
      }
  }

}


void openfiles()
{
  if ((outr100 = fopen("r100_sim","wt"))==NULL) 
  {
    printf(">> Unable to create file r100_sim\n");
    exit(0);
  }

  if ((outrun = fopen("run_sim","wt"))==NULL) 
  {
    printf(">> Unable to create file run_sim\n");
    exit(0);
  }
}


void dotemplate()
{
  int i, j, k;

  fprintf(outr100,"# r100_sim : 100 0 0\n\n");
 
  fprintf(outr100,"if !(test -s $1.upe)\nthen\n");
  fprintf(outr100,"  echo '>> Cannot find file '$1.upe\n  exit 0\nfi\n\n");

  fprintf(outr100,"PERCENT=100\n");
  fprintf(outr100,"OFF=0\n\n");

  fprintf(outr100,"echo 'Processing file '$1.upe' at '$PERCENT'%%'\n\n");


  fprintf(outrun,"# run_sim : %d %d %d\n\n",percent,false,outof);

  fprintf(outrun,"if !(test -s $1.upe)\nthen\n");
  fprintf(outrun,"  echo '>> Cannot find file '$1.upe\n  exit 0\nfi\n\n");

  fprintf(outrun,"PERCENT=%d\n",percent);
  fprintf(outrun,"FALSE=%d\n",false);
  fprintf(outrun,"OUTOF=%d\n",outof);
  fprintf(outrun,"OFF=0\n");
  fprintf(outrun,"RAND=%d\n\n",ranseed);

  fprintf(outrun,"echo 'Processing file '$1.upe' at '$PERCENT'%% '$FALSE'%% '$OUTOF'%% and random '$RAND\n\n");

  for (i=0; i<MAXELE; i++)
    {
      if (full)
	{
	  fprintf(outr100,"do_sim_es $1 %s > $1.%s.mop\n",elelist[i],elelist[i]);
	  fprintf(outrun,"do_sim_es $1 %s > $1.%s.mop\n",elelist[i],elelist[i]);
	}

      k = 0;

      for (j=0; j<snum; j++)
	if (!strcmp(elelist[i],simstr[j])) k = 1;
	
      for (j=0; j<rnum; j++)
	if (!strcmp(elelist[i],realstr[j])) k = 2;
	
      if (k == 0)
	{
	  fprintf(outr100,"gop -h $OFF $1.%s.mop $1.%s.op\n\n",elelist[i],elelist[i]);
	  fprintf(outrun,"gop -h $OFF $1.%s.mop $1.%s.op\n\n",elelist[i],elelist[i]);
	}
      else if (k == 1)
	{
	  fprintf(outr100,"gop $1.%s.mop $1.%s.op\n\n",elelist[i],elelist[i]);
	  fprintf(outrun,"gop -h $PERCENT -f $FALSE -c $OUTOF -s $RAND $1.%s.mop $1.%s.op\n\n",elelist[i],elelist[i]);
	}
      else if (k == 2)
	{
	  fprintf(outr100,"gop $1.%s.mop $1.%s.op\n\n",elelist[i],elelist[i]);
	  fprintf(outrun,"gop $1.%s $1.%s.op\n\n",elelist[i],elelist[i]);
	}
      
    }

  fprintf(outr100,"mergenet $1");

  fprintf(outrun,"mergenet $1");
}
