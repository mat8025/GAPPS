
/****************************************************************************************
 *	Multi-channel FIR filter bank							*
 *	Time-domain filtering								*
 *	Inputs:	  Vox file 	plus							*
 *	DATA file FRAME containing frequency responses of all filters			*
 *	or										*
 *      file containing impulse response coefficients					*
 *											*
 *	Outputs: 	file containing  filter frequency responses			*
 *      & or										*
 *	Multi-channel Vox file containing filtered data					*
 *	serial version							*
 *											*
 *	 Authors: Mark Terry & Clive Summerfield 					*
 ****************************************************************************************/

#include <stdio.h>
#include "/usr/.attinclude/aplib.h"
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */

#define DEF_SIZE    9

#define MAXAPADR 30000
#define CONST 0.7237
#define OPBUFSIZE 512  



int   Data, Coeff, Out_vec, Dot1, Dot2, Rads, aprv, idx, Sine, Cosine;
int   in_vec_ptr,out_vec_ptr,filter_ptr;
int   Src,Tmp,Result,Ctab, Sv,Pwr2;
int   Scalep;
float Scaleio[2];

short	 Fil_bank_vox[1024];
float    Fil_bank_op[1024];
float    sample, real[1024], imag[1024], wt[1024],rad[1024];
float    pi2 = 6.283185307;
float    I0pi2 = 1.0;
float	 Scale = 1.0;
float    ss, cc;
double   pow(),sin (), cos (), log (), log10 ();


int Opbufsize;
int debug = 0;
float    In_buf[1024];
float    Window[1024];
int vox_file_out = 0;    

main (argc, argv)
int   argc;
char *argv[];
{
   data_file o_df,i_df;
   channel   i_chn[2];
   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   

   int job_nu = 0;   
   char start_date[40];

   char in_file[120];
   char out_file[120];

   char data_type[20];
   int no_header = 0;
   int offset = 0;
     
   float  length;

   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read =0;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;

   double   atof ();

/* DEFAULT SETTINGS */

   int i_flag_set = 0;
   int o_flag_set = 0;
   float     sf = 16000.0;

   int   ii, jj,ns, size;
   int   Dflg=0, Bwflg =0,Rflg = 0;
   int   pow2 = 9;
   int   bytes;
   int    u_chn = -1, l_chn = -1;
   int bufnu = 0;
   int vap;

   int last_chn = 0;
   int npts;


   float u_freq = 16000.0 / 4.0;
   float l_freq = 16000.0 / 8.0;

   float start_time, time;
   float chn_min,chn_max,chn_inc;
   int filt_coef_nu;
   int more_input;
   int chn_set =0;
   int delay = 0;
   int init = 1;
   int st_offset;
   int nu_filters = 1;

   int    desfl, resfl;
   int   do_filter = 1;
   int   coef_in = 0, coef_out = 0;
   int   c_in, c_out;
   int   var,start_bytes,rbytes;

   char tag[80];

   char window_type[40];
   char filter_type[40];
   char coef_infile[80], coef_outfile[80];
   char desfile[80], resfile[80];

/* Header structures */

   static channel chn[2];

   Scaleio[0] = 1.0;
   Scaleio[1] = 1.0;
  
/* scale needed to prevent floating point overflow in AP ? */
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

	      case 'U':
	          u_freq = atof(argv[++i]);
	          break;

	      case 'L':
	          l_freq = atof(argv[++i]);
	          break;
	          	          
	      case 'u':
		  u_chn = atoi (argv[++i]);
	          if (u_chn > 0)
		  chn_set =1;
		  break;

	      case 'l':
		  l_chn  = atoi (argv[++i]);
		  if (l_chn >= 0)
		  chn_set =1;
		  break;

	      case 'd':
		  strcpy(desfile,argv[++i]);
		  Dflg = 1;
		  break;
	      case 'r':
		  strcpy(resfile,argv[++i]);
		  Rflg = 1;
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 'c': 
		  strcpy( coef_infile,argv[++i]);
		  coef_in = 1;
		  break;
	       case  'D':
		  delay = 1;
		  break;

	       case 'C': 
		  strcpy( coef_outfile,argv[++i]);
		  coef_out = 1;
		  break;

	       case 's':
		   pow2= atoi (argv[++i]);
		   if (pow2 < 1 || pow2 > 9)
		   pow2 = 9;
		   break;
	       case 'S':
		   sf= atof (argv[++i]);
		   break;
	       case 'I':
		   Scaleio[0]= atof (argv[++i]);
		   break;		   
	       case 'O':
		   Scaleio[1]= atof (argv[++i]);
		   break;		   		  
	       case 'V':
	       	    vox_file_out =1; /* short_integer file*/
	       	    break;
	       case 'N': 
		  do_filter = 0;
		  break;

	       case 'w': 
		  strcpy(window_type,argv[++i]);
		  break;

	       case 't': 
		  Bwflg = 1;
		  strcpy(filter_type, argv[++i]);
		  break;		  

	      case 'Y':
	      	  debug = atoi (argv[++i]);;
	      	  break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
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
	    break;
      }
   }

  if (debug == HELP)
  	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


