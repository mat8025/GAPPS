/*//////////////////////////////////<**|**>///////////////////////////////////
//                           glide.cpp 
//		          
//    @comment  user 
//    @release   Beryllium  
//    @vers 1.15 P Phosphorus 6.4.48 C-Be-Cd 
//    @date 07/23/2022 10:36:56    
//    @cdate 07/23/2022        
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2022 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

                                  


#include  <stdio.h>
#include  <fcntl.h>
#include  <math.h>
#include <iostream>
#include "defs.h"
#include "types.h"
#include "si.h"
#include "glide.h"


extern int Cglid;
extern int Cwoid;
extern int Cwid;


int Nuac =0;

// these routines may be obsolete/unused
// can be replaced by asl script that will be compiled

__BEGIN_DECLS
//int u1 (Svarg * s);
//int write_da4 (Svarg * s);
//int read_da4 (Svarg * s);
//int flightphase (Svarg * s);
//char **uac_init (int *cnt);
__END_DECLS




// to avoid C++ name mangling



  // convert data files for GPS  
  /* structure for TP: 31 bytes */
struct s_tpt
{

  char prg;			/* 1 byte  0 if APT is not programmed  1 if APT is programmed */
  char name[9];			/* 9 bytes: TP name */

  /* 8 characters and 00hex at the end */

  float latitude;		/* 4 bytes: latitude in degrees, north is positive */

  float longitude;		/* 4 bytes: longitude in degrees, east is positive */

  short int altitude;		/* 2 bytes: altitude in ft */

  float f;			/* 4 byte :radio f in MHz (0.0 - unknown) */

  short int rw;			/* 2 bytes: runway length in ft(not used) */

  char rwdir;			/* 1 byte: runway direction */

  /* 0..18 (0 - unknown) */

  char rwtype;			/* 1 byte: runway type */

  /* G - gras */

  /* C - concrete */

  char tcdir;			/* 1 byte: training circle */

  /* N - north */

  /* E - east */

  /* S - south */

  /* W - west */

  /* B - both */

  /* I - unknown */
  /* 2 bytes: training circle in ft (0 - unknown) */
  /*   short int tc; */

  char tc[2];

};
//[EF]===========================================//
struct s_tp
{

  char prg;			/* 1 byte  0 if APT is not programmed  1 if APT is programmed */
  char name[9];			/* 9 bytes: TP name */
  char latitude[4];		/* 4 bytes: latitude in degrees, north is positive */
  char longitude[4];		/* 4 bytes: longitude in degrees, east is positive */
  char altitude[2];		/* 2 bytes: altitude in ft */

  char f[4];			/* 4 byte :radio f in MHz (0.0 - unknown) */

  char rw[2];			/* 2 bytes: runway length in ft(not used) */

  char rwdir;			/* 1 byte: runway direction */

  /* 0..18 (0 - unknown) */

  char rwtype;			/* 1 byte: runway type */

  /* G - gras */

  /* C - concrete */

  char tcdir;			/* 1 byte: training circle */

  /* N - north */

  /* E - east */

  /* S - south */

  /* W - west */

  /* B - both */

  /* I - unknown */
  /* 2 bytes: training circle in ft (0 - unknown) */
  char tc[2];
};


  /* structure for TSK: 32 bytes */
struct s_tsk
{

  char prg;			/* 1 byte */
  /* 0 if TSK is not programmed */
  /* 1 if TSK is programmed */

  char ctrlpnt;			/* 1 byte: control point number(0 - no control point) */

  char pnttype[10];		/* 10 byte */

  /* 0 if point index is not programmed */

  /* 1 if point index is programmed */

  /*   unsigned pntind[10]; */
  /* 20 bytes: point index */
  //    unsigned short  pntind[10]; 
  short pntind[10];
};
//[EF]===========================================//
 /* total size 25500 bytes */
struct s_file_da4
{
  struct s_tp tp[600];		/* 600 TP points: 18600 bytes */
  struct s_tsk tsk[100];	/* 100 TSK: 3200 bytes */
  char tsk_name[100][37];	/* 100 TSK descriptions(just for remark): 3700 bytes */
} file_da4;
//[EF]===========================================//

