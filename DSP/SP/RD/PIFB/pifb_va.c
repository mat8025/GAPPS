/*************************************************************************************
 * 	PIFB 
	parallel input filter bank
  	Time-domain filtering
 
	Author:	Mark Terry 
 	Inputs:
	Multi_channel Vox file 
 	+
        file containing frequency responses of all filters
 	or
        file containing impulse response coefficients
 
 	Outputs:
 	Multi-channel Vox file containing filtered data
	or
 	Multi-channel file containing filtered data (float)
 
****************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "/usr/.attinclude/aplib.h"
#include "df.h"
#include "sp.h"

/*Define default constants */

#define DEF_SIZE    9
#define MINVAL      10.0e-11
#define CONST 0.7237
#define MAXAPADR 32000
#define OPBUFSIZE 512 
int   Rads, aprv,  Sine, Cosine;
int   Data, Coeff, Out_vec, Dot1, Dot2, dot_var,var, idx, cstride ;
int   in_vec_ptr,out_vec_ptr,filter_ptr;
int   Src,Tmp,Result,Ctab, Sv,Pwr2;

short	 Fil_bank_vox[1024];
float    Fil_bank_op[1024];
float    Fbuf[1024];
float    sample, real[1024], imag[1024], rad[1024];
float    pi2 = 6.283185307;
float    I0pi2 = 1.0;
float	 Scale = 1.0;
float    ss, cc;
double   pow(),sin (), cos (), log (), log10 ();




int Opbufsize;
int debug = 0;
float    In_buf[16384];
float    Window[1024];
int vox_file_out = 0;    

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;
   channel   i_chn[128];
   char sd_file[80];      

   int fposn,posn,nc;
   int pid ,fsize;   
   char date[120];
   char in_file[120];
   char out_file[120];

   int job_nu = 0;   
   char start_date[40];
   
   char data_type[20];
   int no_header = 0;
   int offset = 0;
     
   float  length;

   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read = -1;
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

   float start_time, time;
   float chn_min,chn_max,chn_inc;
   int filt_coef_nu;
   int more_input;
   int chn_set =0;
   int delay = 0;
   int init = 1;
   int st_offset;
   int nu_filters = 1;
   int nu_chn = 1;
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

   int   APflg, Wflg = 0;


   int sam_ptr;

   int filt_count =0;
   

   short iodata;

/* Header structures */
   static frame i_fr; /* frequency response of filter(s) */

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {


	       case 'w': 
		  strcpy(window_type,argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

               case 'V':
		   vox_file_out = 1;
		   break;

	      case 'd':
		  strcpy(desfile,argv[++i]);
		  Dflg = 1;
		  break;
	      case 'r':
		  strcpy(resfile,argv[++i]);
		  Rflg = 1;
		  break;


	       case 'C': 
		  strcpy( coef_outfile,argv[++i]);
		  coef_out = 1;
		  break;

	       case 'c': 
		  strcpy( coef_infile,argv[++i]);
		  coef_in = 1;
		  break;
	       case  'D':
		  delay = 1;
		  break;


	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	      case 'Y':
	      	  debug = atoi (argv[++i]);;
	      	  break;


	       default: 
		  fprintf (stderr, "illegal option %s %s\n",argv[--i],argv[++i]);
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



/* set default flags */

	if (!coef_out) 
	    strcpy (coef_outfile, "pifb_va.cof");




   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	printf("not AUDLAB header file\n");
   	exit(-1);
   	}
   }
   
   nc = 0;

   if ( (int) i_df.f[N] > 1) {
      if (debug > 1)
      printf ("There are %d channels;\n", (int) i_df.f[N]);
      nu_chn = (int) i_df.f[N];

   }
 
   length = i_df.f[STP] - i_df.f[STR];



   nsamples = (int) i_chn[0].f[N];
   if (debug > 1)
   printf("ns %d sf %f\n",nsamples,i_chn[0].f[SF]); 
   
   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   if (strcmp(i_chn[nc].dfile,"@") != 0) {
	if (debug > 1)
	printf("dfile %s\n",i_chn[nc].dfile);
	strcpy(sd_file,i_chn[nc].dfile);
	fclose(i_df.fp);
   	i_df.fp = fopen( sd_file,"r");
   	fseek (i_df.fp, fposn, 0); 
   }  

   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */

   
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