/* get VA */

      if (i = mapinit (1)) {
	 dbprintf (1,"VA init failed: %d\n", i);
	 exit (-1);
      }
      i = maprndze ();
      mapsync (i);
   


/*	use design file channel subset if chn_set = 1 */
	   if (u_chn == -1 || l_chn == -1)
		chn_set = 0;


/* set default flags */

	if (!coef_out) 
	    strcpy(coef_outfile, "fir.cof");

/* Open sampled data files */


if (do_filter)  {


   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(0,"not  header file\n");
   	exit(-1);
   	}
   }
   
   nc = 0;

   if ( (int) i_df.f[N] > 1) {

      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
      exit(-1);
   }
 
   length = i_df.f[STP] - i_df.f[STR];

   nsamples = (int) i_chn[0].f[N];

   dbprintf(1,"ns %d sf %f\n",nsamples,i_chn[0].f[SF]); 
   
   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */

   
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;

 }  


/*	 DESIGN
 *       Read track file for filter specification 
 *       Open fir filter response file               
 *                   and                             
 *       Create output  coefficient file 
 */

if (Dflg)  gs_d_filters(desfile,coef_outfile,sf,l_chn,u_chn);

if (Bwflg) gs_d_bw_filters(filter_type,coef_outfile,sf,l_freq,u_freq,pow2);


/******************************************************/
/*                  Read coefficient file             */
/*  Read impulse response tracks to AP vector memory  */
/******************************************************/

/*	CALIBRATE				     */

  if (!coef_in)
    strcpy(coef_infile,coef_outfile);
    
   nu_filters = gs_load_calibrate(coef_infile,window_type,resfile,Rflg,&size);

/*  OUTPUT FILE HEADER INFO */

/*************************************************/
/*                set up output  file            */
/*************************************************/
if (!do_filter) {
   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
	exit(0);
  }




   if (!o_flag_set) 
       strcpy(out_file,"stdout");

	        strcpy (o_df.name,"FIR") ;
       	        strcpy (o_df.type,"CHANNEL") ;
		o_df.f[N] = 1.0 * nu_filters;

		gs_o_df_head(out_file,&o_df);

                strcpy(o_df.name ,"FILTER_BANK") ;
	        if (!vox_file_out)
	        strcpy(o_df.dtype,"float");
		else
	        strcpy(o_df.dtype,"short");
      	        strcpy(o_df.dfile,"@");

      		o_df.f[SF] = sf;
      		o_df.f[FS] = 1.0 / sf;
      		o_df.f[FL] = 1.0 / sf;
		o_df.f[SOD] = 0.0;
      		o_df.f[N] = 1.0 * nsamples;
      		o_df.f[LL] = i_chn[0].f[LL]; /* 12 bit da range default */
      		o_df.f[UL]= i_chn[0].f[UL];

	/* write out headers */
