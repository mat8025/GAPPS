/*		CRS
 *
 *
 *	segmentation option uses the analysis file and the ANN
 *      to perform a frame by frame classification - 
 *	this is written to a label file
 */

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/* Network constants */

#define MAXCELLS 500
#define MAXOCELLS 20
#define MAXICELLS 400
#define MAXPAT 1
#define ONTHRESHOLD 0.9
#define OFFTHRESHOLD 0.1
#define NETTHRESH 100
#define NTRACKS 2
#define DISPLAY 1
#define SS 2

#define READ 0
#define WRITE 1
#define RW 2

FILE *lab_fp,*train_lab_fp,*train_ana_fp;

char datafile[120];
char lab_file[120];

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


struct  cat {
	char ic_name[15]; /* input class name */
	char oc_name[15];
	char op_class_code[15];
	short  num;
	short  op_class;	
};

#define MAXCAT   50
struct  cat cat_table[MAXCAT];

struct OP_CONN { 
		short cell;
		int   wi;
	};
	

int N_op_classes;

#define MAXCONN 5000
struct OP_CONN OPC[MAXCONN];

float data[1024];
float input [MAXPAT][MAXICELLS];  
float target_vec[MAXPAT][MAXOCELLS];   
float activity[MAXCELLS];
float weight[MAXCONN];
float oldwt[MAXCONN];
float wt_ch[MAXCONN];
float delta[MAXCELLS];
short Conn[MAXCONN];

/*  this struct enables one to specify architecture other than in a strictly layered
	feed_forward net */
	
struct Connect {
		int nipc;
		int nopc;
		int wt_index;
		int ip_conn_index;
		int op_conn_index;
	};

struct Connect Cell_Conn[MAXCELLS];
	
float squares;

struct Layer {
		int n;
		int fc;
		int lc;
} ;

struct Layer NL[4];



struct ocr {
		int np;
		int nc;
		float pc;
		int op_code;
		char label[50];
		long int last_tok;
	};


struct ocr OC[30];	

struct nn_num Num;

struct nn_param ANN ;

float activation(); 

int sweep = 0;
int debug = 0;

int segment = 0;
int recog_seg;

float learn_level = 0.1;

float pc_level = 97.0;
float pc_old = 0.0;
float pc_incr = 0.0;
int random_pres = 0;
int cycle =1;

FILE *fp, *list_fp;

data_file o_df,o_chn, df;

int Build_Train_Files = 0;

int Wls = 0;
double exp();
char Pat_file[120];	
main(argc,argv)
char **argv;
int argc;
{

	char *file;
	char filename[120];
	char *design_file;

	char *target_file;		
	char *track_file;
	char *rss_file;
	char *wss_file;
	char *wtsfile;
	char *winfo_file;
			
	FILE *tfp;


        int  r,q;

	int  finish;
	int train;
	int targ_lim = 0;

	int targets = 0;
	


	int do_list, do_phrase, class_member, frame_num, input_found;

	int  seed = 7;		/* my lucky number */
	char fname[120]; 
        int fposn,posn;
	int   p, j,k, sod,i,np,nc;   
	int track = 0;
	int trk_app = 0;
	int n_save_sweeps = 0;
	int n_error_sweeps = 5;	
	int end_pat,start_pat,class,n_pat;
	double sqrt();
	float c_ratio,n_r;	        
	float  sq, rms,pc;
	double sumsq;
	
        int job_nu = 0;   
        char start_date[40];	

	int n_toks = 200;
	int n_tok_reps = 2;

	ANN.alpha = 0.9;
	ANN.theta = 0.9;
	ANN.eta = 0.1;


	for (i = 1; i < argc; i++) {
		switch (*argv[i])
		{      	
			case '-': 
			switch (*(argv[i] + 1)) 
			{

				case 'a':	/* weight space momentum */
				  ANN.alpha = atof (argv[++i]);
				  break;

				case 'b':	/* weight space momentum */
				  ANN.theta = atof (argv[++i]);
				  break;

				case 'e':	/* learning rate	 */
				  ANN.eta = atof (argv[++i]);
				  break;
				  
				case 'i':	/* net descriptor filename */
				  design_file= argv[++i];
				  break;

				case 'I':	/* info file name	*/
				  winfo_file = argv[++i];
				  break;

				case 'n':	/* Num of sweeps	*/
				  ANN.sweeps = atoi(argv[++i]);
				  break;

				case 'p':	/* pattern filename	*/

				  strcpy(Pat_file, argv[++i]);

				  break;

				case 'x':	/* segment analysis files */
				  recog_seg = 1;
				  break;
				case 'z':
				  segment = 1;

				  break;

				case 't':	

				  target_file = argv[++i];
				  targets = 1;
				  break;


				case 's':	/* i/p saved state filename */

				  ANN.read_ss = 1;
				  rss_file = argv[++i];
				  break;

				case 'L':
				/* target 1 -> 0.9  target 0 -> 0.1 */	
				targ_lim = 1;
					break;
				case 'W':

				/*	weighted least squares */

				/* target 1 more important than other 0 value output nodes */
				Wls = 1;
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
			        case 'B':
			        	Build_Train_Files = 1;
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


				case 'Y':	/* Debugging mode	*/

				  debug = atoi(argv[++i]);
				  break;
				default: 


				  break;
			}
			break;

		default: 
	          printf("%s: illegal option\n",  argv[0]);

		}
	}


   if (debug == HELP)
   	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

        signal (SIGFPE, fpe_trap);
   
	init_cat();

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }



    dbprintf(1,"CRS RUNNING\n"); 

    dbprintf(1,"NET_PARAMS  a  %f b  %f  e %f\n",ANN.alpha,ANN.theta,ANN.eta);


	dbprintf(1,"TARGET LIMIT %d WLS %d\n",targ_lim,Wls);
	
	if (n_save_sweeps > 0 && debug)
		dbprintf(1,"SAVING WTS every %d sweeps\n",n_save_sweeps);
	

	if (pc_incr > 0.0  && debug)
		printf("SAVING WTS every %f percentage correct increase\n",pc_incr);

