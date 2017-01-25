/*		INN
 * 		uses neural-network to anaylze intonation contour
 *		attempts to classify contour as a statement or query
 *		June 1993
 *		feed forward strictly layered
 *
 *              serial version of backpropagation
 *		Mark Terry  March 1988
 *
 *  		Implements a back-propagating neural network:
 *		Main program file
 *  Ref:		Rumelhart, Hinton and Williams, "Learning Internal 
 *		Representations", Ch. 8 in "Parallel Distributed   
 *		Processing", Vol. 1, Rumelhart & McClelland (eds.),
 *		MIT, 1986.					   
 *
 */


#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/* Network constants */

#define MAXCELLS 250
#define MAXWTCH 5000
#define MAXOCELLS 20
#define MAXOFEAT 22
#define MAXICELLS 220
#define MAXPAT 1400
#define ONTHRESHOLD 0.9
#define OFFTHRESHOLD 0.1
#define NETTHRESH 100
#define SPARE "Spare"
#define DISPLAY 1
#define SS 2


/* INPUT */

#define INVAL_MAX 100000.0
#define INVAL_MIN -100000.0

#define READ 0
#define WRITE 1
#define RW 2


/* NN structures	*/
struct nn_param
{
	int    sweeps;
	float  eta;
	float  alpha;
	float  theta;
	int    read_ss;
};


struct nn_num
{
	int in;

	int in_row;
	int out_row; /* in_row out_row are just for graphic display purposes 
			default value 1 */
	int bot_hid;	
	int top_hid; /* nu of nodes in top hidden layer */
	int out;
	int cells;
	int pats;
	int layers; /* maximum nu 4 */
	int conn; /* number of interconnections */
};


#define MAXCONN 10000

char program_name[256];

int OF[MAXOFEAT][3];

float Input[MAXPAT][MAXICELLS];  

float Target_vec[MAXPAT][MAXOFEAT];   

float Activity[MAXCELLS];

float weight[MAXWTCH];

float oldwt[MAXWTCH];

float wt_ch[MAXWTCH];

float delta[MAXCELLS];

float ave_wtch[MAXWTCH];


float squares;


int n_lf[4],n_ll[4],n_cl[4],n_ul[4],lw[4],uw[4];
int p_order[MAXPAT];

int stage[20];

struct nn_num num;
struct nn_param net = {3000, 0.5, 0.9, 0};

extern float activation(); 

int sweep = 0;
int debug = -1;
int hit_miss = 0;
float learn_level = 0.1;

float pc_level = 97.0;
float pc_old = 0.0;
float pc_incr = 0.0;
int random_pres = 0;
int cycle =1;
int n_stages =1;
FILE *fp;

main(argc,argv)
char **argv;
int argc;

{

	char *file;
	char filename[120];
	char *design_file;
	char *pat_file;
	char *target_file;		
	char *track_file;
	char *rss_file;
	char *wss_file;
	char *wtsfile;
	char *winfo_file;
			
	FILE *tfp;

	data_file o_df,o_chn;

	int  infd ;		/* Input net descriptor file	*/
	int  patfd;		/* Input pattern file		*/
	int  targfd;		/* Input pattern file		*/
	int  outfd;		/* Output track file		*/
	int  finish;
	int train;
	int targ_lim = 0;
	int wls = 0;
	int targets = 0;
	
	int  epoch =0;		/* wt change after each pattern */

	int  seed = 7;		/* my lucky number */
	int the_of; /* the output feature */

	char fname[120]; 
        int fposn,posn;
	int   p, j,k, sod,i,np,nc;   
	int track = 0;
	int trk_app = 0;
	int n_save_sweeps = 0;
	int n_error_sweeps = 5;	
	int end_pat,start_pat,class,n_pat;
	double sqrt();
	        
	float sumsq, sq, maxsquares,rms,pc;
	
   int job_nu = 0;   
   char start_date[40];	
/* DEFAULT SETTINS */


	net.alpha = 0.9;
	net.theta = 0.9;
	net.eta = 0.1;
	


	for (i = 0;  i < 20; i++)
		stage[i] = 0;

	for (i = 1; i < argc; i++) {
		switch (*argv[i])
		{      	
			case '-': 
			switch (*(argv[i] + 1)) 
			{

				case 'a': /* weight space momentum */
				  net.alpha = atof (argv[++i]);
				  break;

				case 'b': /* weight space momentum */
				  net.theta = atof (argv[++i]);
				  break;

				case 'e': /* learning rate */
				  net.eta = atof (argv[++i]);
				  break;

				case 'i': /* net descriptor filename */
				  design_file= argv[++i];
				  break;

				case 'I': /* info file name	*/
				  winfo_file = argv[++i];
				  break;

				case 'n': /* Num of sweeps	*/
				  net.sweeps = atoi(argv[++i]);
				  break;

				case 'p': /* pattern filename	*/

				  pat_file = argv[++i];

				  break;

				case 't':	

				  target_file = argv[++i];
				  targets = 1;
				  break;


				case 's': /* i/p saved state filename */

				  net.read_ss = 1;
				  rss_file = argv[++i];
				  break;

				case 'L':

				/* target 1 -> 0.9  target 0 -> 0.1 */	

				targ_lim = 1;
					break;
				case 'W':

				/*	weighted least squares */

				/* target 1 more important than other 0 value output nodes */
				wls = 1;

				break;

				case 'T':	/* track file name	*/

				  track_file = argv[++i];
				  track = 1;
				  break;

				case 'w':	/* o/p saved state filename */

				  wss_file = argv[++i];
				  break;

				case 'r': /* random seed */
					seed = atoi(argv[++i]);

					break;

				case 'E':
					epoch = atoi(argv[++i]);
					break;					


				case 'S': /* save wts after every x sweeps */
					n_save_sweeps = atoi(argv[++i]);
					break;

				case 'P': /* save wts after PC has increased by x % */
					pc_incr = atof(argv[++i]);
					break;
					

				case 'R': /* rms error report after x sweeps */
					n_error_sweeps = atoi (argv[++i]);
					break;


			       case 'J': 
	       			     job_nu = atoi( argv[++i]) ;
				     gs_get_date(start_date);
				      break;

				case 'H':
				case 'h':
					debug = HELP ;
					break;

				case 'Y':	/* Debugging mode	*/

				  debug = atoi(argv[++i]);
				  break;
				default: 

		     printf("%s: %s: illegal option\n", program_name, argv[0]);

				  break;
			}
			break;

		default: 
	          printf("%s: %s: illegal option\n", program_name, argv[0]);

		}
	}


   if (debug == HELP)
   	sho_use();

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }

   if ( debug >= 0)
   	debug_spm(argv[0],debug,job_nu) ;

	dbprintf(1,"BACKPROP RUNNING\n"); 


	dbprintf(1,"NET_PARAMS  a  %f b  %f  e %f\n",net.alpha,net.theta,net.eta);


	dbprintf(1,"TARGET LIMIT %d WLS %d\n",targ_lim,wls);
	
	if (n_save_sweeps > 0 && debug)
	dbprintf(1,"SAVING WTS every %d sweeps\n",n_save_sweeps);
	

	if (pc_incr > 0.0  && debug)
	printf("SAVING WTS every %f percentage correct increase\n",pc_incr);

