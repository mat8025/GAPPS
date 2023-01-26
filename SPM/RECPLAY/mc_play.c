static char     rcsid[] = "$Id: mc_play.c,v 1.1 2000/01/30 18:01:36 mark Exp mark $";
#include <gasp-conf.h>

#include <stdio.h>
#include <mr.h>
#include <fcntl.h>
#include <setjmp.h>
#include "df.h"
#include "sp.h"

#define BUFF_SIZE  8192

#define BLOCK_SIZE 512

#define NUM_BUFFS  50

#define OFLAG (O_RDONLY)	/* set flag for read-only */

/*  last rev date Jan 30 1994 M.T. */

int scale =0;
float S_factor = 1.0;
int debug = 0;
char  Device[40], Clock[40];
int   Dapn = -1, Adpn = -1, Clkp = -1;
int   Eflag, Fd, Cvsync, Fchan, Nchans, Incr, Gainad;
float    Freq = 16000.0;
int errno;
channel i_chn[2];
channel df, o_df;
int N_bufs;
int header = 1;   
main (argc, argv)
char *argv[];
{				

   char  def_file[64], dadev_name[32], daclk_name[32];
   int   error, fsize, rem;
   int fposn;
   int   in_len;		/* num of points actually sampled */
   int   fpos, head_size, wrcnt, rdcnt, i;
   int head_stat =0;
   float    start = 0.0;
   float    play_time = 0.0;	/* length in secs of speech segment */
   int job_nu = 0;   
   char start_date[40];
   int ipc =0;
   int overide_freq = 0;
   int set_play_time = 0;
   float max_dur;   
/* parse command line variables */

   Fchan = 0;
   Nchans = 1;
   strcpy (dadev_name, "");
   strcpy (daclk_name, "");

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");

   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {
	       case 's': 
		  sscanf (argv[++i], "%f", &start);

		  break;
	       case 'e': 
		set_play_time = 1;
	sscanf (argv[++i], "%f", &play_time);
		  break;
	       case 'f': 

        sscanf (argv[++i], "%f", &Freq);
		  overide_freq = 1;
		  break;
		  
	       case 'A': 

        sscanf (argv[++i], "%f", &S_factor);
		  scale = 1;
		  break;		 
       case 'a': 
		  strcpy (dadev_name, argv[++i]);
		  break;
       case 'k': 
		  strcpy (daclk_name, argv[++i]);
		  break;
       case 'i': 
		  strcpy (def_file, argv[++i]);
		  break;
       case 'b': 
		  sscanf (argv[++i], "%d", &Fchan);
		  break;
       case 'c': 
		  sscanf (argv[++i], "%d", &Nchans);
		  break;
      
       case 'N' :
       		header = 0;
	        break;

       case 'S': 
       /* use files as signals between recording process and 
	  application process */
		   ipc = 1;	            
		   break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]);
		  break;
	       default: 

		  break;
	    }
	    break;
	 default: 
	    break;
      }
   }


   if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

/* check to see if device and clock available;


   default = daf0 and clk0 */
   if (!strcmp (dadev_name, ""))
      strcpy (dadev_name, "daf0");
   if (!strcmp (daclk_name, ""))
      strcpy (daclk_name, "clk0");

   strcpy (Device, "/dev/dacp0/");
   strcpy (Clock, "/dev/dacp0/");
   strcat (Device, dadev_name);
   strcat (Clock, daclk_name);

dbprintf(0,"Device %s CLock %s \n",Device,Clock);

   error = gs_openda_chk ();

   if (error == -1) {
   	dbprintf(0,"device error\n");	
      return (-1);
    }

   Eflag = 0;

   if (!strncmp (daclk_name, "ef", 2))
      Eflag = 1;

