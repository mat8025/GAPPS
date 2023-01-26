

/*
 	CNL
 
	Author 	Mark Terry & Steve Renals 1987
 
 	This program will take as input either a multichannel vox or
 	track file and compute a compressive non_linear function
 
 	output to a multi_chn vox or multi_chn track  file
 	usage:   cnl -i [vox|track] -o outfile
 	-r  multiplier [30.0]
 	-v  power      [0.33]
	-i  vox or trk file input
	-V  produce a Vox (short int) ouptu file
	-o  trk (default) or Vox file

	AP version
 */

#include <gasp-conf.h>

#include <stdio.h>
#include <aplib.h>
#include "df.h"
#include "color.h"

/*Define default constants */

#define DEF_SAMPLER 16000.0
#define MINCOMM 6 

short Sbuf[2048];
int Vox;
float Rms[512];
float Fbuf[2048];
float    Pi2 = 6.283185307;

static float zero = 0.0;
static float r = 20.0;
static float v = 0.33;

static int va_array, va_abs, va_tmp0, va_tmp1, va_r, va_v, va_zero;

double   pow(),sin (), cos (), log (), log10 ();


main (argc, argv)
int   argc;
char *argv[];
{

   void init_va();
   void am_nonl();
   int var;   
   int   i, k, j,  n, size,ob_size;
   int nspec,npts,eof;
   int nu_chn,nsamples,outfd,infd;
   int rbytes,nbytes,shfbytes,shfpts;
   int brk_flag, dat_size;
   int track = 0;
   int Oflg= 0;
   int Iflg= 0;
   int write_mt_out = 1.0;
   int l_chn;
   int u_chn;
   float min = 0.0;
   float max = 1.0;
   float sampler;
   char tag[4];
   char *infile, *outfile;
   short iodata;


/* Header structures */
   static struct fileheader   o_fh,i_fh;
   static struct sampleheader i_sh;
   static struct trackheader i_th,o_th;
   static struct sampledescriptor   i_sd[1],o_sd[1];
   static struct trackdescriptor i_tds, o_tds;


/* If command line size out-of bounds sho usage*/

   if (argc < MINCOMM ) {
      fprintf (stderr, "-i [vox|track]  -o outfile\n");
      fprintf (stderr, "-V vox output file\n");
      fprintf (stderr, "-r multiplier\n");      
      fprintf (stderr, "-v power\n");
   }

   Vox = 0;


/* process command line for specifications */

   for (i = 1 ; i <= argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'r':
		  r = atof(argv[++i]);
		  break;
	       case 'v':
		  v  = atof(argv[++i]);
		  break;
	       case 'V':
		  write_mt_out = 0;
	       	  Vox = 1;
	       	  break;
	       case 'i': 
		  Iflg = 1;
                  infile = argv[++i];
		  break;
	       case 'o': 
		  Oflg = 1;
                  outfile = argv[++i];
		  break;
	       default: 
		  fprintf (stderr, "illegal options\n");
		  return (-1);
	    }
	    break;
      }
   }


/* Get and lock VA (if available) */

	while (var = gs_apget () == -1) {
		printf(" %s sleeping  %d\n", argv[0],var);
		sleep(20);
	}

	printf ("%s in progress \n",argv[0]);

/* set default flags */

	if(Iflg !=  1 || Oflg != 1) {
	  fprintf (stderr, "please specify both input and output files\n");
		  return(-1);
	}

/*	create output vox or track file */
      if ((outfd = creat (outfile, 0666)) == -1) {
	 printf ("%s cannot create file\n", outfile);
	 return (-1);
      }

/*	open input file determine vox or track and number of channels   */


/* Open sampled data files */

        printf ("Opening input file\n");

        if ((infd = open (infile, 0)) == -1) {
	   printf ("%s not found \n", infile);
	   close (infd);
  	   return (-1);
        }

/* Read headers from file */
        read (infd, &i_fh, sizeof (struct fileheader));
/*	is it vox or trk ? */