/* set up arrays and net_design */

	get_design(design_file,&Num);
	
	if (FPE ) {
	dbprintf(1,"get design\n");
	FPE = 0;
        }

	init_arrays(&ANN, &Num, rss_file,  seed);

        if (FPE )
	dbprintf(1,"init_arrays \n");

        	
	if (targ_lim)
		limit_target(&Num);


	if (track && ! segment )
	{     

 gs_init_df(&o_df);
 gs_init_df(&o_chn);
  
 o_df.f[STR] = 0.0;
 o_df.f[STP] = (float) ANN.sweeps ;   

 strcpy(o_df.name,"CR");
 strcpy(o_df.type,"CHANNEL"); 
 o_df.f[N] = 2.0 ;

                        gs_o_df_head(track_file,&o_df);
			     /* write out headers for trackfile */
	/*      write out ascii info */

	/*      open channel file */
		     

			fprintf(o_df.fp,"net learning file\n");
			fprintf(o_df.fp,"start_of_data 0\n");
			fprintf(o_df.fp,"layers %d\n",Num.layers);
			fprintf(o_df.fp,"in %d\n",Num.in);
			fprintf(o_df.fp,"out %d\n",Num.out);
			fprintf(o_df.fp,"bot_hid %d\n",Num.bot_hid);
			fprintf(o_df.fp,"top_hid %d\n",Num.top_hid);
			fprintf(o_df.fp,"pats %d\n",Num.pats);

   o_chn.fp = o_df.fp;
   o_chn.f[N] = (float) ( ANN.sweeps /n_error_sweeps );   
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

	     
	if (ANN.sweeps > 0) {
		dbprintf(1,"training with %d pats %d %d\n",n_pat,Num.pats,cycle);
		train =1;
	} else if ( ! segment )
	{
		dbprintf(1,"recognition\n");
		train =0;
	        ANN.sweeps = 1; 
	} else {
		
		dbprintf(1,"segmentation\n");
		train =0;
	        ANN.sweeps = 1; 
       }

		if ( (list_fp = fopen(Pat_file,"r")) == NULL) {
			dbprintf(1,"pat file not found\n");
			exit (-1);
		}
				
		frame_num = 0;

		if ( ! segment ) {
		if ( ! get_phrase (list_fp ,1))
		exit (-1);
	        }

	if ( segment )  {
	        segment_phrase () ;
		dbprintf(1,"SEGMENTATION FINISHED\n");    
		exit(0);
	}
        else if ( recog_seg ) {
                
                segment_recog (&np,&nc, &sumsq) ;
		sweep = 1;
		report_net_stats(sweep, sumsq,np,nc ) ;
		dbprintf(1,"SEG_RECOG FINISHED\n");    
		exit(0);

	}
	else  {

	if (Build_Train_Files)		
	 n_toks = build_training_files();
	 else
	 n_toks = count_tokens ();
	 
	 if ( n_toks <= 0) {
	 	printf("error in training files \n");
	 	exit (0);
	 }

	 
	for (sweep = 1; sweep <= ANN.sweeps; sweep++)  {  /* begin sweeps loop */
				
	        FPE  = 0;		
	        np = 0;
		nc = 0;	
		sumsq = 0.0;   

		for ( i = 0; i < N_op_classes; i++) {
			OC[i].np = 0;
			OC[i].nc = 0;		
			}

	        for ( q = 0 ; q < n_toks ; q++ ) {

		for ( r = 0 ; r < N_op_classes ; r++ ) {


		     input_found = 0;
		     
		     while ( ! input_found ) {
        	     input_found = get_train_input(r);
		     }
		     
		      dbprintf(1,"cm %d %d\n", r,frame_num); 

			/* present each token n_tok_reps */
			class_member = r;
			

	 			OC[class_member].np += 1;
				i = nc;
	      			net_sweep(p,&nc,&np,&Num,&ANN,&sumsq,train) ;

				if (nc > i)
				OC[class_member].nc += 1;


			dbprintf(1,"nc %d np %d\n",nc,np);	

			/* update class  recog score */
	  } /* op_classes */
	}
	dbprintf(1,"sweep %d pats %d nc %d\n",sweep,np,nc);

	rms = sqrt (sumsq/ (1.0 * np * Num.out));
	pc = (nc / (float) np) * 100.0;

 if (  sweep % n_error_sweeps == 0 ) {
	report_net_stats(sweep, sumsq,np,nc ) ;
	
	if (track) {
		fprintf(o_df.fp,"%f %f\n",rms,pc);
		fflush(o_df.fp);
	        }
        }

	if ( n_save_sweeps > 0 && sweep % n_save_sweeps == 0) {
			write_saved_state( wss_file,&Num,sweep);
	}

		if ( pc_incr > 0.0 && ( pc > pc_old)  ) {
 dbprintf(1,"wts saved @sweep %d pats %d error %f rms %f pc %f\n",sweep,np,sq,rms, pc);
		write_saved_state( wss_file,&Num,sweep);
		   while (pc_old < pc)
		   pc_old += pc_incr;
		}

      } /* train */
	} /* End of sweeps loop */
   
		write_info(winfo_file, &Num, &ANN);

		if (train)
		write_saved_state(wss_file,&Num,sweep);

		dbprintf(1,"BACKPROP COMPLETED\007\n");    

   if (track)
   gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
 }


sho_use()
{

	printf(" cr -i net_descriptor_file -p pattern_file -t target_file -a alpha -e eta\n");
	printf("  -b bias(theta) -T (rms,per_corr trk_file) \n");
	printf("  -n number_of_sweeps [-s use previous wts_state_file] -w wts_save_file\n");
	printf("  -R sweeps (report rms %c after sweeps) [-W wtd least sqaures]\n");	
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
	int nw;

	int i, j;
	dbprintf(1,"init_array nconn_wts %d ncells %d\n",num->conn,num->cells );
	
	nw = num->conn + num->cells;
	
	for (i = 0 ; i < nw ; ++i)       /* initialise network arrays */
		{
			weight[i] = 0.0;
			oldwt[i] = 0.0;
			wt_ch[i] = 0.0;
/*			ave_wtch[i] = 0.0;    */
		}
	
        				 
	srand(seed);



	if (net->read_ss == 1)
		read_saved_state(rss_file,num);
	else			

	for (i = 0; i < nw ; ++i) 	 /* initialise weights  */ 
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

char line[120];
char var_name[40];
char cell1[20];
char cell2[20];
char cell3[20];
char l1[20];
int layer, c1,c2, c3;
int k;
int ioc =0;
int ci = 0;
FILE *fp;

	int cell, pat, rsize;
	int nbytes = 1;
	int node[2];
	float input_val, targ;   
	int i;
	int sc =0;
	int read_conn;
		
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

	if ( (nn_design(design_file, num,&sc,&ioc)) == -1)
		exit (-1);

	if (debug) {
	dbprintf(1,"layers = %d \n",num->layers);
	dbprintf(1,"in = %d \n",num->in);
	dbprintf(1,"out = %d \n",num->out);
	dbprintf(1,"bot_hid = %d \n",num->bot_hid);
	dbprintf(1,"top_hid = %d \n",num->top_hid);
	dbprintf(1,"pats = %d \n",num->pats);
	dbprintf(1,"cycle = %d \n",cycle);
	dbprintf(1,"learn_level = %f \n",learn_level);
	dbprintf(1,"pc_level = %f \n",pc_level);
	}



	num->cells = num->in + num->out + num->top_hid + num->bot_hid;

	init_conn();

        get_layers ();
   
	if (num->cells > MAXCELLS)
		error("Too many cells in network.\n");

/* Read connections from header */

if (num->layers == 4)
num->conn = num->cells + (num->in * num->bot_hid) + 
(num->bot_hid * num->top_hid) + (num->top_hid * num->out);
	else		
	num->conn = num->cells + (num->in *num->bot_hid) + (num->bot_hid * num->out);   

/* default connectivity */
	if ( ! sc) {
	for (i = 0 ; i < num->conn ; ++i)  {
		Conn[i] = i;
	}

        }  
        else {
        
/* work out conn again if net architecture is specified as non_standard */


	if (( fp = fopen(design_file,"r")) == NULL)
		return (-1);
		read_conn = 1;
	
	  while (read_conn) {

		if ( fgets(line,120,fp) == NULL ) {
		dbprintf(0,"design file error\n");
		fclose(fp);
		return(-1);
		}
	
	sscanf(line,"%s %s %s %s %s ",var_name, l1,cell1 , cell2, cell3);
	
		if ( strcmp(var_name,"END_HEADER") == 0) {
		fclose(fp);
		read_conn = 0;
		}

		if (strcmp (var_name,"CC") == 0)  {
        	 layer = atoi (l1);
		 c1 = atoi (cell1);
		 c2 = atoi (cell2);
		 c3 = atoi (cell3);
		 set_ip_conn( num, layer, c1,c2,c3, &ci);
	         }

	        }
          }
            

	num->conn = ci;
	
	if (num->conn > MAXCONN) {
		dbprintf(1,"TOO MANY CONNECTIONS %d max %d\n",num->conn, MAXCONN);
		exit(-1);
	}

	set_wt_conn();

	if (ioc)
		set_ioc(design_file);

}	


