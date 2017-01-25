#include <gasp-conf.h>

#include <stdio.h>
#include <mr.h>
#include <fcntl.h>
#include <setjmp.h>
#include "df.h"
#include "sp.h"

#define BUFF_SIZE  1024

#define BLOCK_SIZE 512

#define NUM_BUFFS  256

#define OFLAG (O_RDWR | O_CREAT) /* set flag for read/write */

#define FMODE  0660		/* access mode, ie read/write everyone */


char  Device[40], Clock[40];
int   Dapn = -1, Adpn = -1, Clkp = -1;
int   Fd, Eflag, Cvsync, STAT[6], Fchan, Nchans, Incr;

int Gainad = 0;

float    Freq;

data_file df;

channel o_vox;

int out_vox_fd;
int N_bufs;
int loop = 0;
int debug = 0;
float loop_time;
int  buf_cnt = 0;
int ipc =0;

main (argc, argv)
int   argc;
char *argv[];
{
   char  def_file[64], addev_name[32], adclk_name[32];
   int   fsize, rem, error;
   int   in_len;		/* num of points actually sampled */
   int   head_size, rdcnt, wrcnt, i, tmp;
   int   new_totgs_points, file_present;
   float    rec_time;
   float    new_stop_time, new_totgs_time;

   char tag[10];

   int job_nu = 0;   
   char start_date[40];

   int posn;

/* parse command line variables */

   Gainad = 0;
   Nchans = 1;
   Fchan = 0;
   rec_time = 0.0;
   Freq = 16000.0;
   
   strcpy (addev_name, "adf0");
   strcpy (adclk_name, "clk0");

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_vox.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_vox.source, argv[i]);
        strcat(o_vox.source, " ");
        }
        strcat(o_vox.source, "\0");
	        
/* PARSE COMMAND LINE  */



   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {

	       case 'd': 
	  sscanf (argv[++i], "%f", &rec_time) ;

		  break;
               case 'f': 
		  sscanf (argv[++i], "%f", &Freq);
		  break;
	       case 'o': 
		  strcpy (def_file, argv[++i]);
		  break;

	       case 'a': 
		  strcpy (addev_name, argv[++i]);
		  break;

	       case 'k': 
		  strcpy (adclk_name, argv[++i]);
		  break;

	       case 'c': 
		  sscanf (argv[++i], "%d", &Nchans);
		  break;

	       case 'l':
	          loop =1;
	          sscanf(argv[++i],"%f",&loop_time);

	          break;


	       case 'b': 
		sscanf (argv[++i], "%d", &Fchan);
		  break;

	       case 'g': 
		  sscanf (argv[++i], "%d", &Gainad) ;
		  break;

	       case 'S': /* use files as signals between recording process and 
	       		  application process */
		   ipc = 1;	            
		   break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi (argv[++i]);
		  break;

	       default: 
		  printf ("illegal option %s\n", argv[i]);
		  break;
	    }
	    break;
	 default: 
	    printf ( " illegal option %s\n", argv[i]);
	    break;
      }
   }


if (debug == HELP)
	sho_use();


   if (!strcmp (def_file, "")) {
      printf ("no output file specified\n");
      return (-1);
   }

/* check to see if device and clock available;
   defaults = adf0 and clk0 */



   strcpy (Device, "/dev/dacp0/");
   strcpy (Clock, "/dev/dacp0/");
   strcat (Device, addev_name);
   strcat (Clock, adclk_name);

   error = gs_openad_chk ();
   
   if (debug)
   printf(" clock %s ad %s\n",Clock,Device);
   


   if (!strncmp (adclk_name, "ef", 2))
      Eflag = 1;

