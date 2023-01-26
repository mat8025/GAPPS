/****************************************************************
* Mergenet - binary net output                                  *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      25.11.96 *
****************************************************************/


#include <gasp-conf.h>

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define NUMELE  7
#define MAXLINE 512
#define FSIZE   sizeof(float)

char    *elelist[] = {"ecH","ecI1","evA1","evI1","evU1","fric","voice"};

FILE	*opfile, *outfile;
char    stem[255], fname[255], outfname[255];
int     numframes, verbose;
float   fdata[MAXLINE*NUMELE];


void    readopfile(int col);
void    smooth(int col);
void    writeoutfile(void);



int main(int argc, char *argv[])
{
  int i;

  if (argc < 2)
  {
    printf("Usage : fmergenet wordstem {1.15}\n");
    exit(0);
  }

  verbose = 0;

  for (i=0; i<MAXLINE*NUMELE; i++)
    fdata[i] = 0.0;

  strcpy(stem,argv[1]);
  strcpy(outfname,argv[1]);
  strcat(outfname,".out");

  for (i=0; i<NUMELE; i++)
    {
      strcpy(fname,stem);
      strcat(fname,".");
      strcat(fname,elelist[i]);

      readopfile(i);
      smooth(i);

      if (verbose)
        {
          printf("File   : %s\n",fname);
          printf("Length : %d\n\n",numframes);
	}
    }

  writeoutfile();

  return(0);
}


void readopfile(int col)
{
  if ((opfile = fopen(fname,"rb"))==NULL) 
    {
      printf(">> Unable to open file %s\n",fname);
      exit(0);
    }

  fseek(opfile,0,2);
  numframes = ftell(opfile) / FSIZE;

  if (numframes > MAXLINE)
    {
      printf("Warning : %s %d truncated to %d\n",fname,numframes,MAXLINE);
      numframes = MAXLINE;
    }

  if (col == 0) fdata[0] = (float)numframes;

  fseek(opfile,0,0);
  fread(&fdata[MAXLINE*col+1],FSIZE,numframes,opfile);

  fclose(opfile);
}


void smooth(int col)
{
  int i, j, k;
  int N, left, right;
  float sum, new;
  float newdata[MAXLINE];

  N = 2;
  left = -N;
  right = N;

/*  printf("%s\n",elelist[col]);*/

  for (i=0; i<numframes; i++)
    {
      sum = 0.0;
      k = MAXLINE*col+i+1;

      if (col == 3) fdata[k] = 0.0;

      if (i < N) left = -i;
      else if (numframes-i <= N) right = numframes-i-1;
      else
	{
	  left = -N;
	  right = N;
	}

      for (j=left; j<=right; j++)
	sum += fdata[k+j];

      new = sum/(float)(2*N+1) + 0.5;

/*      printf("%f -- %f %f\n",fdata[k],floor(new),sum);*/

      newdata[i+1] = new;
    }

  for (i=0; i<numframes; i++)
    fdata[MAXLINE*col+i+1] = newdata[i+1];
}


void writeoutfile()
{
  int i, j;
  float len;

  if ((outfile = fopen(outfname,"wb"))==NULL) 
  {
    printf(">> Unable to create file %s\n",outfname);
    exit(0);
  }

  len = fdata[0];

  fwrite(&len,FSIZE,1,outfile);

  for (j=0; j<(int)len; j++)
    for (i=0; i<NUMELE; i++)
      fwrite(&fdata[MAXLINE*i+j+1],FSIZE,1,outfile);
    
  if (verbose)
    {
      for (j=0; j<(int)len; j++)
	{
	  for (i=0; i<NUMELE; i++)
	    printf("%.1f  ",fdata[MAXLINE*i+j+1]);
	}
      printf("\n");
    }

  fclose(outfile);
}