set_ip_conn( num,layer, c1, c2, c3, ci) 
struct nn_num *num;
int *ci;
{
int i,j,k, k1;		
int cell_j;
  dbprintf(1, "sc %d %d %d %d\n",layer ,c1 ,c2, c3);
    
  if ( layer <= 0 || ( layer >= num->layers ) ) {
  	dbprintf(1,"set_conn error %d %d\n",layer,num->layers);
  	exit(-1);
  }
	
        k =  NL[layer-1].fc ; /* actual cell number of first cell in lower
        		     layer */

        cell_j = c1 + NL[layer].fc;
	
	k1 = ( c3 - c2 + 1);

	for (j = 0 ;  j < k1 ; j++ ) {
	Conn[*ci] = c2 + j +k; /* cell num connected to */

	*ci += 1;
        Cell_Conn[cell_j].nipc += 1;
        }

  dbprintf(2,"cell %d nic %d tic %d\n",cell_j, Cell_Conn[cell_j].nipc,*ci);

}

set_wt_conn()
{
int i,k,j,opk,wi;

    /* ip connections */
    i = NL[1].fc;

    Cell_Conn[i].ip_conn_index = 0;
    Cell_Conn[i].wt_index = Num.cells;

    for ( i = 1 ; i < Num.layers ; i++ ) {
    for ( j = NL[i].fc ; j <= NL[i].lc ; j++ ) {
    
    Cell_Conn[j+1].ip_conn_index = Cell_Conn[j].ip_conn_index
		   + Cell_Conn[j].nipc;	
    Cell_Conn[j+1].wt_index = Cell_Conn[j].wt_index
		   + Cell_Conn[j].nipc;	    				   
  
    dbprintf(2,"cell %d ipci %d wti %d nipc %d\n",j, Cell_Conn[j].ip_conn_index, 
    				Cell_Conn[j].wt_index,Cell_Conn[j].nipc);
    }	
    
    }

/* op connections */
    opk =0;

    Cell_Conn[0].op_conn_index = 0;

    for ( i = 0 ; i < Num.layers-1 ; i++ ) {
	dbprintf(2,"opc layer %d\n",i);
    for ( j = NL[i].fc ; j <= NL[i].lc ; j++ ) {
	Cell_Conn[j].nopc = 0;
	dbprintf(2,"opc cell %d\n",j);
    for ( k = NL[i+1].fc ; k <= NL[i+1].lc ; k++ ) {
	dbprintf(2,"opc op_cell %d\n",k);
	if ( ( wi = get_opc ( j, k)) != -1 ) {
	Cell_Conn[j].nopc ++;	
	OPC[opk].cell = k;
	OPC[opk].wi = wi;
	dbprintf(2,"cell %d op_cell %d wi %d opk %d\n",j,k,wi,opk);
	opk++;
        }

    }
    Cell_Conn[j+1].op_conn_index = Cell_Conn[j].op_conn_index
		   + Cell_Conn[j].nopc;	
    }	
    
    }


	
}


get_opc ( cell , op_cell)
{
int i, n, k;
int wi = -1;
/* search op_cell ip conn for cell if pres return wt index else -1 */	
	
	n = Cell_Conn[op_cell].nipc;
	i = Cell_Conn[op_cell].ip_conn_index;
	wi = Cell_Conn[op_cell].wt_index;
	dbprintf(2,"get_opc oc %d nipc %d ipci %d wi %d\n",op_cell,n,i,wi);

	for ( k = 0; k < n ; k++ )	 {
	if ( Conn[k+i] == cell )
	    return ( k+  wi);	
	
        }
	return -1;
}

