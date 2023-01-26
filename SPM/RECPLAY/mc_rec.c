#include <gasp-conf.h>

#include <stdio.h>
#include <mr.h>
#include <fcntl.h>
#include <setjmp.h>
#include "df.h"
#include "sp.h"

#define BLEN  8192 /* buffer length in bytes 
		   size can be crucial -try increasing
		   this if there are problems */

#define NUM_BUFFS  50  
		        
#define MAXBUFFS   50

#define OFLAG (O_RDWR | O_CREAT)

#define FMODE  0660	


/* number of elements in a total buffer */
#define MAXBUFSIZE (NUM_BUFFS*BLEN/2)

#define IOMODE 0		/* access mode for task */

short rob[BLEN]; /* buffer for reordering disk file 
		    after loop record */

union buf_tp {
   long int   ibuf;
   short    sbuf[MAXBUFSIZE];
} bbuf;

/* short   *bf; */
int   bcr (),  dummy ();
long int first, last;


char  Device[40], Clock[40];
int   Dapn = -1, Adpn = -1, Clkp = -1;
int   Fd, Eflag, Cvsync, STAT[6], Fchan, Nchans, Incr;

int Gainad = 0;

float    Freq;

data_file df;

channel o_vox;
int Write_out = 0;
int out_vox_fd;
int N_bufs;
int N_loop_bufs;
int loop = 0;
int debug = 0;
float loop_time;
int  buf_cnt = 0;
int  loop_bc = 0;
int ipc =0;
int sod_posn;
float Max_da;
float  Min_da;

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


	       case 'N': 
		sscanf (argv[++i], "%d", &Write_out);
		  break;

	       case 'g': 
		  sscanf (argv[++i], "%d", &Gainad) ;
		  break;

	       case 'S': /* use files as signals between recording process and 
	       		  application process */
		   ipc = 1;	            

   	           unlink ( "mc_rec_start" );
                   unlink ( "mc_rec_stop" );   	
		  
		   break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi (argv[++i]);
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

   if (!strcmp (def_file, "")) {
      dbprintf (1,"no output file specified\n");
      return (-1);
   }

/* check to see if device and clock available;
   defaults = adf0 and clk0 */

   strcpy(Device,"\0");
   strcpy(Clock,"\0");

   if ( strncmp(addev_name,"/dev",4) != 0)
   strcpy (Device, "/dev/dacp0/");

   if ( strncmp(adclk_name,"/dev",4) != 0)
   strcpy (Clock, "/dev/dacp0/");


   strcat (Device, addev_name);
   strcat (Clock, adclk_name);
   error = gs_openad_chk ();


   dbprintf(1," clock %s ad %s\n",Clock,Device);

   if (!strncmp (Clock, "/dev/dacp0/ef", 11 ))
                Eflag = 1;

	Max_da = 2047.0;
	Min_da = -2047.0;

     if ( !Eflag ) {
     Max_da *= 16.0;
     Min_da *= 16.0;	
     }
     	

/* Set up parameters for channel sampling;

NB. the maximum use of the A/D equipment can only be
achieved when used in single user mode; random sampling
errors will occur when in multiuser mode */

   if (Fchan < 0 || Fchan > 15) {
 dbprintf (1,"mc_rec: starting input channel must be from 0 to 15 \n");
      return (-1);
   }

   if (Nchans < 0 || (Fchan + Nchans - 1) > 15) {
   dbprintf (1,"mc_rec: # of channels is out of range\n");
      return (-1);
   }

   Incr = 1;			/* increment by 1 channel */