/*
 *           Read track file for filter specification 
 *        Open fir filter response file               
 *                     and                             
 *                    Create output  coefficient file 
 */

if (Dflg)  gs_d_filters(desfile,coef_outfile,sf,l_chn,u_chn);

/*
 *  Filter  vox file                     
 */

/*************************************************/
/*                set up output  file            */
/* write out as headers for  parallel track file */
/*************************************************/

/******************************************************/
/*                  Read coefficient file             */
/*  Read impulse response tracks to AP vector memory  */
/******************************************************/

  if (!coef_in)
    strcpy(coef_infile,coef_outfile);

   nu_filters = gs_load_calibrate(coef_infile,window_type,resfile,0,&size);


   if (!o_flag_set) 
       strcpy(out_file,"stdout");

	        strcpy (o_df.name,"PIFB") ;
       	        strcpy (o_df.type,"CHANNEL") ;

		o_df.f[N] = 1.0 * nu_filters;

		gs_o_df_head(out_file,&o_df);
                fprintf(o_df.fp,"%s\n",date);
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
      		o_df.f[LL] = -2048.0; /* 12 bit da range default */
      		o_df.f[UL]= 2048.0;

	/* write out headers */
/*   write each channel head */
  		for (i = 0; i < nu_filters; i++) {
		o_df.f[CN] = 1.0 * i;
        	sprintf(tag,"%f",o_df.f[CN]);
		strcpy(o_df.name,tag);
		gs_w_chn_head(&o_df);
	        }

	
	posn = gs_pad_header(o_df.fp);

        Opbufsize = nu_chn;


      gs_time_ticks(time,0.1,1);
    
/*      Convolver routine for fir filter operation */

/*	should read in a block of at least 512 pts */
	
        more_input = 1;

        out_vec_ptr = Out_vec;

        start_time = 0.0;
/*	
 * stride between sample points in different channels laid out in AP
 *
 */
	cstride = 2*size ;
	if (debug > 1)
	printf("size %d %d\n",size,cstride);

       j = 0;
       n = Opbufsize;
       more_input = 1;
        
        npts = 0;

	while (more_input) {	

	/*   Load in values into AP */
		
        	in_vec_ptr = Data;
		filter_ptr = Coeff;

   	for (i = 0 ; i < size ; i++ ) { 

          eof = read_m_chn(&i_chn[0],&In_buf[0],n);

	  if ( eof == 0)  {
	   more_input = 0;
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }
	
		if (delay) {
		    var = maplodfv (In_buf, 4,i+ Data+size/2, cstride, nu_chn);

		    }
	        	else
			var = maplodfv (In_buf, 4, i+Data+size, cstride, nu_chn);
  	        mapbwaitpkt (var);	
	}

     for ( j = 0; j < size ;  j++ ) {

/*
 *	each channel is dot_producted against respective
 *	filter
 *     for each filter obtain  output value 
 *     by calculating  dot product of filter coefficient vector 
 *     and input time vector	
 */

	    sam_ptr = in_vec_ptr;
             for ( i = 0; i < nu_chn ; i++ ) {
	      if (debug > 2)
	      printf("%d %d %d %d\n",i,sam_ptr,filter_ptr,out_vec_ptr);

              dot_var = mapdotfv (sam_ptr, 1, filter_ptr, 1, out_vec_ptr, size);

    	      mapsync (dot_var);	
	      sam_ptr += cstride;
	
	      filter_ptr += size;
	      
	      out_vec_ptr++;

	    }

/* write filter output sample value */


/*   buffer Out_vec to suitable size before writing */

		if ((out_vec_ptr-Out_vec) == Opbufsize) {

		afb_op(o_df.fp,Opbufsize);

        	out_vec_ptr = Out_vec;
		delay = 0;
		}

/*	update input vector  ptrs   */
	filter_ptr = Coeff;
	in_vec_ptr++;       
	}
        in_vec_ptr = Data;

/*	      swop buffers       */

	for (i =0 ; i < nu_chn ; i++ ) {
	if (debug > 2)
	printf("swap %d\n",i);
	var= mapcopfv(Data+(i*cstride)+size,1,Data+(i*cstride),1,size);
	}
   	mapsync (var);


	if (debug >= 1) {
		npts += size;
	        time = (float) npts / sf;
		if (gs_time_ticks(time,0.1,0))
		printf("npts %d time %f\n",npts,time);
        	}


	}  /*   finished ?  */

