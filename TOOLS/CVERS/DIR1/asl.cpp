/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////                                       ASL                            
///        Array Scripting Language
//         CopyRight   - RootMeanSquare - 1990,2017 --->               
//         Mark Terry                                                        
/////////////////////////////////////////<v_&_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include <gasp-conf.h>

#include<sys/socket.h>
#include<arpa/inet.h>
#include "si.h"
#include "gshm.h"
#include "win.h"
#include "wcom.h"
#include "sam.h"
#include "gstime.h"
#include "ctype.h"
#include "chem.h"
#include "clock.h"
#include "debug.h"
#include "externs.h"
#include "vsh.h"
#include "sig.h"
#include "fop.h"
#include "prep.h"
#include "wcom.h"
#include "thread_w.h"
#include "sinit.h"
#include "opera.h"

#ifndef linux

#if  !WNT
#include <sgtty.h>
#endif

#endif


#include <sys/ioctl.h>
#include <signal.h>

#if ! WNT
#include <sys/ipc.h>
#include <sys/shm.h>
#endif

#if sun && !SOLARIS
#include <sun4/setjmp.h>
#else
#include <setjmp.h>
#endif

#define CDB_ASL DBOFF
#undef CDB_DEBUG
#define CDB_DEBUG CDB_ASL

//#include "dbug/dbpr.h"

extern int Use_Dlls;

int debug = -1;

int St_xic_error = 0;
int N_error = 0;
int Last_error = 0;
int Last_err_line = 0;
int MaxProgErrors = -1;
int MaxErrorsSet = 0;

char Last_func[240];

extern Svar GR;

#include "asl_signals.h"

SIGHAND   Shand[66];



char Host_name[64];
int spawnX = 0;

char Script_name[256];

char out_name[256];
char err_name[256];
char tst_name[256];
char oln_name[256];

char Hist_file[256];

//int Draw_Laser = 0;

extern int Fhout;   // can redirect  output to a file -o option

extern int Mono;
void im_redraw (GS_window * wp);
void show_use ();

Timer *Asl_timer;

int  buildFilter (int argc, char *argv[],char *envp[], FILE *sfp, int starg);

//  version number for our libs
void rdp_info();
void pexpnd_info();
void array_info();
void dbug_info();
void fop_info();
//////////////////////////////////

void setAslOption (int wd, int onoff)
{
  Asl_options = (onoff) ? (Asl_options | wd) : (Asl_options & ~wd);
}
//========================
void
show_use ()
{
  printf ("asl [options] script  arg1 arg2 ...\n");
  printf ("asl -i\n");
  printf ("asl -X script arg1 arg2 ...\n");
  printf ("options:\n\
\t-c   compile - produce an executable \n\
\t-i   starts an interactive shell \n\
\t-l   produce a listing file .lic of intermediate code\n\
\t-o   <outname> standard output is directed to named file\n\
\t-e   <errorname> standard error output is directed to named file\n\
\t-t   <testname>  output from test functions is directed to named file\n\
\t-v   version\n\
\t-w   warn,debug\n\
\t-u   produce a unique debug file using the pid \n\
\t-X   start the X-window graphic display on this machine \n\
             and use shared memory and pipes for communication \n\
\t-S   ip address (e.g. 127.0.0.1, 192.168.1.115) communicate graphic instructions\n\
              via socket to a GWM  (default port is 4779) \n\
\t-f   use following single quoted args as lines in script - but uses a builtin while input loop\n\
\t-s   use following single quoted args as lines in script\n\
\t\te.g. asl -s \'<<\" $(date()) \\n\"\'\n\
\t\t   would print today's date and\n\
\t\t  \'pan a = 1; pan b = 0; for (i=0;i<1000;i++) {<<\"$i $b  \\n\";  t= a ; a= a +b; b = t;}\'\n\
\t\t  would print the first 1000 fibonacci numbers\n\
\t\tthe script file is usually \'scriptname\'.asl \n\
\t   if -c is used as an option an intermediate code file 'scriptname' is\n\
\t   produced which is executable and can then be run by typing .\/'scriptname\' on the command line.\n\
\t-k  <filename> keep the one-line code from -s option into a  <filename>.asl (default it is removed)\n\
\n\n");


//  obsolete options  
//\t-j   turns off second-pass intermediate code \n
//\t-a   show ic code \n			\

  
  show_version ();
  exit (-1);
}