/* all channels are same except for tag so write first only */

		o_df.f[CN] = (float) (nu_filters - 1);
        	sprintf(tag,"%f",o_df.f[CN]);
		strcpy(o_df.name,tag);
		gs_w_chn_head(&o_df);
/*   write each channel head */
	posn = gs_pad_header(o_df.fp);

/*    FILTER					     */

    if (debug > 1)     
      gs_time_ticks(time,0.1,1);

/*      Convolver routine for fir filter operation */
/*	should read in a block of at least 512 pts */

	Opbufsize = size;

	dbprintf(1,"size %d Opbufsize %d\n",size,Opbufsize);
        out_vec_ptr = Out_vec;

       j = 0;
       n = Opbufsize;
       more_input = 1;
       last_sample_read = -1;

if (!delay) {
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          last_sample_read += n;

	    aprv = maplodfv (In_buf, 4, Data, 1, size);
	    mapbwaitpkt (aprv);
            aprv = mapmulfsv (Scalep, Data, 1, Data, 1, size);

      	 new_sample += Opbufsize;
	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,Opbufsize);
}




       while ( more_input) {


/* READ INPUT DATA */

          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          last_sample_read += n;


/*	  printf("lsr %d\n",last_sample_read); */

	  if ( eof <= 0)  {

	  dbprintf(1,"END_OF_FILE\n"); 

	  for ( k = j + eof ; k < j+n ; k++)
	  In_buf[k] = 0.0;
	  more_input = 0;
	  }


        in_vec_ptr = Data;
	filter_ptr = Coeff;

/*            Load in values into AP */
/*
	if (delay) {
	    aprv = maplodfv (In_buf, 4, Data+size/2, 1, size);
	    mapbwaitpkt (aprv);
	    aprv = mapmulfsv (Scalep, Data+size/2, 1, Data+size/2, 1, size);
            mapsync (aprv);
	    delay = 0;
	    }
        else
	    {
*/
	    aprv = maplodfv (In_buf, 4, Data+size, 1, size);
	    mapbwaitpkt (aprv);
            aprv = mapmulfsv (Scalep, Data+size, 1, Data+size, 1, size);
/* } */

/*
 *     for each filter obtain  output value 
 *     by calculating  DOT PRODUCT of filter coefficient vector 
 *     and input time vector	
 */

     for ( j = 0; j < size ;  j++ ) {

	    for ( i = 0; i < nu_filters ; i++ ) {

              aprv = mapdotfv (in_vec_ptr, 1, filter_ptr, 1, out_vec_ptr, size);

/*
	       aprv= mapcopfv(out_vec_ptr,1,in_vec_ptr,1,1);
 */ 
             mapsync (aprv);
	      filter_ptr += size;
	      out_vec_ptr++;
		}

	/* write filter output sample value */

	/*   buffer Out_vec to suitable size before writing */

	if ((out_vec_ptr-Out_vec) >= Opbufsize) {
    /*  mapsync( aprv) ; */

	afb_op(o_df.fp,(out_vec_ptr-Out_vec));
        out_vec_ptr = Out_vec;
	bufnu++;
        }

/*	update input vector  ptrs   */
	filter_ptr = Coeff;
	in_vec_ptr ++;       

	}

        in_vec_ptr = Data;

/*	      swop buffers       */
        mapsync (aprv);
	aprv= mapcopfv(Data+size,1,Data,1,size);
   	mapsync (aprv);

	if (debug > 1) {
		npts += size;
	        time = (float) npts / sf;
		if (gs_time_ticks(time,0.1,0))
		dbprintf(1,"npts %d time %f\n",npts,time);
        	}

      	 new_sample += Opbufsize;
	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,Opbufsize);

	}  /*   finished ?  */

/*	flush output buffer */

	n= out_vec_ptr-Out_vec;

	if(n > 0)
        afb_op(o_df.fp,n);

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);


   /* release VA */
   mapfreeva(-1);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


	dbprintf(1,"%s FINISHED \n",argv[0]);

}


