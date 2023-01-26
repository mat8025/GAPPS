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
#include "df.h"
#include "sp.h"

/*Define default constants */

#define DEF_SIZE    9
#define MINVAL      10.0e-11
#define CONST 0.7237
#define MAXAPADR 124000
#define FORWARD 1
#define INVERSE -1
#define OPBUFSIZE 512 

int   Data, Coeff, Out_vec, Dot1, Dot2, dot_var,var, idx, cstride ;
int   in_vec_ptr,out_vec_ptr,filter_ptr;
int   Opbufsize;
int   Src,Tmp,Result,Ctab, Sv,Pwr2;

short Sbuf[1024];
short	 Fil_bank_vox[1024];
float    Fil_bank_op[1024];
float    Fbuf[1024];
float    Va[MAXAPADR];
float    sample, real[1024], imag[1024], rad[1024];
float    pi2 = 6.283185307;
float    I0pi2 = 1.0;
float	 Scale = 1.0;
float    ss, cc;
double   pow(),sin (), cos (), log (), log10 ();
double   WF,BB,ERROR;

main (argc, argv)
int   argc;
char *argv[];
{
   int   i, ii,k, j, jj,ns, n, size,ob_size;
   int   Dflg=0,F_type_flg=0,  Rflg = 0,Cflg = 0,Iflg = 0,Oflg = 0,number,f;
   int   APflg, Wflg = 0;
   int   shift, bytes;
   float   sampler = 0.0 ;
   float start_time, time;
   int nsamples,nu_chn,filt_coef_nu,start_bytes;
   int more_input;
   int nbnks =1;
   int nbnk;
   int delay = 0;
   int init = 1;
   int st_offset;
   int vap;

   int track,sdt_in;
   int sam_ptr;
   int rbytes;
   int u_chn;
   int l_chn ;
   int   write_mt_out = 1;
   int   infd, outfd, desfl, resfl;
   int   do_filter = 1;
   int   coef_in = 0, coef_out = 0;
   int   c_in, c_out;
   int npts;

   float chn_min,chn_max,chn_inc;
   char tag[16];
   char *infile, *outfile;
   char *window_type;
   char *coef_infile, *coef_outfile;
   char *desfile, *resfile;
   short iodata;

/* Header structures */

   static struct fileheader   i_fh,o_vox_fh,i_fr_fh,o_fb_fh,o_co_fh;
   static struct sampleheader i_sh;
   static struct trackheader i_th,o_fb_th;
   static struct sdtheader i_fr_th,i_co_th,o_co_th,otr,i_sdth;
   static struct sampledescriptor   i_sd[1];
   static struct sampledescriptor   o_sd[1];
   static struct trackdescriptor   i_tds,o_fb_tds;

/* If command line size out-of bounds sho usage*/

   if (argc < MINCOMM ) {
        fprintf (stderr, "Usage [-d -w -V  -i -o]:\n");
	fprintf(stderr,"-d frequency response design filename\n");
	fprintf(stderr,"-c impulse response   design filename\n");	
	fprintf(stderr,"-w smoothing window e.g. Hanning\n");
	fprintf(stderr,"-V produce Vox file integer data\n");
   }

/* process command line for specifications */

   for (i = 1 ; i <= argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	      case 'd':
		  desfile = argv[++i];
		  Dflg = 1;
		  break;

	       case 'i': 
		  Iflg = 1;
                  infile = argv[++i];
		  break;
	       case 'o': 
		  Oflg = 1;
                  outfile = argv[++i];
		  break;

	       case 'c': 
		  coef_infile = argv[++i];
		  coef_in = 1;
		  break;

	       case  'D':
		  delay = 1;
		  break;

	       case 'C': 
		  coef_outfile = argv[++i];
		  coef_out = 1;
		  break;

               case 'V':
		   write_mt_out = 0;
		   break;
	       case 'w': 
		  window_type = argv[++i];
		  break;

	       default: 
		  fprintf (stderr, "illegal option %s %s\n",argv[--i],argv[++i]);
		break;
	    }
	    break;
      }
   }


/* set default flags */

	if (!coef_out) 
	    coef_outfile= "pifb_fir.cof";

