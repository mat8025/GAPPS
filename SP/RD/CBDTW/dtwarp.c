/******************************************************************************
*                                                                             *
*       Copyright (C) 1993 Tony Robinson				      *
*                                                                             *
*       See the file SLICENSE for conditions on distribution and usage	      *
*                                                                             *
*******************************************************************************
* Modified by Geoff Martindale  gjm@rmsq.com                         12.11.96 *
******************************************************************************/

# include <stdio.h>
# include <sys/types.h>
# include <math.h>
# include <stdlib.h>
# include "Slib.h"


# define NELEM	      9


typedef struct dist_type_struct {
  float	distance;
  int	index;
  char  name[255];
} dist_type;

FILE    *infile;
char    s[255], sym;
int     len, best, min;


int main(int argc, char **argv) {
  int  i, nfile, nref, *nframe;
  float ***template;
  dist_type *globdist;

  if (argc < 2)
  {
    printf("Usage : dtwarp wordfile {1.11}\n");
    exit(0);
  }

  /* nref in the number of reference files, the last one is "unknown" */

  nfile = 13;
  nref = nfile - 1;

  template = Svector(nfile, sizeof(**template));
  nframe   = SvectorInt(nfile);
  globdist = Svector(nref, sizeof(*globdist));

  if ((infile = fopen("template","rt"))==NULL) 
    {
      printf(">> Unable to read template\n");
      exit(0);
    }

  for(i = 0; i < nref; i++) {
    int   j;

    fscanf(infile,"%s",&s[0]);
    strcpy(globdist[i].name,s);

    fscanf(infile,"%s %d",&s[0],&len);
    nframe[i] = len;

    template[i] = (float**) Smatrix(nframe[i], NELEM, sizeof(***template));

    for(j = 0; j < len; j++) {
      int k;

      fscanf(infile,"%s",&s[0]);
      fscanf(infile,"%s",&s[0]);
      fscanf(infile,"%s",&s[0]);

      for(k = 0; k < NELEM; k++)
      {
        fscanf(infile,"%s",&s[0]);
	template[i][j][k] = (float)atoi(s);
      }
    }
  }

  fclose(infile);


  if ((infile = fopen(argv[1],"rt"))==NULL) 
    {
      printf(">> Unable to open file %s\n",argv[1]);
      exit(0);
    }

  for(i = nref; i < nfile; i++) {
    int   j;

    fgets(s,255,infile);
    sscanf(s,"%d",&len);

    nframe[i] = len;

    template[i] = (float**) Smatrix(nframe[i], NELEM, sizeof(***template));

    for(j = 0; j < len; j++) {
      int k;

      fscanf(infile,"%s",&s[0]);
      fscanf(infile,"%s",&s[0]);
      fscanf(infile,"%s",&s[0]);

      for(k = 0; k < NELEM; k++)
      {
        fscanf(infile,"%s",&s[0]);
	template[i][j][k] = (float)atoi(s);
      }
    }
  }

  fclose(infile);

  /* Match the i'th reference against the unknown using DTW */

   for(i = 0; i < nref; i++) {
    globdist[i].distance = Sdtw(template[nref], nframe[nref], template[i],
				nframe[i], NELEM);

    if (globdist[i].distance > 10000) globdist[i].distance = 10000.0;
				
    globdist[i].index = i;
  }

  min = 10000;
  
  for(i = 0; i < nref; i++)
  {
    printf("%s\t%d\n",globdist[i].name,(int)globdist[i].distance);
    if (globdist[i].distance < min)
      {
    	min = globdist[i].distance;
    	best = i;
      }
  }

  printf("\n%s\n",globdist[best].name);
 
  for(i = 0; i < nfile; i++) Sfree(template[i]);
  Sfree(template);
  
  return(0);
}