extern "C" int
read_da4 (Svarg * s)
      // da4 type file and print it to stdout
{
  char name[MAXFILENAME];
  struct s_file_da4 *da4;
  struct s_tp *tpt;
  struct s_tsk *tskpt;

  FILE *fpt;
  int i, nbr, len, j, k;
  char tp_name[10];
  float lat;
  float longi;
  float frq;
  char altc[2];
  char altcs[2];
  short alt;
  short rwlen;
  short *altp;
  char fixtype[128];
  short ph;
  char *cp;
  char *tcp;
  short buf[4];

  if (!s->ArgCount (1))
    return 0;

  if (!checkscpy (name, s->getArgStr (), MAXFILENAME))
    return 0;


  da4 = (struct s_file_da4 *) calloc (1, sizeof (s_file_da4));
  /*    printf("da4 size %d tp size %d tsk size %d\n",sizeof(struct s_file_da4),sizeof(struct s_tp), sizeof (struct s_tsk)); */
  fpt = fopen (name, "rb");
  if (fpt != NULL)
    {
      nbr = fread (da4, sizeof (struct s_file_da4), 1, fpt);
      /*        printf("%d size %d\n",nbr,sizeof(struct s_file_da4)); */
      tpt = &da4->tp[0];

      for (i = 0; i < 600; i++)
	{
	  strncpy (tp_name, tpt->name, 8);
	  len = strlen (tp_name);
	  if (len < 8)
	    for (j = len; j < 9; j++)
	      tp_name[j] = ' ';

	  tp_name[8] = '\0';

	  strncpy ((char *) &altc, tpt->altitude, 2);

	  altcs[0] = altc[1];
	  altcs[1] = altc[0];
	  strncpy ((char *) &alt, altcs, 2);
	  /*        printf("%d %d %d %d \n",tpt->latitude[0],tpt->latitude[1],tpt->latitude[2],tpt->latitude[3]); */

	  cp = (char *) &lat;
	  tcp = (char *) tpt->latitude;
	  for (k = 0; k < 4; k++)
	    *cp++ = *tcp++;


	  /*     printf("%d %d %d %d \n",tpt->longitude[0],tpt->longitude[1],tpt->longitude[2],tpt->longitude[3]); */

	  cp = (char *) &longi;
	  tcp = (char *) tpt->longitude;
	  for (k = 0; k < 4; k++)
	    *cp++ = *tcp++;

	  cp = (char *) &frq;
	  tcp = (char *) tpt->f;
	  for (k = 0; k < 4; k++)
	    *cp++ = *tcp++;

	  cp = (char *) &rwlen;
	  tcp = (char *) tpt->rw;
	  for (k = 0; k < 2; k++)
	    *cp++ = *tcp++;

	  cp = (char *) &ph;
	  tcp = (char *) tpt->tc;
	  for (k = 0; k < 2; k++)
	    *cp++ = *tcp++;

	  printf ("%s %f %f %d %f %d %d %c %c %d\n", tp_name, lat, longi, alt,
		  frq, rwlen, tpt->rwdir, tpt->rwtype, tpt->tcdir, ph);

	  tpt++;
	}

      tskpt = &da4->tsk[0];

      for (i = 0; i < 100; i++)
	{
	  printf ("%d     %d \n", tskpt->prg, tskpt->ctrlpnt);
	  if (tskpt->prg == 1)
	    {
	      printf ("%s      \n", &da4->tsk_name[i]);

	      for (k = 0; k < 10; k++)
		{

		  sswab (&tskpt->pntind[k], &buf[0], 1);

		  printf ("%d %d\n", tskpt->pnttype[k], buf[0]);
		}
	    }
	  else
	    break;
	  tskpt++;
	}

      fclose (fpt);
      free (da4);
    }
  store_int (s->result, 1);
}
//[EF]===========================================//