set_ioc (design_file)
char *design_file;
{
int read_ioc = 0;
char line[120];
char var_name[40],num_oc[40], tar[20];

int i_hash,k_class, c_class,k;
char c_class_code[15];
char c_class_name[15];

	dbprintf(1,"ioc set\n");

	if (( fp = fopen(design_file,"r")) == NULL)
		return (-1);
		read_ioc = 1;
	
	  while (read_ioc) {

		if ( fgets(line,120,fp) == NULL ) {
		dbprintf(0,"design file error\n");
		fclose(fp);
		return(-1);
		}
	
	        sscanf(line,"%s %s",var_name, num_oc);
	
		if ( strcmp(var_name,"END_HEADER") == 0) {
		fclose(fp);
		read_ioc = 0;
		}

		if (strcmp (var_name,"ioc") == 0)  {
		/* read in out classes */
		  N_op_classes = atoi (num_oc);
		  k_class = 0;
		  c_class = 0;
		  while (strcmp (var_name,"end_ioc") != 0) {
  			if ( fgets(line,120,fp) == NULL ) {
			return 0;
			}
		strcpy(tar,"\0");
		strcpy(var_name,"\0");
	        sscanf(line,"%s %s %s",var_name, num_oc,tar);
		 if (strcmp (var_name,"end_ioc") == 0) 
		     break;
		     
		if ( strlen(tar) == 0) {
	        i_hash =  cat_hash(var_name,1);
		cat_table[i_hash].op_class = (short) c_class;		
	        strcpy(cat_table[i_hash].oc_name,c_class_name);
	        strcpy(cat_table[i_hash].op_class_code,c_class_code);	        
      dbprintf(1,"%s oc_class_code %s  oc %d\n",var_name,c_class_code, c_class);
	        }
		else {
		sscanf(var_name,"%d",&c_class); /* op class */
		strcpy(c_class_name,num_oc);   /* op class name */
		strcpy(c_class_code,tar);      /* op class oct op code */
		strcpy(OC[c_class].label,c_class_name);
		k = atoi (c_class_code);
		OC[c_class].op_code = k;
	        dbprintf(1,"%s %s %s\n",var_name, num_oc ,tar);
		k_class++;
	        }
	         }
	     }

          }
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
			target_vec[pat][cell] = 0.0;
			
	j = strlen(b_n);
	
	dbprintf(2,"%d %d %s \n",pat,target,b_n);

	for (cell = 0; cell < j; cell++) {
			if (strncmp(&b_n[cell],"0",1) == 0)
			target_vec[pat][j-1-cell] = 0.0;
			else
			target_vec[pat][j-1-cell] = 1.0;

		}

	for (cell = num->out-1; cell >= 0; cell--) 
	dbprintf(2,"tar pat %d cell %d %f\n",pat,cell,target_vec[pat][cell]);

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




read_saved_state(file,num)
char *file;
struct nn_num *num;
{
int ssfd;
float swp_no = 0.0;
int nw;
		dbprintf(1,"read saved state\n");

				  if ((ssfd = open(file, READ)) == -1)
				  {
					printf("Cannot open %s \n", file);
					close(ssfd);
					exit(-1);
				  }

		nw = num->cells + num->conn ;
		
		read(ssfd, &weight[0], nw * sizeof(float));
		read(ssfd, &wt_ch[0], nw * sizeof(float));
	if (read(ssfd, &swp_no, 1.0 * sizeof(float) ) > 0) 
		printf("%s   %d\n",file, (int) swp_no);
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
char tag[3];
char filename[120];
float swp_no;
int nw;
char copy_it[120];

	swp_no = 1.0 * sweep;
		
	strcpy(filename,file);
	sprintf(tag,".%d",j);
	strcat(filename,tag);
	j++;

	sprintf(copy_it,"cp %s lastw",filename);
	
	if ((wtsfd = creat(filename, 0666)) == -1)
		{
	        			       printf("Cannot open %s \n",filename);
	        			       close(wtsfd);
		        		       exit(-1);
		}
		nw = num->cells + num->conn ;		       

		write(wtsfd, &weight[0], nw * sizeof(float));
		write(wtsfd, &wt_ch[0], nw * sizeof(float));
		write(wtsfd, &swp_no, 1 * sizeof(float));
		close(wtsfd);
		
		system( copy_it);
		dbprintf(1,"saved wt matrix in %s\n",filename); 

}

/*  End of write_saved_state()  */

error( s ) 
char *s;
{
	fprintf( stderr, "error : %s\n",  s );
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

/* write out connection architecture */			
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
		run_net (p, num, net);
		write (infofd, &activity[0], sizeof(float) * num->cells);
		write (infofd, &target_vec[p][0], sizeof(float) * num->out);
		}

	close(infofd);

}		/*  End of write_info()  */


run_net (p, num,net)
int p;
struct nn_param *net;
struct nn_num *num;
{
	int cell_i, cell_j,k, wt_ptr;
	int rowj, wtindex;
	float netin = 0.0;
        int nic, conn_index,i;
        
	FPE =  0;
	dbprintf(1,"run_net %d\n",p); 
		
/*	work out activation for input layer as well ? */

	for (cell_j =0 ; cell_j < num->in; ++cell_j)
		activity[cell_j] = input[p][cell_j];


/*      layer by layer */

	
	for (k = 1; k <= (num->layers-1); k++) {


	for (cell_j = NL[k].fc ; cell_j <= NL[k].lc ; cell_j++ )
	{
		    
		         nic = Cell_Conn[cell_j].nipc ;
			 conn_index = Cell_Conn[cell_j].ip_conn_index;
			 wtindex = Cell_Conn[cell_j].wt_index;			 
dbprintf(2,"rn cj %d nic %d ci %d  wi %d\n",cell_j,nic,conn_index,wtindex); 		
		for(i = 0 ; i < nic ; ++i) {
			cell_i = Conn[conn_index];
			netin += activity[cell_i] * weight[wtindex];
dbprintf(2,"i %d cell_i %d act %f wt %f wi %d\n",i,cell_i,activity[i],weight[wtindex],wtindex); 
			conn_index++;
			wtindex++;
			}

			if (net->theta == 0.0)
			weight[cell_j] = 0.0;
			activity[cell_j] = activation(netin, weight[cell_j]);
			dbprintf(2,"cell %d act %f\n",cell_j,activity[cell_j]);

		netin = 0.0;
	}
      }
	if (FPE )
	dbprintf(1,"run_net %d\n",p); 
}

output_error(p, net, num, squares,opl,train)
int  p;
struct nn_num *num;
struct nn_param *net;
double  *squares;
{
	int i, j, tp,nic, conn_index;
	float error, change,nro;
	int correct = 1;
	int cell_i;	
	int wtindex; 

	/* Calculate sum squared error */
	FPE = 0;
	dbprintf(2,"op_error %d\n",p);
   	
	*squares = 0.0;

	tp = NL[opl].fc;
	nro = num->out -1;



	for(j = tp ; j <= NL[opl].lc ; j++) /* final layer */
	{

dbprintf(2,"cell %d tar %f op %f\n",j,target_vec[p][j-tp],activity[j]);
		error = (target_vec[p][j-tp] - activity[j]);
		*squares += error * error;

		if (target_vec[p][j-tp] > 0.5 )	{
		if (activity [j] < 0.5 )	
		correct =0;
		}	
		else {
		if (activity [j] >= 0.5 )	
		correct =0;
	        }

		/*	treat the ON target num.out-1 * as important as OFF cells */
	 
	 if (train) {	
		if (target_vec[p][j-tp] <= 0.1 && Wls == 1)
		delta[j] = ( error/ nro ) * activity[j] * (1.0 - activity[j]);	
		else
		delta[j] = error * activity[j] * (1.0 - activity[j]);	


         nic = Cell_Conn[j].nipc ;
	 conn_index = Cell_Conn[j].ip_conn_index;
	 wtindex = Cell_Conn[j].wt_index;			 
	 
	 dbprintf(2,"op cj %d nic %d ci %d  wi %d\n",j,nic,conn_index,wtindex); 				

		for(i = 0 ; i < nic ; ++i) {
			cell_i = Conn[conn_index];
				
			change = delta[j] * net->eta * activity[cell_i]; 

dbprintf(2,"op j %d %d cell_i change %f wtindex %d\n",j,cell_i, change,wtindex ); 				

			oldwt[wtindex] = weight[wtindex];

		weight[wtindex] += (change + net->alpha * wt_ch[wtindex]);
		wt_ch[wtindex] = (change + net->alpha * wt_ch[wtindex]) ;
		wtindex++ ;
	        conn_index++;
		       }

		if (net->theta > 0.0) {
		weight[j] += delta[j] * net->eta + net->theta*wt_ch[j];
		wt_ch[j] = delta[j] * net->eta + net->theta*wt_ch[j];
			}

	    }   
	} /* train */

	if (FPE )
	dbprintf(1,"op_error %d\n",p);

	return (correct);

}	

hidden_error(p, net, layer)
int p;
int layer;
struct nn_param *net;

{
	int i, j, k, wtindex;
	int h_index, wt_ptr;
	int noc, conn_index;
	int nic,cell_j,cell_i;	
	float dw, change;
     
	/* Calculate delta values for hidden nodes */

/*	which layer */

	
	for (j = NL[layer].fc ; j <= NL[layer].lc ; j++)