/* Set up parameters for channel sampling;

NB. the maximum use of the A/D equipment can only be
achieved when used in single user mode; random sampling
errors will occur when in multiuser mode */

   if (Fchan < 0 || Fchan > 15) {
      printf ("mc_rec: starting input channel must be from 0 to 15\n");
      return (-1);
   }

   if (Nchans < 0 || (Fchan + Nchans - 1) > 15) {
      printf ("mc_rec: # of channels is out of range\n");
      return (-1);
   }

   Incr = 1;			/* increment by 1 channel */

      if (!strcmp (addev_name, "adf0")) {
      if ((Freq * (float) Nchans) > 1.0e7) {/* max = 1 megahz */
	 printf ("mc_rec: sampling frequency too high for # of channels\n");
	 return (-1);
      }

      if (Gainad < 0 || Gainad > 3) {
  printf ("mc_rec: incorrect gain for the AD device setting to 0\n",Gainad);
	 Gainad = 0;
      }
   }

   if (!strcmp (addev_name, "ads0")) {
      if ((Freq * (float) Nchans) > 40000.0) {/* max = 40 KHz */
	 printf ("mc_rec: sampling frequency too high for number of channels\n");
	 return (-1);
      }
      Gainad = 0;
   }

   in_len = (int) (rec_time * Freq);/* num of points resulting */

   in_len *= Nchans;		

   N_bufs = (in_len) /  (BUFF_SIZE/ 2) + 1 ;

   in_len = ((N_bufs-1) * (BUFF_SIZE / 2) ) / Nchans;
   
   rec_time = in_len / Freq;
   

   if ( !loop)
   N_bufs = NUM_BUFFS;

   if (N_bufs > NUM_BUFFS) {
   	printf("not enuf mem\n");
   	exit(-1);
   }

/* create new sample data header */

	        strcpy (o_vox.name,"A/D_RECORDING") ;
       	        strcpy (o_vox.type,"CHANNEL") ;
  		o_vox.f[STR] = 0.0; 
  		o_vox.f[STP] = rec_time;   		
		o_vox.f[N] = 1.0 * Nchans;

		gs_o_df_head(def_file,&o_vox);

       	        strcpy(o_vox.dtype,"short");
      	        strcpy(o_vox.dfile,"@");

      		o_vox.f[SF] = (int) Freq;
      		o_vox.f[FS] = 1.0/ Freq;
      		o_vox.f[FL] = 1.0 / Freq;
		o_vox.f[SOD] = 0.0;
      		o_vox.f[N] = 1.0 * in_len ;
      		o_vox.f[MN] = -100.0;
      		o_vox.f[MX]= 100.0;

	/* write out headers */


  		for (i = 0; i < Nchans ; i++) {
		o_vox.f[CN] = 1.0 * i;
        	sprintf(tag,"%f",(float) i);
		strcpy(o_vox.name,tag);
		if(debug)
	        printf("chn %s\n",tag);
		gs_w_chn_head(&o_vox);

/*   write each channel head */
	        }

        posn = gs_pad_header(o_vox.fp);
	o_vox.f[SOD] = 1.0 * posn;


        fsize = (in_len * 2) + head_size;

   /* fsize is total size in bytes of file */

   if (fsize > 3e7) {		
      printf ("\nToo much disk space !!\n EXITING!!");
      return (-1);
   }				

   if (( out_vox_fd = open (def_file, OFLAG, FMODE)) < 0) {

      fprintf (stderr, "\nFiling error in %s\n", def_file);
      exit (-1);
   }				

/* set file pointer */

	if (debug)
	printf("OUTPUT  %d %d\n",out_vox_fd,posn);

	lseek(out_vox_fd,posn,0);

   Freq *= Nchans;		/* multiply sample freq by Nchans to * allow
				   for sequential conversion */

   head_size = posn ;
   
   Fd = out_vox_fd;
      
		  if (debug)
	          printf("loop_time %f\n",loop_time);   
   
   dorecord(in_len, rec_time);

   close (out_vox_fd);

   if (job_nu) {
	job_done(job_nu,start_date,o_vox.source);
   }


}


