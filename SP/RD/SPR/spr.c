/*
__________________________________________________________________________________
	SPR
/ 	
/	Author: 	Mark Terry 1989
/ 
/ 	This program will take as input either a multichannel 
/ 	file and compute a a "neural" spike train
/	a period histogram is then computed via auto_correlation of the
/	spike train
/	the spike rate per channel can also be written to file
__________________________________________________________________________________
*/

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */


int Vox;
float Lt[1024];
float Amp[1024];
float Pe[1024];
float Ih[1024];
float Lih[1024];
float Fbuf[8192];
float Rate[1024];
double   pow(),sin (), cos (), log (), log10 ();

int rand();
float frand();

int debug = 0;
float    In_buf[8192];
short    Out_buf[8192];
channel   i_chn[128];
int do_log = 0;

   float nyquist,bark_nyq;
   
main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df,r_df;

   char sd_file[80];      
   int job_nu = 0;   
   char start_date[40];
   
   int fposn,posn,nc;
   int pid ,fsize;   

   char in_file[120];
   char out_file[120];
   char rate_file[120];   

   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float  length;

   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read = -1;
   int new_sample = 0;
   int   eof, nsamples, n_frames;
   int i,j,n,k,cp;
   int  loop;
   int noc;
   
   double   atof ();


/* DEFAULT SETTINGS */
   int n_sac = 2;   
   int nbins = 17;
   
  

   int i_flag_set = 0;
   int o_flag_set = 0;
   int r_flag_set = 0;   

   int frame_shift_set = 0;
   int frame_length_set = 0;   
   int win_shift_set = 0;
   int  win_shift = 128;
   int  win_length = 256;
   float     sf = 16000.0;

   int start = 0;

   float min = 0.0;
   float max = 1.0;
   float tim;
   float frame_shift = .005;
   float frame_length = .005;
   char tag[4];

   int n_firings;
   int nspec,npts,nfrms = 0;
   int l;
   int lc = 0;
   int adapt =0;

   int l_chn = -1;
   int u_chn = -1;

   int print_out = 0;

   int bn;
   float time,t1,t2,gain;

   float frate,freq,fqr;
   float bark;


   int first_time;
   float thres = 1.0;
   float fire_thres = 50.0;   
   float p = 1.0;
   float am_zxte();
   float period;
   float Hz_Bark(), Bark_Hz();


/* Header structures */

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i < argc; i++) {
     if (debug == HELP)     
     	 break;
      switch (*argv[i]) {

	 case '-': 

	    switch (*++(argv[i])) {
	      
	        case 'n' :
	       	  nbins  = atoi (argv[++i]);
	       	  break;

	        case 'm' :
	       	  n_sac  = atoi (argv[++i]);
	       	  break;

	       case 'P':
        	       lc =1;
	       	       break;
	       case 'A':
	       	       adapt =1;
	       	       break;
	       case 'T':
		  thres = atof (argv[++i]);
		  break;

	       case 'F':
		  fire_thres = atof (argv[++i]);
		  break;

	       case 'L':
		  do_log = 1;
		  break;

	       case 's': 
		  frame_shift_set = 1;
		  frame_shift = atof (argv[++i]);
		  time_shift = 1;
		  frame_shift *= .001;
		  break;

	       case 'l': 
		  frame_length_set = 1;		  
		  frame_length = atof (argv[++i]);
		  frame_length *= .001;
		  break;

	       case 'b':
	       	   l_chn = atoi (argv [++i]);
	       	   break;	
	       case 'u' :
	           u_chn = atoi (argv [++i]);
	           break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 'r': 
  		  r_flag_set = 1;
		  strcpy(rate_file,argv[++i]);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date);
		  break;
	       case 'H':
	       case 'h':
	          debug = HELP ;
	          break;	          

	       default: 
		  printf ("%s: option not valid\n", argv[i]);
		  debug = HELP;
		  break;
	    }
      }
   }


if (debug == HELP)
	sho_use();

	srand(7);

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	exit(-1);
   	}
   }
   
   nc = (int) i_df.f[N];

   if ( (int) i_df.f[N] > 1) {
      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
	i_chn[0].f[SKP] = i_df.f[N] -1;
   }
 
   length = i_df.f[STP] - i_df.f[STR];

   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   

   nsamples = (int) i_chn[0].f[N];


   dbprintf(1,"length %f ns %d %f\n",length,nsamples,i_chn[0].f[SF]);   
   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }


   if ( ((int) i_chn[0].f[SOD]) > 0)
   fposn = (int) i_chn[0].f[SOD];

   /* else start reading where header ends */
   /* sampling frequency */

   sf = i_chn[0].f[SF];

      win_shift = (int) (frame_shift * sf);
      win_length = sf * frame_length;
      n_frames = (int) (length / frame_shift);

   /* Get sample start and stop times */