// pan icode not working TBD
//\tasl -s \'pan a = 1; pan b = 0; for (i=0;i<100;i++) {<<\"$i $b  \\n\";  t= a ; a= a +b; b = t;}\'\\n\
//\twould print first 100 numbers in fibonacci sequence\n\

int Asl_port = 4779;

char Asl_host_address[64] = "127.0.0.1";

void
init_hist_file (char *stem, int argc, char *argv[])
{
  char date[128];
  char name[512];
  FILE *Hf = NULL;

  sprintf (name, "%s/His/%s.his", GS_WORK, stem);

  gs_get_date (&date[0], 1);

  Hf = fopen (name, "a+");
  //  DBT("hist file? %s Hf %f\n",name, Hf);
  fprintf (Hf, "%s: ", date);
  fprintf (Hf, "%s ", asl_version);
  fprintf (Hf, "%d ", GS_PID);

  for (int i = 0; i < argc; i++)
    {
      fprintf (Hf, "%s ", argv[i]);
    }

  fprintf (Hf, "\n");
  fclose (Hf);
}
//=======================================

void
close_hist_file (char *stem)
{
  char date[128];
  char name[512];
  FILE *Hf = NULL;

  sprintf (name, "%s/His/%s.his", GS_WORK, stem);

  gs_get_date (&date[0], 1);

  Hf = fopen (name, "a+");
  //  DBT("hist file? %s Hf %f\n",name, Hf);
  fprintf (Hf, "%s: ", date);
  fprintf (Hf, "%s ", asl_version);
  fprintf (Hf, "%d ", GS_PID);
  fprintf (Hf, "exit_status %d nerrors %d invalidSivs %d ", Exit_status, N_error, InvalidSiv);
  fprintf (Hf, "\n");
  fclose (Hf);
}

/*
\tasl -s \'<<\" $(pt(\\\"ag\\\"))\\n\"\'\n\
\tasl -s \'<<\" $(pt(47))\\n\"\'\n\
\twould print the entry for silver in the periodic table\n\
*/


int
setupXGS ()
{
  int ok = 0;
  int flags, inflags, delflags;

  if (spawnX)
    {

      if (Xspawn (Asl_wp, Script_name, &ASL_fdin) == NOTOK)
	{
	  printf (" can't spawn off xgs !! \n");
	  exit (-1);
	}

      DBPF 
	    ("Spawned xgs ASL_FDIN %d !! Use_gwm %d \n", ASL_fdin,
	     checkAslOption (ASL_USE_GWM));

    }

  //  if (Use_gwm)
  {

    DBPF  ("setup IPC with %d\n", ASL_fdin);


    Asl_wp->setWAW (ON, SHM_IPC);

    ok = setUpIPC (Asl_wp, ASL_fdin);



    // inflags = fcntl (ASL_FDIN, F_GETFL, 0);
    // delflags = fcntl (ASL_FDIN, F_SETFL, inflags | O_NDELAY);
    DBPF("ASL_FDIN %d inf %d out %d scr %s\n", ASL_fdin, inflags, delflags, Asl_wp->fname);

    if (!ok)
      {
	// printf("ipc not ok ! -- exit\n");
	DBT("ipc not ok ! -- exit\n");
	exit (-1);
      }

    // now wait for the GWM plot thread established message
#if 0
    if (!checkPlotThread ())
      {
	printf ("no GWM plot thread ! --so exit\n");
	DBT("no GWM plot thread ! --so exit\n");
	exit (-2);
      }
#endif

  }

  //  else
  // {
  //  EXIT_CC = 1;
  //  ASL_OUT = -1;
  // }


  Asl_wp->pfd[0] = ASL_fdin;

  DBPF 
	("FDIN %d FDOUT %d WN %d  Use_gwm %d\n", ASL_fdin, ASL_OUT,
	 Asl_wp->getWid(), checkAslOption (ASL_USE_GWM));

  if (Asl_wp->pid < 0 || !ok)
    {
      DBPF("my window pid is %d %d\n", Asl_wp->pid, sizeof (GS_window));
      DBE("can't talk to XGS so Exiting \n");
      exit (-1);
    }


  DBPF 
	("%d  %s %s %s\n", Asl_wp->pid, Asl_wp->fname, Host_name,
	 asl_version);


  return 1;

}