/* set up arrays and net_design */

	get_design(design_file,&num);
	
	if (FPE )
	dbprintf(1,"get design\n");
	
	init_arrays(&net, &num, rss_file,  seed);

        if (FPE )
	dbprintf(1,"init_arrays\n");

	for (i = 0 ; i <= MAXOCELLS; i++) {
			OF[i][0] = 0;
			OF[i][1] = 0;	
        }

        if (!get_ip_pats(pat_file,&num,targets)) {
        	printf("error in pattern files\n");
        	exit(-1);
        }
        	
        if (FPE )
	dbprintf(0,"ip_pats\n");

	if (targets)
                get_targets (target_file);
     	
	if (targ_lim)
		limit_target(&num);

	maxsquares = 0.0;

	if (track)
	{     

	 gs_init_df(&o_df);
	 gs_init_df(&o_chn);
  
	o_df.f[STR] = 0.0;
	o_df.f[STP] = (float) net.sweeps ;   

	strcpy(o_df.name,"BKPR");
	strcpy(o_df.type,"CHANNEL"); 
	o_df.f[N] = 2.0 ;


   gs_o_df_head(track_file,&o_df);
			        /* write out headers for trackfile */
	
/*      write out ascii info */

/*      open channel file */
		     

			fprintf(o_df.fp,"net learning file\n");
			fprintf(o_df.fp,"start_of_data 0\n");
			fprintf(o_df.fp,"layers %d\n",num.layers);
			fprintf(o_df.fp,"in %d\n",num.in);
			fprintf(o_df.fp,"out %d\n",num.out);
			fprintf(o_df.fp,"bot_hid %d\n",num.bot_hid);
			fprintf(o_df.fp,"top_hid %d\n",num.top_hid);
			fprintf(o_df.fp,"pats %d\n",num.pats);
			fprintf(o_df.fp,"sweeps %d\n",net.sweeps);	
			fprintf(o_df.fp,"report_error %d\n",n_error_sweeps);	

   o_chn.fp = o_df.fp;
   o_chn.f[N] = (float) ( net.sweeps /n_error_sweeps );   
   strcpy(o_chn.dtype,"ascii");
   strcpy(o_chn.name,"RMS");
   o_chn.f[CN] = 0.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 1.0;   
   o_chn.f[FS] = (float) n_error_sweeps ;
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);

   o_chn.f[CN] = 1.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 100.0;   
   strcpy(o_chn.name,"PC");
   gs_w_chn_head(&o_chn);   

   posn = gs_pad_header(o_df.fp);

	}

	sod = 0;

	squares = 0.0;

	n_pat = stage[0];

	for (k = 0 ; k < num.pats; k++)
	     p_order[k] = k;
	     
	if (net.sweeps > 0) {
dbprintf(1,"training with n_pat %d pats %d cycle %d\n",n_pat,num.pats,cycle);
		train =1;
	} else
	{

		dbprintf(1,"recognition\n");
		train =0;
	}

	if ( train) {

		for (sweep = 1; sweep <= net.sweeps; sweep++)  {  /* begin sweeps loop */

	        FPE  = 0;		
		sumsq = 0.0;   
		np = 0;
		nc = 0;


	        if ( random_pres) {
	        shuffle(num.pats);

		for ( k = 0; k < num.pats; k++) {	        	
	        p = p_order[k];
	        net_sweep(p,&nc,&np,&num,&net,&sumsq,epoch,wls,train) ;
		} 

	        }
		else {
			for ( k = 0; k < n_pat; k++) {
			for ( class= 0 ; class < (num.pats / cycle) ; class++ ) {
			p = class * cycle + k;
		        net_sweep(p,&nc,&np,&num,&net,&sumsq,epoch,wls,train) ;
			}
 		  }
	        }

		if (epoch != 0)
			mk_ave_wtc(num.cells,num.pats,epoch,&net);
/*      		else
      			prt_big_wtc(num.cells); 
  */    
		sq = 0.5 * sumsq;


		dbprintf(1,"sweep %d pats %d nc %d\n",sweep,np,nc);

		if (sq > maxsquares)
			maxsquares = sq;

		rms = sqrt (sumsq/ (1.0 * np * num.out));
		pc = (nc / (float) np) * 100.0;
					
		if (  sweep % n_error_sweeps == 0 ) {
dbprintf(0,"sweep %d pats %d error %f rms %f pc %f\n",sweep,np,sq,rms, pc);
		fflush(stdout);
			if (track) {
				fprintf(o_df.fp,"%f %f\n",rms,pc);
				fflush(o_df.fp);
		        }
	               }

		if ( n_save_sweeps > 0 && sweep % n_save_sweeps == 0) {
			write_saved_state( wss_file,&num,sweep);
		}

		if ( pc_incr > 0.0 && ( pc > pc_old)  ) {
		dbprintf(1,"wts saved @sweep %d pats %d error %f rms %f pc %f\n",sweep,np,sq,rms, pc);
		write_saved_state( wss_file,&num,sweep);
		   while (pc_old < pc)
		   pc_old += pc_incr;
		}


		if (rms <= learn_level || pc > pc_level) {
			dbprintf(1,"learning criterion reached @ sweep %d\n",sweep);
			finish = add_tokens(&n_pat);
			if (finish) break;
		}
		
	}			

	/* End of sweeps loop */
   
		write_info(winfo_file, &num, &net);

		if(train)
		write_saved_state(wss_file,&num,sweep);

		dbprintf(1,"INN BACKPROP COMPLETED \n");    
     }

	else { /* recognition */

dbprintf(1,"TRYING TO RECOGNIZE \n");

		sumsq = 0.0;   

		np = 0;
		nc = 0;
	
		for ( p= 0 ; p < num.pats ; p++ ) {
       			run_net(p, &num,&net);
  		
 if (( (hit_miss = output_error(p,&net, &num, &squares,epoch,wls,num.layers-1,train))) == 1)
	nc++;	
	        
		the_of = (int) Target_vec[p][MAXOCELLS];

		OF[the_of][0] += 1;
		OF[the_of][1] += hit_miss;

dbprintf(0,"p %d correct %d type %d\n",p+1,hit_miss, the_of);


          		sumsq += squares;
		np++;
		}
	
		sq = 0.5 * sumsq;
		rms = sqrt (sumsq/ (1.0 * np * num.out));
		pc = (nc / (float) np) *100.0;


dbprintf(0,"recognize  pats %d error %f rms %f pc %4.2f\n",np, sq, rms, pc);

printf("RECOGNIZE  pats %d error %f rms %f pc %4.2f\n",np, sq, rms, pc);
		
		for (i = 0 ; i <= MAXOCELLS; i++) {
		if ( OF[i][0] > 0) {
			pc = ( OF[i][1]/ (float) OF[i][0]) * 100.0;
		printf("type %d np %d pc %f\n",i,OF[i][0], pc);
		}
	        }

			fflush(stdout);
		write_info(winfo_file, &num, &net);

	}



   if (track)
   gs_close_df(&o_df);
 

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

  }

