/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////                                    engine_e                    
//// 	   engine parser                                               
///        CopyRight   - RootMeanSquare - 1990 -->                  
//         Mark Terry                                                        
/////////////////////////////////////////<v_&_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include "engine_e.h"

Parset *CurrentParset = NULL;

int Line_num = 0;
int EXIT_SI;

//extern char Script_name[];

FILE *sfp = NULL;

Siv LP_siv ("_lastp");	/* last print */
Siv CLargc  ("_clargc");	/* command line arg count */
Siv CLarg  ("_clarg");	/* command line args */

/// need this per asl thread
Siv CParg  ("_cparg");   // proc args
Siv Lstate ("_lstate");
Siv Cscript ("_script");   // the main script
Siv Cinclude ("_include"); // current/last include code


//Siv Lastr  ("_lastr");

int MaxErrorsAllowed = 300;
int QuitTooManyErrors = 0;

void SetUpInternalVars(void)
  {

    get_byte_order ();

    // per thread?
    //  Lastr.type = FLOAT;
    //Lastr.slot = _LASTR;

    LP_siv.setType( SVAR);
  //  LPROC_siv.type = SVAR;
  //  CPNA_siv.type = INT;
    Cscript.setType (SVAR);
    CLarg.setType (SVAR);
    CLarg.setSlot(_CLARG);
    DBT("set cl_arg slot %d %d\n",CLarg.getSlot(),CL_argc);
  //  store_value (&LP_siv, OFFSETZERO, "main", SVAR);
     store_value (&LP_siv, OFFSETZERO, "_", SVAR);

     CLarg.setType (SVAR);
     CLargc.setType (INT);
     CLargc.setSlot(_CLARGC);
     CLargc.Store(CL_argc);
     DBT("set cl_argc slot %d %d\n",CLargc.getSlot(),CL_argc);
   for (int i = 0; i <  CL_argc; i++) {
    store_value (&CLarg, i, get_CL_arg (i), SVAR);
  // set this up as array
    //DBT("Cl arg %d %s \n",i,CLarg.getValue()->cptr(i));
  }

  //DBT("sz %d %d\n",CLarg.getSize(),CL_argc);
  //CLarg.setSize(CL_argc);
  
  CLarg.setND(1);
  CLarg.CheckBounds(); 
  CLarg.setND(1);

  store_value (&Cscript, 0, Asl_wp->fname, SVAR);
  
  //DBT("script is %s\n",Cscript.getValue()->cptr(0));  
}
//[EF]===================================================//

void exitASLonError(char * where, char *why)
{

  DBP("Error exit %s %s\n",where,why);
  EXIT_SI =1;

}
//[EF]===================================================//


// could use pthread to call script ??
// 

int CheckForMemErrors()
{
static int n_mem_errors = 0;

      if (MT_ERROR) {
       n_mem_errors++;
       DBE("MEM_ERROR ! total so far %d\n",n_mem_errors);
       DBE("%s\n",LastLine);
       //       DumpMemTable();
       MT_ERROR = 0; //reset
      }

  return n_mem_errors;
}
//[EF]===================================================//


