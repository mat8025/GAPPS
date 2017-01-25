/****************************************************************
* Net Output Generator                                          *
*                                                               *
* Simulates net output to a specified accuracy.  Requires .op   *
* files as input                                                *
* Compile with 'gcc -o gop gop.c'                               *
*                                                               *
* Geoff Martindale - geoff@phon.ucl.ac.uk              14.10.96 *
****************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define IA          16807
#define IM          2147483647
#define AM          (1.0/IM)
#define IQ          127773
#define IR          2836
#define NTAB        32
#define NDIV        (1+(IM-1)/NTAB)
#define EPS         1.2e-7
#define RNMX        (1.0-EPS)

#define MAXSWAP     8
#define	MAXCLASS    5
#define	MAXLINE	    2048

#define RAND    1
#define BURST   2
#define BOTH    3


char    *ele3[] = {"ecU1","ecA1","ecI1","ecN1","ecG1",
		   "evU1","evA1","evI1","ev01","cs3","END"};


struct
{
  int class;
  int group;
  char label[32];
  int miss;
} opinfo[MAXLINE];


FILE	*intimit, *outgfe, *inscript;
char	swapstr[MAXSWAP][255], temp[255], change[255];
char	gfefname[255], timitfname[255],	scriptfname[255];
char    errname[8];
int     hitrate, hittotal, falserate;
int     zerorate, zerototal;
int     errtype, line, Nclass;
int	verbose, script, lastswap;
long    ranseed, ranlong;
float   opvalue[MAXLINE][MAXCLASS];
float   newop[MAXLINE][MAXCLASS];
float   one, zero;


void	parse(void);
void	strrpl(char *str, char *find, char *rpl);
void	exchange(void);
void 	getflags(int argc, char *argv[]);
void 	checkflags(void);
void 	showflags(void);
void 	showinfo(void);
void 	getopfile(void);
void    modifyop(void);
void 	putopfile(void);
float   ran1(long *idum);



int main(int argc, char *argv[])
{
  strcpy(errname,"RAND");
  hitrate = 100;
  falserate = 0;
  zerorate = 0;
  verbose = 0;
  script = 0;
  ranseed = -29;

  one = 1.0;
  zero = 0.0;

  if (argc < 3)
  {
    printf("Usage : gop [...] infile outfile {1.24}\n");
    printf(" -h H : hit percentage (100)\n");
    printf(" -f F : false alarm percentage (0)\n");
    printf(" -c C : class zero activation (0)\n");
    printf(" -o O : define one (1.0)\n");
    printf(" -z Z : define zero (0.0)\n");
    printf(" -e E : error type RAND, BURST, BOTH (RAND)\n");
    printf(" -s S : random generator seed (29)\n");
    printf(" -v V : verbose (0)\n");
    printf(" -S   : script (infile)\n");
    exit(0);
  }

  getflags(argc,argv);
  checkflags();

  if (verbose) showflags();

  if (script)
  {
    if ((inscript = fopen(scriptfname,"rt"))==NULL) 
    {
      printf(">> Unable to open SCRIPT file %s\n",scriptfname);
      exit(0);
    }

    if (fgets(timitfname,255,inscript) == NULL)
    {
      printf(">> Unable to read SCRIPT file %s\n",scriptfname);
      exit(0);
    }

   parse();
  }

  do
  {
    if (script)
    {
      strncpy(temp,"",255);
      strncpy(temp,timitfname,strlen(timitfname)-1);
      strcpy(timitfname,temp);
      exchange();
    }

    if (!strcmp(timitfname,gfefname))
    {
      printf(">> Input and output are the same\n>> %s\n",timitfname);
      exit(0);
    }

    if (verbose) showinfo();

    getopfile();
    modifyop();
    putopfile();
  }
  while (script && fgets(timitfname,255,inscript) != NULL);
  
  if (script) fclose(inscript);

  return(0);
}


void parse()
{
  int i, j;
  char *sptr;

  for (i=0; i<MAXSWAP; i++)
    strncpy(swapstr[i],"",255);

  i = 0;
  j = 0;

  while (change[j] == '^') j++;
  strcpy(swapstr[i],change+j);
  sptr = strtok(swapstr[i],"^");
  
  do
  {
    sptr = strtok(NULL,"^");
    if (sptr != NULL) strcpy(swapstr[++i],sptr);
  }
  while (sptr != NULL && i < MAXSWAP-1);

  lastswap = i;
}


void strrpl(char *str, char *find, char *rpl)
{
  int i, j, num;
  char orgstr[255];

  if (strlen(find) > 0 && strlen(rpl) > 0 && strstr(str,find) != NULL)
  {
    strncpy(orgstr,str,255);

    num = (int)(strstr(str,find) - str);
    strncpy(str,"",255);
    strncpy(str,orgstr,num);
    strcat(str,rpl);

    j = strlen(str);
    for (i=num+strlen(find); i<strlen(orgstr); i++)
      str[j++] = orgstr[i];
  }
}


void exchange()
{
  int i;

  strcpy(gfefname,timitfname);

  for (i=0; i<=lastswap; i+=2)
    strrpl(gfefname,swapstr[i],swapstr[i+1]);
}


void getflags(int argc, char *argv[])
{
  int i;

  for (i=1; i<argc-1; i++)
  {
    if (*argv[i] == '-')
    {
      switch (*++(argv[i]))
      {
        case 'h' : hitrate = atoi(argv[++i]);
                   break;
        case 'f' : falserate = atoi(argv[++i]);
                   break;
        case 'c' : zerorate = atoi(argv[++i]);
                   break;
        case 'o' : one = atof(argv[++i]);
                   break;
        case 'z' : zero = atof(argv[++i]);
                   break;
        case 'e' : strcpy(errname,argv[++i]);
                   break;
        case 's' : ranseed = -atol(argv[++i]);
                   break;
        case 'v' : verbose = atoi(argv[++i]);
                   break;
        case 'S' : script = 1;
                   break;
        default  : printf("Warning : flag -%c ignored\n",*argv[i]);
      }
    }
  }

  if (script)
  {
    strcpy(scriptfname,argv[argc-2]);
    strcpy(change,argv[argc-1]);
  }
  else
  {
    strcpy(timitfname,argv[argc-2]);
    strcpy(gfefname,argv[argc-1]);
  }
}


void checkflags()
{
  int i;

  if (!strcmp(errname,"BOTH")) errtype = BOTH;
  else if (!strcmp(errname,"BURST")) errtype = BURST;
  else if (strlen(errname)) errtype = RAND;

  Nclass = 2;

  i = 0;

  if (strstr(timitfname,"cs5"))
    Nclass = 5;
  else
  while (strcmp(ele3[i],"END"))
    {
      if (strstr(timitfname,ele3[i]))
      {
	Nclass = 3;
	break;
      }

      i++;
    }
}


void showflags()
{
  printf("Hit rate    : %d%%\n",hitrate);
  printf("False rate  : %d%%\n",falserate);
  printf("Zero rate   : %d%%\n",zerorate);
  printf("One         : %.2f\n",one);
  printf("Zero        : %.2f\n",zero);
  printf("Error type  : %s\n",errname);
  printf("Random seed : %d\n",-ranseed);
}


void showinfo()
{
  printf("\nInput file  : %s\n",timitfname);
  printf("Output file : %s\n",gfefname);
  if (script) printf("Script file : %s\n",scriptfname);
  printf("\nClasses     : %d\n",Nclass);
}


void getopfile()
{
  int i, class, frame, group;
  char s[255], label[32];

  if ((intimit = fopen(timitfname,"rt"))==NULL) 
  {
    printf(">> Unable to open OP file %s\n",timitfname);
    exit(0);
  }

  line = 0;

  while (!feof(intimit))
  {
    if (fgets(s,255,intimit) && s[0] != '#')
    {
      sscanf(s,"%d %d %d %s",&class,&frame,&group,&label);

      opinfo[line].class = class;
      opinfo[line].group = group;
      strcpy(opinfo[line].label,label);
      opinfo[line].miss = 0;

      if (class == 0)
	{
	  zerototal++;
	  for (i=0; i<Nclass; i++) opvalue[line][i] = 0.0;
	}
      else
	{
	  hittotal++;

	  for (i=0; i<Nclass; i++)
	    opvalue[line][i] = 0.0;
	  opvalue[line][class-1] = 1.0;
	}

      for (i=0; i<Nclass; i++)
	newop[line][i] = opvalue[line][i];

      line++;

      if (line >= MAXLINE)
	{
	  printf(">> OP file too long (%d)\n",MAXLINE);
	  exit(0);
	}
    }
  }
 
  fclose(intimit);
}


void modifyop()
{
  int i, j, k;
  int count, fcount, zcount;

  ranlong = ranseed;
  ran1(&ranlong);

  count = hittotal*(1.0 - ((float)hitrate/100.0));
  fcount = hittotal*((float)falserate/100.0);
  zcount = zerototal*((float)zerorate/100.0);

  if (verbose)
    {
      printf("Frames      : %d\n",line);
      printf("\nEle total   : %d\n",hittotal);
      printf("Misses      : %d\n",count);
      printf("False alarms: %d\n",fcount);
      printf("CZ total    : %d\n",zerototal);
      printf("CZ firing   : %d\n",zcount);
    }

  while (count)
    {
      i = ran1(&ranlong)*line;

      if (!opinfo[i].miss && opinfo[i].class)
	{
	  opinfo[i].miss = 1;

/*
	  do
	    {
	      k = ran1(&ranlong)*Nclass+1;
	    }
	  while (k == opinfo[i].class);
*/
	  for (j=0; j<Nclass; j++) newop[i][j] = zero;