sho_use()
{

	printf("backprop -i net_descriptor_file -p pattern_file -t target_file -a alpha -e eta\n");
	printf("  -b bias(theta) -T (rms,per_corr trk_file) \n");
	printf("  -n number_of_sweeps [-s use previous wts_state_file] -w wts_save_file\n");
	printf("  [-E epoch] -R sweeps (report rms %c after sweeps) [-W wtd least sqaures]\n");	
	printf("  [-L target 1 ->0.9 target 0 ->0.1 ] -S sweeps (save wts after sweeps) \n");		
	printf("  -I info_file ( save net state for each pattern) \n");			
	printf("  -r random number seed \n");				
	exit(-1);
}


init_arrays(net, num, rss_file ,seed)
struct nn_param *net;
struct nn_num *num;
char *rss_file;
{
	int rand();


	register int i, j;
   


	for (i = 0 ; i < MAXCELLS*20; ++i)       /* initialise network arrays */
		{
			weight[i] = 0.0;
			oldwt[i] = 0.0;
			wt_ch[i] = 0.0;
			ave_wtch[i] = 0.0;
		}
	
        				 
	srand(seed);

	if (num->layers == 4)
	num->conn = num->cells + (num->in * num->bot_hid) + (num->bot_hid * num->top_hid) + (num->top_hid
			* num->out);
	else		
	num->conn = num->cells + (num->in *num->bot_hid) + (num->bot_hid * num->out);

	if (net->read_ss == 1)
		read_saved_state(rss_file,num);
	else			

	for (i = 0; i < num->conn; ++i) 	 /* initialise weights  */ 
	{
		
		weight[i] = (((rand() % 120) / 200.0) -0.3);

		oldwt[i] = weight[i];
		
/*		printf("wt[%d] = %f\n",i,weight[i]);	 */
	}

	for (i = 0; i < num->cells; ++i) 
				delta[i] = 0.0;    

}