gs_openad_chk () {
   int   adopen;

   adopen = open (Device, O_RDONLY);
   if (adopen == -1) {
      printf ("A/D device %s does not exist on system\n", Device);
      return (-1);
   }
   close (adopen);

   adopen = open (Clock, O_RDONLY);
   if (adopen == -1) {
      printf ("Clock device %s does not exist on system\n", Clock);
      return (-1);
   }
   close (adopen);
   return (1);
}



/* number of elements in a total buffer */
#define MAXBUFSIZE (BUFF_SIZE*NUM_BUFFS)/2 

#define IOMODE 0		/* access mode for task */



union buf_tp {
   int   ibuf;
   short    sbuf[MAXBUFSIZE];
} bbuf;


short   *bf;

int   bdone (),  dummy ();
				/* buffer completion routines to be locked in
				   memory */
int   onintr (), mc_quit ();
int   tmp, Dacqfail;
long int first, last;

static jmp_buf jmpbuf;

extern int  errno;

dorecord (num_items, rec_time)
float rec_time;
{
   double   pwidth, rfreq, rwidth;
   int   i,j,k;
   int stop_status;
   int   r_time;   
   int fsize;
   FILE *fp;
   
   /* find sections of data memory and subroutines to be locked */
   r_time = 1000.0 * rec_time ;		/* convert to msecs */

   r_time += 100;

 if (debug) {
 printf ("\nFchan Nchan CVsync Freq Gain Incr %d %d %d %g %d %d\n",
	 Fchan, Nchans, Cvsync, Freq, Gainad, Incr);
   printf("using ipc signals\n");
 }
 
  Dacqfail = 0;


   if (setjmp (jmpbuf) != 0) {
      if (debug) 
      printf ("\nERROR JUMP!\n");
      Dacqfail = 1;
      goto endid;
   }

  
   seterropt (ERROR, FATAL-1, 0, 0, 0);

   seterrtrap (onintr, FATAL);

 if (debug)
 printf("\nlock: start %d length %d  \n",(int)&bbuf,
		((int) &first - (int) &bbuf)); 


   tmp = plockin ((int) & bbuf, ((int) & first - (int) & bbuf));

   tmp = nice (-20);
   if (debug)
   printf("\nlock: start %d length %d  nice: %d\n",(int) bdone,
		((int) dummy -(int) bdone),tmp);


   tmp = plockin ((int) bdone, ((int) dummy - (int) bdone));
   if(debug > 1)
   printf("\n%d pages locked\n",tmp); 


/*   updoff (); */

   i = mropen (&Adpn, Device, IOMODE);/* open A/D */

   i = mropen (&Clkp, Clock, IOMODE);
      
   mrbufall (Adpn, bbuf.sbuf, N_bufs, BUFF_SIZE);

   if (!Eflag)
      mradmod (Adpn, 0, 0);

   mrclk1 (Clkp, 0, Freq, &rfreq, 4, pwidth, &rwidth, 0);

   mradinc (Adpn, Fchan, Nchans, Incr, Gainad);

   mrclktrig (Adpn, 1, Clkp);

   if ( !ipc) {
   printf ("\nRECORD AFTER BELL - PROMPT\n ");
   if (debug) {
   printf("\nnum_items = %d\n",num_items);;
   printf("\nrfreq %g rwidth %g\n",rfreq,rwidth);
   }
   bell ();
   }
   else {
   fp = fopen ("WRK/mc_rec_start", "w");
   fprintf(fp,"mc_start\n");
   fflush(fp);
   fclose(fp);
   bell ();
   }

   if(!loop) {
   gs_wait(1.0);
   printf ("\nRECORD NOW!!\n ");
   mrxinq (Adpn, BUFF_SIZE / 2, num_items, bdone);/* offset for header */
   }
   else {
   if (! ipc)
   printf ("\nRECORD LOOP ACTIVE - KYBD OR MOUSE CLICK to STOP\n ");
   mrxinq (Adpn, BUFF_SIZE / 2 , 0, bdone);/* open ended transfer */
   }

   if(!loop) {
   mrevwt (Adpn, NULL, r_time);	
   	if (debug) {
	   printf("waiting %d %d \n",Adpn,r_time);
	}
    }
   else {
   if ( ! ipc ) {
   getchar();	
   } else {
   while ( 1) {
   if (df_stat ("WRK/mc_rec_stop",0) >= 0)  {

/*  look for signal - message */
   if ( debug)
   printf("stopping record\n");
   break;
   }
   gs_wait(0.5) ;
   }
   }
   gs_wait(loop_time);
   mrstop(Adpn,0,&stop_status);
   
   }

   if (loop) { /* write the buffers to file in order of last use */

        k = buf_cnt+1;
  	for (j = 0; j < N_bufs-1 ; j++) {

	if (k > (N_bufs -1))
	k =0;
  	
  	write(Fd, &bbuf.sbuf[k * (BUFF_SIZE / 2)], BUFF_SIZE );
	k++;

        }
    }

   tmp = nice (20);
   tmp = punlock ((int) & bbuf, ((int) & first - (int) & bbuf));

/*   printf("\n%d pages unlocked",tmp);  */

   tmp = punlock ((int) bdone, ((int) dummy - (int) bdone));

   if (debug ==1)
   printf("MC_RECORD FINISHED\n");

   if ( ipc ) {
   	unlink ( "WRK/mc_rec_start" );
        unlink ( "WRK/mc_rec_stop" );   	
   }

endid: 

   mc_quit (errno);

   if (Dacqfail)
      return (99);
   else
    return (0);  

}			



