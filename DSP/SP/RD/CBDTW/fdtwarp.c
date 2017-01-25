/******************************************************************************
*                                                                             *
*       Copyright (C) 1993 Tony Robinson				      *
*                                                                             *
*       See the file SLICENSE for conditions on distribution and usage	      *
*                                                                             *
*******************************************************************************
* Modified by Geoff Martindale  gjm@rmsq.com                         21.11.96 *
******************************************************************************/

# include <stdio.h>
# include <sys/types.h>
# include <math.h>
# include <stdlib.h>
# include "Slib.h"


# define NELEM	      7
# define FSIZE        sizeof(float)

typedef struct dist_type_struct {
  float	distance;
  int	index;
  char  name[255];
} dist_type;

FILE    *infile;
char    s[255];
int     len, best, min;
float   fnum;



int main(int argc, char **argv) {
  int  i, nfile, nref, *nframe;
  float ***template;
  dist_type *globdist;

  if (argc < 2)
  {
    printf("Usage : fdtwarp wordfile {1.11}\n");
    exit(0);
  }

  /* nref in the number of reference files, the last one is "unknown" */

  if ((infile = fopen("template","rb"))==NULL) 
    {
      printf(">> Unable to read template\n");
      exit(0);
    }

  fread(&fnum,FSIZE,1,infile);

  nref = (int)fnum;
  nfile = nref+1;

  template = Svector(nfile, sizeof(**template));
  nframe   = SvectorInt(nfile);
  globdist = Svector(nref, sizeof(*globdist));

  for(i = 0; i < nref; i++)
    {
    fread(&s[0],sizeof(char),32,infile);
    strcpy(globdist[i].name,s);

    fread(&fnum,FSIZE,1,infile);
    nframe[i] = (int)fnum;

    len = (int)fnum;

    template[i] = (float**) Smatrix(nframe[i], NELEM, sizeof(***template));

    fread(&template[i][0][0],FSIZE,len*NELEM,infile);
    }

  fclose(infile);


  if ((infile = fopen(argv[1],"rb"))==NULL) 
    {
      printf(">> Unable to open file %s\n",argv[1]);
      exit(0);
    }

  for(i = nref; i < nfile; i++)
    {
    fread(&fnum,FSIZE,1,infile);
    nframe[i] = (int)fnum;

    len = (int)fnum;

    template[i] = (float**) Smatrix(nframe[i], NELEM, sizeof(***template));

    fread(&template[i][0][0],FSIZE,len*NELEM,infile);
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