	{
		dw = 0.0;
     	
	         noc = Cell_Conn[j].nopc ;
		 conn_index = Cell_Conn[j].op_conn_index;

                dbprintf(2,"he  cj %d noc %d ci %d \n",j,noc,conn_index); 

	        for (k = 0 ; k < noc ; k++) {
			cell_j =  OPC[conn_index].cell;
			wt_ptr =  OPC[conn_index].wi;

			dw += delta[cell_j] * oldwt[wt_ptr];
                dbprintf(2,"he delta cj %d wtp %d delta %f\n",cell_j,wt_ptr,delta[cell_j]); 		
			conn_index++;
		}
		
		delta[j] = activity[j] * (1.0 - activity[j]) * dw;

	dbprintf(2,"delta for %d %f dw %f\n",j,delta[j],dw);

/* Calculate change in weights between hidden and  lower nodes  in lower layer */

	         nic = Cell_Conn[j].nipc ;
		 conn_index = Cell_Conn[j].ip_conn_index;
		 wtindex = Cell_Conn[j].wt_index;			 

 dbprintf(2,"he cj %d nic %d ci %d  wi %d\n",j,nic,conn_index,wtindex); 

	for(i = 0 ; i < nic ; i++) {
			
			cell_i = Conn[conn_index];
        dbprintf(2,"hl  cell_i %d eta %g act %g\n",cell_i, net->eta,activity[cell_i]); 				
     			change = delta[j] * net->eta * activity[cell_i];
        dbprintf(2,"hl j %d %d cell_i change %g wtindex %d\n",j,cell_i, change,wtindex ); 	

	weight[wtindex] += (change + net->alpha * wt_ch[wtindex]);
	wt_ch[wtindex] = (change + net->alpha * wt_ch[wtindex]) ;
			
			wtindex ++; 
		        conn_index ++;
		}

		if (net->theta >= 0.0) {
		weight[j] += delta[j] * net->eta + net->theta*wt_ch[j];
		wt_ch[j] = delta[j] * net->eta + net->theta*wt_ch[j];
		}

	}
}



float activation(netin, bias)          
float netin, bias;
{
	double  out;

	out = (1.0 / (1.0 + exp ((-1.0 * (double) (netin + bias)))));
  dbprintf(2,"netin %f  bias %f act_out %f\n",netin,bias,out);
	return ( (float) out);
}		


get_layers ()
{
/*	 layer layer 0 input 
		  layer 1 first hidden
		  layer 2 second hidden
		  layer 3 output
*/

	NL[0].fc = 0;
	NL[0].lc = Num.in -1;
        NL[0].n = Num.in;

	NL[1].fc = Num.in;
	NL[1].n = Num.bot_hid;
	NL[1].lc = Num.in + Num.bot_hid -1;

	NL[2].n = Num.out;
	NL[2].fc = Num.in + Num.bot_hid ;
	NL[2].lc = NL[2].fc + Num.out -1;	
              

}




limit_target ( num)
struct nn_num *num;
{
int i,j;
float targ;

		for (i = 0; i < num->pats; i++)
		for (j = 0; j < num->out; j ++) {

			targ = target_vec[i][j];

			if (targ > 0.9)
				targ = 0.9;
			if (targ < 0.1)
				targ = 0.1;				

			target_vec[i][j] = targ;
		}
}


nn_design(design_file,num,sc,ioc)
char *design_file;
struct nn_num *num;
int *sc,*ioc;
{
char line[120];
char var_name[80];
char var_units[80];
char var_value[80];
float tmp;
int posn;
int i,j;
FILE *fp;

	dbprintf(1,"nnd %s\n",design_file);

	strcpy(var_units,"1");

	num->in_row = num->out_row = 1;
	
	if (( fp = fopen(design_file,"r")) == NULL)
		return (-1);
		
	while (1) {

	if ( fgets(line,120,fp) == NULL ) {
		printf("design file error\n");
		fclose(fp);
		return(-1);
	}
	
	sscanf(line,"%s %s %s",var_name,var_value,var_units);
/*	printf("%s %s %s\n",var_name,var_value,var_units); */
	
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
	

	
	if (strcmp (var_name,"cycle") == 0) 
	cycle = atoi(var_value);
	
	if (strcmp (var_name,"learn_level") == 0) 
	sscanf(var_value,"%f",&learn_level);
	
	if (strcmp (var_name,"pc_level") == 0) 
	sscanf(var_value,"%f",&pc_level);
	
	if (strcmp (var_name,"random_presentation") == 0) 
	random_pres = 1;
	
	if (strcmp (var_name,"conn_specs") == 0) 
	*sc = 1;
	if (strcmp (var_name,"ioc") == 0) 
	*ioc = 1;	

	
        }


}

net_sweep(p,nc,np,num,net,ss,train)
int *nc,*np;
double *ss;
struct nn_num *num;
struct nn_param *net;
{
int j;
double squares;

/*	if (debug) printf("pat %d\n",p); */
		
	if ( p >= num->pats) {
			printf("ERROR ! p %d\n",p);
			p = 0;
		}


       			run_net(p, num,net);


       					 /* Back 		*/
					 /* Propagation		*/
       			 		 /* of errors		*/

if ((output_error(p,net, num, &squares,num->layers-1,train)) == 1)
			*nc += 1;	

       			/* Error written to squares	*/

        if ( train == 1 ) {
			for ( j= 1; j < (num->layers -1 ); j++) { /* maximum of 2 hidden rows */
			hidden_error(p, net,j);
			}
        }

          		*ss += squares;
	
	*np += 1;

}



/******************************************************************************************************
 * 						get_phrase					      *
 *												      *
 *	read  label file name and associated analysis file					      *
 ******************************************************************************************************/

get_phrase (fp , first)
FILE *fp;

{
char line[120];
	
	    if ( fgets(line,120,fp) == NULL ) 
	    	                 return 0;
		sscanf(line,"%s", lab_file);

		if ( ! first) {
		  gs_close_df(&df);
		  fclose (lab_fp);
	        }
	        
	     if ( (lab_fp = fopen(lab_file,"r")) == NULL) {
		dbprintf(1,"can't open %s\n",lab_file);
	     		return 0;

	      }
	    if ( fgets(line,120,fp) == NULL ) 
	    	                 return 0 ;
		sscanf(line,"%s", datafile);
		   
		if (!gs_open_frame_file(datafile,&df)) {
			dbprintf(1,"error opening data file %s\n",datafile);
			return 0;
		}
	dbprintf(1,"lab_file  %s \ndata_file %s\n",lab_file,datafile);
	printf("lab_file  %s \ndata_file %s\n",lab_file,datafile);	
		return (1);
}

get_phrase_seg (fp)
FILE *fp;