get_design(design_file, num)
char *design_file;
struct nn_num *num;
{   	
	int cell, pat, rsize;
	int nbytes = 1;
	int node[2];
	float input_val, targ;   
	int i;

	
	char lab_value[80];
	
/*	read & check net architecture */

	num->in =0;
	num->out =0;
	num->layers = 0;
	num->top_hid =0;
	num->bot_hid =0;
	num->pats =0 ;
	num->cells = 0;


	dbprintf(1,"df %s \n",design_file);
/*      read ascii net descriptor file and set up net */

	if ( !gs_nn_design(design_file, num))
		exit (-1);
	
        if (n_stages == 1) {
        stage[0] = cycle;	
        
        }


	dbprintf(1,"layers = %d \n",num->layers);
	dbprintf(1,"in = %d \n",num->in);
	dbprintf(1,"out = %d \n",num->out);
	dbprintf(1,"bot_hid = %d \n",num->bot_hid);
	dbprintf(1,"top_hid = %d \n",num->top_hid);
	dbprintf(1,"pats = %d \n",num->pats);

	dbprintf(1,"cycle = %d \n",cycle);
	dbprintf(1,"n_stages = %d \n",n_stages);
	dbprintf(1,"stage[0] = %d \n",stage[0]);
	dbprintf(1,"learn_level = %f \n",learn_level);
	dbprintf(1,"pc_level = %f \n",pc_level);

	num->cells = num->in + num->out + num->top_hid + num->bot_hid;

	for (i =0; i< num->layers; i++)
		get_node_num(i,&n_lf[i],&n_ll[i],&n_cl[i],&n_ul[i],&lw[i],&uw[i]);
   
	if (num->cells > MAXCELLS)
		error("Too many cells in network.\n");

}	


get_jo(l,nfdt,twcf,nftw,njf)

{
int offset =0;
int jitter;
int m ,k;



	m = njf * 2 + 1;	
	k = (l + njf) % m;
	jitter = k - njf;
	
        offset = nfdt - (twcf + nftw/2)  + jitter  ;


        dbprintf(1,"offset %d jitter %d\n",offset,jitter);

	return(offset);
}


compute_n_to_j(n_to_j, ntn,ntu)
int n_to_j[];
{
int ntmk;
int i,k,m;
	
	k = ntn / ntu;
	m = ntn % ntu;


         dbprintf(1,"ntn %d ntu %d k  %d m %d\n",ntn, ntu, k, m);

	for ( i =0 ; i < ntn ; i++)
	n_to_j[i] = k;
	
	for ( i =0 ; i < m ; i++)
	n_to_j[i] += 1;
		
	/* jitter tokens */
}


get_ip_pats(pat_name,num,targets)
char pat_name[];
struct nn_num *num;
{
FILE *fp;
float data[1024];
float input_val;
int eof;
int cell;
int k,kk;
int pat = 0;
/*****************************************************************
 *							         *
 * using an analysis file 					 *
 * build net input tokens 					 *
 *****************************************************************/


/* open file */

	if (( fp = fopen(pat_name,"r") ) == NULL)
		return (0);

	while (1) {

/* set net input */

	eof = fread(data,sizeof(float), num->in + 2 , fp);
	
	if (eof <=0) {
	dbprintf(1,"file error inout \n");	
	break;
	}

	cell = 0;

/* CHECK INPUT IS VALID  A NUMBER BETWEEN SAY */

	for (k = 0; k < num->in;  k++ ) {
		
		input_val = data[ k + 2];
		if (input_val < INVAL_MAX && input_val > INVAL_MIN)
		Input[pat][cell] = input_val;		
		else
		{
dbprintf(0,"pat %d inval out of range %f changed to 0\n",pat,input_val);
		Input[pat][cell] = 0.0;		
		}
	
		cell++;

	}

/* set net target */
/* each output cell represents different category */

	for (cell = num->out-1; cell >= 0; cell--) 
			Target_vec[pat][cell] = 0.0;
	
	cell = (int) data[0];

		Target_vec[pat][cell-1] = 1.0;
		Target_vec[pat][MAXOCELLS] = data[0];

	for (kk = num->out-1; kk >= 0; kk--) 
		dbprintf(1,"%2.0f ",Target_vec[pat][kk]);

	pat++;
		dbprintf(1,"\npat %d target %d\n",pat,cell);

	if (pat >= num->pats)
	break;

	}

	dbprintf(1,"using %d input tokens %d\n",num->pats,pat);

	return (1);
}