/***************/
/*Initialise AP*/
/***************/
firinit (size,nu_filters)
int   size,nu_filters;
{
	int ap_end;
/* Set-up AP memory mapping */

   Rads   = 0;                  /* Radians pointer */
   Sine   = Rads   + size + 2;  /* Sine wave store */
   Cosine = Sine   + size + 2;  /* Cosine wave store */
   Dot1   = Cosine + size + 2;  /* real dot product results */
   Dot2   = Dot1          + 2;  /* Imaginary dot product results */

   Data    = 0;		 		/* Data */

   Out_vec = Data  + 3 * size + 2;      /* Output vector base pointer */

   Coeff   = Out_vec + OPBUFSIZE + 10;	/* Coefficients */



/* Initialise rounding strategy */

   aprv = maprndze ();

   mapsync (aprv);

/* initialise fir array */

   Scalep = Coeff + nu_filters * size  + 10;

    ap_end = Scalep + 2;


	if (ap_end > MAXAPADR-size)
	{
	  printf("AP/VA memory limit exceeded\n");
	  return (-1);
	}

   aprv = mapclrfv (Data, 1,2* size);
   mapsync (aprv);
   
   aprv = maplodfv (Scaleio, 4, Scalep, 1, 2);
   mapbwaitpkt (aprv);

   return(1);
}

afb_op(fp,npts)
FILE *fp;
{
	int i,var,j;

	   /* scale  results 	 */
	   idx = mapmulfsv (Scalep+1, Out_vec, 1, Out_vec, 1, npts);
	   mapsync (idx);
	    if (!vox_file_out) {
	    var = mapstrfv (Out_vec, 1,Fil_bank_op,4,npts);
	    mapbwaitpkt (var);
	    fwrite(Fil_bank_op, npts, sizeof(float),fp);
	    }
	    else {
		var= mapcvtfiv(Out_vec,1,Out_vec,1, npts);
   		mapsync (var);
	        var = mapstrwv (Out_vec, 1, Fil_bank_vox, 2, npts);
	        mapbwaitpkt (var);
	    	fwrite(Fil_bank_vox, npts, sizeof(short),fp);
	    }
}

gs_time_ticks(time,tick,reset)

float time, tick;

{
	static float last_time = 0.0;
	if (reset) 
	last_time = 0.0;
	if ((time - last_time) > tick) {
	last_time += tick;
	return(1);
	}
	else
	return(0);
}