/* Open sampled data files */
      if (Iflg){
        printf ("Opening input files\n");
        if ((infd = open (infile, 0)) == -1) {
	   printf ("%s not found \n", infile);
	   close (infd);
  	   return (-1);
        }
/* Read headers from file */

        read (infd, &i_fh, sizeof (struct fileheader));

/* Test file for sampled data */

        if (i = strcmp (i_fh.filetype, SAMPLE) != 0) {

  	   printf ("%s: input file NOT sampled data\n", infile);
  	   printf ("%s: data_fmt\n ", i_fh.data_fmt);
		   track = 1;

	   if (i_fh.data_fmt == FLOAT) 
		printf("Float data\n");

		if (strcmp (i_fh.filetype, SDT) == 0) { 
		   sdt_in = 1;
          	   read (infd, &i_sdth, sizeof (struct sdtheader));
		   nu_chn = i_sdth.nchannels; 
		   sampler = i_sdth.sample_freq;
	           nsamples = i_sdth.tracklen;
     		   printf("track file no of pts %d sf %f \n ",nsamples,sampler);
		}
		else
		{
          	   read (infd, &i_th, sizeof (struct trackheader));
		   nu_chn= i_th.ntracks; 
		   sampler = (float) i_th.sample_freq;
          	   read (infd, &i_tds, sizeof (struct trackdescriptor));
		   l_chn = 0;
		   u_chn = nu_chn -1;
		   printf("l_chn %d u_chn %d\n",l_chn,u_chn);
		   nsamples = i_tds.tracklen;
     		   printf("track file no of pts %d sf %f \n ",nsamples,sampler);
		}
	}

	else {
        read (infd, &i_sh, sizeof (struct sampleheader));
        read (infd, &i_sd[0], sizeof (struct sampledescriptor));
          	     	   l_chn = 0;
		   u_chn = nu_chn -1;
		   printf("l_chn %d u_chn %d\n",l_chn,u_chn);
        nsamples = i_sd[0].chanlen;
        sampler = i_sh.sample_freq;
     	printf("Vox infile no of pts %d sf %f \n ",nsamples,sampler);
      }

     }


/* Set default if vox not selected */
      sampler = (sampler == 0.0) ? DEF_SAMPLER : sampler;

/*
 *           Read track file for filter specification 
 *        Open fir filter response file               
 *                     and                             
 *                    Create output  coefficient file 
 */
	if (Dflg) {

      printf ("Opening design  frequency response file\n");
      	if (gs_open_sdt_trk (&desfl, desfile, &i_fr_fh, &i_fr_th, 0) != 1)
	  return(-1);

      size = i_fr_th.nchannels;
      bytes = size * sizeof (float);

      printf(" resolution %d \n", size);

      o_co_th.nchannels = 2*size;
      o_co_th.frame_shift = i_fr_th.frame_shift;
      o_co_th.frame_length = 2 * size / sampler;
      o_co_th.dsp_dflts.lower_limit = -1.0;
      o_co_th.dsp_dflts.upper_limit = 1.0;
      o_co_th.dsp_dflts.hue = GREEN;
      o_co_th.dsp_dflts.linewidth = 1;
      o_co_th.dsp_dflts.plot_style = LINES;
      o_co_th.dsp_dflts.break_number = -100000.0;
      o_co_th.sample_freq = sampler;
      o_co_th.chn_max = 2 * size ;
      o_co_th.chn_min = 0.0;
      o_co_th.tracklen = nu_chn;
      strcpy (o_co_th.xdomain, "Time secs");
      strcpy (o_co_th.ydomain, "amplitude ");

/*
 * Open fir coef response file 
 * use default name if not supplied
 */

      gs_open_sdt_trk (&c_out,coef_outfile,&i_fr_fh,&o_co_th,1);

      printf("filter coefficent op file %d %s\n",c_out,coef_outfile);

      	init = 1;

	st_offset = l_chn * bytes;

	lseek (desfl, i_fr_fh.start_of_data + st_offset,0) ;

  for (i = l_chn; i <= u_chn; i++ ) {

/* Read filter response track */
/*
         printf("read %d\n",bytes);
  
*/
    	 if ((read (desfl, real, bytes)) == EOF) {
	 printf ("Error reading fir spec file\n");
	 close (desfl);
	 return (-1);
         }

/* Convert dbs to absolute values */

	gs_dB_abs(real,size);

/* reflect data */

	gs_reflect_array(real,size);

        ns = 2 * size;

        for (j=0;  j< ns; j++)

	imag[j] = 0.0;

/* Do  inverse fourier transform */

	gs_fft(real,imag,ns,1);

	init = 0;

/* Rearrange fir filter coefficients */

	gs_order_coef(real,imag,ns);

/*	write output to coeff file    */
      
        gs_write_trk (&c_out, imag,ns);
      
        }

        close (desfl);

        gs_close_sdt_trk (&c_out,coef_outfile,&i_fr_fh,&o_co_th);

}

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



   if (coef_in == 1) 
      i = gs_open_sdt_trk (&c_in, coef_infile, &i_fr_fh, &i_co_th, 0);
	else
      i = gs_open_sdt_trk (&c_in, coef_outfile, &i_fr_fh, &i_co_th, 0);

     if ( i == -1)  return(-1);

      nu_chn = i_co_th.tracklen;