compute_targets(target,pat,num)
struct nn_num *num;
{
int cell;
int j;
/* octal number */

char b_n[60];

	strcpy(b_n,"\0");

	oct_bin	(target,b_n);

	for (cell = num->out-1; cell >= 0; cell--) 
			Target_vec[pat][cell] = 0.0;
			
	j = strlen(b_n);
	
	dbprintf(1,"%d %d %s \n",pat,target,b_n);

	for (cell = 0; cell < j; cell++) {
			if (strncmp(&b_n[cell],"0",1) == 0)
			Target_vec[pat][j-1-cell] = 0.0;
			else
			Target_vec[pat][j-1-cell] = 1.0;
		}

	for (cell = num->out-1; cell >= 0; cell--) 
	dbprintf(2,"%d %d %f\n",pat,cell,Target_vec[pat][cell]);

}


oct_bin(n,b_n)
char b_n[];
{
int i,k;

	if (n == 0) {
	strcat(b_n,"000");
	return;
        }

	while ( n > 0 ) {

		k = n - (n/10 *10);
		n = n /10 ;
		
		 switch (k) {
	
		 	case 0:
		 		strpre(b_n,"000");
		 		break;
		 	case 1:
	 			strpre(b_n,"001");
				break;

		 	case 2:
	 			strpre(b_n,"020");
				break;
		 	case 3:
	 			strpre(b_n,"011");
				break;
		 	case 4:
	 			strpre(b_n,"100");
				break;
		 	case 5:
	 			strpre(b_n,"101");
				break;
		 	case 6:
	 			strpre(b_n,"110");
				break;
		 	case 7:
	 			strpre(b_n,"111");
				break;				

			default:
	 			strpre(b_n,"XXX");
				break;
		}
      }

}


strpre(s1,s2)
char s1[];
char s2[];
{
/* put s2 at head of s1 */	
char tmp[1000];
	strcpy (tmp,s1);
	strcpy (s1,s2);
	strcat( s1,tmp);
}

get_targets()

{
/*
	for (cell = 0; cell < num->out; cell++)
		{				

			read(*targfd, &targ, sizeof(float));

		if( targ_lim) {
			if (targ > 0.9)
				targ = 0.9;
			if (targ < 0.1)
				targ = 0.1;				
			}		
		
			Target_vec[pat][cell] = targ;

		}

*/
}




read_saved_state(file,num)
char *file;
struct nn_num *num;
{
int ssfd;
float swp_no = 0.0;

		dbprintf(1,"read saved state\n");

				  if ((ssfd = open(file, READ)) == -1)
				  {
					printf("Cannot open %s \n", file);
					close(ssfd);
					exit(-1);
				  }


		read(ssfd, &weight[0], num->conn * sizeof(float));
		read(ssfd, &wt_ch[0], num->conn * sizeof(float));
	if (read(ssfd, &swp_no, 1.0 * sizeof(float) ) > 0) 
		dbprintf(0,"%s   %d",file, (int) swp_no);
		else
		dbprintf(0,"%s   -1",file);
		close(ssfd);
		return(1);
}

/* write wt_matrix & wt_chng  ? */

write_saved_state(file,num,sweep)
char *file;
struct nn_num *num;
{
int wtsfd;
static int j = 1;
char tag[10];
char filename[120];
float swp_no;

	swp_no = 1.0 * sweep;
		
	strcpy(filename,file);
	sprintf(tag,".%d",j);
	strcat(filename,tag);
	j++;
	
				if ((wtsfd = creat(filename, 0666)) == -1)
	        			{
	        			       printf("Cannot open %s \n",filename);
	        			       close(wtsfd);
		        		       exit(-1);
		        		}

		write(wtsfd, &weight[0], num->conn * sizeof(float));
		write(wtsfd, &wt_ch[0], num->conn * sizeof(float));
		write(wtsfd, &swp_no, 1 * sizeof(float));
		close(wtsfd);

		dbprintf(1,"saved wt matrix in %s\n",filename); 

}

/*  End of write_saved_state()  */

error( s ) 
char *s;
{
	fprintf( stderr, "%s error : %s\n", program_name, s );
	exit(-1);
}
                                    

write_info(file, num,net)
char *file;
struct nn_num *num;
struct nn_param *net;

{

	int p;
	int infofd;
	char lab_value[120];
	char string[120];
	int sod;
static int j = 1;
char tag[3];
char filename[120];
	
	strcpy(filename,file);

			infofd = creat(filename,0644);
			close(infofd);
			
     /* write out headers for info file*/

			fp = fopen(filename,"a");
			fprintf(fp,"START_HEADER\n");
			fprintf(fp,"net_state info file\n");
			fprintf(fp,"layers %d\n",num->layers);
			fprintf(fp,"in %d\n",num->in);
			fprintf(fp,"out %d\n",num->out);
			fprintf(fp,"bot_hid %d\n",num->bot_hid);
			fprintf(fp,"top_hid %d\n",num->top_hid);
			fprintf(fp,"pats %d\n",num->pats);
			fprintf(fp,"in_row %d\n",num->in_row);
			fprintf(fp,"out_row %d\n",num->out_row);
			fprintf(fp,"END_HEADER\n");
			sod = ftell(fp);
			fclose(fp);
			
/*
	sprintf(tag,".%d",j);
	strcat(filename,tag);
	j++;
*/				
			  if ((infofd = open(filename, 2)) == -1)
				  {
					printf("Cannot open %s \n", filename);
					close(infofd);
					exit(-1);
				  }