/* INIT OP DATA STRUCTURE */

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

	gs_init_df(&o_df);



	nyquist = sf /2.0;
	bark_nyq = Hz_Bark(nyquist);
	      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;

 strcpy(o_df.name,"PE");
 strcpy(o_df.type,"FRAME"); 
 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

   
   o_df.f[VL] = (float) nbins ; 
   o_df.f[FS] = frame_shift;
   o_df.f[FL] = frame_length;
   o_df.f[SF] = sf;
   o_df.f[MX] = bark_nyq ;
   strcpy (o_df.x_d, "channel_nu");
   strcpy (o_df.y_d, "firings");
   o_df.f[LL] = 0.0;
   o_df.f[UL] = 200.0;
   o_df.f[N]= (float) n_frames;
   gs_w_frm_head(&o_df);   
   posn = gs_pad_header(o_df.fp);


  if (r_flag_set)  {

   gs_init_df(&r_df);
      
   r_df.f[STR] = i_df.f[STR];
   r_df.f[STP] = r_df.f[STR] + length;

   strcpy(r_df.name,"SPR_RATE");
   strcpy(r_df.type,"FRAME"); 
   r_df.f[N] = 1.0;

   gs_o_df_head(rate_file,&r_df);
   
   r_df.f[VL] = (float) nc;
   r_df.f[FS] = frame_shift;
   r_df.f[FL] = frame_length;
   r_df.f[SF] = sf;
   r_df.f[MX] = bark_nyq ;
   strcpy (r_df.x_d, "channel_nu");
   strcpy (r_df.y_d, "firings");
   r_df.f[LL] = 0.0;
   r_df.f[UL] = 200.0;
   r_df.f[N]= (float) n_frames;
   gs_w_frm_head(&r_df);   
   posn = gs_pad_header(r_df.fp);
   }
 

dbprintf(1,"spike rate and periodicty analysis wl %d \n%",win_length);

/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = win_length;
       
/* MAIN LOOP */

        if (l_chn == -1)
		l_chn = 0;
	if (u_chn == -1)
		u_chn = nc -1;

        dbprintf(1,"l_chn %d u_chn %d\n",l_chn,u_chn);
        dbprintf(1,"nu of channels %d\n",nc);
        dbprintf(1,"nu of samples  %d\n",nsamples);

	noc = u_chn - l_chn +1;

/* add DC and Nyquist points both zeroed */
	nbins -= 2;

	fqr = bark_nyq / (float) ( nbins);


       	dbprintf(1,"%f %f\n",bark_nyq,fqr);
	bark_nyq = Hz_Bark(nyquist);

	loop = 0;
/*	MAIN LOOP   */

	while (1) {

/* READ INPUT DATA */

          eof = read_m_chn(&i_chn[0],&In_buf[j],n);
          last_sample_read += n;

	  if ( eof == 0)  {
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }



	dbprintf(1,"time %f %d\n",(loop* frame_shift),last_sample_read); 
	n_firings = 0;

	first_time =1;	

   	for (k = l_chn; k <= u_chn ; k++ ) {
	Rate[k] = 0.0;

	for (l =0 ; l < win_length-2 ; l++ ) {

/*	 check for +ve peak   */
	   cp = l * nc + k;

	if ( spike_gen( k,cp,nc, thres,fire_thres, sf,&first_time)) {
		n_firings++;
		Rate[k]++;

	        }
	} 	   

      if (lc ) {
      	
      Rate[k] *= (nc / (k+1)) ; /* work this out same as in ph */
       
      }

      }

      dbprintf(1,"firings in channels %d %d %d\n",n_firings,l_chn,u_chn);

      


      
      if (r_flag_set) {
      	gs_write_frame(&r_df,Rate);
      }

      Fbuf[n_firings *2 ] = -1.0;
      Fbuf[n_firings *2 + 1] = -1.0;
      
      if (n_firings > 0) {

      sac(nbins,n_firings,sf,fqr,n_sac); 

      ph(nbins,fqr,lc,adapt);

      }
/* CHECK FOR END OF DATA */	      
              loop++;


/* INPUT BUFFER & POSITION FOR NEXT READ */
      	 new_sample += win_shift;
/*	 new_sample += win_length -2; */

 m_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);

 fwrite(Pe,sizeof(float),nbins + 2, o_df.fp);

  }

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);
   if (r_flag_set)    gs_close_df(&r_df);   

 dbprintf(1,"%s finished %d \n",argv[0],loop);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}


spike_gen(k,cp,nc, thres,fire_thres, sf,first_time)
float sf;
int *first_time;
float thres,fire_thres;
{
static int j = 0;	
float time;
float spike_time();
float delta;

        delta = 1.0 / sf;
	if (*first_time) j = 0;
	*first_time = 0;

  if ( (In_buf[cp] < In_buf[cp+nc]  && In_buf[cp+nc] > In_buf[cp+2*nc]) ) { /* peak */	

	if (In_buf[cp+nc] > thres && fire(In_buf[cp+nc],fire_thres))  { 
		
		time = (cp / nc) * delta;
		Fbuf[j++] = (float)k;
		Fbuf[j++] = spike_time(In_buf[cp],In_buf[cp+nc],In_buf[cp+2*nc],delta) + time;

		dbprintf(2,"firing @ %f channel %d Fb %f\n",Fbuf[j -1],k,Fbuf[j -2]);
	        return(1);
	 }
	}
	return(0);
}

