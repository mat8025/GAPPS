/****************************************************************
* Buildtempl - binary output                                    *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      21.11.96 *
****************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define NUMELE  7
#define MAXLINE 512
#define MAXWORD 16
#define FSIZE   sizeof(float)


struct
{
  char name[32];
  char stem[32];
} wordinfo[MAXWORD];

FILE	*infile, *opfile, *outfile;
char    fname[255], fdefname[255], templfname[255];
int     numframes, numfloats, wordcount, verbose;
float   fdata[MAXLINE*NUMELE];


void    readfiledef(void);
void    readopfile(void);



int main(int argc, char *argv[])
{
  int i;
  float len, num;

  if (argc < 3)
  {
    printf("Usage : fbuildtempl filedef templname {1.11}\n");
    exit(0);
  }

  verbose = 0;

  strcpy(fdefname,argv[1]);
  strcpy(templfname,argv[2]);

  readfiledef();

  if ((outfile = fopen(templfname,"wb"))==NULL) 
  {
    printf(">> Unable to create file %s\n",templfname);
    exit(0);
  }
  
  len = (float)wordcount;
  fwrite(&len,FSIZE,1,outfile);

  for (i=0; i<wordcount; i++)
    {
      strcpy(fname,wordinfo[i].stem);
      strcat(fname,".out");

      readopfile();

      fwrite(wordinfo[i].name,sizeof(char),32,outfile);
      fwrite(&fdata[0],FSIZE,numfloats,outfile);

      if (verbose)
	{
	  printf("File   : %s\n",fname);
	  printf("Word   : %s\n",wordinfo[i].name);
	  printf("Length : %d\n\n",numframes);
	}
    }

  fclose(outfile);

  return(0);
}


void readfiledef()
{
  int i;
  char s[255], name[32], stem[32];

  if ((infile = fopen(fdefname,"rt"))==NULL) 
    {
      printf(">> Unable to open file %s\n",fdefname);
      exit(0);
    }

  i = 0;

  while (!feof(infile))
    {
      if (fgets(s,255,infile) && s[0] != '#')
        {
          sscanf(s,"%s %s",&name[0],&stem[0]);

	  strncpy(wordinfo[i].name,"",32);
	  strncpy(wordinfo[i].name,name,32);

	  strncpy(wordinfo[i].stem,"",32);
	  strncpy(wordinfo[i].stem,stem,32);

	  i++;
	}
    }
	 
  wordcount = i;
}


void readopfile()
{
  if ((opfile = fopen(fname,"rb"))==NULL) 
    {
      printf(">> Unable to open file %s\n",fname);
      exit(0);
    }

  fseek(opfile,0,2);

  numfloats = ftell(opfile) / FSIZE;
  numframes = (ftell(opfile)-4) / (FSIZE*NUMELE);

  if (numframes > MAXLINE)
    {
      printf(">> Warning %s %d truncated to %d\n",fname,numframes,MAXLINE);
      numframes = MAXLINE;
    }

  fseek(opfile,0,0);
  fread(&fdata[0],FSIZE,numfloats,opfile);

  fclose(opfile);
}