		lseek(infofd,sod,0);

		for ( p = 0; p < num->pats ; p++) {
		run_net(p, num, net);
		write (infofd, &Activity[0], sizeof(float) * num->cells);
		write (infofd, &Target_vec[p][0], sizeof(float) * num->out);
		}

	close(infofd);

}		/*  End of write_info()  */


run_net(p, num,net)
int p;
struct nn_param *net;
struct nn_num *num;
{
	register int i, j,k;
	int rowj, wtindex;
	float netin = 0.0;


	dbprintf(1,"run_net %d\n",p); 
		
/*	work out activation for input layer as well ? */

	for (j =0 ; j < num->in; ++j) {
		Activity[j] = Input[p][j];
/*	dbprintf(1,"pat %d incell %d act %f\n",p,j,Input[p][j]); */
	}

/*      layer by layer */

	for (k = 1; k <= (num->layers-1); k++) {

	for (j = n_ll[k]+1 ; j <= n_cl[k]; ++j)
	{
		wtindex = lw[k] + (j -(n_ll[k]+1));
		
		for(i = n_lf[k] ; i <= n_ll[k]; ++i) {
			netin += Activity[i] * weight[wtindex];

/* dbprintf(3,"act %d wtin %d\n",i,wtindex);  */

			wtindex += (n_cl[k] - n_ll[k]);
			}

			if (net->theta == 0.0)
			weight[j] = 0.0;

			Activity[j] = activation(netin, weight[j]);

		netin = 0.0;
	}
      }
}

output_error(p, net, num, squares,epoch,wls,opl,train)
int	p;
struct nn_num *num;
struct nn_param *net;
float  *squares;
{
	register int i, j, tp;

	float error, change,nro;

	int correct = 1;
	
	int wtindex;

/* Calculate sum squared error */

	dbprintf(2,"op_error %d\n",p);
   	
	*squares = 0.0;
	tp = n_ll[opl]+1;

	nro = num->out -1;

        if (debug >=1) {
	for(j = tp ; j <= n_cl[opl]; j++) { /* show output */
		if (Activity [j] < 0.5 )	
		dbprintf(1," 0 ");
		else
		dbprintf(1," 1 ");
        }
	}


	for(j = tp ; j <= n_cl[opl]; j++) /* final layer */
	
	{

		wtindex = lw[opl] + (j - tp);

		error = (Target_vec[p][j-tp] - Activity[j]);

dbprintf(2,"j %d tp %d wtindex %d\n",j,tp,wtindex);

		*squares += error * error;



		if (Target_vec[p][j-tp] > 0.5 )	{
	
			if (Activity [j] < 0.5 )	
				correct =0;
		}	
		else {
			if (Activity [j] >= 0.5 )	
			correct =0;
	        }


dbprintf(2,"sweep %d pat %d j %d error %f act %f cr%d\n",sweep,p,j,error,Activity[j],correct);


/*	treat the ON target num.out-1 * as important as OFF cells */

	  if (train) {	
		if (Target_vec[p][j-tp] <= 0.1 && wls == 1)
		delta[j] = ( error/ nro ) * Activity[j] * (1.0 - Activity[j]);	
		else
		delta[j] = error * Activity[j] * (1.0 - Activity[j]);	

		for(i = n_lf[opl] ; i <= n_ll[opl]; i++)
		{
		
			change = delta[j] * net->eta * Activity[i]; 
			oldwt[wtindex] = weight[wtindex];

	 			if(epoch != 0)
				ave_wtch[wtindex] += (change + net->alpha * wt_ch[wtindex]);
			 else {
				weight[wtindex] += (change + net->alpha * wt_ch[wtindex]);
				wt_ch[wtindex] = (change + net->alpha * wt_ch[wtindex]) ;
				}
/*			printf(" operr j %d wti %d\n",j,wtindex); */
			wtindex += num->out;

		       }

		if (epoch != 0)
			ave_wtch[j] += delta[j] * net->eta + net->theta*wt_ch[j];
			else {
			if (net->theta > 0.0) {
			weight[j] += delta[j] * net->eta + net->theta*wt_ch[j];
			wt_ch[j] = delta[j] * net->eta + net->theta*wt_ch[j];
			}
		}
	    }   

	} /* train */

	return (correct);
}	

hidden_error(p, net, layer, epoch)
int p;
int layer;
struct nn_param *net;

{
	register int i, j, k, wtindex;
	int hidwtp;

	float dw, change;
     
	/* Calculate delta values for hidden nodes */

/*	which layer */

	wtindex = uw[layer];
	hidwtp = lw[layer];
	
	for (j = n_ll[layer]+1 ; j <= n_cl[layer] ; j++)