{
char line[120];


char date[120];	
char val_string[90];
static int lbi = 0;

	    if ( fgets(line,120,fp) == NULL ) 
	    	                 return 0;
	
		sscanf(line,"%s", datafile);
	
	if (!gs_open_frame_file(datafile,&df)) {
			dbprintf(1,"error opening data file %s\n",datafile);
			return 0;
		}
	      sprintf(lab_file,"lab.%d",lbi);
		lbi++;
	
	     if ( (lab_fp = fopen(lab_file,"w")) == NULL)
	     		return 0;
/* lab file header */
		gs_get_date(date);

	        gs_wrt_lab(lab_fp,"AL GENERIC 1.0"," "," ");
		gs_wrt_lab(lab_fp,date," "," ");
	        gs_wrt_lab(lab_fp,"datafile",datafile,"ANN");

	    	/*      start_of_data */


	        gs_wrt_lab(lab_fp,"start_of_data","0","bytes");

	    	/*	sample_freq */

		sprintf(val_string,"%f",df.f[SF]);

	        gs_wrt_lab(lab_fp,"sample_freq",val_string,"Hz");

	    	/*	labeller etc */


		gs_wrt_lab(lab_fp,"labeller","CRS_ANN"," ");


dbprintf(1,"lab_file  %s \ndata_file %s\n",lab_file,datafile);
	printf("lab_file  %s\ndata_file %s\n",lab_file,datafile);
	fflush(stdout);
		return (1);

}


/******************************************************************************************************
 * 						get_input					      *
 *												      *
 *	read  input frames from analysis file					                      *
 ******************************************************************************************************/

get_input (frame_num)

{
int pat = 0;
int cell = 0;
int k = 0;
int dp =0;
int i;
int n;
int eof;
	    
                eof = gs_seek_frame(&df,frame_num,0);

 dbprintf(2,"VL %d %d s eof %d\n", (int) df.f[VL], (int) df.f[SOD], eof);	
	        n = Num.in / (int) df.f[VL];
	        
        	for (i = 0 ; i < n ; i++ ) {

		eof = gs_read_frame(&df, data);

		if( debug > 2 || eof <= 0) {
		dbprintf(2,"eof %d data %f fr %d\n",eof,data[0],i);
		return 0;	
	        }

			for (k = 0; k < (int) df.f[VL] ;  k++ ) {
	        	   input[pat][cell] = data[ k];
  dbprintf(2,"ip pat %d cell %d  val %f\n",pat ,cell,input[pat][cell]);  
		        cell++; 
			}

		 }
}




/******************************************************************************************************
 * 			get_class_member					      *
 *												      *
 *	read current class from label file and determine which member (if any) of target class        *
 ******************************************************************************************************/

get_class_member (frame_number, label)
char label[];
{
int start ,stop;	
char token[7];
int i,n;
char target[15];
        
        n = Num.in / (int) df.f[VL];
	start = (int) (frame_number * df.f[FS] * df.f[SF]) ;
	stop = (int) ((frame_number+n) * df.f[FS] * df.f[SF]) ;

	strcpy(label,"?");
	
	/* use label file */
	
	if ( ! get_label(start,stop,token)) 
		return -2;

	dbprintf(2,"gcm start %d stp %d tkn %s\n",start,stop,token);		

	
	i = get_class(token, target);

	
	if (i != -1) {
	   set_target(target);
	   dbprintf(2,"gcm class %d %s\n",i,token);
           strcpy(label,token);
        }
	return i;
}

get_label(str_nu,stp_nu,token)
char token[];
{

char w1[30],w2[30];
int k = 0;
int lastk = 0;
char last_lab[10];

	strcpy(last_lab,"h#");
	fseek(lab_fp,0,0);

	while (1) {	
       	
        k= gs_read_lab (lab_fp,"label",w2,"*","END_LAB");
        	 if ( k == 0) {
	           dbprintf(1,"label %d nf\n",k);
	        	return 0;
		 }
	          strcpy(token,w2);
	
	         if (! gs_read_lab(lab_fp,"s2",w2,"*","*") )
	         	return 0;
	         	k = atoi(w2);

	        	if ( k >= stp_nu) {
		  if ( (stp_nu - lastk) < ( lastk - str_nu)) 
		  strcpy(token, last_lab);
		  dbprintf(2,"label %s %d\n",token,k);
	         	return 1;	
		}
			lastk = k; 
		        strcpy(last_lab,token);
        }

}


get_class( token, target)
char token[ ], target[];
{
int i,k;

 i = cat_hash(token,0);

 if ( i >= 0 ) {
 	strcpy(target, cat_table[i].op_class_code);
	k = cat_table[i].op_class;
        dbprintf(2,"get_class %s %d %d %d\n",token,k,cat_table[i].num,i);
	return k;
        }  else 
	return -1;
}

set_target(tar)
char tar[];
{
int k;

   k = atoi ( tar );
   dbprintf(2,"set_tar %s %d\n",tar,k);
   compute_targets(k,0,&Num);

}


cat_hash (name, new)
char *name;
{
   int   hash;
   int   step = 7;
   int   max = 7;
   char vname[10];
   char *ptr;
   sscanf(name,"%s",vname);
   
   ptr = &vname[0];
   
   for (hash = 0; *ptr != '\0';)
      hash += *ptr++;

   hash = (hash % MAXCAT);

   while (1) {

      if (!strncmp (vname, cat_table[hash].ic_name,10) 
          || cat_table[hash].num == -1 ) {
	
          dbprintf(2,"%s hash index %d\n",vname,hash);	 
	
	  if (new) {
	    strncpy (cat_table[hash].ic_name, vname, 10);
	    cat_table[hash].num = 1 ;
	    return (hash);      
	   } else if (cat_table[hash].num == -1 ) 
	   return -1;
	   else
	   return hash;


        }
	 hash += step;
	 if (hash > MAXCAT-1)
	    hash = (hash - MAXCAT-1);
   }

}

init_cat()
{
int i, cat_num;
FILE *cfp;
char line[120];
char i_cat[60];
	
	dbprintf(1,"init_cat\n");
	
	for ( i =0 ; i < MAXCAT ; i++) {
        cat_table[i].num = -1;        
	strcpy(cat_table[i].ic_name,"\0");
	strcpy(cat_table[i].oc_name,"\0");	
	}
}




init_conn()
{
int i, n;

	for (i =0 ; i< Num.cells; i++) {
		
	Cell_Conn[i].nipc = 0;	
	Cell_Conn[i].nopc = 0;	
        }	
}

/* for token find next frame_number */



get_frame( op_class, cfn ) 
{
int k,i,n;
char w1[30],w2[30];
char token[30],target[15];;

	dbprintf(1,"get frame oc %d\n",op_class);

        

	while (1) {	
       	
        k= gs_read_lab (lab_fp,"label",w2,"*","END_LAB");

        	 if ( k == 0) {
/* if EOF */


                   dbprintf(1,"finish phrase \n");

		   if ( !get_phrase(list_fp ,0) ) {
		        fclose( list_fp);	

			if ( (list_fp = fopen(Pat_file,"r")) == NULL) {
			dbprintf(1,"pat file not found\n");
			exit (-1);
			}

		    if ( !get_phrase(list_fp ,0) ) {
		    printf("error opening new phrase\n");
		    exit (-1);
		    }

		    }
		 } 
		 else {

	          strcpy(token,w2);

/* is current token of op_class */

	         i = get_class(token, target);	

		 if ( i == op_class ) {

		         if ( gs_read_lab(lab_fp,"s1",w2,"*","*") ) {
	        	 	k = atoi(w2);
/* compute frame number */
	   	          cfn = (int) ( k / ( df.f[FS] * df.f[SF]) ) ;

	                  dbprintf(1,"op_class i %d token %s cfn %d\n",i,token,cfn);
                          set_target(target);
         	
                          return (cfn );
		        }
		}

        }

}

}


