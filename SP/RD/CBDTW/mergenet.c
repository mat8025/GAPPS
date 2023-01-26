/****************************************************************
* Mergenet Program                                              *
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

FILE	*opfile, *outfile;
int     Nclass, col, maxline;
char    stem[255], fname[255], outfname[255];
char    data[1024*MAXELE][1];


void    readopfile(void);
void    writeoutfile(void);



int main(int argc, char *argv[])
{
  int i;

  if (argc < 2)
  {
    printf("Usage : mergenet wordstem {1.12}\n");
    exit(0);
  }

  for (i=0; i<1024*MAXELE; i++)
    data[i][0] = 'x';

  strcpy(stem,argv[1]);
  strcpy(outfname,argv[1]);
  strcat(outfname,".out");

  for (i=0; i<MAXELE; i++)
    {
      if (i == 0) Nclass = 3;
      else Nclass = 2;

      col = i;

      strcpy(fname,stem);
      strcat(fname,".");
      strcat(fname,elelist[i]);
      strcat(fname,".op");

      readopfile();

      fclose(opfile);
    }

  writeoutfile();

  return(0);
}


void readopfile()
{
  int i, line;
  float netop[3];
  char s[255], sym;

  if ((opfile = fopen(fname,"rt"))==NULL) 
    {
      printf(">> Unable to open file %s\n",fname);
      exit(0);
    }

  line = 0;

  while (!feof(opfile))
    {
      if (fgets(s,255,opfile) && s[0] != '#')
	{
	  sscanf(s,"%f %f %f",&netop[0],&netop[1],&netop[2]);

	  if (Nclass == 3)
	    {
	      if (netop[0] == 1.0) sym = 'S';
	      else if (netop[1] == 1.0) sym = 'V';
	      else if (netop[2] == 1.0) sym = 'C';
	      else sym = 'x';
	    }
	  else
	    {
	      if (netop[0] == 1.0) sym = '1';
	      else if (netop[1] == 1.0) sym = '0';
	      else sym = 'x';
	    }

	  data[10*line+col][0] = sym;

	  line++;
	  if (line > maxline) maxline = line;
	}
    }
}


void writeoutfile()
{
  int i, j;

  if ((outfile = fopen(outfname,"wt"))==NULL) 
  {
    printf(">> Unable to create file %s\n",outfname);
    exit(0);
  }

  fprintf(outfile,"%d\t\tcs3  ecH  ecG  ecN  ecA  ecI  ecU  evA  evI  evU\n",maxline);

  for (j=0; j<maxline; j++)
  {
    fprintf(outfile,"Frame %d \t",j);

    for (i=0; i<10; i++)
      fprintf(outfile,"%3c  ",data[10*j+i][0]);

    fprintf(outfile,"\n");
  }

  fclose(outfile);
}