/*	  newop[i][k-1] = one;*/

	  count--;
	}
    }

  while (fcount)
    {
      i = ran1(&ranlong)*line;

      if (!opinfo[i].miss && opinfo[i].class)
	{
	  opinfo[i].miss = 1;

	  do
	    {
	      k = ran1(&ranlong)*Nclass+1;
	    }
	  while (k == opinfo[i].class);

	  for (j=0; j<Nclass; j++) newop[i][j] = zero;
	  newop[i][k-1] = one;

	  fcount--;
	}
    }

  while (zcount)
    {
      i = ran1(&ranlong)*line;

      if (!opinfo[i].miss && !opinfo[i].class)
	{
	  opinfo[i].miss = 1;

	  k = ran1(&ranlong)*Nclass+1;

	  for (j=0; j<Nclass; j++) newop[i][j] = zero;
	  newop[i][k-1] = one;

	  zcount--;
	}
    }


}


void putopfile()
{
  int i, j;
  char s[255], sv[255];

  if ((outgfe = fopen(gfefname,"wt"))==NULL) 
  {
    printf(">> Unable to create GOP file %s\n",gfefname);
    exit(0);
  }

  for (i=0; i<line; i++)
    {
      strncpy(s,"",255);
      for (j=0; j<Nclass; j++)
	{
	  sprintf(sv,"%.2f  ",newop[i][j]);
	  strcat(s,sv);
	}

      sprintf(sv,"| %d %d %d %s",opinfo[i].class,i+1,opinfo[i].group,opinfo[i].label);
      strcat(s,sv);

      if (opinfo[i].miss) strcat(s," *");

      fprintf(outgfe,"%s\n",s);
    }

  fclose(outgfe);
}


float ran1(long *idum)
{
  int j;
  long k;
  static long iy=0;
  static long iv[NTAB];
  float temp;

  if (*idum <= 0 || !iy) {
    if (-(*idum) < 1) *idum=1;
    else *idum = -(*idum);
    for (j=NTAB+7;j>=0;j--) {
      k=(*idum)/IQ;
      *idum=IA*(*idum-k*IQ)-IR*k;
      if (*idum < 0) *idum += IM;
      if (j < NTAB) iv[j] = *idum;
    }
    iy=iv[0];
  }

  k=(*idum)/IQ;
  *idum=IA*(*idum-k*IQ)-IR*k;
  if (*idum < 0) *idum += IM;
  j=iy/NDIV;
  iy=iv[j];
  iv[j] = *idum;
  if ((temp=AM*iy) > RNMX) return RNMX;
  else return temp;
}