segment_phrase () 
{
int i;
int opc;
int last_opc = -2;
int frame_num =0;
int input_found;
int lab_nu = 1;
		
	/* move frame by frame */
				
	        FPE  = 0;		
	          if ( !get_phrase_seg(list_fp) ) 
		  exit (-1);
dbprintf(1,"seg n op class %d\n",N_op_classes );		

	for ( i = 0; i < N_op_classes; i++) {
			OC[i].np = 0;
			OC[i].nc = 0;		
			}
     while ( 1 ) {

                input_found = get_input (frame_num) ;

	         if ( input_found) {		
		run_net(0, &Num,&ANN);
			
	        opc = net_op ();
                dbprintf(1,"seg opc %d\n",opc);		
		if ( opc >= 0 ) {
		OC[opc].np ++;
		}
		/* if segment change update label file */
		if ( opc != last_opc ) {
		update_lab_file ( opc, frame_num, &lab_nu);	
		 last_opc = opc;
	        }
	        
		
		/* update class  recog score */
		frame_num++;
		        } else {

				   gs_close_df(&df);
		   		   fclose(lab_fp);

		        	/* end of input phrase  */
		printf("segmented phrase %d labels\n",lab_nu);

		fflush(stdout);
				   lab_nu =1;

				   frame_num = 0;
		        	/* close label files & get exit */
			          if ( !get_phrase_seg(list_fp) ) 
	  			  break;
		        }

		}

	dbprintf(1,"finished segmenting \n");
}


segment_recog (np,nc, sumsq) 
int *nc,*np;
double *sumsq;
{
int train = 0;
int class_member;
int frame_num= 0;
int i;
int input_found;
char token[30];
/* move frame by frame */
double squares;
int n_phrases = 0;
				
	        FPE  = 0;		
	        *np = 0;
		*nc = 0;	
		*sumsq = 0.0;   
	
	dbprintf(1,"seg_rec nop_class %d\n", N_op_classes) ;
	
		for ( i = 0; i < N_op_classes; i++) {
			OC[i].np = 0;
			OC[i].nc = 0;		
			}

        
	while ( 1 ) {
		
		 class_member = get_class_member(frame_num, token) ; 

		 if (class_member == -2 ) {
	        printf("SR np %d nc %d pc %f\n",*np,*nc, ( *nc / (float) *np * 100.0));
	        fflush(stdout);

	          if ( !get_phrase(list_fp, 0) ) 
			break;      
	          else
		  n_phrases++;  

		  frame_num = 0;
		  class_member = get_class_member(frame_num, token) ; 
		 }

	         dbprintf(1,"cm %d %d\n", class_member,frame_num);

		 if (class_member >= 0 ) {
 		 input_found = get_input (frame_num) ;

	         if ( input_found) {		
		
	 			OC[class_member].np += 1;
				i = *nc;
				run_net(0, &Num,&ANN);
			        *np += 1;       		
	
      			if ((output_error(0,&ANN, &Num, &squares,Num.layers-1,0)) == 1)
				   *nc += 1;	
				*sumsq += squares;
		
			if (*nc > i) {
			OC[class_member].nc += 1;
	                dbprintf(1,"HIT cm %d np %d nc %d\n",class_member,OC[class_member].np,
        		OC[class_member].nc); 
        		} else
	                dbprintf(1,"MISS np %d nc %d\n",*np,*nc);

			/* update class  recog score */

	        } 
	        else {
	    printf("SR np %d nc %d pc %f\n",*np,*nc, ( *nc / (float) *np * 100.0));
    	    dbprintf(1,"SR np %d nc %d pc %f\n",*np,*nc, ( *nc / (float) *np * 100.0));    
		  frame_num = 0;
	          fflush(stdout);

			/* get next phrase */	        	
	        	  if ( !get_phrase(list_fp ,0) ) 
				break;    
			  else
			  n_phrases++;  
                }
        } /* class member */ 
   	         frame_num++;	


       }

	printf("N_phrase %d\n",n_phrases);

}


net_op( )
{
int opc; /* return output category */	
char code[30];
int i,k;
int op = 2;
/* decode output layer */
	strcpy(code,"\0");
	
	for (i = NL[op].lc ;  i >= NL[op].fc ; i-- ) {
		if ( activity[i] >= 0.5)
		strcat(code,"1");
		else
		strcat(code,"0");
dbprintf(1,"net_op %s %f %d\n",code, activity[i],i);
	}
dbprintf(1,"net_op bin %s \n",code);
	k = bin_oct(code);

	for (i = 0; i < N_op_classes ; i++) {
dbprintf(1,"opc %d net_op oct  %d  op_code %d\n",i,k,OC[i].op_code);
		if ( k == OC[i].op_code)
		return i;
	}
	return -1;
}

bin_oct( code )
char code[];
{
int i,j,m,p,k;

	i = strlen( code);
	if (i <= 0)
	return (-1);

dbprintf(1,"bo %s %d\n",code,i);
	k  = 0;

	while (1) {
		j= 0;
		m = 1;

	for (p =0 ; p < 3 ; p++ ) {
	
	if ( code[i-1] == '1') {
		j = j + m;
	}
	i--;
	m = m * 2;
		if (i <= 0) {
			break;
        	 }
         }		
        k=k * 10 + j;
	if (i <= 0)
	break;
        }

	return k;
}


update_lab_file ( opc, frame_num, lab_nu)
int *lab_nu;
{
char label[60];
int sample;
char val_string[60];

	sample = (int) (frame_num * df.f[FS] * df.f[SF]) ;
/* opc label */
		if ( opc >= 0)
		strcpy(label,OC[opc].label);
		else
		strcpy(label,"?");

	dbprintf(1,"%s %d\n",label,sample);
	
			sprintf(val_string,"%d",sample);
			
			if (*lab_nu > 1 )
	        	gs_wrt_lab(lab_fp,"s2",val_string," ");

			sprintf(val_string,"%d",*lab_nu);

		        gs_wrt_lab(lab_fp,"label",label,val_string);

			sprintf(val_string,"%d",sample);
	        	gs_wrt_lab(lab_fp,"s1",val_string," ");

		*lab_nu += 1;	
}



report_net_stats(sweep, sumsq ,np,nc) 
double sumsq;
{
double sq, rms, pc;
int i;
	rms = sqrt (sumsq/ (1.0 * np * Num.out));
	pc = (nc / (float) np) * 100.0;
	sq = 0.5 * sumsq;
	printf("sweep %d pats %d error %f rms %f pc %f\n",sweep,np,sq,rms, pc);
	for ( i = 0 ; i < N_op_classes ; i++ ) {
	OC[i].pc = OC[i].nc/ (float) OC[i].np * 100.0 ;	
	printf("class %d np %d nc %d pc %f\n",i,OC[i].np,OC[i].nc,OC[i].pc);	
	
        }
    fflush(stdout);
}