extern "C" int
write_da4 (Svarg * s)
{
  char tpname[MAXFILENAME];
  char taskname[MAXFILENAME];
  char da4name[MAXFILENAME];
  struct s_file_da4 *da4;
  struct s_tp *tpt;
  struct s_tsk *tskpt;
  FILE *fpt, *da4fpt, *taskfpt;
  int i, nbr, j, k;
  char tp_name[32];
  float lat;
  float lngi;
  float frq;
  short rwd;
  char altc[4];
  char altcs[4];
  short alt;
  short rwlen;
  short *altp;
  char fixtype[128];
  short ph;
  char line[1024];
  char *cp;
  char *tcp;
  char slat[32];
  char slong[32];
  char salt[32];
  char sfrq[32];
  char srwd[32];
  int dotask = 0;
  short buf[2];


  if (!s->ArgCount (2))
    return 0;

  if (!checkscpy (tpname, s->getArgStr (), MAXFILENAME))
    return 0;
  if (!checkscpy (da4name, s->getArgStr (), MAXFILENAME))
    return 0;

  if (s->AnotherArg ())
    {
      if (!checkscpy (taskname, s->getArgStr (), MAXFILENAME))
	return 0;
      dotask = 1;
      taskfpt = fopen (taskname, "rb");
    }
  da4 = (struct s_file_da4 *) calloc (1, sizeof (s_file_da4));

  fpt = fopen (tpname, "rb");
  da4fpt = fopen (da4name, "wb");

  tpt = &da4->tp[0];
  tskpt = &da4->tsk[0];

  for (j = 0; j < 600; j++)
    {
      cp = (char *) tpt;

      for (i = 0; i < 31; i++)
	*cp++ = '\0';
      tpt++;
    }


  tpt = &da4->tp[0];

  if (fpt != NULL)
    {
      /* read in txt file */
      int ntpt = 0;
      while (1)
	{

	  if (fgets (line, 1024, fpt) == NULL)
	    break;
	  /*              printf("%s\n",line); */
	  /*        sscanf(line,"%s %f %f %d %f",tp_name,&lat,&lngi,&alt,&frq); */

	  sscanf (line, "%s %s %s %s %s %s", tp_name, slat, slong, salt, srwd,
		  sfrq);

	  /*      printf("%s %s %s %s %s \n",tp_name,slat,slong,salt,sfrq);  */

	  lat = (float) atof (slat);
	  rwd = atoi (srwd);
	  lngi = (float) atof (slong);
	  alt = (short) atof (salt);
	  frq = (float) atof (sfrq);
	  sprintf (sfrq, "%3.3f", frq);
	  frq = (float) atof (sfrq);

	  /*        printf("%s %f %f %d %f \n",tp_name,lat,lngi,alt,frq); */
	  /* shove in struct */
	  for (i = 0; i < 8; i++)
	    tpt->name[i] = ' ';
	  strncpy (tpt->name, tp_name, 8);

	  tpt->prg = 1;
	  tpt->name[8] = '\0';
	  tpt->rw[0] = '\0';
	  tpt->rwtype = 'G';
	  tpt->tcdir = 'I';
	  tpt->rwdir = (char) rwd;
	  tpt->tc[0] = 0;
	  tpt->tc[1] = 0;

	  cp = (char *) &lat;
	  tcp = (char *) tpt->latitude;

	  for (k = 0; k < 4; k++)
	    *tcp++ = *cp++;

	  /*      strncpy( tpt->latitude,(char *) &lat,4); */

	  cp = (char *) &lngi;
	  tcp = (char *) tpt->longitude;

	  for (k = 0; k < 4; k++)
	    *tcp++ = *cp++;

	  /*     strncpy( tpt->longitude,(char *) &lngi,4);  */

	  cp = (char *) &frq;
	  tcp = (char *) tpt->f;

	  for (k = 0; k < 4; k++)
	    *tcp++ = *cp++;

	  strncpy ((char *) &altc, (char *) &alt, 2);

	  altcs[0] = altc[1];
	  altcs[1] = altc[0];
	  strncpy (tpt->altitude, altcs, 2);
	  //        dbprintf(0,"tpt %d %s\n",ntpt,tpt->name);
	  tpt++;
	  ntpt++;
	  if (ntpt >= 600)
	    break;

	}

      if (dotask)
	{
	  int tski = 0;
	  int tpind;
	  char tsk_name[120];
	  while (1)
	    {

	      if (fgets (line, 1024, taskfpt) == NULL)
		break;
	      sscanf (line, "%s %s", tp_name, tsk_name);
	      //        dbprintf(0,"task %s %d\n",tp_name,tski);
	      if (strncmp (tp_name, "#", 1) == 0)
		{
		  dbprintf (0, "task %d\n", tski);
		  tskpt->prg = 1;
		  int legi = 0;

		  while (1)
		    {

		      if (fgets (line, 1024, taskfpt) == NULL)
			break;
		      sscanf (line, "%s", tp_name);
		      if (strncmp (tp_name, "#", 1) == 0)
			{
			  strncpy (da4->tsk_name[tski], tsk_name, 36);
			  break;
			}
		      sscanf (line, "%s %s %s %s %s %s %s %s %s %s %d",
			      tp_name, slat, slong, salt, srwd, sfrq, sfrq,
			      sfrq, sfrq, sfrq, &tpind);
		      tskpt->pnttype[legi] = 1;
		      dbp ( "leg %d tpnum %d tski %d\n", legi, tpind,
				tski);

		      buf[0] = tpind + 1;	// colibri counts from 1 - I count from 0

		      sswab (&buf[0], &tskpt->pntind[legi], 1);

		      legi++;
		      if (legi >= 10)
			break;

		    }

		}
	      tskpt++;
	      tski++;
	      if (tski >= 100)
		break;
	    }
	  fclose (taskfpt);
	}

      fclose (fpt);
      nbr = fwrite (da4, sizeof (struct s_file_da4), 1, da4fpt);
      fclose (da4fpt);
    }
  store_int (s->result, 1);
}
//[EF]===========================================//