	{
		dw = 0.0;
		
	        for (k = n_cl[layer]+1 ; k <= n_ul[layer]; k++) {
			dw += delta[k] * oldwt[wtindex];
/*			printf("hid delta %d wti %d\n",j,wtindex); */
			wtindex++;
		}
			
		hidwtp = lw[layer] + (j-( n_ll[layer]+1));
		
		delta[j] = Activity[j] * (1.0 - Activity[j]) * dw;

	  /* Calculate change in weights between hidden and  lower nodes  in lower layer */
     	
     	for (i = n_lf[layer] ; i <= n_ll[layer] ; i++)
     		{

     			change = delta[j] * net->eta * Activity[i];

	 			if(epoch !=0 )
				ave_wtch[hidwtp] += (change + net->alpha * wt_ch[hidwtp]);
				else {
				weight[hidwtp] += (change + net->alpha * wt_ch[hidwtp]);
				wt_ch[hidwtp] = (change + net->alpha * wt_ch[hidwtp]) ;
				}
/*			printf("hidwt %d\n",hidwtp); */
			hidwtp += (n_cl[layer] - n_ll[layer]) ;
			

		}
		
		if(epoch !=0 )
		ave_wtch[j] += delta[j] * net->eta +  net->theta * wt_ch[j];
		else {
		if (net->theta >= 0.0) {
		weight[j] += delta[j] * net->eta + net->theta*wt_ch[j];
		wt_ch[j] = delta[j] * net->eta + net->theta*wt_ch[j];
		}
		}
	}
}


float activation(netin, bias)          
float netin, bias;
{
	double  out;

	out = (1.0 / (1.0 + exp ((-1.0 * (double) (netin + bias)))));
	return ( (float) out);
}		


/*
 *	make wt_change average of each individual pattern wt chnage
 */

mk_ave_wtc( nc, np, epoch,net)
struct nn_param *net;
{
int j,i, max_i,max_j;
float change,max_change;
/*	update wt matrix */	
	max_change = 0.0;
	max_i =0;
	max_j =0;
	for (j = 0; j < nc; j++ ) {
/*		use sum of changes */
			if ( epoch == 1) 
			change   = ave_wtch[j]/ (float) np;
			else
			change   = ave_wtch[j];

			weight[j] += change;
			if ( fabs(change) > max_change) {
				max_j = j;
				max_change = change;
			}

			wt_ch[j] = change;
			ave_wtch[j] = 0.0;

		}

	if ( fabs(max_change) > 2.0)
	printf("max change %f wt[%d] %f\n",max_change,max_j,weight[j]);
/*	update wt_ch matrix */	

}

get_node_num (layer,n_lf,n_ll,n_cl,n_ul,lw,uw)

int *n_ll,*n_cl,*n_ul,*n_lf,*uw,*lw;

{
/*	 layer    layer 0 input 
		  layer 1 first hidden
		  layer 2 second hidden
		  layer 3 output
*/
		  switch(layer) {
		  	case 0:
		  	
			*n_lf = 0;
			*n_ll = 0;
			*n_cl = num.in -1;
			*n_ul = num.in + num.bot_hid -1;
			*uw = num.cells;
			*lw = num.cells;
			break;

			case 1:		
			*n_lf = 0;
			*n_ll = num.in -1;
			*n_cl = num.in + num.bot_hid -1;
			
			if (num.layers ==4)
			*n_ul = num.in + num.bot_hid +num.top_hid -1;
			else
			*n_ul = num.in + num.bot_hid +num.out -1;			
			*uw = num.cells + (num.in * num.bot_hid );
			*lw = num.cells ;
			break;
			

			case 2:		
			if (num.layers == 4) {
			*n_lf = num.in;
			*n_ll = num.in + num.bot_hid -1;
			*n_cl = num.in  +  num.bot_hid + num.top_hid -1 ;
			*n_ul = num.in + num.bot_hid + num.top_hid + num.out -1;
			*uw = num.cells + (num.in * num.bot_hid ) + (num.bot_hid * num.top_hid );
			*lw = num.cells + (num.in * num.bot_hid );
			}	
			else {
			*n_lf = num.in ;
			*n_ll = num.in  +  num.bot_hid  -1 ;
			*n_cl = num.in + num.bot_hid +  num.out -1;
			*n_ul = num.in + num.bot_hid +  num.out -1;
			*uw = num.cells + (num.in * num.bot_hid ) + 
							(num.bot_hid * num.out) ;
			*lw = num.cells + (num.in * num.bot_hid ) ;
				
			}

			break;
			
			case 3:
			*n_lf = num.in + num.bot_hid ;
			*n_ll = num.in  +  num.bot_hid + num.top_hid -1 ;
			*n_cl = num.in + num.bot_hid + num.top_hid + num.out -1;
			*n_ul = num.in + num.bot_hid + num.top_hid + num.out -1;
			*uw = num.cells + (num.in * num.bot_hid ) + (num.bot_hid * num.top_hid ) +
				(num.top_hid * num.out) ;
			*lw = num.cells + (num.in * num.bot_hid ) + (num.bot_hid * num.top_hid );
			break;
	}
/*	printf("layer %d n_lf %d n_ll %d n_cl %d n_ul %d lw %d uw %d\n",layer,*n_lf,*n_ll,*n_cl,
			*n_ul,*lw,*uw); */
}