/* check for file specs; 
if no headers use command string info 
   for Freq and Nchans */

   
   if ((fsize = df_stat (def_file,0)) <= 0) 
      return (-1);

    head_stat = 0;
    head_size = 0;

 if ( header) {

   if ( (fposn = read_sf_head(def_file,&df,&i_chn[0]) ) == -1) {
 	dbprintf(1,"can't read header\n");
        exit(-1);   
   } else
    head_stat = 1;
}


    if ( head_stat) {
    Nchans = (int) df.f[N];
    max_dur = df.f[STP] - df.f[STR];
    if ( ! set_play_time )
    play_time = max_dur;
    
    dbprintf(1," nc %d %f %d\n",Nchans,max_dur,fposn);
    head_size = fposn;
    }
    
    if ( ! overide_freq && header )
    Freq = i_chn[0].f[SF];

    dbprintf(1,"freq %f\n", Freq);
    
   if ((Fd = open (def_file, OFLAG)) < 0) {
      dbprintf (0, "Can't open file %s\n", def_file);
      return (-1);
   }
   
/* Set up parameters for channel sampling */

   if (!strcmp (dadev_name, "daf0")) {
      if (Fchan < 0 || Fchan > 3) {
	 dbprintf (0,"mc_play: starting channel out of range\n");
	 return (-1);
      }

      if (Nchans <= 0 || (Fchan + Nchans - 1) > 3) {
	 dbprintf (0,"mc_play: # of channels out of range\n");
	 return (-1);
      }
    
 if (Freq > 500000.0 || (Freq * (float) Nchans) > 1.0e7) {
 dbprintf (0,"mc_play: sampling frequency too high for # of channels\n");
	 return (-1);
      }
   }


   Cvsync = 0; /* skewed conversions when more than 1 channel
				   */
   Incr = 1;  /* Channel address increment */

   if (play_time <= 0) {
   	play_time = ( fsize / 2 ) / Freq ;
   }
   
   if (start >= play_time) {
      dbprintf (0, "START TIME > STOP TIME\n");
      return (-1);
   }

   head_size = ((int) (start * Freq)) * 2;

   if (head_stat)
      head_size += fposn;

   play_time -= start;		/* subtract offset */


   in_len = (int) (play_time * Freq);/* num of points resulting */

   dbprintf(1,"play_time %f %d\n",play_time,in_len);

   in_len *= Nchans;		

   N_bufs = (in_len) /  (BUFF_SIZE/ 2) + 1 ;

   in_len = N_bufs * (BUFF_SIZE / 2)  ;
   
   play_time = in_len / Freq;

   dbprintf(1,"play_time %f %d\n",play_time,in_len);

   fpos = lseek (Fd, head_size, 0);
   /* move file pointer to start posn when using
   queued buffers. */

   play_time *= 1000.0;		/* convert to msecs */

   if (!Eflag)
   Freq *= Nchans;	 
   else {
   if ( Nchans > 2)
   Nchans = 2;
  
   }

   /* multiply sample freq by num channels to *
	   allow for sequential conversion */

   
   playbk (in_len,  (int) play_time);
    

   close (Fd);

   if (job_nu) {
	dbprintf(0,"%s \n",o_df.source);
	job_done(job_nu,start_date,o_df.source);
   }


}  


gs_openda_chk () {
   int   daopen;

   daopen = open (Device, O_RDONLY);
   if (daopen == -1) {
      dbprintf (0,"MC_PLAY:D/A device %s does not exist on system\n", Device);
      return (-1);
   }
   close (daopen);

   daopen = open (Clock, O_RDONLY);
   if (daopen == -1) {
      dbprintf (0,"MC_PLAY:Clock device %s does not exist on system\n", Clock);
      return (-1);
   }
   close (daopen);

   return (1);
}


/* number of elements in a total buffer */

/* number of elements in a total buffer */
#define MAXBUFSIZE (BUFF_SIZE*NUM_BUFFS)/2 

#define IOMODE 0		/* access mode for task */


union buf_tp {
   int   ibuf;
   short    sbuf[MAXBUFSIZE];
} bbuf;


short   *bf;
int   bcr (),  dummy ();
	
int   onintr (), quit ();
int   tmp, Dacqfail;
long int first, last;
static   jmp_buf jmpbuf;