if (!strcmp (addev_name, "adf0")) {
if ( (Freq * (float) Nchans) > 1.0e7 ) {
	 dbprintf ("0,ERROR mc_rec: sampling frequency too high for # of channels\n");
	 return (-1);
      }

      if (Gainad < 0 || Gainad > 3) {
 dbprintf (1,"mc_rec: incorrect gain for the AD device setting to 0\n",Gainad);
	 Gainad = 0;
      }
   }

   if (!strcmp (addev_name, "ads0")) {
   if ((Freq * (float) Nchans) > 40000.0) {/* max = 40 KHz */
 dbprintf (1,"mc_rec: sampling frequency too high for number of channels\n");
	 return (-1);
      }
      Gainad = 0;
   }

   in_len = (int) (rec_time * Freq);
   /* num of points resulting */

   in_len *= Nchans;		

   N_bufs = (in_len) /  (BLEN/ 2) + 1 ;

   in_len = N_bufs * (BLEN/ 2) ;
   
   rec_time = in_len / (Freq * Nchans) ;

   dbprintf(1,"N_buffs %d\n",N_bufs);

   N_loop_bufs = N_bufs;

      if ( N_bufs > MAXBUFFS)
         N_bufs = MAXBUFFS;

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
      		o_vox.f[N] = 1.0 * in_len / Nchans ;


      		o_vox.f[UL] = Max_da;
      		o_vox.f[LL]=  Min_da;

	/* write out headers */


  		for (i = 0; i < Nchans ; i++) {
		o_vox.f[CN] = 1.0 * i;
		o_vox.f[SKP] = 1.0 * (Nchans-1);		
        	sprintf(tag,"%f",(float) i);
		strcpy(o_vox.name,tag);

		gs_w_chn_head(&o_vox);

/*   write each channel head */
	        }

        sod_posn = gs_pad_header(o_vox.fp);
	o_vox.f[SOD] = 1.0 * sod_posn;


        fsize = (in_len * 2) + head_size;

   /* fsize is total size in bytes of file */

   if (fsize > 3e7) {		
      dbprintf (0,"ERROR disk space ");
      return (-1);
   }				

   if (( out_vox_fd = open (def_file, OFLAG, FMODE)) < 0) {
      exit (-1);
   }				



/* set file pointer */

	lseek(out_vox_fd,sod_posn,0);

   Freq *= Nchans;

 /* multiply sample freq by Nchans to * allow
   for sequential conversion */

   head_size = sod_posn ;
   
   Fd = out_vox_fd;

   dbprintf(1,"loop_time %f\n",loop_time);   
   
   dorecord(in_len, rec_time); 

   mrclosall ();
   

   close (out_vox_fd);


   
   if (job_nu) {
	job_done(job_nu,start_date,o_vox.source);
   }

   tmp = nice (0);
}


gs_openad_chk () {
   int   adopen;

   adopen = open (Device, O_RDONLY);
   if (adopen == -1) {
      dbprintf (0,"MC_REC:A/D device %s does not exist on system\n", Device);
      return (-1);
   }
   close (adopen);

   adopen = open (Clock, O_RDONLY);
   if (adopen == -1) {
      dbprintf (0,"MC_REC:Clock device %s does not exist on system\n", Clock);
      return (-1);
   }
   close (adopen);
   return (1);
}



/* buffer completion routines to be locked in
	   memory */