char  updnam[256];

updoff () {

   int   Fdu;

   sprintf (updnam, "%s.%d", "noupd", getpid ());

   unlink (updnam);

   if ((Fdu = creat (updnam, 0644)) < 0) {
      perror (updnam);
      printf ("\nCouldn't create %s\n", updnam);
   }
}


updateon () {

   unlink (updnam);

}



int   bdone (rpathno)
int  *rpathno;
{
   
   int   wrcnt, indx, aps, bsize;

   if (*rpathno != Adpn) {
      printf ("\nbad path\n");
      exit (-1);
   }


   mrbufget (*rpathno, 0, &bf);

/*	add option where fixed size record loop is active */

   if (!loop) {
   if ((wrcnt = write (Fd, bf, BUFF_SIZE)) < 0) {;
      printf ("\nwrite error!!\n");
      exit (-1);
   }

   }

   mrbufrel (*rpathno, bf); /* assume they are retrieved  in order */

   buf_cnt++;
   if (buf_cnt > (N_bufs-1)) 
   buf_cnt = 0;

}


static int  mc_quit (num)
int   num;
{
   int   sts;

   if (Dacqfail)
      close (Fd);

   if (debug)
   fprintf (stderr, "\nQUIT NUM == %d \n", num);
   fflush (stderr);

   mrclosall ();

/*   updateon (); */

   seterrtrap ("", FATAL);

   /* signal(SIGINT,SIG_DFL); */

}

static int  onintr () {
/*signal(SIGINT,onintr);*/
               longjmp (jmpbuf, 1);
   exit (-1);
}


dummy () {
   return;
}



bell () {
   int   ring;
   ring = 7;
   printf ("%c", ring);
}


gs_wait(delay)
float delay;
{
int ast_time;
	
   ast_time = (int) (1000.0 * delay);
   ast_time = astpause (50, ast_time);
   while (ast_time > 1)
   ast_time = astpause (50, ast_time);
}



/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
    "Usage: mc_rec [-d secs -f  -o out_file] \n");

      fprintf(stderr,"-d record duration \n");      
      fprintf(stderr,"-c number of channels [1]\n");
      fprintf(stderr,"-b start channel [0] \n");                  
      fprintf(stderr,"-f sampling frequency [16000] \n");            
      fprintf(stderr,"-a ad_dev [ adf0 ] \n");            
      fprintf(stderr,"-k clk_dev [ clk0 ] \n");                  
      fprintf(stderr,"-l delay(secs) after stop signal before stopping recording secs[no loop record] \n");                  

      exit (-1);
}