/*	flush output buffer */

	n = out_vec_ptr-Out_vec;
	
	if(n > 0) {
   	mapsync (var);
		afb_op(o_df.fp,Opbufsize);
	}	




   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   /* release VA */
   mapfreeva(-1);
   
   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


	if (debug)
	printf(" pifb  FINISHED \n");
}


/*****************/
/* Initialise AP */
/*****************/
firinit (size,nu_chn)
int   size,nu_chn;
{
   int ap_end;

/* Set-up AP memory mapping */

   Data    = 0;		 		/* Data */

   Out_vec = Data    + size*nu_chn*2  + 2;      /* Output vector base pointer */

   Coeff   = Out_vec + OPBUFSIZE  + 10;	/* Coefficients */

   ap_end = Coeff + nu_chn *size;

	if (ap_end > MAXAPADR)
	{
	  if(debug)
	  printf("ap memory limit exceeded\n");
	  return(-1);
	}

/* Initialise rounding strategy */

   var = maprndze ();
   mapsync (var);

/* initialise fir array */

   var = mapclrfv (Data, 1,2* size*nu_chn);
   mapsync (var);
if(debug)

   printf("fir init ok\n");
   return(1);
}

afb_op(fp,npts)
FILE *fp;
{
 int i,var,j;
	   /* scale  results 	 */

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

sho_use ()
{
        printf ( "Usage pifb [-d -w -V  -i -o]:\n");
	printf("-d frequency response design filename\n");
	printf("-D delay - produce minimal phase\n");	
	printf("-c impulse response   design filename\n");	
	printf("-w smoothing window e.g. Hanning\n");
	printf("-V produce Vox file integer data\n");
	exit(-1);
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
      if (debug >1)
	printf("size %d\n",size);
	sf = i_co.f[SF];
/***************************************************/
/* Test design of filter (if design test flag set) */
/***************************************************/


   if (Rflg == 1) {
	gs_init_df(&o_fr);
	o_fr.f[N] = 1.0;
             strcpy (o_fr.source, "FIR_filter_FRQ_RESP");      
             strcpy (o_fr.name, "FIR_filter_FRQ_RESP");            
             strcpy (o_fr.type, "FRAME");                         
        gs_o_df_head(resfile,  &o_fr);
      	o_fr.f[VL] = 1.0 * size;
      	o_fr.f[FS] = 0.05;
      	o_fr.f[FL] = 2 * size / sf;
      	o_fr.f[LL] = -100.0;
      	o_fr.f[UL] = 10.0;
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

	if (debug > 1)
		for (j= 0; j < size; j += 4)
		printf("%d %f\n",j,imag[j]);

/* 	Apply  weighting                     */

	if (i == 0 )
	        gs_window(window_type,size,Window);
		for (j = 0; j < size ; j++ )
			imag[j] = imag[j] * Window[j];


/*  place in AP vm      */

	if (debug > 1)
	printf("loading filter coef %d into AP %d\n",i,filt_coef_nu);
	aprv = maplodfv(imag,4,filt_coef_nu,1,size);

/*	mapbwaitpkt(aprv);	*/

	filt_coef_nu += size;
      }


   if (Rflg) {

      		filt_coef_nu = Coeff;
		      if (debug >1)
	      		printf("CALIBRATING FIR\n");
	
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

	if (debug > 1)
	printf("res fr %d %f\n",jj,real[0]);
        gs_write_frame ( &o_fr,real);

	if (debug)
        printf (" Calibrated channel %d coefficient pointer %d\n", 
                                jj, filt_coef_nu);
        filt_coef_nu += size;

        }
     }

   if (Rflg) 
	    gs_close_frame (  &o_fr);
            return(nu_filters);

}