/*	open output track file      */


      if ((outfd = creat (outfile, 0666)) == -1) {
	 printf ("%s cannot create file\n", outfile);
	 return (-1);
      }


		   	nu_chn = i_fr_th.tracklen;
			l_chn =0;
			u_chn = nu_chn -1;

		chn_max = i_fr_th.chn_max;
		chn_min = i_fr_fh.segid.start_time;
		chn_inc = i_co_th.frame_shift;


/* copy across some data from input to output headers */
		printf("chn_max %f %f %f\n",chn_max,chn_min,chn_inc);
  		strcpy (o_fb_fh.descr,"PFBANK");
  		strcpy (o_fb_fh.segid.name,i_fh.segid.name);
  		o_fb_fh.segid.start_time=i_fh.segid.start_time; 
  		o_fb_fh.segid.stop_time=i_fh.segid.stop_time; 
  		strcpy (o_fb_fh.hist_file,i_fh.hist_file);
  		strcpy (o_fb_fh.parent,i_fh.parent);

	        if (write_mt_out) {
  		o_fb_fh.start_of_data = sizeof(struct fileheader) +
		    	              sizeof(struct trackheader) +
    	              nu_chn * sizeof(struct trackdescriptor);

                strcpy(o_fb_fh.filetype ,"TFBANK") ;
	        o_fb_fh.data_fmt = FLOAT;
      		o_fb_th.ntracks = nu_chn;
      		o_fb_th.par_serial = PARALLEL;
      		o_fb_th.track_dimensions = Y_DIM;
      		o_fb_th.sample_freq = (int) sampler;
      		o_fb_th.frame_shift = 1.0 / sampler;
      		o_fb_th.frame_length = 1.0 / sampler;

      		o_fb_tds.tracklen = nsamples;
      		o_fb_tds.dsp_dflts.lower_limit= -100.0;
      		o_fb_tds.dsp_dflts.upper_limit= 100.0;
      		o_fb_tds.dsp_dflts.break_number = -100000.0;
      		o_fb_tds.dsp_dflts.plot_style = LINES;
      		o_fb_tds.dsp_dflts.linewidth = 1;
      		o_fb_tds.dsp_dflts.hue = GREEN;
	        }

		else {
	        /* alter input sample header and write out */
  	              o_fb_fh.start_of_data = sizeof(struct fileheader) +
    	              sizeof(struct sampleheader) +
    	              nu_chn * sizeof(struct sampledescriptor);
                	strcpy(o_fb_fh.filetype, i_fh.filetype );
	        	o_fb_fh.data_fmt = SHORT;
	                i_sh.nchannels = nu_chn;
	                i_sh.par_serial = PARALLEL;
      			o_sd[0].dsp_dflts.lower_limit = -100.0;
      			o_sd[0].dsp_dflts.upper_limit = 100.0;
      			o_sd[0].dsp_dflts.hue = GREEN;
      			o_sd[0].dsp_dflts.linewidth = 1;
      			o_sd[0].dsp_dflts.plot_style = LINES;
      			o_sd[0].dsp_dflts.break_number = -100000.0;
		}


	/* write out headers */

  	write (outfd,&o_fb_fh,sizeof(struct fileheader));

       if (write_mt_out) {
  		write (outfd,&o_fb_th,sizeof(struct trackheader));
  		for (i = 0; i < nu_chn; i++) {
        	sprintf(tag,"%f",i*chn_inc + chn_min);
		strcpy(o_fb_tds.descr,tag);
  		write (outfd,&o_fb_tds,sizeof(struct trackdescriptor));
	        }
	     }
	     else
		{
  		write (outfd,&i_sh,sizeof(struct sampleheader));
		        o_sd[0].chanlen = i_sd[0].chanlen;
		        o_sd[0].nbits   = i_sd[0].nbits  ;
		        o_sd[0].aacutoff = i_sd[0].aacutoff ;
  			for (i = 0; i < nu_chn; i++) {
        		sprintf(tag,"%d",i+l_chn);
			strcpy(o_sd[0].descr,tag);
  			write (outfd,&o_sd[0],sizeof(struct sampledescriptor));
	        	}
	       }

		nu_chn = i_co_th.tracklen;
      		size = i_co_th.nchannels;
		bytes = size * sizeof (float);

		while ( firinit (size,nu_chn) == -1) {
			nbnks = nbnks * 2;
                	nu_chn = i_co_th.tracklen / nbnks ;
		}

      Opbufsize = nu_chn;
      fprintf (stderr, "nbanks %d nchannel=%d \n",nbnks,nu_chn);

      for (nbnk = 1; nbnk <= nbnks ; nbnk++) {
      
      gs_time_ticks(time,0.1,1);

     
      fprintf (stderr, "nbanks %d nchannel=%d  bytes=%d size %d\n",nbnks,
                      nu_chn,  bytes,size);
      if (nbnk > 1) {
		firinit (size,nu_chn);
		 Opbufsize = nu_chn;
		}

      filt_coef_nu = Coeff;

      for (i = 0; i < nu_chn; i++) {

        read (c_in, imag, bytes);

	/* 	Apply  weighting      */
        gs_smooth_array(imag, size, window_type);
    
	/*  place in AP vm      */


	if (i == nu_chn-1)

	 printf("loading filter coef %d into VA %d\n",i,
			 	filt_coef_nu +(nbnk-1) * nu_chn);

	vap = filt_coef_nu ;

	for ( k = 0 ; k < size ; k++ ) 
		Va[vap + k] = imag[k];

	filt_coef_nu += size;

	}


/*      Convolver routine for fir filter operation */

/*      should read in a block of at least 512 pts */
	
        more_input = 1;

        out_vec_ptr = Out_vec;

        start_time = 0.0;
/*	
 * stride between sample points in different channels laid out in AP
 *
 */
	cstride = 2*size ;

	printf("size %d %d\n",size,cstride);

/*	seek start point in input file */

        start_bytes = (nbnk-1) * nu_chn * sizeof (float);

	rbytes = lseek(infd,(i_fh.start_of_data + start_bytes),0);

	printf(" start bytes, %d  %d \n",start_bytes,rbytes);

/*	seek start point in output file */

	rbytes = lseek(outfd,(o_fb_fh.start_of_data + start_bytes),0);

	printf(" op bytes, %d \n",rbytes);

        npts = 0;

	while (more_input) {	

	/*   Load in values into AP */
		
        	in_vec_ptr = Data;
		filter_ptr = Coeff;

   	for (i = 0 ; i < size ; i++ ) { 
		if (track)
	   	bytes = read(infd, Fbuf, sizeof(float)*nu_chn);
		else
	   	bytes = read(infd, Sbuf, sizeof(short)*nu_chn);
	   	        if (bytes == 0) {
			more_input = 0;
			break;
			}

	if (nbnks > 1) {       
		if (track)
		bytes = lseek(infd, (nbnks-1) * sizeof(float)*nu_chn,1);
		else
		bytes = lseek(infd, (nbnks-1) * sizeof(short)*nu_chn,1);	
/*
		printf("nbnk %d %d\n",nbnk,bytes);
*/
		}

	if (delay) 
	   vap = i+ Data + (size/2);
	else
	   vap = i+ Data + size;
        delay = 0;
	    
/* could apply input scaling here if overflow */

	   if (track)	   
	   for (k = 0; k < nu_chn ; k++ ) 
	   	Va[vap+(k*cstride)] = Fbuf[k] ;
	   else
	   for (k = 0; k < nu_chn ; k++ ) 
	   	Va[vap+(k*cstride)] = (float) Sbuf[k] ;
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
/*
	      printf("%d %d %d %d\n",i,sam_ptr,filter_ptr,out_vec_ptr);
*/

	    Va[out_vec_ptr] = 0.0;

	    for ( k = 0; k < size ; k++) 

	      Va[out_vec_ptr] += (Va[sam_ptr +k] * Va[filter_ptr+k]);
/*
              dot_var = mapdotfv (sam_ptr, 1, filter_ptr, 1, out_vec_ptr, size);

*/

	      sam_ptr += cstride;

	      filter_ptr += size;
	      
	      out_vec_ptr++;

	    }

/* write filter output sample value */

/*   buffer Out_vec to suitable size before writing */

		if ((out_vec_ptr-Out_vec) == Opbufsize) {

		afb_op(write_mt_out,&outfd,Opbufsize,nbnk,nbnks);

        	out_vec_ptr = Out_vec;
		}

/*	update input vector  ptrs   */

	filter_ptr = Coeff;

	in_vec_ptr++;       

	}

        in_vec_ptr = Data;

/*	      swop buffers       */

	for (i =0 ; i < nu_chn ; i++ ) {
/*
	var= mapcopfv(Data+(i*cstride)+size,1,Data+(i*cstride),1,size);
*/
	vap = Data + (i*cstride) ;

	for ( k = 0 ; k < size ; k++ )
		Va[vap+k] = Va[vap+size+k];

	}

	npts += size;

        time = (float) npts / sampler;

	if (gs_time_ticks(time,0.1,0))

		printf("npts %d time %f\n",npts,time);
	}  