int script (char *name)
{
  int src_file(0);
  time_t src_time(0);
  time_t exe_time(0);
  int fnlen;
  int p_size = 0;
  struct stat stbf;

  ClearCvec(LastLine,1024);

  Parset *parset = new Parset;

  CurrentParset = parset;

  if (parset == NULL) return 0 ;

  CurrentParset->setCompile(Asl_options & ASL_SPIC);
  // compiling intermediate code ? - this is default

  // do we have exe file ?
  int exe_ok = -2;
  char new_name[MAXFILENAME];
  char orig_name[MAXFILENAME];
  
  new_name[0] = '\0';
  orig_name[0] = '\0';
  
  fnlen = strLen(name);

  DBP("intsz %d\n longsz %d\n floatsz %d\n  doublesz %d\n  sivsz %d\n svarsz %d\n  statesz %d\n",
      sizeof(int),sizeof(long),sizeof(float),
      sizeof(double), sizeof(Siv), sizeof(Svar), sizeof(Statement));

  DBPF("looking for file %s\n",name);
  //printf("looking for file %s\n",name);

  if (fnlen >=1)
    strcpy(orig_name,name);


  if ( ((fnlen <=4) || (fnlen > 4 &&  (strncmp(&name[fnlen-4],".asl",4) !=0)))
       && (Asl_options & ASL_RUN_EXE)  ) {
    //printf("looking for exe %s\n",name);
	  src_file = 0;
   if (stat(name,&stbf) != -1 ){
	  exe_time = stbf.st_mtime;
	  DBP("found exe file %s time %u\n",name,exe_time);
     }
  }
  
  if (Asl_options & ASL_FNAME_ASIS) {
    DBT("use name as is %s\n",name);
    //printf("use name as is %s\n",name);    
    p_size = fsize (name, 0);
    if (p_size > 0) {
      src_file = 1; // force
    }
    else {
      //printf("exit ?\n");
      EXIT_SI = 1; 
      return -1;
    }
  }
  else {

     p_size = find_script_file (name, new_name);

     if (p_size > 0) {

       fnlen = strLen(new_name);

       if ((Asl_options & ASL_RUN_EXE) && (strncmp(&new_name[fnlen-4],".asl",4) !=0))  {
	 //printf("found an exe file %s --> %s %d \n",name,new_name,src_time);
            src_file = 0;
       }
       else if (!(Asl_options & ASL_RUN_EXE)
		&& (fnlen > 4)
		&& (strncmp(&new_name[fnlen-4],".asl",4) ==0)) {

           if (stat(new_name,&stbf) != -1 ){
	    src_time = stbf.st_mtime;
	    DBP("found src file %s --> %s %d \n",name,new_name,src_time);
	    //printf("found src file %s --> %s %d \n",name,new_name,src_time);
	   src_file = 1;
	    //  printf("found src file %s --> %s %d \n",name,new_name,src_time);
           }
       }
       else if ( !(Asl_options & ASL_RUN_EXE) ) {
	 // src file
	 p_size = fsize (orig_name, 0);
         if (p_size >0) {
           // make sure it is not an exe file!
	   src_file =1;
	 }
	 else {
	 printf(" can't find src file %s or %s.asl anywhere \n",orig_name,orig_name);
         }
	 }
       else {
	 //printf("  file %s  p_size %d\n",orig_name,p_size);
       }
     }
     else {
       printf(" Can't find file %s or %s.asl anywhere \n",orig_name,orig_name);
       exit(-1);
     }
  }

   /////////   Main Gthread //////////////////

   int mt_index = create_gthread (1);

   Gthread *gthread = get_gthread (mt_index);
   // do this via create thread

   gthread->parset = parset;

   parset->thread =  gthread;
  
   DBPF( "thread mt_index %d id %d ",mt_index, parset->thread->GetId());


  SetUpInternalVars();

  setUpInternalConsts();

  strcpy (parset->scope, "_");


  //  DBPF ("initial parset->scope %s <%d> %s sivsz %d \n",parset->scope,parset->St->id,parset->St->getTxt(), sizeof(Siv));
  //  DBPF ("initial parset->scope %s <%d>  sivsz %d \n",parset->scope,parset->St->id, sizeof(Siv));
  DBPF ("initial parset->scope %s",parset->scope);



  // this should be main thread result
  // Siv result ("Sresult");
  // SetUp main thread
  //   checkscpy (gthread->parset->srcf,Inc_file, MAXFILENAME);
  // parset->addScope("main");

   parset->addScope("_");

   //  store_value (&parset->CP_siv, OFFSETZERO, "main", SVAR);

   parset->clearPCW();

   parset->pt_result =  &gthread->result;

   parset->pt_result->ResetVar();


   ///////////////////////////////////////////////////////////

  if (Asl_options & ASL_LIST) {
    // needs to be done in first readsrcfile
      parset->init_pic(name);
  }

   DBP("exe_time %d src_time %d  src_file %d\n",exe_time,src_time, src_file);
   //printf("exe_time %d src_time %d  src_file %d\n",exe_time,src_time, src_file);
  //if (exe_time >= src_time && !src_file) {
  
  if (!src_file &&  (Asl_options & ASL_RUN_EXE)  ) {

     DBP("reading exe file %s\n",name);
     //printf("reading exe file %s\n",name);

       exe_ok = parset->readExe(name);

       if (exe_ok != R_SUCCESS) {
	 printf(" no exe file %s\n",orig_name);
         exit(-1);
	 EXIT_SI = 1; // bad exe code bail out
       }

    // adjust args ??

  }

  if (Asl_options & PRINTICA) {
    return 0;
  }

  // HAVE WE FOUND A FILE SRC OR EXE YET ?
  if (!(exe_ok == SUCCESS || p_size > 0)) {
     printf(" no exe/src file %s\n",orig_name);
    DBP("NO SRC OR EXE FILE \n");
    EXIT_SI = 1;
    exit(-1);
  }
  


  if (EXIT_SI) 
    return -1;


  if (exe_ok == -2) { 

    DBP("reading src file %s\n",name);
    checkscpy (C_script, name, MAXFILENAME);    
    parset->code = parset->ReadSrcFile(name) ;

    if (parset->code == NULL || parset->code->status == -1) {
        DBPERROR("Can't read script file or find executable \n");
	return 0;
    }

    DBPF("status %d",parset->code->status);

    parset->FirstPassIC(0, parset->code->nlines);

    parset->PreProcessIC();
  }

//  parset->SetPCW (WRTEXE, OFF);

  int ks = 0;
  int last_ncerr = 0;
  //  int first = 1;
  int n_ice = 0;
  DBPF("ready to run !");

 
  while (!EXIT_SI)
    {

      CheckForMemErrors();

      parset->pt_result =  &gthread->result;

      parset->pt_result->ResetVar();
     
      parset->DoStatements();

      //      DBP("PCW %d \n",parset->getPCW());

      if ((GetNcerrors() > last_ncerr)  && (Sp_debug > 0)) {
          // view/step/quit
	  DBP("got error %d\n",last_ncerr);
          parset->DebugInteract ();
          last_ncerr++;
	  if (EXIT_SI) {
	    printf("DBG set EXIT\n");
	    break;
	  }
      }

      if (TERM_SIG) {
         DBT("TERM_SIG set!\n");
         EXIT_SI =1;
         break;	
      }

      if (CheckINTRPaction())
	{
	  DBP( "CTRL_C %d limit so exit\n", CTRL_C);
	  break;
	}


       if (parset->Exit()) break;
    
       ks++;

// FIX_NECESSARY?       if (ks % 100 == 0) 	 ClearStack();


       if (QuitTooManyErrors && (GetNcerrors() > MaxErrorsAllowed)) {
         EXIT_SI =1;
         break;
       }

       if (PIPE_BRK) {
         //EXIT_SI =1;
	 DBW(" pipe com broken - so exit\n");
	 
	 break;
       }


       if (CHILD_SIG) {
	 DBW(" child died - so exit ?\n");
	 CHILD_SIG = 0;
         // EXIT_SI =1;
	 // break;
       }

       n_ice = getICerrors();
       if (n_ice > 10) {
         DBE("ICerror %d - continue??!\n",n_ice);
	 if (n_ice >200) {
	   //EXIT_SI =1;
	   fprintf(stderr,"IC error %d- stop ?\n",n_ice);
         }
	 }

       if (EXIT_SI) {
	 DBP("break on EXIT_SI!\n");
	 break;
       }
       
    }

  // DBT("exit main instruction loop \n");
  DBPF("GetNCerr %d %d",GetNcerrors(),MaxErrorsAllowed);

  if (CHILD_SIG) {
	 DBT(" child died - so exit\n");
  }
  
  if (getICerrors() || GetNcerrors() ) {
    DBW("Code errors %d  ICerrors %d\n", GetNcerrors(), getICerrors());
  }

  CTRL_C = 0;

  fflush(stdout);


  DBPF("exit condition %d pcw %d\n",parset->TestPCW(WRTEXE) ,parset->getPCW());
  DBPF("compile wrte_exe %d\n",(Asl_options & ASL_COMPILE));
  if (parset->TestPCW(WRTEXE) || (Asl_options & ASL_COMPILE)) {

    if (GetNcerrors() ) {
        // only produce exe file if no code errors!
	dberror("Code errors occurred! %d \n",GetNcerrors());
      }
      
      	parset->writeExe();
  }

// maybe not close

  int tryclose = 0;
  if (tryclose) {
  close_fps ();
  }

//  this causes problems -- check /malloc/new/delete 
//  free_script_vars ();

  ExitAsl = 1;
  return 1;
}
//[EF]===================================================//