//-----------------------------------------------


int
asl (GS_window * wp, int gwm)
{
// get commands and submit to GWM 

  DBPF  ("@ %u\n", Asl_timer->getMsecs ());

  //printf("gwm %d script %s @ %u\n", gwm, wp->fname, Asl_timer->getMsecs());

  if (!checkAslOption (ASL_USE_SOCK))
    {

      if (checkAslOption (ASL_USE_GWM))
	{
	  setupXGS ();
	}

    }

  script (wp->fname);

  if (checkAslOption (ASL_USE_GWM))
    {
      //printf("exit gwm \n");
      SendExitGWM ();
      // exit msg to gwm ??
    }

}

//-----------------------------------------------

void
sig_init ()
{

  if (signal (SIGPIPE, SIG_IGN) != SIG_IGN)
    signal (SIGPIPE, (void (*)(int)) gs_onpipe);

  if (signal (SIGFPE, SIG_IGN) != SIG_IGN)
    signal (SIGFPE, (void (*)(int)) gs_onfpe);

  if (signal (SIGCHLD, SIG_IGN) != SIG_IGN)
    signal (SIGCHLD, (void (*)(int)) gs_onchild);

  // default action to ignore CNTRL-C INT

  if (signal (SIGINT, SIG_IGN) != SIG_IGN)
    signal (SIGINT, (void (*)(int)) gs_onintr);

    if (signal (SIGTERM, SIG_IGN) != SIG_IGN)
    signal (SIGTERM, (void (*)(int)) gs_onterm);

    if (signal (SIGSEGV, SIG_IGN) != SIG_IGN)
     signal (SIGSEGV, (void (*)(int)) gs_onsegv);

  /*
   * if (signal (SIGTSTP, SIG_IGN) != SIG_IGN) signal (SIGTSTP,
   * gs_onsusp);
   */

  // default action to obey CNTRL-\ QUIT
  //  if (signal (SIGQUIT, SIG_IGN) != SIG_IGN)
  //    signal (SIGQUIT, (void (*)(int)) gs_onquit);
}

//-----------------------------------------------

fd_set Rasl;

extern char **ENVP;

char PRG_stem[256];

#if FREEBSD || WNT
;
#else
#include <mcheck.h>
#endif

void
byeBye ()
{
  if (N_error > 1)
    {
      // printf("<%d> errors\n", N_error);
      //  printf("<<<GoodBye>>>\n");
      // remove xic file
    }
}

//-----------------------------------------------

uint32_t Asl_options = 0;
int Use_vsh = 0;
void
single_flags (char *argp, int &dblevel)
{
  while (*argp != '\0')
    {

      if (*argp == 'c')
	{
	  Asl_options |= ASL_COMPILE;
	}

        if (*argp == 'x')
	{
	  Asl_options |= ASL_RUN_EXE;
	}

        if (*argp == 'd')
	{
	  Asl_options |= ASL_DEBUG_SPECIFIC;		  	  
          //fprintf(stderr,"set debug_spec %X\n",Asl_options);
	}

      if (*argp == 'w')
	{
	  Asl_options |= ASL_DEBUG;
	  dblevel = 1;
	  // printf("%c -w arning \n",*argp);
	}

      if (*argp == 'W')
	{
	  dblevel = 1;
	  setCW (DBaction, DBSTEP, ON);
	}

      if (*argp == 'l')
	{
	  Asl_options |= ASL_LIST;
	}

      if (*argp == 'j')
	{
	  Asl_options &= ~ASL_COMPILE;
	  Asl_options &= ~ASL_SPIC;	// turn off the second pass intermediate code
	}
      
      if (*argp == 'u') {
		  Asl_options |= ASL_DEBUG_UNIQUE;
      }

      if (*argp == 'i') {
	Use_vsh = 1;
      }
      
      ++argp;
    }
}