/* Test file for sampled data */
        if (i = strcmp (i_fh.filetype, SAMPLE) == 0) 
		track = 0;
	else {
  	   printf ("%s: input file NOT sampled data\n", infile);

        if (i_fh.data_fmt != FLOAT)  {
  	   printf ("%s: input file NOT float data\n", infile);
	   return(-1);
	   }
	   else
	   track = 1;
        }



	if (track) {
	read (infd, &i_th, sizeof (struct trackheader));
	nu_chn = i_th.ntracks ;
	read (infd, &i_tds, sizeof (struct trackdescriptor));
	nsamples = i_tds.tracklen;

	}
	else {
        read (infd, &i_sh, sizeof (struct sampleheader));
	nu_chn = i_sh.nchannels;
        read (infd, &i_sd[0], sizeof (struct sampledescriptor));
  	nsamples = i_sd[0].chanlen;
        }

        printf("nu of channels %d\n",nu_chn);
        printf("nu of samples  %d\n",nsamples);
	l_chn = 0;
	u_chn = nu_chn -1;
        printf("l_chn %d u_chn %d\n",l_chn,u_chn);
/* copy across some data from input to output headers */

		if (track)
			sampler = (float) i_th.sample_freq;
			else
			sampler = (float) i_sh.sample_freq;
  		strcpy(o_fh.segid.name, i_fh.segid.name); 
  		o_fh.segid.start_time = i_fh.segid.start_time; 
  		o_fh.segid.stop_time = i_fh.segid.stop_time ; 


	        if (write_mt_out) {

  		o_fh.start_of_data = sizeof(struct fileheader) +
    	              sizeof(struct trackheader) +
    	              nu_chn * sizeof(struct trackdescriptor);

                strcpy(o_fh.filetype ,"TFBCNL") ;

                strcpy(o_fh.descr ,"CNL") ;
	        o_fh.data_fmt = FLOAT;
  		write (outfd,&o_fh,sizeof(struct fileheader));

      		o_th.ntracks = nu_chn;
      		o_th.par_serial = PARALLEL;
      		o_th.track_dimensions = Y_DIM;
      		o_th.sample_freq = (int) sampler;
      		o_th.frame_shift = 1.0/sampler;
      		o_th.frame_length = 1.0 / sampler;

      		o_tds.tracklen = nsamples;
      		o_tds.dsp_dflts.lower_limit= -2048.0;
      		o_tds.dsp_dflts.upper_limit= 2048.0;
      		o_tds.dsp_dflts.break_number = -100000.0;
      		o_tds.dsp_dflts.plot_style = LINES;
      		o_tds.dsp_dflts.linewidth = 1;
      		o_tds.dsp_dflts.hue = GREEN;

  		write (outfd,&o_th,sizeof(struct trackheader));

  		for (i = 0; i < nu_chn; i++) {
	      	sprintf(tag,"%d",i + l_chn);
		strcpy(o_tds.descr,tag);
  		write (outfd,&o_tds,sizeof(struct trackdescriptor));
	        }
	     }

	     else
		{

	        /* alter input sample header and write out */

  	              o_fh.start_of_data = sizeof(struct fileheader) +
    	              sizeof(struct sampleheader) +
    	              nu_chn * sizeof(struct sampledescriptor);

                	strcpy(o_fh.filetype, i_fh.filetype );

	        	o_fh.data_fmt = SHORT;
	                i_sh.nchannels = nu_chn;
	                i_sh.par_serial = PARALLEL;
      			o_sd[0].dsp_dflts.lower_limit = -2048.0;
      			o_sd[0].dsp_dflts.upper_limit = 2048.0;
      			o_sd[0].dsp_dflts.hue = GREEN;
      			o_sd[0].dsp_dflts.linewidth = 1;
      			o_sd[0].dsp_dflts.plot_style = LINES;
      			o_sd[0].dsp_dflts.break_number = -100000.0;

  		write (outfd,&o_fh,sizeof(struct fileheader));

  		write (outfd,&i_sh,sizeof(struct sampleheader));
		        o_sd[0].chanlen = i_sd[0].chanlen;
		        o_sd[0].nbits   = i_sd[0].nbits  ;
		        o_sd[0].aacutoff = i_sd[0].aacutoff;
  			for (i = 0; i < nu_chn; i++) {
        		sprintf(tag,"%d",i + l_chn);
			strcpy(o_sd[0].descr,tag);
  			write (outfd,&o_sd[0],sizeof(struct sampledescriptor));
	        	}
	       }