char *
si_get_line (char *ptr)
{
  while (*ptr)
    {
      if (*ptr == '\n')
	{
	  Line_num++;
	  ptr++;
	  break;
	}
      ptr++;
    }
  return ptr;
}
//[EF]===================================================//
int
chk_brace (char *ptr, int *l_brace, int *r_brace)
{
  char *bp;
  bp = chk_brace_posn (ptr, l_brace, r_brace);
  if (bp != NULL)
    return 1;
  return 0;
}
//[EF]===================================================//
char *
chk_brace_posn (char *ptr, int *l_brace, int *r_brace)
{
  int j = 0;
  int in_quote = 0;
  char last_char;
  int len;
  char *ip;
  char line[VALUELEN];
/* eat white space & check if comment line */

  if (ptr == NULL) return NULL;

  ip = ptr;

  while (*ip != '\n')
    {
      line[j++] = *ip++;
      if (j == 127)
	break;
    }

  line[j] = 0;
  j = 0;

  DBPF( "chk_brace %s %d %d\n", line, *l_brace, *r_brace);

  ip = ptr;
  len = strLen (ptr);

  while (*ptr == ' ' || *ptr == 9)
    {
      ptr++;
      j++;
    }

  if (ptr == NULL) return NULL;
  if (*ptr == '#') return NULL;

  last_char = *ptr;

  while (1)
    {
      if (*ptr == '"' && (last_char != '\\'))
	in_quote = ~in_quote;

      if (!in_quote)
	{
	  if (*ptr == '{')
	    *l_brace += 1;
	  if (*ptr == '}')
	    *r_brace += 1;
	  if (*ptr == '#')
	    break;
	}
      last_char = *ptr;

      if (j++ > len)
	break;

      /*dbpr(0,"%c %d %d\n",*ptr,*l_brace,*r_brace); */
      ptr++;

      if (*r_brace == *l_brace && *l_brace > 0)
	{

#if CDB_ENGINE
	  DBP( "chk_brace %s found match %d %d\n", line, *l_brace, *r_brace);
	  StrNCopy (line, ptr, 64);
	  Dbp( "chk_brace @ %s found match \n", line);
#endif
	  return ptr;
	}

      if (*r_brace > *l_brace && *l_brace > 0)
	{
	  DBP(" too many } chk_brace %s found match %d %d\n", line, *l_brace, *r_brace);
	  return NULL;
	}
      if (*ptr == '\n')
	return NULL;
    }
  return NULL;
}
//[EF]===================================================//