//---------------------------------------------

void init_periodic_table ();

Proc *proc_table[MAXPROCS];


int
main (int argc, char *argv[], char *envp[])
{
  /// check for leaks comment out in release version
  ///  mtrace();

  char *argp;
  char *getenv ();
  Svar asldir ("asldir");
  int nread, i, j;
  int ok;
  int nbr;
  int got_script = 0;
  int run_one_liner = 0;
  int build_filter = 0;
  int one_liner_argc = 0;
  char type;
  int ViaXGS = 0;
  char rol_name[128];

  int dblevel = 0;

  int shift_args = 0;
  asl_error_codes rval;
  //

  //printf("argv[0] %s\n", argv[0]);
  
  StartSecs = GetUtime ();

  j = 0;


  init_si ();
  
  Asl_timer = new Timer;

  ASL_argc = argc;
  ASL_fdin = 0;
  // turn on debug 
  GS_PID = getpid ();

  ASL_pip = create_pip ();	// always

  
  init_pp ();			// this must be before any hash operations

  //  printf("argc %d argv[0] %s \n",argc,argv[0],argv[1]);

  set_asl ();

  Use_Dlls = 1;			// for non dll version set to zero
  
  // we can set up signal handle via sig_handle in scripts
  // to ignore, use default action or call script handle routine
  sig_init ();

  win_init ();			/* catch SIGUSR1 */

  //  Table_init ();

  Use_gwm = 0;

  int argistart = 1;
  // 
  // 0 should be asl
  // 1 could be -X for graphic -S to indicate following script name
  // or -cwl flags for compile, show warnings and to produce a xic listing file
  //
  // after these should be script_name
  // and rest following are args to the script
  //
  //printf("argc %d  first(asl?) %s  second(options)  %s  third(prog) %s \n",argc, argv[0], argv[1],  argv[2]);
  
  if (argc < 2)
    {
      printf ("no args -- need a script 'asl -h' gives  help \n");
      exit (-1);
    }

  srand (get_time_seed ());
  store_value (&Lstate, OFFSETZERO, "main", SVAR);

  if (*argv[1] != '-')
    {
      strcpy (Script_name, argv[1]);
      argistart++;
      got_script = 1;
    }
   strcpy (err_name, "");
  //  for (int i = 0; i < argc ; i++) printf("[%d] %s \n",i,argv[i]);

  CL_warg = 1;

  i = argistart;

  //  init_si ();
  init_periodic_table ();
  //printf("i %d argc %d\n",i,argc);

  //Asl_options |=  ASL_COMPILE; // default

  setAslOption (ASL_SPIC,ON);	// default

  if (!got_script && argc >= 2
      && (!strcmp (argv[0], "asl") || (strstr (argv[0], "/asl") != NULL)))

    // if argv[0] is asl then we want to parse arg flags -w,-G,-S,-c , -l prior to script name
    // else we are executing an "executable" pre-compiled script
    //

    {
      while (i < argc)
	{

	  //      printf("[%d] %s \n",i,argv[i]);

	  if (*argv[i] == '-')
	    {

	      argp = argv[i];
	      argp++;

	      switch (*argp)
		{
		case 'S':

		  setAslOption (ASL_USE_GWM,ON);
		  setAslOption (ASL_USE_SOCK,ON);
		  strcpy (Asl_host_address, argv[i + 1]);
		  shift_args++;
		  shift_args++;
		  i++;

		  break;

		case 'P':
		  ASL_fdin = atoi (argv[i + 1]);
		  //     DBP("P pipe? %d\n",ASL_fdin);
		  Use_gwm = 0;
		  make_pipe_coms = 1;
		  shift_args++;
		  shift_args++;
		  i++;

		  break;

		case 'F':
                  setAslOption (ASL_FNAME_ASIS,ON);
		  break;
		case 'G':
		  ASL_fdin = atoi (argv[i + 1]);
		  //printf("graphic launch FDIN %d\n",ASL_fdin);
		  ViaXGS = 1;
		  Use_gwm = 1;
		  // make_pipe_coms = 1; // need this for viaXGS ?
		  shift_args++;
		  shift_args++;
		  i++;
		  setAslOption (ASL_USE_GWM,ON);
		  break;
		case 'c':
		  single_flags (argp, dblevel);
		  //Asl_options |= ASL_COMPILE;
		  //printf("%c -c compile \n",*argp);
		  shift_args++;
		  break;
		case 'i':
		  single_flags (argp, dblevel);
		  Use_vsh = 1;
		  setAslOption (ASL_INTERACT,ON);
		  shift_args++;
		  break;
		case 'a':
		  Asl_options |= PRINTICA;
		  shift_args++;
		  break;
		case 'h':
		  show_use ();
		  break;
		case 'o':
		  //      printf("after -S set script to %s\n",argv[i+1]);
		  strcpy (out_name, argv[i + 1]);
		  // stdout will be directed into this file
		  shift_args++;
		  shift_args++;
		  Asl_options |= ASL_FHOUT;
		  i++;
		  break;
		case 'e':
		  strcpy (err_name, argv[i + 1]);
		  // stdout will be directed into this file
		  shift_args++;
		  shift_args++;
		  Asl_options |= ASL_FHERR;
		  i++;
		  break;
		case 't':
		  strcpy (tst_name, argv[i + 1]);
		  // test function output will be directed into this file
		  shift_args++;
		  shift_args++;
		  Asl_options |= ASL_FHTST;
		  i++;
		  break;
		case 'v':
		  check_versions (argc, argv);
		  exit (-1);
		  break;

		case 'W':
		case 'w':
		  // show warnings
		  single_flags (argp, dblevel);
		  dblevel = 1;
		  shift_args++;
		  break;

		case 'l':
		  // produce listing of intermediate code
		  single_flags (argp, dblevel);
		  shift_args++;
		  Asl_options |= ASL_LIST;
		  break;
		case 'u':
		  // produce a unique debug file using pid
		  single_flags (argp, dblevel);
		  shift_args++;
		  //Asl_options |= ASL_DEBUG_UNIQUE;
		  break;
		case 'd':
		  dblevel = 1;
		  single_flags (argp, dblevel);
		  Asl_options |= ASL_DEBUG_HIGH;
		  //Asl_options |= ASL_DEBUG_SPECIFIC;		  
		  shift_args++;
		  break;
		case 'k':
		  strcpy (oln_name, argv[i + 1]);
		  // -s code  will be directed into this file
		  Asl_options |= ASL_KEEP_TAS;
		  shift_args++;
		  shift_args++;
		  i++;
		  break;
		case 'f':
		  build_filter = 1;
		  shift_args++;
		  one_liner_argc = shift_args + 1;
		  break;
		case 's':
		  run_one_liner = 1;
		  //printf("one-liner\n");

		  shift_args++;
		  one_liner_argc = shift_args + 1;
		  // should we compile anyway? - yes! ---
		  // the one liner is split into statments and written
		  // to a file tas_pid.asl
		  // then run as a 'normal' script
		  //
		  // and now problems with interpreted looping code
		  // Asl_options &= ~ASL_COMPILE;
		  // Asl_options &= ~ASL_SPIC;
		  //
		  break;
		case 'j':
		  Asl_options &= ~ASL_COMPILE;
		  Asl_options &= ~ASL_SPIC;	// turn off the second pass intermediate code
		  shift_args++;
		  break;
		case 'x':
		  single_flags (argp, dblevel);
		  Asl_options |= ASL_RUN_EXE;
		  shift_args++;
		  break;		  
		case 'X':
		  spawnX = 1;
		  shift_args++;
		  //CL_warg++;
		  Asl_options |= ASL_XW;
		  Use_gwm = 1;
		  setAslOption (ASL_USE_GWM,ON);
		  //printf("start an xgs\n");
		  break;

		default:
		  break;
		}
	      i++;
	    }
	  else
	    break;
	}
    }


  //fprintf(stderr,"ASL_OPTIONS %X  DS? %d\n",Asl_options,   checkAslOption(ASL_DEBUG_SPECIFIC));

  if (Asl_options & ASL_FHOUT)
    {
      // >> option append -a?
      Fhout = gsopenfile (out_name, "w");
      //    printf("redirect stdout to %s %d \n",out_name,Fhout);
      if (Fhout == -1)
	{
	  Asl_options &= ~ASL_FHOUT;
	  Fhout = 1;
	}
    }

  if (Asl_options & ASL_FHERR)
    {
      Fherr = gsopenfile (err_name, "w");
      if (Fherr == -1)
	{
	  Asl_options &= ~ASL_FHERR;
	  Fherr = 2;
	}
    }

  if (Asl_options & ASL_FHTST)
    {
      Fhtst = gsopenfile (tst_name, "w");
      if (Fhtst == -1)
	{
	  Asl_options &= ~ASL_FHTST;
	  Fhtst = 1;
	}
    }

  if (checkAslOption (ASL_USE_SOCK))
    {
      make_pipe_coms = 0;
    }

  // should be at script-name !!
  //printf("argv[%d] is %s\n",i,argv[i]);

  assert ((argc > 0));

  //DBPASSERT((argc > 0),"not enuf args");

  if (run_one_liner || build_filter)
    {

      // use args separate lines in script
      if ((Asl_options & ASL_KEEP_TAS))
	{
	  sprintf (rol_name, "%s.asl", oln_name);
	}
      else
	sprintf (rol_name, "tas_%d.asl", GS_PID);

      FILE *rol = fopen (rol_name, "w");

      if (rol != NULL)
	{
	  strcpy (Script_name, rol_name);

	  if (run_one_liner)
	    {
	      for (int ka = one_liner_argc; ka < argc; ka++)
		{
		  fprintf (rol, "%s\n", argv[ka]);
		  //printf("[%d] %s\n",ka,argv[ka]);
		}
	      fflush (rol);
	      fclose (rol);
	      got_script = 1;
	    }
	  else if (build_filter)
	    {
	      got_script =
		buildFilter (argc, argv, envp, rol, one_liner_argc);
	    }
	}
    }
  //-------------------------------------------------

  if (!Use_vsh)
    {

      if (!got_script)
	{
	  if (argv[i] != NULL)
	    {
	      // printf("using arg [%d] as script %s\n",i, argv[i]);
	      strcpy (Script_name, argv[i]);
	    }
	  else
	    {
	      printf ("no script -- so exit\n");
	      exit (-1);
	    }
	}
      
       // finding the script file src/exe in LIB all done in engine -- find_script_file
       
      if (debug == HELP)
	show_use ();

      if (checkAslOption (ASL_USE_GWM))
	{
	  //ASL_FDIN = atoi (argv[1]);

	  DBPF  ("ASL_FDIN %d\n", ASL_fdin);
	}
    }

  nbr = get_gs_work ();

//  if (!strpat (Asl_wp->fname, "/", PRG_stem, 1, -1))
//  strcpy (PRG_stem, Asl_wp->fname);

  // default

  if (Asl_options & ASL_RUN_EXE  ) {
	     sprintf (Debug_file, "%s/Debug/xdb",GS_WORK);
           }
	  else
	    sprintf (Debug_file, "%s/Debug/idb",GS_WORK);

  
  if (!Use_vsh)
    {
      
      char *mname = strrchr (Script_name, '/');

      if (mname != NULL)
	mname++;


      if (mname == NULL)
	mname = Script_name;

      strcpy (PRG_stem, mname);

      mname = strrchr (PRG_stem, '.');
      
      if (mname != NULL)
	  *mname = 0;
      
	  if (Asl_options & ASL_DEBUG_UNIQUE) {
	     if (Asl_options & ASL_RUN_EXE)
	       sprintf (Debug_file, "%s_%d.xdb", PRG_stem, GS_PID);	    
            else
	       sprintf (Debug_file, "%s_%d.idb", PRG_stem, GS_PID);	    
	  }
	  else if (Asl_options & ASL_DEBUG_SPECIFIC) {
	       if (Asl_options & ASL_RUN_EXE  )
	          sprintf (Debug_file, "%s.xdb", PRG_stem);
               else
		  sprintf (Debug_file, "%s.idb", PRG_stem);
          }
	  
	  //fprintf(stderr, "using debug_file %s \n", Debug_file);	    
    
      
      init_debug (Debug_file, dblevel, asl_version);

      init_hist_file (PRG_stem, argc, argv);

      if (!checkAslOption (ASL_USE_GWM) || checkAslOption (ASL_USE_SOCK))
	{
	  Asl_wp->pid = getpid ();
	  // printf("pid %d\n",Asl_wp->pid);
	  strcpy (Asl_wp->fname, Script_name);
	  strcpy (Asl_wp->title, "ASL_A");
	}
    }


  init_COM_mutex ();
  init_SRS_mutex ();
  init_IC_mutex ();
  init_AI_mutex ();
  initSVpool();
  
  // libs info
  opera_info();
  rdp_info();
  pexpnd_info();
  array_info();
  dbug_info();
  fop_info();
  
  // Table_show(); // how many script functions do we have
  // use script functions functions() to get table

#if ! WNT
  Shm.madd = 0;
#endif

  if (ViaXGS)
    {
      //printf("reading XGS window on %d\n",ASL_fdin);
      int nbr = read (ASL_fdin, Asl_wp, sizeof (GS_window));
      DBPF  ("nbr %d viaXGS window read\n", nbr);
      // printf("nbr %d viaXGS window read\n",nbr);
    }

  if (checkAslOption (ASL_USE_SOCK))
    {
      DBT("Using sockets\n");

      rval = (asl_error_codes) asl_sock_connect (Asl_port, Asl_host_address);

      if (rval == SUCCESS)
	{
	  Msg mp;
	  // send socket connection setup
	  DBT("socket connected!\n");
	  // now get hshake
	  int nbr = recv (Asl_wp->rp.i[CSOCK], (char *) &mp, sizeof (Msg), 0);
	  if ((nbr == sizeof (Msg)) && mp.type == GM_GWM_REPLY)
	    {
	      DBT("got gwm handshake! -- proceed \n");

	    }
	  else
	    {
	      rval = COM_SETUP_ERROR;
	    }
	}

      if (rval == COM_SETUP_ERROR)
	{
	  printf
	    ("no connection with gwm ! check gwm active tried port  %d \n",
	     Asl_port);
	  DBT("no connection - exit!\n");
	  exit (-1);
	}
    }
  else if (make_pipe_coms)
    {
      MakePipeComs (ASL_pip, ASL_fdin);
    }

  if (checkAslOption (ASL_USE_SOCK))
    {
      Asl_wp->setWAW (ON, SOCK_IPC);
      Use_gwm = 1;
    }
  else
    {

      if (!run_one_liner)
	{
	  //printf("using shared mem !\n");
	  Asl_wp->setWAW (ON, SHM_IPC);

	}
    }

  ok = GetCWD (&asldir, 0);

  get_node_name (Host_name);
  
  DBT ("\n script %s READY TO GO on <|%s|> \n\n",Asl_wp->fname, Host_name);
  DBT("sizeof Siv %d Svar %d Asl_event %d Msg %d\n",sizeof(Siv), sizeof(Svar), sizeof(Asl_event), sizeof(Msg));
  DBT("sizeof int %d float %d long %d double %d\n",sizeof(int), sizeof(float), sizeof(double), sizeof(long));
  DBT("sizeof char %d short %d long long %d long double %d\n",sizeof(char), sizeof(short), sizeof(long long), sizeof(long double));

  Table_init ();
  VMF_Table_init ();

  ENVP = envp;

  if (!Use_vsh) {
  copy_args (argc, argv, shift_args);

  pr_cl_args (argc);
  }
  //  init_si ();


  if (Use_vsh)
    {
	  if (Asl_options & ASL_DEBUG_UNIQUE) {
            sprintf (Debug_file, "vsh_%d.idb",  GS_PID);	    
	  }

	  //printf ("vsh  debug in %s\n",Debug_file);
 
      init_debug (Debug_file, 0, asl_version);
      
      vsh ();			// carry in args?
      exit (0);
    }


  asl (Asl_wp, checkAslOption (ASL_USE_GWM));

  /////////////////////////// EXITING /////////////////////////////////////////////////

  // printf("Exit asl - cleanup @ %d \n",GetUtime());
  DBPF  ("Exit asl - cleanup @ %d \n", GetUtime ());


  if (!checkAslOption (ASL_USE_SOCK))
    {

      if (Asl_wp->TestWAW (SHM_IPC) && Shm.madd != NULL)
	{
	  DBP( "?SHM_IPC %o %o\n", Asl_wp->waw, SHM_IPC);

	  if (shmdt (Shm.madd))
	    dbprintf (0, "Detach shared mem error \n");
	}

      if (make_pipe_coms)
	{
	  // close our pipe
	  close (ASL_pip->gpipe.fd[WT_PIP_ASL]);
	  close (ASL_pip->gpipe.fd[RD_ASL_PIP]);
	  // should close pipes to any children ?
	  dbp (" closing pipes to mother - send sigchild ?\n");
	  Exit_status = ASL_pip->id;
	}
    }

  int took = Asl_timer->getMsecs ();
  dbp ("debug_file is %s num_errors %d  invalidSiv %d %d %d exit status %d took %d msecs\n",
       Debug_file, N_error, InvalidSiv, Sp_debug, Use_pid, Exit_status,took);
  //printf("took %d msecs\n",took);
  fflush (Jf);
  fclose (Jf);
  Jf = NULL;


///// Destruct Global Siv's
/// go back to start cwd 



  if (ok)
    chdir (asldir.cptr (0));

  if (Sp_debug < 0 || (Sp_debug == 0 && N_error <= 1 && N_cerror <= 1))
    {
      if (!checkAslOption (ASL_DEBUG_KEEP)) {
	//printf("removing %s nerrors %d %d debuglevel %d\n",Debug_file, N_error, N_cerror,Sp_debug);
      //if (Use_pid)
      //	i = unlink (Debug_unique);	/* need to be in startup dir */
      //else
      
	i = unlink (Debug_file);
	
        if (strlen(err_name) >= 1 ) {
	  unlink (err_name);
	  DBT("unlinking %s\n",err_name);
        }
      }
    }

  if ( N_error <= 1 && N_cerror <= 1) {

        if (strlen(err_name) >= 1 ) {
	  unlink (err_name);
	  DBT("no errors unlinking %s\n",err_name);
        }
  }

  if (InvalidSiv > 0)
    {

      //printf("warning %d InvalidSiv accesses \n",InvalidSiv);
    }

  if (Pf != NULL)
    {
      fflush (Pf);
      fclose (Pf);
      Pf = NULL;
    }

  if (run_one_liner)
    {
      if (!(Asl_options & ASL_KEEP_TAS))
	unlink (rol_name);
    }

  atexit (byeBye);
  
  close_hist_file (PRG_stem);

  exit (Exit_status);

}

//////////  TBD //////
///
/// add filter option
///
///
///
       