float
spike_time(a1,a2,a3, delta)
float delta,a1,a2,a3;
{
float time;
float pk_pos, pk_amp, pk_bw;
/* need to estimate peak position in time */ 

	parabolic_ip (a1, a2, a3,1, delta, 1, &pk_pos, &pk_amp, &pk_bw);

/* time=  1.0 / sf; */
	return(pk_pos);
}


sac(nbins,n_firings,sf,fqr,n_sac)
float sf,fqr;

{
int k,j;
float t1,t2;
int sp = 0;
int asp = 0;
int cc,bn;
int firings =0;
float period,freq,bark;
int n_ac = 0;

	for (k= 0; k < nbins; k++ )
		Ih[k] =0.0;

	/* get firing */
	while (1) {

		cc = (int) Fbuf[asp];

		dbprintf(2,"cc %d\n",cc);
		if (cc < 0 )
		return;
		t1 = Fbuf[asp + 1];
		asp += 2;
		sp = asp;
		firings++;
		if (firings >= n_firings)
		return;
		n_ac = 0;		

		while ((int) Fbuf[sp] == cc) {
			t2 = Fbuf[sp+1];
			sp += 2;
		        period = t2 - t1;
			if (period > 0.0)
		   	freq = 1.0 /  period;
			else
			freq =0.0;

			if (freq > (sf /2.0 + 1.0) || freq <= 0.0) {
			dbprintf(1,"aliase error %f \n",freq);
			freq = 0.0;
		        }

	        if(freq < 0.0) freq = 0.0;

dbprintf(2,"freq %f cc %d asp %d sp %d t1 %f t2 %f\n",freq,cc,asp,sp,t1,t2); 

		if (freq > 10.00 && freq < nyquist ) {
	
		bark = Hz_Bark(freq);
		bn = bark / fqr;
		Ih[bn]++;
		n_ac++;
	
		if (n_ac >= n_sac)
		break;
		}

   	  }
   }

}

ph(nbins,fqr,lc,adapt)
float fqr;
{
int j;
float freq;
float gain;
float lcmp;

	Pe[0] = 0.0;
	Pe[nbins+1] = 0.0;

	for (j =0 ; j < nbins ; j++) {
	
	freq = Bark_Hz((j+1) * fqr);

	if (lc) {
		lcmp = Ih[j];
		Ih[j] = (lcmp * 1000.0 / (freq ) ) ;
dbprintf(1,"lc %f freq %f  b4lc %f alc %f\n",fqr,freq,lcmp,Ih[j]);	

	 }

dbprintf(1,"bin %d bark %f freq %f firings %f\n",j,(j+1)*fqr,freq,Ih[j]);


/*	update pitch estimate array applying decay
 *	and comparing present and last update to
 *	mimic effects of adaptation
 *		ADAPTATION
 */


	if (adapt) {
		if (Lih[j] > Ih[j])
		gain = Ih[j] /(2.0*Lih[j] + 1.0);
		else
		gain =1.0 - Lih[j] /(2.0*Ih[j] + 1.0);
		Pe[j] = Pe[j] / 2.0;
		Pe[j] = Pe[j] + gain * Ih[j];
		if (gain > 2.0) dbprintf(1,"j %d gain = %f\n",j,gain);
		Lih[j] = Ih[j];	
		}
	else
	Pe[j + 1] =  Ih[j];

	if (do_log)
	if (Pe[j] > 0.0) Pe[j] =  10.0 * log10(Pe[j]);
   }
}


fire(amp,fire_thres)
float amp, fire_thres;
{
float y;

	y =  frand() * fire_thres;	

	dbprintf(1,"amp %f fire_thres %f\n",amp,y);
	if ( amp > y)
	return (1);
	return (0);
}

sho_use()
{
        fprintf (stderr, "spr -b -u -l -s -F -P -A -L -T -n -m  -i infile -o outfile\n");
        fprintf (stderr, " -b lower channel of filterbank input [first]\n");
        fprintf (stderr, " -u upper channel [last] \n");
        fprintf (stderr, " -n bins in periodicty histogram ( pwr 2 + 1 [17] ) \n");	      
fprintf (stderr, " -m number of consective firings for estimating periodicity [2] \n");	      
        fprintf (stderr, " -P apply loudness compenstation contour \n");	      
        fprintf (stderr, " -A apply adaptation to firing \n");	      
        fprintf (stderr, " -L apply log transform \n");	              
        fprintf (stderr, " -T threshold [1.0] \n");	              
        fprintf (stderr, " -F firing threshold [50.0] \n");	              
        fprintf (stderr, " -r firing rate output data file\n");	              
        fprintf (stderr, " -l length of analysis window msec [5]\n");
        fprintf (stderr, " -s analysis window shift msec [5]\n");        
	exit(-1);
}