gs_load_calibrate(coef_infile,window_type,resfile,Rflg,filter_size)
char coef_infile[],resfile[],window_type[];  
int *filter_size;
{
int nu_filters;	
int size,posn;
frame o_fr,i_co;
int i,j,ii,jj;
float sf;
int k,vap, filt_coef_nu;

        i = gs_open_frame_file (coef_infile, &i_co);

	if ( i == -1)  exit(-1);

      nu_filters = i_co.f[N];
      size = i_co.f[VL];
      *filter_size = size;


	sf = i_co.f[SF];


	dbprintf(2,"load & calib size %d %f\n",size,sf);
/***************************************************/
/* Test design of filter (if design test flag set) */
/***************************************************/


   if (Rflg == 1) {
	gs_init_df(&o_fr);
	o_fr.f[N] = 1.0;
             strcpy (o_fr.source, "FIR_FRQ_RESP");      
             strcpy (o_fr.name, "FIR_FRQ_RESP");            
             strcpy (o_fr.type, "FRAME");                         
        gs_o_df_head(resfile,  &o_fr);
      	o_fr.f[VL] = 1.0 * size;
      	o_fr.f[FS] = 0.05;
      	o_fr.f[FL] = 2 * size / sf;
      	o_fr.f[LL] = -100.0;
      	o_fr.f[UL] = 20.0;
      	o_fr.f[BRK_VAL] = -100000.0;
      	o_fr.f[SF] = sf;
      	o_fr.f[MX] = sf / 2.0;
	o_fr.f[N] = (float) nu_filters;      	
      	strcpy (o_fr.x_d, "Frequency_(Hz)");
      	strcpy (o_fr.y_d, "amplitude_(dB)");
     	     gs_w_frm_head(&o_fr);
	   posn = gs_pad_header(o_fr.fp);   
	} 

/* Open fir filter response file */

	nu_filters = (int) i_co.f[N];

	if ( firinit (size,nu_filters) == -1) {
		printf("Not enough memory\n");
		exit(-1);
	}


      size = (int) i_co.f[VL];
      filt_coef_nu = Coeff;

      for (i = 0; i < nu_filters; i++ ) {
      		gs_read_frame (&i_co,imag);

/*
		for (j= 0; j < size; j += 4)
		printf("%d %f\n",j,imag[j]);
*/

/* 	Apply  weighting                     */

	if (i == 0 )
	        gs_window(window_type,size,Window);
		for (j = 0; j < size ; j++ )
			imag[j] = imag[j] * Window[j];


/*  place in AP vm      */


	dbprintf(2,"loading filter coef %d into AP %d\n",i,filt_coef_nu);
	aprv = maplodfv(imag,4,filt_coef_nu,1,size);

/*	mapbwaitpkt(aprv);	*/

	filt_coef_nu += size;
      }


   if (Rflg) {

      		filt_coef_nu = Coeff;

	
      	for (jj = 0; jj < nu_filters; jj++) {
        		for (i = 0; i < size; i++) {
				/* Calculate Radians */
          		for (ss = cc = 0.0, ii = 0; ii < size; ii++)
	      		rad[ii] = ((float) (ii * i) * pi2) / (float) (2 * size);
				/* AP Load radians for sin-cos calculation */
	    		idx = maplodfv (&rad[0], 4, Rads, 1, size);
	    		mapbwaitpkt (idx);
	    		idx = mapsincosfv (Rads, 1, Sine, 1, Cosine, 1, size);
	    		idx = mapdotfv (Sine, 1, filt_coef_nu, 1, Dot1, size);
	    		idx = mapdotfv (Cosine, 1, filt_coef_nu, 1, Dot2, size);
	    		mapsync (idx);
	    		idx = mapstrfv (Dot1, 1, &ss, 4, 1);
	    		mapbwaitpkt (idx);
	    		idx = mapstrfv (Dot2, 1, &cc, 4, 1);
	    		mapbwaitpkt (idx);

  	   		ss = ss * ss + cc * cc;
	   		if (ss < MIN_VAL)
	      		ss = MIN_VAL;
	   		real[i] = 10.0 * log10 (ss);
          		}
/* Write response into file and increment coefficent array pointer */


	dbprintf(2,"res fr %d %f\n",jj,real[0]);
        gs_write_frame ( &o_fr,real);


        dbprintf (2," Calibrated channel %d coefficient pointer %d\n", 
                                jj, filt_coef_nu);
        filt_coef_nu += size;

        }
     }

   if (Rflg) 
	    gs_close_frame (  &o_fr);
            return(nu_filters);

}



sho_use ()
{
printf("-d :design file containing auditory filter bank frequency responses\n");
printf("-l :lower channel to use default use first channel in design file:\n");
printf("-u :upper channel to use default use last channel in design file\n");
printf("-r :if ON the save frequency response of each filter to file\n");
printf("-w :type of window used in filter\n");
printf("-t :type of  filter e.g. low_pass high_pass band_pass band_stop\n");
printf("-L :if -t option specifies lower cut-off frequency\n");
printf("-U :if -t option specifies upper cut-off frequency\n");
printf("-s :resolution of filter power of 2 default 9\n");
printf("-c :coefficient input file name\n");
printf("-C :coefficient output file name\n");
printf("-I :input scaling factor:\n");
printf("-O :output scaling factor:\n");
printf("-i :input filename:\n");
printf("-o :output filename:\n");
printf("-N : no filtering use if only filter coefficients required\n");
	exit(-1);
}