/*	main loop   */

	npts = 2048;

	if (track)
	        dat_size = sizeof(float);
	else
	        dat_size = sizeof(short);
        
	
	/* lseek to correct position in file */
	rbytes = lseek(infd,(i_fh.start_of_data ),0);

	n = 0;
	
	init_va(npts); /* uses r, v and zero */
	
	brk_flag = 0;
	
	while (1)  {

	/*	compute non_lin */

	if (track)	
		nbytes=read(infd,Fbuf, dat_size * npts);
	else 
		nbytes=read(infd,Sbuf, dat_size * npts);
	

	if (nbytes == 0) break;

	else if (nbytes < dat_size * npts) brk_flag = 1;

        am_nonl(npts); /* Data from and to Fbuf */

	/*	update max and min */

	if (Vox) {
	for (k=0 ;k < npts ; k++) 
        Sbuf[k] = (short) Fbuf[k];
	write(outfd,Sbuf,npts*sizeof(short));
	}
	else
	    write(outfd,Fbuf,npts*sizeof(float));
	
	if (brk_flag) break;
	

	}
		
	
	close(infd);
 	 close(outfd);

/*	release AP/VA */

	gs_aprel();

	printf("cnl finshed\n");
}



void am_nonl (npts)

/* puts input signal from first filter thru a non-linearity */
/* Data from and to Fbuf[]	*/
/* vth power non-linearity */
int npts;
{
        int i, idx;
	
        idx = maplodfv(Fbuf, 4, va_array, 1, npts);
	mapsyncmath(idx, VA0);
	
	mapnegfv(va_array, 1, va_tmp0, 1, npts);
	mapcxdfslt(va_array, 1, va_zero, va_tmp0, 1, va_array, 1, va_abs, 1,
								npts);
	/* va_abs <= abs(va_array)	*/
	
	maplogfv(va_abs, 1, va_tmp0, 1, npts);
	/* va_tmp0 <= ln(abs(va_array)	*/
	
	mapmulfsv(va_v, va_tmp0, 1, va_tmp1, 1, npts);
	/* va_tmp1 <= va_v * ln(abs(va_array)	*/
	
	mapexpfv(va_tmp1, 1, va_tmp0, 1, npts);
	/* va_tmp0 <= abs(va_array)^v	*/
	
	mapmulfsv(va_r, va_tmp0, 1, va_tmp1, 1, npts);
	/* va_tmp1 <= r*abs(va_array)^v	*/
	
	
	mapnegfv(va_tmp1, 1, va_tmp0, 1, npts);
	idx = mapcxdfslt(va_array, 1, va_zero, va_tmp0, 1, va_tmp1, 1,
							 va_abs, 1, npts);
	/* va_abs <= (sign(va_array))(r*abs(va_array)^v)	*/
	
	mapsyncdma(idx, VA0);
	mapstrfv(va_abs, 1, Fbuf, 4, npts);
	mapbwaitdma(VA0);
	
}



void init_va (npts)
int npts;
{

	
	va_array = mapmalloc(npts, 0, VA0);  /* Buffer Array  */
	va_abs   = mapmalloc(npts, 0, VA0);  /* Abs Buffer Array  */	
	va_tmp0  = mapmalloc(npts, 0, VA0);  /* Temp storage  */
	va_tmp1  = mapmalloc(npts, 0, VA0);  /* Temp storage  */
	va_r     = mapmalloc(1, 0, VA0);
	va_v	 = mapmalloc(1, 0, VA0);
	va_zero	 = mapmalloc(1, 0, VA0);	
	
	maplodfv(&zero, 4, va_zero, 1, 1);
        maplodfv(&r, 4, va_r, 1, 1);
        maplodfv(&v, 4, va_v, 1, 1);        
	mapbwaitdma(VA0);
}