int   onintr (), mc_quit ();
int   tmp, Dacqfail;


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
   int pbi,tbi,sbi,wbi,tbpos;
   FILE *fp;
   

  dbprintf(1," ni %d rec_time %f\n",num_items,rec_time);
   
   /* find sections of data memory and subroutines to be locked */
   
   r_time = 1000 * rec_time ;		/* convert to msecs */

   r_time += 100;


   seterropt (ERROR, FATAL-2, 0, 0, 0);

   seterrtrap (onintr, FATAL-1); 



        mrlock(0,0,&tmp);

   dbprintf(1,"\n%d bytes locked\n",tmp); 

   i = mropen (&Adpn, Device, IOMODE);/* open A/D */

   i = mropen (&Clkp, Clock, IOMODE);

   mrbufall (Adpn, bbuf.sbuf, N_bufs, BLEN);

   if (!Eflag)
      mradmod (Adpn, 0, 0);

   mrclk1 (Clkp, 0, Freq, &rfreq, 4, pwidth, &rwidth, 0);

   mradinc (Adpn, Fchan, Nchans, Incr, Gainad);

   mrclktrig (Adpn, 1, Clkp);

   if ( !ipc) {

   printf ("\nRECORD AFTER BELL - PROMPT\n ");

   dbprintf(1,"\nnum_items = %d\n",num_items);;
   dbprintf(1,"\nrfreq %g rwidth %g\n",rfreq,rwidth);

   bell ();
   }
   else {
   fp = fopen ("mc_rec_start", "w");
   fprintf(fp,"mc_start\n");
   fflush(fp);
   fclose(fp);
   bell ();
   }


   tmp = nice (-15);    

   if(!loop) {
   MC_wait(1.0);
 
   printf ("\nRECORD NOW!!\n ");

   num_items = (2 * num_items )/ 2 ;
   dbprintf(1,"\nnum_items = %d\n",num_items);;

   mrxinq (Adpn, BLEN / 2, num_items, bcr);    
   }
   else {
   
    mrxinq (Adpn, BLEN / 2 , 0, bcr);/* open ended transfer */
    if (! ipc)
  printf ("\nRECORD LOOP ACTIVE - KYBD OR MOUSE CLICK to STOP\n ");
   }

   if(!loop) {

    dbprintf(1,"waiting %d %d \n",Adpn,r_time);
    mrevwt (Adpn, NULL, r_time);	
    mrstop(Adpn,0,&stop_status);
    dbprintf(1,"stop_status %d \n",stop_status);
    }
   else {

   if ( ! ipc ) {
   getchar();	
   } 
   else {
   while ( 1) {
   if (df_stat ("mc_rec_stop",0) >= 0)  {

/*  look for signal - message */

   break;
   }
   MC_wait(0.5) ;
   }
   }
   MC_wait(loop_time);
   mrstop(Adpn,0,&stop_status);
   }

    if (! ipc)
  printf ("\n RECORD LOOP COMPLETED - SAVING FILE\n ");


   MC_wait(0.5) ;
   
   if (loop)  { 
   
  	/* write the buffers to file in order of last use */

	if ( N_loop_bufs <= N_bufs ) {
        
        k = buf_cnt;
        
  	dbprintf(1,"reorder memory loop buffs %d\n",k);

  		for (j = 0; j < N_bufs-1 ; j++) {



		if (k > (N_bufs -1) || k < 0)
		k =0;
  	dbprintf(1,"j %d k %d\n",j,k);  	
	  	write(Fd, &bbuf.sbuf[k * (BLEN/ 2)], BLEN); 
		k++;

        	}
        }  
        else {
	/* reorder	 file */

        k = loop_bc;
	pbi = k;
	sbi = 0;
	wbi = BLEN/2;
	tbpos = sod_posn+ (pbi * BLEN);
	lseek(Fd,tbpos,0);

	dbprintf(1,"reorder disk file lbc %d\n",
	loop_bc);
	read(Fd,&rob[wbi], BLEN);	
	
  	for (j = 0; j < N_loop_bufs-1 ; j++) {
	
	if ( pbi <= k )
	tbi = (N_loop_bufs -1 - (k-pbi));
	else
	tbi = pbi-(k+1) ;
	/* save */
	tbpos = sod_posn+ (tbi * BLEN);
	lseek(Fd,tbpos,0);
	read(Fd,&rob[sbi], BLEN);
	lseek(Fd,tbpos,0);
	write(Fd,&rob[wbi], BLEN);
	dbprintf(1,"j %d pbi %d tbi %d sbi %d wbi %d\n",j
	,pbi,tbi,sbi,wbi);
	tmp = sbi;
	sbi = wbi;
	wbi = tmp;
	pbi = tbi;

        }
        }

    }

   if ( ipc ) {
   	unlink ( "mc_rec_start" );
        unlink ( "mc_rec_stop" );   	
   }


}			


int   bcr (rpathno)
int  *rpathno;
{
   
  int   wrcnt, indx, aps, bsize;
   int i;
   short *bufp; 
   static int nb =0;
     
   if (*rpathno != Adpn) {
            exit (-1);
   }

   
   i = mrbufget (*rpathno, 3, &indx);


/*	add option where fixed size record loop is active */
     if ( loop && ((nb % N_loop_bufs ) == 0)) {
           lseek(out_vox_fd,sod_posn,0);     
           dbprintf(1,"loop bf %d %d\n",indx,nb); 

     }
   
   dbprintf(1,"bf %d %d\n",indx,nb); 

   if ( (! loop ) || (N_loop_bufs > N_bufs)) {   


   if ((wrcnt = write (out_vox_fd, &bbuf.sbuf[indx], BLEN)) <= 0) 
	{
      dbprintf (0,"ERROR write error!!\n");
      exit (-1);
   }

   }
   
    nb++;
   mrbufrel (*rpathno, &bbuf.sbuf[indx] ); 

   /* assume they are retrieved  in order */

   buf_cnt++;
   loop_bc++;
   
   if (buf_cnt > (N_bufs-1)) 
   buf_cnt = 0;

   if (loop_bc > (N_loop_bufs-1)) 
   loop_bc = 0;   

   fflush(stdout);   
}

int dummy () {
   return;
}


bell () {
   int   ring;
   ring = 7;
   printf ("%c", ring);
}


MC_wait(delay)
float delay;
{
int ast_time;

  ast_time = (int) (1000.0 * delay);
   ast_time = astpause (50, ast_time);
   while (ast_time > 1)
   ast_time = astpause (50, ast_time);
   /*
   printf("waited %f\n",delay);	
   fflush (stdout);
   */
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
      fprintf(stderr,"-l delay [ 0 secs] after stop signal\n");
      fprintf(stderr," before stopping recording \n");
      exit (-1);
}


int  onintr () {
   exit (-1);
}