/*   finished ?  */

/*	flush output buffer */

	n = out_vec_ptr-Out_vec;

	printf("%d bank FINISHED rewinding\n",nbnk);

	if(n > 0) {

        afb_op(write_mt_out,&outfd,n,nbnk,nbnks);
	}	

        } /* nbnks finished ? */

        close (infd);
        close (outfd);
        close (c_in);

	printf(" PIFB  FINISHED \n");
}


/***************/
/*Initialise AP*/
/***************/


firinit (size,nu_chn)
int   size,nu_chn;
{
	int ap_end,vap,k;

/* Set-up AP memory mapping */

   Data    = 0;		 		/* Data */

   Out_vec = Data    + (size*nu_chn*2)  + 2;      /* Output vector base pointer */

   Coeff   = Out_vec + OPBUFSIZE + 10;	/* Coefficients */

/* initialise fir array */

   ap_end = Coeff + nu_chn *size;

	if (ap_end > MAXAPADR-size)
	{
	  printf("VA array memory limit exceeded\n");
	  return (-1);
	}

	vap = Data;
	
	for (k = 0 ; k < (2*size); k++ ) 
	Va[vap+k] = 0.0;

   printf("fir init ok\n");

   return(1);
}

afb_op(sdt,fd,npts,nbnk,nbnks)

int sdt,*fd,npts;
{
	int i,var,k;

	   /* scale  results 	 */

	if (sdt) {

	    for (k = 0; k < npts; k++)

	    Fil_bank_op[k] = Va[Out_vec +k];

	    if (nbnk ==1)
	    for (i = 0 ; i< nbnks ;i++)

	    gs_write_trk(fd,Fil_bank_op, npts);

	    else {

    	    gs_write_trk(fd,Fil_bank_op, npts);

	    lseek(*fd,(nbnks-1) *sizeof(float)*npts,1);

	    }
	    
	    }
	    else
	    {
	    /*	output to vox file     */

 	
	    for (k = 0; k < npts; k++)
	    Fil_bank_vox[k] = (short) (  Va[Out_vec +k]);
	    
  	    if (nbnk ==1)

	    for (i = 0 ; i< nbnks ;i++)

	    write(*fd,Fil_bank_vox, npts* sizeof(short));

	    else {

	    write(*fd,Fil_bank_vox, npts* sizeof(short));

	    lseek(*fd,(nbnks-1) *sizeof(short)*npts,1);
	    }

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