prt_big_wtc(nc)
{
int j,i;
float change,max_change;
/*	update wt matrix */	
	max_change = 0.0;
	for (j = 0; j < nc; j++ ) {
			change   = wt_ch[j];
			if ( abs(change) > max_change) 
				max_change = change;
		}
	printf("max change %f \n",max_change);
}


prt_big_awtc( nc)

{
int j,i, max_i,max_j;
float change,max_change;
/*	update wt matrix */	
	max_change = 0.0;
	max_j =0;
	for (j = 0; j < nc; j++ ) {
			change   = ave_wtch[j];

			if ( abs(change) > max_change) {
				max_j = j;
				max_change = change;
			}
		}
	 if ( abs(max_change) > 1.0)
	printf("max change %f wt[%d] %f\n",max_change,max_j,weight[j]);

/*	update wt_ch matrix */	
}

add_tokens(pat_nu)
int *pat_nu;
{
static int j =0;
	j++;
	*pat_nu = stage[j];

dbprintf(1,"stage %d n_pat %d ll %f pc_l %f \n",j,*pat_nu,learn_level,pc_level);

	if ( j == (n_stages -1))
	pc_level = 100.0;
	if (*pat_nu == 0)
	return(1);
	else
	return(0);	

}




limit_target ( num)
struct nn_num *num;
{
int i,j;
float targ;
		for (i = 0; i < num->pats; i++)
		for (j = 0; j < num->out; j ++) {

			targ = Target_vec[i][j];

			if (targ > 0.9)
				targ = 0.9;
			if (targ < 0.1)
				targ = 0.1;				

			Target_vec[i][j] = targ;
		}
}



gs_nn_design(design_file,num)
char *design_file;
struct nn_num *num;
{
char line[120];
char var_name[80];
char var_units[80];
char var_value[80];
float tmp;
int posn;
int i,j;
FILE *fp;

	strcpy(var_units,"1");

	num->in_row = num->out_row = 1;
	
	if (( fp = fopen(design_file,"r")) == NULL)
		return (0);
		
	while (1) {

	if ( fgets(line,120,fp) == NULL ) {
		printf("design file error\n");
		fclose(fp);
		return(0);
	}
	
	sscanf(line,"%s %s %s",var_name,var_value,var_units);

	
	if ( strcmp(var_name,"END_HEADER") == 0) {
	fclose(fp);
	return(1);
	}

	if (strcmp (var_name,"layers") == 0)  
	num->layers = atoi(var_value);
	
	if (strcmp (var_name,"in") == 0) 
	num->in = atoi(var_value);
	
        if (strcmp (var_name,"in_row") == 0) 
	num->in_row = atoi(var_value);
	
        if (strcmp (var_name,"out_row") == 0) 
	num->out_row = atoi(var_value);
	
	if (strcmp (var_name,"out") == 0) 
	num->out = atoi(var_value);
	
	if (strcmp (var_name,"pats") == 0) 
	num->pats = atoi(var_value);
	
	if (strcmp (var_name,"bot_hid") == 0) 
	num->bot_hid = atoi(var_value);
	
	if (strcmp (var_name,"top_hid") == 0) 
	num->top_hid = atoi(var_value);
	
	if (strcmp (var_name,"n_stages") == 0) 
	n_stages = atoi(var_value);
	
	if (strcmp (var_name,"cycle") == 0) 
	cycle = atoi(var_value);
	
	if (strcmp (var_name,"learn_level") == 0) 
	sscanf(var_value,"%f",&learn_level);
	
	if (strcmp (var_name,"pc_level") == 0) 
	sscanf(var_value,"%f",&pc_level);
	
	if (strcmp (var_name,"random_presentation") == 0) 
	random_pres = 1;
	
	if (strcmp (var_name,"stage") == 0)  {
	sscanf(var_value,"%d",&i);
	sscanf(var_units,"%d",&stage[i]);
        }


        }

}

net_sweep(p,nc,np,num,net,ss,epoch,wls,train)
int *nc,*np;
float *ss;
struct nn_num *num;
struct nn_param *net;
{
int j;
float squares;
/*	if (debug) printf("pat %d\n",p); */
		
	if ( p >= num->pats) {
			p = 0;
			printf("ERROR ! p %d\n",p);
		}
       			run_net(p, num,net);

       					 /* Back 		*/
					 /* Propagation		*/
       			 		 /* of errors		*/

	if ((output_error(p,net, num, &squares,epoch,wls,num->layers-1,train)) == 1)
			*nc += 1;	

       			/* Error written to squares	*/

			for ( j= 1; j < (num->layers -1 ); j++) { /* maximum of 2 hidden rows */
			hidden_error(p, net,j,epoch);
			}

          		*ss += squares;
		*np += 1;

}

float frand();

shuffle(n_pats)
{
int i,j,k,tmp;

	dbprintf(1,"shuffle n_pats %d\n",n_pats);
	
	for (i = 0; i < n_pats; i++) {

		j =  (int) (frand ()  * (n_pats-1)  + 0.5)  ;
	        k =  (int) (frand ()  * (n_pats-1)  + 0.5) ;
	if (j < 0 || j >= n_pats)
	dbprintf(1,"shuffle  %d %d\n",j,k);
		tmp = p_order[k];
		p_order[k] = p_order[j];
		p_order[j] = tmp;
	}

}