build_training_files()
{
int n_toks, i ,class_member ,input_found ,frame_num , k;
char token[30];
char line[120];
int opc, tok_n;
int n, cell;
	        n = Num.in / (int) df.f[VL];

	if (( train_lab_fp = fopen("train1.lab","w")) == NULL)
	    exit (-1);

	if (( train_ana_fp = fopen("train.ana","w")) == NULL)
	    exit (-1);	    

	/* get token input & write to train files */
				
	        FPE  = 0;		
	
		for ( i = 0; i < N_op_classes; i++) {
			OC[i].np = 0;
			OC[i].nc = 0;		
			}

	         frame_num = 0;
        	 n_toks =0;


	while ( 1 ) {
		
  class_member = get_class_member(frame_num ,token) ; 

		 if (class_member == -2 ) {

	          if ( !get_phrase(list_fp,0) ) 
			break;      
		  frame_num = 0;
		  class_member = get_class_member(frame_num ,token) ; 
	          dbprintf(1,"bt data %s\n",datafile);
		 }


		 if (class_member >= 0 ) {
 		 input_found = get_input (frame_num) ;

	         if ( input_found) {		

		OC[class_member].np += 1;

 fprintf(train_lab_fp,"%d %d %s %d %s %s\n",class_member, n_toks, token, frame_num,lab_file,datafile);
 fflush(train_lab_fp);
		cell =0;
	        
        	for (i = 0 ; i < n ; i++ ) {		

			for (k = 0; k < (int) df.f[VL] ;  k++ ) {
	        	   data[ k] = input[0][cell];
		        cell++; 
			}
	        
	       	        fwrite(data, sizeof ( float), (int) df.f[VL], train_ana_fp); 
		 }
	        
	        n_toks++;
	        
	        } 
	        else {
		  frame_num = 0;
			/* get next phrase */	        	

	          if ( !get_phrase(list_fp ,0) ) {
	          	fclose (list_fp);
			break;      
	           }

                } 
   	        
		}
   	        frame_num++;	
       }

	printf("Build train files N_toks %d \n", n_toks);
	/* print N_op_classes */

	fclose (train_lab_fp);
        fclose (train_ana_fp);	

        k = OC[0].np;
        
	for ( i = 0; i < N_op_classes; i++) {
		if ( OC[i].np > k)
		k = OC[i].np;
		if ( OC[i].np <= 0)  {
			printf("no examples of opc %d\n",i);
			exit(-1);
		}
        }


/* re_organize lab file */

 	if (( train_lab_fp = fopen("train1.lab","r")) == NULL)
	    exit (-1);
	    
	if (( fp = fopen("train.lab","w")) == NULL)
	    exit (-1);	   

        
	for ( i = 0; i < N_op_classes; i++) {
	     fseek(train_lab_fp,0,0);
			OC[i].np = 0;

	while ( 1) {

	    if ( fgets(line,120,train_lab_fp) == NULL )  {
			 break;
	    		}
	sscanf(line, "%d %d %s\n",&opc,&tok_n, token);

	if ( opc == i) {
	OC[opc].np += 1;
	fprintf(fp,"%d %d %s\n",opc,tok_n, token);

             }
           }
       }


        k = OC[0].np;
        
	for ( i = 0; i < N_op_classes; i++) {
		printf("i %d n %d\n",i,OC[i].np);
		if ( OC[i].np > k)
		k = OC[i].np;
        }
	
	fclose (fp);
	fclose (train_lab_fp);


	if (( train_ana_fp = fopen("train.ana","r")) == NULL)
	    exit (-1);	    

 	if (( train_lab_fp = fopen("train.lab","r")) == NULL)
	    exit (-1);


	return (k );
}


count_tokens ()
{
int n_toks, i ,class_member ,input_found ,frame_num , k, tok_n;
char token[30];
char line[120];
int opc;

	printf("count tokens\n");
	
	if (( train_lab_fp = fopen("train.lab","r")) == NULL)
	    exit (-1);

	if (( train_ana_fp = fopen("train.ana","r")) == NULL)
	    exit (-1);	    

				
	        FPE  = 0;		
	
		for ( i = 0; i < N_op_classes; i++) {
			OC[i].np = 0;
			OC[i].nc = 0;		
			}


        	 n_toks =0;


	while ( 1 ) {
		

		    if ( fgets(line,120,train_lab_fp) == NULL )  {
			 break;
	    		}
		sscanf(line, "%d %d %s\n",&opc,&tok_n, token);
		OC[opc].np += 1;

	        
	        n_toks++;
	}
	
	/* print N_op_classes */

        k = OC[0].np;

	printf("n_toks %d\n",n_toks);
		        
	for ( i = 0; i < N_op_classes; i++) {
		printf("i %d n %d\n",i,OC[i].np);
		if ( OC[i].np > k)
		k = OC[i].np;
		if ( OC[i].np <= 0)  {
			printf("no examples of opc %d\n",i);
			exit(-1);
		}
        }
	
	fflush(stdout);
	
	return (k );
}


get_train_input ( r )
{
int pat = 0;
int cell = 0;
int k = 0;
int dp =0;
int i;
int n;
int eof;
int opc_found = 0;
int tok_n, opc;
long int tok_start;
char line[120];
char token[40];
char target[30];

	/* get frame number */
	tok_start = OC[r].last_tok;
	fseek(train_lab_fp, tok_start,0);	

     while ( ! opc_found ) {
		
		    if ( fgets(line,120,train_lab_fp) == NULL )  {
		    	fseek(train_lab_fp,0,0);
	    		    if ( fgets(line,120,train_lab_fp) == NULL )  {
	    		    dbprintf(1 ," error reading train_lab file\n");
	    		    exit(0);
			    }
	    		}
     sscanf(line, "%d %d %s\n",&opc,&tok_n, token);
/* this must work through all tokens */

			if ( opc == r) {
		        tok_start = ftell(train_lab_fp);	
			OC[r].last_tok = tok_start;

				opc_found = 1;
		        }
	     }

     dbprintf( 1, "tr_tok opc %d tok_n %d %s\n",r,tok_n,token);
	        
     tok_start = tok_n * Num.in * sizeof (float);
     fseek ( train_ana_fp, tok_start, 0);
		

    eof =fread(data, sizeof (float) , Num.in , train_ana_fp); 

	if( debug > 2 || eof <= 0) {
	dbprintf(2,"eof %d data %f fr %d\n",eof,data[0],i);
	return 0;	
        }

	for (k = 0; k < Num.in ;  k++ ) {
       	   input[pat][cell] = data[ k];
           dbprintf(2,"ip pat %d cell %d  val %f\n",pat ,cell,input[pat][cell]);  
        cell++; 
	}
		i = get_class(token, target);
		 set_target(target);
		 return 1;
}