int  playbk (num_items, r_time)
int   num_items;
int   r_time;
{
   double   pwidth, rfreq, rwidth;
   int   i, exstat, rdcnt;
   float    numin ();
   int stop_status;
   int n;
   short *bfp;
   
   if (Eflag)
   Cvsync = 1;
   
   /* find sections of data memory and subroutines to be locked */

   Dacqfail = 0;

   seterropt (ERROR, WARNING, 0, 3, 0);
   seterrtrap (onintr, FATAL);

   mrlock(0,0,&tmp);

   tmp = nice (-10); 

   r_time += 100;		/* add 100msecs to wait time */

   if (N_bufs < NUM_BUFFS)
   n = N_bufs * BUFF_SIZE;
   else
   n= NUM_BUFFS * BUFF_SIZE;   
   
   rdcnt = read (Fd, bbuf.sbuf, n);

   if (rdcnt < 0) {
      dbprintf (0,"MC_PLAY can't read !\n");
      exit (-1);
   }
   
  /* sample channels for ef12 stereo limit */
  
   
  
   bfp = &bbuf.sbuf[0];
  	
   
   if (scale ) {
   	
	n = n / 2;
	
	for ( i = 0; i < n ; i++ ) {
	*bfp = (short) ( *bfp * S_factor);		
	bfp++;

        }
   }

   
  
   mropen (&Dapn, Device, IOMODE);

   mropen (&Clkp, Clock, IOMODE);

   if (!Eflag) 
    mrdamod (Dapn, 0, 0);

   	
   mrclk1 (Clkp, 0, Freq, &rfreq, 4, pwidth, &rwidth, 0);
      
   mrbufall (Dapn, bbuf.sbuf, NUM_BUFFS, BUFF_SIZE);

   mrdainc (Dapn, Fchan, Nchans, Incr, Cvsync);

   mrclktrig (Dapn, 1, Clkp);

   mrxoutq (Dapn, BUFF_SIZE / 2, num_items, bcr);

   /* offset for header */

   mrevwt (Dapn, NULL, r_time);	
   dbprintf(1," r_time %d\n",r_time);
   fflush(stdout);   
   /* stop after a second if 0 replaced with
   1000, or after sampling time if replace
   with	r_time */

   tmp = nice (10); 

   dbprintf (1,"\nnum_items = %d\n", num_items);;
   dbprintf(1,"\nrfreq %g rwidth %g",rfreq,rwidth); 
   
   mrstop(Dapn,0,&stop_status);
   
   mrclosall ();
   return ( 1 );
   
}				


int   bcr (rpathno)
int  *rpathno;
{
   int   rdcnt, indx, aps, bsize;
   static int  buf_cnt = 0;
   short *bfp;
   int i, k ,n;
   
   if (*rpathno != Dapn) {
      dbprintf (0," bad path\n");
      exit (-1);
   }

   mrbufget (*rpathno, 0, &bf);

   bfp = bf;
   
   if ((rdcnt = read (Fd, bf, BUFF_SIZE)) < 0) {
      dbprintf (0,"MC_PLAY read error !! \n");
      exit (-1);
   }

/* scale option */
   
  
   if (scale) {

	n = BUFF_SIZE / 2;
	
	for ( i = 0; i < n ; i++ ) {
	*bfp = (short) ( *bfp * S_factor);		
	bfp++;

        }
  
   }


   mrbufrel (*rpathno, bf);
   buf_cnt++;
}


static int  onintr () {
   exit (-1);
}


dummy () {
   return;
}


/* USAGE & HELP */

sho_use() 
{
   	
  printf ("Usage: mc_play  -i <signal file>\n");
      fprintf(stderr,"-s start time secs [0] \n");      
      fprintf(stderr,"-e stop time secs [EOF] \n");            
      fprintf(stderr,"-c number of channels [1]\n");
      fprintf(stderr,"-b start channel [0] \n");                  
      fprintf(stderr,"-f sampling frequency [16000] \n");      
      fprintf(stderr,"-a da_dev [ daf0 ] \n");            
      fprintf(stderr,"-k clk_dev [ clk0 ] \n");              
      fprintf(stderr,"-N no header use flags or defaults\n");                    
      fprintf(stderr,"-A amplification factor \n");                    
      exit(-1);
   }

