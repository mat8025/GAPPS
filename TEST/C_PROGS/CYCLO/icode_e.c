/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    icode_e                            \\\\
///   CopyRight   - RootMeanSquare                                          \\\
//    Mark Terry  - 1998 -->                                                 \\
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



#include <gasp-conf.h>
#include  <stdio.h>
#include  <fcntl.h>
#include  <math.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "defs.h"
#include "df.h"
#include "types.h"
#include "si.h"
#include "siexterns.h"
#include "simem.h"
#include "parse.h"
#include "paraex.h"
#include "opera.h"
#include "array.h"
#include "convert.h"
#include "icode.h"
#include "stack.h"
#include "fop.h"
#include "mop.h"
#include "hop.h"
#include "sop.h"
#include "state.h"
#include "scope.h"
#include "sclass.h"
#include "rdp.h"
#include "wcom.h"

#include "debug.h"
#include "codedb.h"

#define   CDB_IC    DBOFF
#define   CDB_PIC   DBOFF

int No_IC = 0;

/*
 *  Create and Process Intermediate Code
 *  Each statement parse generates a series of operations
 *  on Siv variables
 *  these are stored and excuted directly on the next execution 
 *  of the statement
 *
 *  numbers and strings and Subscripted arrays  are stored on the stack 
 *  as  SIV variables via GetSSV 
 *  once used they are available for reuse 
 */

/*   opcode     state     slot     sz   cbuf
 *   char       char      int      int  var-length NULL-TERMINATED
 *
 *
 */

// slot-stack


uint Sid = 0;

int ICerrc = 0;
int AlwaysInterp = 0;
int EXECW = 1;



FILE *Pf = NULL;


Svar Iceval;



void
Parset::init_pic (char *pic_name)
{
  //DBP("---->");

  if (Pf != NULL)     return;			// already open

  char date[128];
  char picfile[128];

  SetPCW(WRTPIC,ON);

  if (pic_name != NULL) {

    //DBP("pic_name %s \n", pic_name);

  gs_get_date (&date[0], 1);

  char *cp = strrchr(pic_name,'/');
  
  if (cp != NULL) {
  strcpy(picfile,++cp);
  }
 else
  strcpy(picfile,pic_name);

  cp = strchr(picfile,'.');

  if (cp != NULL) {
    *cp= 0;

   strcat(picfile,".lic");
  }
 else 
   strcat(picfile,".lic");

   Pf = fopen (picfile, "wb");

   //   DBP("%s \n",  picfile);

   fprintf (Pf, "#%s %s %s\n", date, pic_name, asl_version);

  }
}


const char *
octype (int i)
{
  switch (i)
    {
    case NOOP:
      return "NOOP";
    case FINDV:
      return "FINDV";
    case CREATEV:
      return "CREATEV";
    case CREATE_PV:
      return "CREATE_PV";
    case LOADH:
      return "LOADH";
    case LOADRS:
      return "LOADRS";
    case PUSHS:
      return "PUSHS";
    case PUSHCAT:
      return "PUSHCAT";
    case PUSHTAG:
      return "PUSHTAG";
    case CAT_STR:
      return "CAT_STR";
    case PRT_EXP:
      return "PRT_EXP";
    case LOADRN:
      return "LOADRN";
    case CALLF:
      return "CALLF";
    case CALLP:
      return "CALLP";
    case CALLCMF:
      return "CALLCMF";
    case CALLVMF:
      return "CALLVMF";
    case CALLMYCMF:
      return "CALLMYCMF";
    case PUSHN:
      return "PUSHN";
    case STORER:
      return "STORER";
    case REFERV:
      return "REFERV";
    case OPERA:
      return "OPERA";
    case REDIMNV:
      return "REDIMNV";
    case VFILL:
      return "VFILL";
    case LFILL:
      return "LFILL";
    case VFILLR:
      return "VFILLR";
    case PUSH_SIVELE:
      return "PUSH_SIVELE";
    case PUSH_LH_SIVELE:
      return "PUSH_LH_SIVELE";
    case PUSH_OBJELE:
      return "PUSH_OBJELE";
    case PUSH_LSIVELE:
      return "PUSH_LSIVELE";
    case PUSH_SIVELELOC:
      return "PUSH_SIVELELOC";
    case APPLY_SIVSUBS:
      return "APPLY_SIVSUBS";
    case PUSH_SIV:
      return "PUSH_SIV";
    case PUSH_CMV:
      return "PUSH_CMV";
    case PROC_DEF:
      return "PROC_DEF";
    case PUSH_OBJ:
      return "PUSH_OBJ";
    case POP_OBJELE:
      return "POP_OBJELE";
    case PUSH_ISIV:
      return "PUSH_ISIV";
    case CLEARSUBI_SIV:
      return "CLEARSUBI_SIV";
    case TRAN_R_H:
      return "TRAN_R_H";
    case LOADR_CLARG:
      return "LOADR_CLARG";
    case ENDIC:
      return "ENDIC";
    case CWON_SIV:
      return "CWON_SIV";
    case CWOFF_SIV:
      return "CWOFF_SIV";
    case AWON_SIV:
      return "AWON_SIV";
    case AWOFF_SIV:
      return "AWOFF_SIV";
    case EVALRANGE_SIV:
      return "EVALRANGE_SIV";
    case LH_EVALRANGE_SIV:
      return "LH_EVALRANGE_SIV";
    case SUBIELE_SIV:
      return "SUBIELE_SIV";
    case SUBIVEC_SIV:
      return "SUBIVEC_SIV";
    case INVSUBI_SIV:
      return "INVSUBI_SIV";
    case MKSUBSET_SIV:
      return "MKSUBSET_SIV";
    case MKSUBSET_RSIV:
      return "MKSUBSET_RSIV";
    case RANGE_SIV:
      return "RANGE_SIV";
    case COPYPUSH_SIV:
      return "COPYPUSH_SIV";
    case BUILDVEC:
      return "BUILDVEC";
    case PEX:
      return "PEX";
    case SHCOM:
      return "SHCOM";
    case CAT_SIV:
      return "CAT_SIV";
    case CAT_TID:
      return "CAT_TID";
    case PRT_OUT:
      return "PRT_OUT";
    case PRT_FH:
      return "PRT_FH";
      //    case PRT_ARRSEP:
      //    return "PRT_ARRSEP";
    case PRT_MROW:
      return "PRT_MROW";
    case SET_ERROR:
      return "SET_ERROR";
    case PUSHI:
      return "PUSHI";
    case PUSHF:
      return "PUSHF";
    }

  return ("NOT_KNOWN");
}




#define NSPL 1

Linec::Linec ()
{
  si = 0;
  ns = 0;
  type = -1;
  lnum = -1;
  status = 0;
  wstm = NULL;
  scptr = NULL;
  nwscptr = NULL;
  llen = 0;
}


Linec::~Linec ()
{
  if (ns > 0)
    {
      for (int i = 0; i < ns; i++)
	delete wstm[i];
    }
}



int
Linec::Init (int ln)
{
  lnum = ln;

  // get space for statements  var-length NULL-TERMINATED
  // should do just one and then realloc as needed

  char key[32];
  strcpy (key, "Linec_wstm");

  if (status == 0 && ns == 0)
    {

      wstm = (Statement **) sreallocvp_id ((void *) wstm, NSPL, key);

      for (int i = 0; i < NSPL; i++)
	{
	  wstm[i] = new Statement;
	  wstm[i]->linec = this;
	}

      si = 0;
      ns = NSPL;
      status = 1;

#if CDB_IC
      //      dbp( "Linec::Init [%d]  init  ns %d status %d\n", lnum, ns, status);
#endif
    }
  else
    {
#if CDB_IC
      DBP ("line [%d] already initted!! status %d ns %d\n", lnum, status, ns);
#endif
    }

  return ns;
}

int
Linec::AddStatement ()
{
  int rv = 0;

#if CDB_IC
  DBP ("si %d ns %d \n", si, ns);
#endif

  char key[32];
  strcpy (key, "Adds_wstm");

  ns++;

  if (! DBPASSERT((ns >0),"number of statements <=0 ?"))
    {
      ns = 1;
    }

  Statement **nwstm;		// pointer to statements (compiled) in line

  nwstm = (Statement **) sreallocvp_id ((void *) wstm, (int) ns, key);

  if (nwstm != NULL)
    {
      wstm = nwstm;
      wstm[ns - 1] = new Statement;
      rv = ns;
    }


  return rv;
}



Statement *
Linec::GetStatement ( CodeBlock *code, int ws)
{
  // When we read new line - si should be reset to 0
  // work down linked chain ??
  //  DBP("ws %d ns %d \n",ws,ns);

  Statement *pst = NULL;

  if (ws <= ns && ns > 0)
    {
  
      pst = wstm[ws];
      pst->si = ws;
      pst->linec = this;
      pst->code = code;
#if CDB_IC
      DBP ("GetStatement %d %d:%d:%d   %s  %s\n", pst->id, lnum, ws,
	   ns, pst->PrintState (), pst->Stype ());
#endif

    }


  return pst;
}

Statement *
Linec::GetStatement (CodeBlock *code)
{
  // this will add statement if needed
  // When we read new line - si should be reset to 0
      Statement *pst = NULL;

      if (si == ns && ns < MAXSTPERLINE) {
            AddStatement ();
      }

  // work down linked chain ??

  if (si <= ns && ns > 0)
    {
      pst = wstm[si];
      pst->si = si;
      pst->linec = this;
      pst->code = code;
#if CDB_IC
      DBP ("%d %d:%d:%d   %s  %s\n", pst->id, lnum, si, ns,  pst->PrintState (), pst->Stype ());
#endif


    }
  else
    {
      DBPERROR("trying to access statement outside of line set si %d ns %d \n", si, ns);
    }


  return pst;
}




void
Statement::SetType ()
{

  type = N_STATE;
  // assume @ first non-white char

  //DBP("%s\n",txt);

  if (txt != NULL && sl > 0)
    {

      if (CheckShellCommand ())
	;
      else if (CheckCodeBlock ())
	;
      else if (CheckKeyWord ())
	;
      else if (CheckComment ())
	;
      else if (CheckStreamPrint ())
	;
      else if (CheckListDeclare ())
	;
      else if (CheckArrayDeclare ())
	;
      else if (CheckExpression ())
	;
      else if (CheckExprC ())
	;
      else if (CheckDeclare ())
	{
	  type = DECLARE;
	}
      else if (CheckPFCall ())
	{
	  type = PFCALL;
	}
      else if (CheckAccess ())
	;

#if CDB_IC
      DBP ("sl %d  %s  type %s \n", sl, txt, Stype ());
#endif

    }

  if (type == UNKNOWN_TYPE ) {
    if (sl > 1)  {
       type = EXPRESSION;
       // check for object
       //dbwarning("NOT RECOG -- %s  ln %d\n",txt, ln);
       NfpassErrors++;
    }

  }

  if (pst != NULL && (pst->checkType(IF)
		      || pst->checkType (ELSE_IF)
		      || pst->checkType (UNTIL)
		      || pst->checkType (WHILE)
		      || pst->checkType (SWITCH))
      && (checkType(EXPRESSION) || checkType(EXPRESSION_C))) {
       setType(EXPRESSION_T);	// test expression - set exe order statement later
     if (pst->checkType(UNTIL)) setType(EXPRESSION_UT);
    }

  // to determine true/false execution path


}


void
Statement::AddTxt (int wln, char *str, int len, int force)
{

#if CDB_IC
  DBP ("%d  %*.*s \n", len, len, len, str);
#endif

  if (!TestState (SSI))
    {
      Init (wln, " ");
    }

  if (TestState (SSWF) && !force)
    {
      DBP ("AddTxt but SSWF so nop %s \n", getTxt ());
    }

  else {

    if (txt != NULL) {
      sfree (txt); txt = NULL;
    }

  txt = (char *) scalloc ((len + 2), sizeof (char));

  ln = wln;


  if (txt != NULL)
    {
      strncpy (txt, str, len);
      txt[len] = 0;
      int i = len - 1;

      while (i)
	{
	  if (txt[i] == '\n')
	    txt[i] = 0;
	  i--;
	}

      sl = strLen (txt);

      //  dbp("AddTxt sl %d %s \n",sl,getTxt());

      SetState (SSTA, 1);
      wptr = txt;
    }
  }
}

void
Statement::CopyTxt (char *str, int len)
{

  //  if (txt != NULL) sfree (txt);

  txt = (char *) scalloc ((len + 2), sizeof (char));
  strncpy (txt, str, len);
  sl = len;
}

void
Statement::updateTxt (const char *str)
{
  int len = strLen((char *) str);

  //  DBP(" len %d \n",len);
  if (txt != NULL) {
    //DBP(" txt %s \n",txt);
    sfree (txt); txt = 0;
  }

  if (len > 0) {
    txt = (char *) scalloc ((len + 20), sizeof (char));
    strncpy (txt, str, len);
    txt[len] = 0;
    // DBP(" txt %s \n",txt);
    sl = len;
    wptr = txt;
    soc_ptr = txt;
  }

}






// SST - thread ?

char *
Statement::PrintState ()
{
  char flgtxt[256];
  int k = 0;

  if (state == 0)
    sprintf (flgtxt, "NOTSET");
  else
    {
      sprintf (flgtxt, "  ");
      if (this->TestState (SSI))
	k += sprintf (&flgtxt[k], "(SSI|");
      if (this->TestState (SSC))
	k += sprintf (&flgtxt[k], "SSC|");
      if (this->TestState (SSPR))
	k += sprintf (&flgtxt[k], "SSPR|");
      if (this->TestState (SSX))
	k += sprintf (&flgtxt[k], "SSX|");
      if (this->TestState (SSPC))
	k += sprintf (&flgtxt[k], "SSPC|");
      if (this->TestState (SSTA))
	k += sprintf (&flgtxt[k], "SSTA|");
      if (this->TestState (SSOO))
	k += sprintf (&flgtxt[k], "SSOO|");
      if (this->TestState (SSW))
	k += sprintf (&flgtxt[k], "SSW|");
      if (this->TestState (SLSI))
	k += sprintf (&flgtxt[k], "SLSI|");
      if (this->TestState (SLCB))
	k += sprintf (&flgtxt[k], "SLCB|");
      if (this->TestState (SNW))
	k += sprintf (&flgtxt[k], "SNW|");
      if (this->TestState (SIR))
	k += sprintf (&flgtxt[k], "SIR|");
      if (this->TestState (SSWF))
	k += sprintf (&flgtxt[k], "SSWF)");
      else
	k += sprintf (&flgtxt[k], " )");
    }

  return flgtxt;
}


char *
Range::PrintCW ()
{
// FIX - no static

  static char flgtxt[256];
  int k = 0;
  if (cw == 0)
    sprintf (flgtxt, "CLEAR");
  else
    {
      k += sprintf (flgtxt, "( ");
      if (testCW (RNGSTART))
	k += sprintf (&flgtxt[k], "RNGSTART|");
      if (testCW (RNGSTOP))
	k += sprintf (&flgtxt[k], "RNGSTOP|");
      if (testCW (RNGSTRIDE))
	k += sprintf (&flgtxt[k], "RNGSTRIDE|");
      if (testCW (RNGFE))
	k += sprintf (&flgtxt[k], "RNGFE|");
      if (testCW (RNGINV))
	k += sprintf (&flgtxt[k], "RNGINV|");
      if (testCW (RNGEXP))
	k += sprintf (&flgtxt[k], "RNGEXP|");
      if (testCW (RNGALL))
	k += sprintf (&flgtxt[k], "RNGALL|");
      if (testCW (RNGATEND))
	k += sprintf (&flgtxt[k], "RNGATEND)");
      else
	k += sprintf (&flgtxt[k], " )");
    }

  return flgtxt;
}



int
Statement::GetIVS (int sz)
{
  // reading in exe binary
  int rv = ISOK;
  icblock = (char *) scalloc (sz, sizeof (char));

  if (icblock != NULL)
    {
      stend = icblock;
      msz = sz;
    }
  else
    {
      DBPERROR("can't calloc statement \n");
      rv = NOTOK;
    }

  return rv;
}


int
Statement::Init (int n, const char *expr)
{


  int rv = 1;
#if CDB_IC
  DBP ("id %d %d %s\n", id, n, expr);
#endif

  if (!TestState (SSTA) && !TestState (SSWF))
    {				// already added via ProcessLine

      if (txt != NULL)
	{
	  //dbprintf (DBIC, "Free IC Statement txt %s  \n", txt);
	  sfree (txt); txt = 0;
	}

      int k = strLen (expr);
      txt = (char *) scalloc ((k + 2), sizeof (char));

      if (txt != NULL)
	{
	  strcpy (txt, expr);
	}
      else
	{
	  DBPERROR("can't alloc txt in statement %d \n", id);
	  rv = 0;
	}
    }

  if (rv) {

    if (icblock != NULL) {
      sfree (icblock); icblock = 0;
    }

  ln = n;

#if CDB_IC
  dbpl (1, "\nWRTIC-> BEGIN_IC %s\n", txt);
#endif

  icblock = (char *) scalloc (DEF_ICBLKSZ, sizeof (char));

  if (icblock != NULL)  {
    stend = icblock;
    rv = 1;
  }
  else {
    DBPERROR("can't calloc statement \n");
    rv = 0;
  }
  csz = 0;
  msz = DEF_ICBLKSZ;
  SetState (SSI, 1);
  }


  return rv;
}



int
Statement::CheckIX (int ln, char *expr)
{

#if CDB_IC
  DBP ("CheckIX %d  ln %d state %s %s ", id, ln, PrintState (), expr);
#endif

  if (!TestState (SSI))
    {
      Init (ln, expr);
      return PARSE;
    }

  if (!TestState (SSC))
    return PARSE;

  if (No_IC)
    return PARSE;

  if (TestState (SSC))
    return XIC;

  return 0;
}



// stack will need to contain more than just pointer to variable 
// state, type to take care of proc args that are pushed prior to calling
// 

void
icstack::InitSSV ()
{
  Siv *svp;
  int i;

  for (i = 0; i < MAXSTACKSZ; i++)
    SSV[i] = NULL;

  char an[64];

  for (i = 0; i < RUNSTACKSZ; i++)
    {
      sprintf (an, "xic_result_%d", i);
      svp = new Siv (an);
      SSV[i] = svp;
//DBP("InitSSV [%d]\n",i);
      if (svp == NULL) {
	DBPERROR ("init stack variables\n");
      }
      else
	svp->setCW (SI_STACKV, ON);
    }

//  SlotStack.Reset ();

}






void
icstack::Reset ()
{
  si = 0;

}

void
icstack::Overflow ()
{
      DBPERROR ("ICSTACK is full\n");
      ICerrc = 1;
}

void
icstack::Underflow ()
{
      DBPERROR ("ICSTACK is UNDERFLOW - uninitialized variable?\n");
      ICerrc = 2;
}

void
icstack::Push (Siv * asivp, int state)
{

  if (si == ICSSIZE)
    {
      Overflow();
     
    }
  else {

#if CDB_IC
  //    dbp("\t\t\tPushing si %d %d\n",si,asivp->slot);
  DBP ("Pushing si %d %s %s offset %d lhsize %d\n", si, asivp->getName(), asivp->Dtype (), asivp->offset,asivp->lhsize);
  Iceval.GetVarAsStr(asivp);
  DBP("value %s\n",Iceval.cptr(0));
  DBP("SI_MEMBER? %s state is %d  ele %s\n",yorn(asivp->testCW(SI_MEMBER)),state, yorn(asivp->testCW(ARRAY_ELE)));
#endif


  stack[si].state = state;
  stack[si].offset = asivp->offset;
  stack[si++].sivp = asivp;

#if CDB_IC
  DBP ("\t\t\tPush  si now %d \n", si);
#endif

  }

}


Siv *
icstack::Pop ()
{
  Siv *sivp = NULL;

  //  DBP("--->\n");

  if (si == 0)
    {
      Underflow();
    }
  else {
  si--;

  sivp = stack[si].sivp;

  int on = 0;
  // we archived some state and the siv offset when the ptr to siv was pushed
  // reconstruct them here - but this is somewhat ad hoc -- maybe save the siv cw word
  // to give more info


  if (stack[si].state == ASLVAR_REF)
    on = 1;

  // if used as calling arg - is it by value or reference
  // this flag is examined in proc and func call

        sivp->setCW (STACKV_ARGREF, on);
        sivp->offset = stack[si].offset;

#if CDB_IC
	Iceval.GetVarAsStr(sivp);
	DBP ("Popping si %d %s ARGREF %s val %s\n", si, sivp->GetName(), yorn(sivp->testCW (STACKV_ARGREF)) ,Iceval.cptr(0));
#endif

  if (sivp != NULL)
    {
      if (strncmp (sivp->GetName(), "xic_result", 10) == 0)
	{
	  xic_rn--;
	}
    }

#if CDB_IC
     DBP ("\t\t\tPop  si now %d \n", si);
#endif

  }

  return (sivp);
}


Siv *
icstack::PopW ()
{
// DF PopW()
  // returns ptr to Siv
  // examines state to retrieve and set LH subscript/element reference
  // EDF

  if (si == 0)
    {
      DBPERROR ("ICSTACK is UNDERFLOW - uninitialized variable ?\n");
      ICerrc = 2;
      return NULL;
    }

  si--;

  Siv *sivp = stack[si].sivp;

  int ref_lh = (stack[si].state && REF_LH);

  // check for REF_LH

#if CDB_IC
  DBP ("Popw %s state %u  %d  ref_lh %d\n", sivp->getName(), (uint) stack[si].state, REF_LH, ref_lh);
#endif

  if (ref_lh)
    {
      // this flag is examined in storer - for LH val subscript or element info

      sivp->setCW (ARRAY_ELE | SUBSC_ARRAY_LH | SUBSC_ARRAY, 0);	// clear

#if CDB_IC
      DBP("setcw %d \n",stack[si].state);
#endif
//    what are we trying to reset here

      sivp->setCW (stack[si].state, ON);

      if (sivp->testCW (ARRAY_ELE) || sivp->testCW (REF_LH))
	{
#if CDB_IC
          DBP("popw setting array_ele/offset to lhsize %d \n",sivp->lhsize);
#endif
	  sivp->offset = sivp->lhsize;

	  if (sivp->offset >= sivp->size && !sivp->testCW(DYNAMIC_ARRAY) && sivp->type != SVAR)
	    {

	      DBPERROR ("popw %s off %d size %d lhsize %d  nd %d",sivp->GetName(), sivp->offset, sivp->size, sivp->lhsize, sivp->getND());
              sivp->offset = 0;
	    }
	}


      //sivp->setCW (REF_LH, 1); // just to make sure

    }

  if (sivp != NULL)
    {
      if (strncmp (sivp->getName(), "xic_result", 10) == 0)
	{
	  xic_rn--;
	}
    }

  // this is either used for LH ARRAY_ELE spec - in lhsize
  // or for LHsubset and lhsize to do subscript store
  // 

#if CDB_IC
  DBP ("Popping si %d %s REF %d offset %d\n", si, sivp->getName(),
       sivp->testCW (ARRAY_ELE), sivp->offset);
  DBP ("\t\t\tPop  si now %d \n", si);
#endif



  return (sivp);
}


Siv *
icstack::Top ()
{
  Siv *sivp = NULL;
  if (si != 0)
    {
    sivp = stack[si - 1].sivp;
  // should only be able to copy this nothing else !!
    }

  return sivp;
}

Siv *
icstack::PopR ()
{
  Siv *sivp = NULL;

  // not used for args!!
  // does not pull out stack state info

#if CDB_IC
  DBP("---> si %d\n",si);
#endif

  if (si != 0)
    {

  si--;

  if (si >= 0)
  sivp = stack[si].sivp;


#if CDB_IC
  // DBP ("\tPopping si %d %s\n", si, sivp->getName());
    DBP ("\tPopping si %d \n", si);
#endif


  if (sivp != NULL)
    {
      if (strncmp (sivp->getName(), "xic_result", 10) == 0)
	{
	  xic_rn--;
	}
    }
    }


#if CDB_IC
  DBP("<--- si %d\n",si);
#endif


  return (sivp);
}




void
icstack::Examine ()
{
  if (si == 0) {
    DBP ("XIC Stack EMPTY\n");
  }
  else
    {
      for (int i = 0; i < si; i++)
	{
	  Siv *sivp = stack[i].sivp;
	  if (sivp != NULL)
	    {
	      DBP ("XIC Stack item %d  %s state %d  lhsize %d %s \n", i, sivp->getName(),
		   stack[i].state, sivp->lhsize, sivp->Dtype ());
	    }
	}
    }

}



int
icstack::Rotate (int deep)
{
  int rv = 0;
#if CDB_IC
  DBP("--->\n");
#endif
  // rotate stack - deep item comes to top
  // others move one down
  // bottom of stack is si-1
  // top is si

  if (deep == 0)		// nop
    rv = 1;
  else {
  // too deep - nop
  if (deep > si)
    rv = 0;
  else {
  // tmp-item
  // deep 1  is arg underneath top stack item

  Stackv tmp;

  int targ = si - 1 - deep;

  tmp.Copy (&stack[targ]);
  //Examine();

  for (int i = targ; i < si; i++) {
    //DBP("copy %d to %d \n",i,i+1);
    stack[i].Copy (&stack[i + 1]);
  }

  stack[si - 1].Copy (&tmp);

  //  Examine();

  rv = 1;
  }

  }

  return rv;
}


char *
Icode::GetName ()
 { 
  if (sz > 0) 
  return str; 
  else 
  return NULL;
};


#define ICSUCCESS 0


void
Icode::GetSivp (Parset * parset)
{
// this looks up via slot for main variables
// if proc or class method
// gets current proc index - 
// then looks up in local table 


// needs to be reworked for object members!!
// for objects needs to know current object!

  Proc *proc;

  int obmem = 0;
  int sivok;
  Varcon gvc;
  Varcon *vc= &gvc;

  try {


  sivp = NULL;


  if (slot < -1) {

    sivp = parset->internal_siv (slot);

    if (sivp != NULL) {

#if CDB_IC
     DBP("Found me an internal var slot %d\n",slot);
#endif

     throw SUCCESS;
    }

  }


// does this work for internal variables ?

#if CDB_IC
  DBP ("pindex %d var %s state %d slot %d cmslot %d\n", parset->pindex, GetName (), state, slot, cmslot);
#endif

 if (testCW(SI_GLOBAL))
    {
     // i.e. its a main/global variable
     // uses slot number-- 

#if CDB_IC
      DBP ("Looking up Global var slot  %d \n", slot);
#endif

         sivp = c_vars[slot];


      if (sivp == NULL)
	{
	  c_vars[slot] = new Siv;

#if CDB_IC
	  DBP ("making new siv slot %d \n", slot);
#endif
	  sivp = c_vars[slot];
	}


      if (sivp == NULL) {
	dberror ("can't happen \n");
	throw INVALID_SIV_ERROR;
      }


//      ShowSivFlags ("getsivp", sivp);


      if (sivp->isValid())
	{

#if CDB_IC
	  DBP ("found %s id %d WCW %d  type %s\n",sivp->GetName(), sivp->getID(), sivp->getCW(), sivp->Dtype());
	  // create if FREE
          // why would it be marked as free?? - if valid
#endif

	  //sivp->setCW(SI_FREE,OFF); // CHECKME  --- just mark it not free and sail on

	  if (sivp->testCW (SI_FREE))
	    {
#if CDB_IC
       DBP ("GetSivp attempts to creates siv %s %s %d \n", sivp->GetName(),GetName (),  slot);
#endif
	      int nslot = var_hash (sivp->GetName (), SIV_CHECK_EXIST);


	      if (nslot == slot) {
#if CDB_IC
		DBP ("GetSivp checks  siv in hash table %s %d %d\n", sivp->GetName(), slot,sivp->slot);
                // now mark it  not free
#endif
		sivp->setCW(SI_FREE,OFF); // CHECKME  --- and if not create 
              }
              else {
#if CDB_IC
		DBP ("GetSivp need to recreate? siv in hash table %s %d %d\n", sivp->GetName(), slot,sivp->slot);
#endif

		nslot = var_hash (sivp->GetName (), SIV_CREATE );

              }


	    }




#if CDB_IC
    DBP ("%s %s array? %s DYNAMIC %s ELE %s offset %d\n", sivp->GetName(), sivp->Dtype (), yorn(sivp->testCW (SI_ARRAY)), yorn(sivp->testCW (DYNAMIC_ARRAY)),
	 yorn(sivp->testCW (ARRAY_ELE)), sivp->offset);
#endif

    if (!sivp->testCW (ARRAY_ELE)) {

#if CDB_IC
      //       DBP("WARNING reset offset from previous expression ?\n");
#endif
      sivp->offset = 0;
    }

             throw SUCCESS;
	}

	throw INVALID_SIV_ERROR;
    }



  if (testCW(PROC_VAR) && !testCW(SI_MEMBER))
    {

#if CDB_IC
      DBP("looking up Proc var \n");
#endif

      proc = GetProc (parset->pindex);

      if (proc != NULL)
	{

	  sivp = proc->GetLSiv (slot, GetName (), 0, parset);


	  if (sivp == NULL) {
	     DBPERROR (" can't get sivp from proc slot %d\n", slot);
	     throw INVALID_SIV_ERROR;
          }

	  throw SUCCESS;

	}

    }



  if (testCW(SI_MEMBER))
    {
      //   --- StoreSiv has to store enuf info for us to dig out
      // which member of which object -- current objptr has moved to point elsewhere!!
      // FIX - we could be in proc that has created a local obj
      // are we in a procedure ??
      // was this specified as apple->color  or  within a CMF   color, i.e. this->color

      Siv *objsivp = NULL;

      // in storesiv we saved  myobj->slot as ic->slot -- but this was for first instance
      // so recover as

      objsivp = parset->obptr; // current obj -- set via PUSH_OBJ for obj->member statement

      // is it a reference to an object ??

#if CDB_IC
        DBP("looking up class member variable %s of %s   slot is %d\n", GetName(), objsivp->getName(),slot);
        DBP("slot should be the cmslot !!\n");
        objsivp->showSivFlags();
#endif

      if (objsivp->testCW(SVPTR)) {

#if CDB_IC
        DBP("objsivp %s SVPTR pointing @ %s\n",objsivp->getName(),objsivp->psiv->getName());
#endif
                  objsivp = objsivp->findPsiv ();
	//        objsivp = objsivp->psiv;

      }

      else if (objsivp->testCW(SVREF)) {

#if CDB_IC
        DBP("objsivp %s SVREF reference tp @ %s\n",objsivp->getName(),objsivp->psiv->getName());
#endif
        objsivp = objsivp->findPsiv ();

        //objsivp = objsivp->psiv;
      }



      if (objsivp->isValid()) {

      // but will need to have mechanism to compile - slot will have to be obj ? 
       obmem = 1;

#if CDB_IC
     DBP ("FindObjectMember of %s offset %d  cmslot %d \n", parset->obptr->GetName(), parset->oboffset, cmslot);
#endif

   // obptr is what we always want ??

         objsivp = parset->obptr;

#if CDB_IC
	 DBP ("setting member obj to %s id %d type %s\n", objsivp->GetName(), objsivp->getID(), objsivp->Dtype());
#endif


      if (objsivp->testCW(SVPTR)) {

#if CDB_IC
        DBP("objsivp %s SVPTR pointing @ %s\n",objsivp->getName(),objsivp->psiv->getName());
#endif

        //objsivp = objsivp->psiv;
        objsivp = objsivp->findPsiv ();

      }


      // obptr, oboffset - are for current obj variables in CMF executed by that
      // object 
      // need more input to refer to C[1]->x = C[2]->x 
      // in main, declared in proc, in CMF
      // this may be NULL if not in procedure
      {


#if CDB_IC
        if (objsivp->testCW (SI_ARRAY)) {
	    DBP ("Cclass obj %s is Array offset %d size %d\n", objsivp->GetName(), objsivp->offset, objsivp->size);
        }
#endif

	int cmf_offset = 0;

	// cpargv always points to current proc/cmf as  we proceed though stack of nested proc/cmf

	if (parset->TestPCW (OBJELE))
	  {

#if CDB_IC
	    DBP("set via a previous instruction  PUSH/POP_OBJELE \n");
            DBP("obptr %s  objsivp %s offset %d\n",parset->obptr->getName(),objsivp->getName(),objsivp->offset);
            // if parsed a direct refrence like X[i]->type
            // or  X[i]->A[j]->type   --- nested class reference
#endif


	    if (objsivp != NULL) {
	      cmf_offset = objsivp->offset;	// this was set parsing something like OB[j]->val
            }

	    // ob[i]->val * ob[j]->val ??
	  }

	else if (parset->TestPCW (SOBJ))
	  {

#if CDB_IC
	    DBP("set via PUSH_OBJ \n");
#endif

	  }

	else
	  {

	    cmf_offset = parset->oboffset; // need to get current CMF function and which object 

	    if (parset->cpargv != NULL)
	      {
#if CDB_IC
            DBP("getting obptr from parset->cpargv->pin_obptr !! \n");
#endif
		parset->obptr = parset->cpargv->pin_obptr;
		parset->oboffset = parset->cpargv->pin_oboffset;
		cmf_offset = parset->oboffset;	// need to get current CMF function and which object 

	      }

	    // inside CMF function
	    // the object array offset is held in parset->oboffset
	    // this info is also in calling arg stack

	  }



	    if (objsivp->asclass == NULL) {

	         DBPERROR("NULL asclass for %s \n", objsivp->getName());              
		 // try SVPTR
                Siv *where;
	        where = objsivp->findPsiv ();
                if (where != NULL) {
		  if (where->testCW(SI_CLASS)) {
		    DBP("using PSIV %s\n",where->getName());
                    objsivp = where;
                  }
                }
            }


	  if (objsivp->getSize() == 0)
	  {

	    if (objsivp->asclass == NULL) {

  	       	      DBPERROR("asclass for %s \n", objsivp->getName());              

            }
            else {

	         // ignore oboffset must be the single obj we want to reference

	      sivp = objsivp->asclass[0]->getMemberSiv (GetName (), cmslot, parset, vc);

            }


	  }
	else if (cmf_offset < objsivp->size)
	  {
#if CDB_IC
	    DBP("getMemberSiv %s  offset %d cmslot %d\n",GetName(), cmf_offset, cmslot);

#endif

	    sivp =
	      objsivp->asclass[cmf_offset]->getMemberSiv (GetName (), cmslot, parset, vc);

	  }
	else {
	  sivp = objsivp->asclass[0]->getMemberSiv (GetName (), cmslot, parset, vc);
	}


#if CDB_IC
	if (sivp->isValid())
	  {

	    DBP ("Found objmember %s slot %d cmslot %d\n",
		 sivp->GetName(), sivp->slot, sivp->getCmslot());

	    // PRINT_VAL
            if (sivp->checkType(INT)) {
                  int *ip = (int *) sivp->getMemp(); 
		  DBP("value %d\n",*ip);
            }
	  }
	else
	  {
	    DBPERROR ("can't get CM sivp from  slot %d cmslot %d \n",
		 slot, cmslot);
	  }
#endif

      }


      }

      else {

	DBPERROR("objsivp invalid \n");

      }

    }  // SI_MEMBER


  }


   catch (asl_error_codes ball) 
    {

      //      DBP("ball asl_error_codes caught is %d \n", ball);

      if (ball != SUCCESS) {

        DBP("error %d \n",ball);
      }

    }


#if CDB_IC

  if (sivp != NULL)
    {
      DBP ("sivp memp %u Foundsivid %d state %d obmem ?%d %s CW %d MEMBER %s\n",sivp->getMemp(), sivp->GetID (), state,
	   obmem, sivp->GetName(),sivp->getCW(),yorn(sivp->testCW(SI_MEMBER)));

    }

#endif

}


void
Icode::StoreSiv (Siv * siv)
{

  if (siv == NULL)
    {

      DBPERROR ("StoreSiv: NULL variable ");
     
    }
  else {

  sivp = siv;

  int len = strLen (siv->GetName());
  int k = len + 1;

  vlen = k;

  sz += (short) k;

  strcpy (str, siv->GetName());

#if CDB_IC
  DBP ("%s %s  %s id %d slot %d cmslot %d\n", octype (opcode), sivp->GetName(), sivp->Dtype(), sivp->getID(),sivp->slot,sivp->getCmslot() );
  sivp->showSivFlags();
#endif

 if (sivp->testCW(SI_MEMBER)) {

        slot =  ((Siv *) sivp->getMyObj())->slot;

#if CDB_IC
        DBP("%s is member of %s set icslot to %d\n",sivp->getName(), sivp->getMyObjName() ,slot);
        DBP("warning nested class?\n");
#endif

 }
 else {
        slot = siv->slot;
 }



 cmslot = siv->getCmslot();

// lets store sivp->cw
// have to store current values since they can change later in statement parse
  cw = siv->getCW();  // should allow us to check for vector
  // state actually tells us if this is reference or value we need from variable
  aw = siv->getAW();  // should allow us to check for vector

#if CDB_IC
  DBP("icslot %d cmslot %d\n",slot, cmslot);
#endif



  }




}

void
Icode::ReferSiv (Siv * siv)
{
  if (siv == NULL)
    {
      DBPERROR ("ReferSiv: invalid variable ");
    }
  else {
  sivp = siv;

  int len = strLen (siv->GetName());

  int k = len + 1;
  vlen = k;
  sz += (short) k;
  strcpy (str, siv->GetName());

#if CDB_IC
 DBP ("%s   %s  %s \n", octype (opcode), sivp->GetName(), sivp->Dtype() );
 ShowSivFlags("ReferSiv ",sivp);
#endif

  }
}

// XIC

// set to xecute intermediate code
pthread_mutex_t IC_mutex;

// this needs to be mutexed -- only one thread  can be doing this until complete writing to shared memory

void init_IC_mutex()
{
         pthread_mutex_init(&IC_mutex,NULL);

}



void
Statement::WriteIC (char opcode, int wstate, Siv * sivp, const char *name,  ICpar * icpar , float f_value)
{
// add IC to  end lists
// script is interpreted - and then coded into these opcodes
// simplest will just use value of wstate - when executed 
// e.g. see ARRSEP
// if sivp is set to SIV variable then this can be used for manipulations
// calculations using 'high-level' variables
// with separate gpthreads -- we will need to compile each statement prior to execution
// and mutex lock that operation - until done

//  TBD -- redo
//  Note - we have a ptr cp to the position in memory block for current instruction it needs to 
//  incremented per instruction by whatever is stored in ic->str position  
//  at the moment that 
//  will be the name of any Siv variable when StoreSiv is used - thus after StoreSiv ic->sz is
//  that name length and therefore cp must be incremented accordingly - this is somewhat of a hack
//  and should be re-engineered - any further information that is tacked on both ic->sz and the position
//  of code ptr should be incremented  - these should be tied

  pthread_t ptid = pthread_self();

//  DBP("thread <%u> locking COM mutex \n", ptid);

  int status = pthread_mutex_lock(&IC_mutex);

  Svar wiceval;

  ICpar def_icpar;

  //  if (No_IC) GOTOEXIT;

#if CDB_WIC
  dbprintf(0," ----------------------------------------------------------------------------------\n");
  DBP ("<%d> %s %d  nic %d %s %s \n", id, octype (opcode), wstate, nic,name, PrintState ());
  dbprintf(0," ----------------------------------------------------------------------------------\n");
#endif


  char *cp = stend;
   // cp is incremented as info is stored -- want a method to do this


  if (icpar == NULL) {
    icpar = &def_icpar;		// default settings
  }

  //    dbp("testing %d %d  %d \n",SSC,getState(), (SSC & getState()));

  if (TestState (SSC) || TestState (SNW))
    GOTOEXIT;


  //    dbp("testing No SSC ? %d %d  %d \n",SSC,getState(), (SSC & getState()));

  if (!TestState (SSI))
    {
      DBPERROR("not SSI \n");
      GOTOEXIT;
    }

  int k;
  Icode *ic;

#if CDB_IC
//  DBP ("end %d opcode %s state %d  name %s\n", stend,  octype (opcode), wstate, name);
#endif

  ic = (Icode *) stend;
  ic->opcode = opcode;

  if (wstate == NOTANOP)
    ic->state = 0;
  else {
    ic->state = wstate;
  }


  ic->na = icpar->na;

  ic->type = icpar->dtype;

  ic->sivp = sivp;

  ic->slot = -1;

  ic->vlen = 0;

  if (ic->sivp != NULL)
    {
      ic->slot = ic->sivp->slot;
      ic->cmslot = ic->sivp->getCmslot();
    }


  int j;
  ic->sz = 0;

  cp = ic->str;  // ptr to constant space


   switch (opcode) {

       case PUSH_ISIV:
       case PUSHS:
       case LOADRS:
       case PUSHCAT:
       case PUSHTAG:
       case CAT_STR:
       case NOOP:	
       case PRT_OUT:

       {

      int len = strLen (name);
      k = len + 1;
      ic->vlen = k;
      ic->sz += (short) k;
      strcpy (ic->str, name);
      cp += ic->sz;

#if CDB_IC
      DBP ("<%s> %s\n", name, dtype (ic->type));
#endif
      }
	  break;


   case CREATE_PV:
     {

#if CDB_IC
      DBP ("%s %s array %d\n", sivp->GetName(), sivp->Dtype(), sivp->testCW(SI_ARRAY));
#endif
      ic->StoreSiv (sivp); // affects ic->state
      cp += ic->sz;
    }
       break;

   case CREATEV:
    {

      ic->StoreSiv (sivp);
      cp += ic->sz;

      if (sivp != NULL)
      ic->type = sivp->type;

#if CDB_IC
      DBP("CREATEV %s %d  %s\n",sivp->getName(),sivp->GetID(),sivp->Dtype());
#endif
    }
	  break;

  case STORER:
    {

#if CDB_IC
      DBP("STORER %s %d GLB? %s\n",sivp->getName(),sivp->GetID(),yorn(sivp->testCW(SI_GLOBAL)));
      sivp->showSivFlags();
#endif

      ic->StoreSiv (sivp);
      cp += ic->sz;
    }
	  break;
  case REFERV:
    {
      ic->ReferSiv (sivp);
      cp += ic->sz;
    }
	  break;

  case PUSH_SIVELE:
  case PUSH_LH_SIVELE:
	   case CLEARSUBI_SIV:
	   case MKSUBSET_SIV:
	   case MKSUBSET_RSIV:
	   case RANGE_SIV:
	   case CWON_SIV:
	   case CWOFF_SIV:
	   case AWON_SIV:
	   case AWOFF_SIV:
	   case COPYPUSH_SIV:
	   case PUSH_SIV: 
           case PUSH_LSIVELE:
           case PUSH_SIVOFFSET:
           case PUSH_SIVELELOC:
           case PUSH_OBJELE:
    {

#if CDB_IC
      DBP ("%s  Cmember %d slot %d cmslot %d free? %d\n",
	   sivp->GetName(), sivp->testCW (SI_MEMBER), sivp->slot, sivp->getCmslot(), sivp->testCW(SI_FREE));
#endif

      // if this is a proc variable - need to resolve recursion/rentrant
      ic->StoreSiv (sivp);

#if CDB_IC
      DBP ("%s stend @ %u\n", sivp->GetName(), (void *) cp);
#endif

      cp += ic->sz;

    }
	  break;

  case PRT_EXP:
     {
      int len = strLen (name);
      k = len + 1;
      ic->vlen = k;
      ic->sz += (short) k;
      strcpy (ic->str, name);
      cp += ic->sz;
      copy_struct (cp, (char *) icpar, sizeof (ICpar));
      ic->sz += sizeof (ICpar);  // ic->sz is size of ic code for this instruction
      cp += sizeof (ICpar);     //  cp is char ptr to position in  block of memory 
                                // for these instructions

     }
          break;
  case CAT_SIV:
    {
      // looks like all we need to store here is any specified print fmt
      // the variable to cat value is already on the stack
      // this command just prints it out with optional fmt specifier

      char fmt[64];
      fmt[0] = 0;
      fmt[1] = 0;

      if (wstate > 0)
	{
	  StrNCopy (fmt, name, 64);
	}

      int len = strLen (fmt);
//DBP("prt_siv fmt %s len %d\n",fmt,len);
      k = len + 1;
      ic->vlen = k;
      ic->sz = (short) k;
      strcpy (ic->str, fmt);
      ic->sivp = NULL;
      cp += ic->sz;

    }
     break;

  case CAT_TID:
    {
      // find the variable - print its <id><type>
      ic->StoreSiv (sivp);
      cp += ic->sz;
    }
    break;


  case PRT_FH:
    {
      // a file-handle has been computed and is currently on the stack
      // pop it off and set

      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;
    }
	  break;


  case PRT_MROW:
    {
      // set itemsperline or matrix row print - also set - 4 items are on
      // the stack for setup of row print --- this just tells
      // xic to load them up and set the rpap struct
      ic->sivp = NULL;
      //      DBP("MROW\n");
    }
	  break;




    case   APPLY_SIVSUBS:
	   case INVSUBI_SIV:
	   case EVALRANGE_SIV:
	   case LH_EVALRANGE_SIV:
	   case SUBIELE_SIV: 
           case SUBIVEC_SIV:
    {

      ic->StoreSiv (sivp); // this stores name as well and increments ic->sz
      // now store icpar

#if CDB_IC
      DBP (" %s  %s stend @ %d na %d\n", octype (opcode), sivp->GetName(),
	   (void *) cp, ic->na);
#endif

      cp += ic->sz;  // increment cp -- so we don't overwrite
      copy_struct (cp, (char *) icpar, sizeof (ICpar));

      ic->sz += sizeof (ICpar);
      cp += sizeof (ICpar);
    }
	  break;

  case REDIMNV:
    {
      ic->na = sivp->getND();
      ic->type = sivp->type;
      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;

#if CDB_IC
      DBP (" %s  %s stend @ %d na %d\n", octype (opcode), sivp->GetName(),
	   (void *) cp, ic->na);
#endif
    }
	  break;

  case VFILL:
    {
      ic->na = wstate;
      ic->type = sivp->type;
      ic->StoreSiv (sivp);
      cp += ic->sz;

#if CDB_IC
      DBP (" %s  %s stend @ %d slot %d na %d\n", octype (opcode), sivp->GetName(),
	   (void *) cp,ic->slot, ic->na);
#endif
    }
	  break;

  case LFILL:
    {
      ic->na = wstate;
      ic->type = sivp->type;
      ic->StoreSiv (sivp);
      cp += ic->sz;

#if CDB_IC
      DBP (" %s  %s stend @ %d slot %d na %d\n", octype (opcode), sivp->GetName(),
	   (void *) cp,ic->slot, ic->na);
#endif
    }
	  break;

  case VFILLR:
    {
      ic->na = wstate;
      ic->type = sivp->type;
      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;

#if CDB_IC
      DBP (" %s  %s stend @ %d slot %d na %d\n", octype (opcode), sivp->GetName(),
	   (void *) cp,ic->slot, ic->na);
#endif
    }
	  break;

  case LOADRN:

#if CDB_IC
    DBP("LOADRN NOP \n");
#endif
	  break;


  case BUILDVEC:
    {
      ic->slot = wstate;
      ic->state = sivp->type;

#if CDB_IC
      DBP ("BUILDVEC - pop %d to build\n", ic->slot);
#endif

      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;

    }
	  break;

  case PUSHN:
    {
      // put in number
#if CDB_IC || CDB_WIC
	  wiceval.GetVarAsStr(sivp);
      DBP (" -> PUSHN storing number %s %s \n", sivp->Dtype (),  wiceval.cptr (0));
#endif

      ic->type = sivp->type;
      k = sivp->Sizeof ();

      if (sivp->type == PAN) {
         // convert to DOUBLE for now
        // copy sin - struct and fields
	 double d = sivp->getAsDouble();
         ic->type = DOUBLE;
         TypeConvert ((void *) &ic->str[0], &d, ic->type, DOUBLE);
      }
      else if (sivp->type == STRV) {
	DBP("PUSHN ? STRV -- what could we do here ??\n");
      }
      else  if (!TypeConvert ((void *) &ic->str[0], sivp->Memp (), ic->type, sivp->type)) {
	DBP ("could not type convert %s %s \n", sivp->GetName(), sivp->Dtype ());
      }

      ic->sz = k;
      cp += ic->sz;

#if CDB_IC

      if (ic->type == INT) {
	DBP ("WRTIC -> PUSHN stored %d \n", *( (int *) &ic->str[0]));
      }

      if (ic->type == DOUBLE) {
	DBP ("WRTIC -> PUSHN stored %f \n", *((double *) &ic->str[0]));
      }
#endif
    }
      break;


   case CALLF:
    {
#if CDB_IC
      DBP ("CALLF %s ind %d \n", name, wstate);
#endif
      // do we want to archive name ?
      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) &ic->str[0];
      *a1 = wstate;
      ic->sz = k;
      cp += ic->sz;
    }
   break;

   case SET_ERROR:
   case PUSHI:
    {
#if CDB_IC
            DBP("opcode %d %d\n",opcode,wstate);
#endif
      ic->type = INT;
      k = sizeof (int); // PORTABILITY
      int *a1 = (int *) &ic->str[0];
      *a1 = wstate;
      ic->sz = k;
      cp += ic->sz;
    }
   break;
   case PUSHF:
    {
      ic->type = FLOAT;
      k = sizeof (float); // PORTABILITY
      float *a1 = (float *) &ic->str[0];
      *a1 = f_value;
      ic->sz = k;
      cp += ic->sz;
    }
   break;


  case CALLVMF:
    {
#if CDB_IC

      DBP ("CALLVMF %s ind %d \n", name, wstate);

      if (sivp->isValid ())
	{
	  DBP ("CALLVMF %s  \n", sivp->GetName());
	}
#endif

      ic->StoreSiv (sivp);
      cp += ic->sz;

      // do we want to archive name ?

      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) cp;
      *a1 = wstate;
      ic->sz += k;
      cp += k;
    }
	  break;

  case CALLCMF:
  case POP_OBJELE:
  case PUSH_OBJ:
    {
#if CDB_IC
      DBP ("%s ind %d %s  offset %d\n", name, wstate, sivp->getName(), sivp->offset);
#endif

      ic->StoreSiv (sivp);
      cp += ic->sz;
      // do we want to archive name ?
      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) cp;
      *a1 = wstate;
      ic->sz += k;
      cp += k;
    }
	  break;

  case CALLMYCMF:
    {

#if CDB_IC
      DBP ("%s ind %d %s\n", name, wstate, sivp->getName());
#endif

      ic->StoreSiv (sivp);
      cp += ic->sz;

      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) cp;
      *a1 = wstate;
      ic->sz += k;
      cp += k;
    }

       break;

  case ACLASS:
    {
#if CDB_IC
      DBP ("ACLASS %s ind %d \n", sivp->GetName(), wstate);
#endif

      ic->StoreSiv (sivp);
      cp += ic->sz;
      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) cp;
      *a1 = wstate;		// contains sclass index
      ic->sz += k;
      cp += k;
    }
     break;

  case CALLP:
    {

#if CDB_IC
      DBP ("CALLP %s ind %d \n", name, wstate);
#endif
      // callp - just make sure all args are popped off into proc calling structure
      // do we want to archive name ?
      ic->type = INT;
      k = sizeof (int);
      int *a1 = (int *) &ic->str[0];
      *a1 = wstate;
      ic->sz = k;
      cp += k;
    }
	  break;

  case LOADR_CLARG:
    {
#if CDB_IC
      DBP ("	ARG %d\n", wstate);
#endif

    }
	  break;

  case PROC_DEF:
    {
#if CDB_IC
      DBP (" ->   %s\n", optype (wstate));
#endif
      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;


    }
    break;

  default:
    {
#if CDB_IC
      DBP (" ->   %s\n", optype (wstate));
#endif
      ic->str[0] = 0;
      ic->sz = 1;
      cp += ic->sz;

    }

  }



  int cisz;

  cisz = cp - stend;

  stend = cp;

  csz = (stend - icblock);

  if (csz > msz / 2)
    {
      icblock =
	(char *) srealloc (icblock,
			   ((msz + (DEF_ICBLKSZ / 2)) * sizeof (char)));
      msz += DEF_ICBLKSZ / 2;
      // Dbp (" realloc St->icblock csz %d msz %d\n", csz, msz);
      stend = icblock + csz;
    }

  if (csz > msz)
    {

      // TOO LATE  this is an overwrite - and has corrupted mem!!
      DBP ("need to realloc St->icblock sz %d msz %d\n", csz, msz);

      // would need to know new bound
    }

  nic++;

#if CDB_IC
  DBP (" <%d> %d %s  opc %d %d sz %d end @ %d cisz %d\n", id, nic,
       Stype (), ic->opcode, ic->state, ic->sz, stend, cisz);
#endif
  // ENDIC realloc

  SetState (SSW, 1);
  //    dbp("St id %d SSW %d\n",id,getState());

Exit:;

  status = pthread_mutex_unlock(&IC_mutex);

}



Icode *
Statement::NextIC (Icode * ic)
{
  // read IC from current index in list and update index
  csi = ic->str + ic->sz;	// moveon - can we tell if there is another??
//  DBP(" str %d sz %d cptr %d\n",ic->str,ic->sz,csi);
  Icode *nextic = (Icode *) csi;
  return nextic;
}

int
Statement::checkNextIC (Icode * ic)
{
  int rv = 1;
  // read IC from current index in list and update index
  char *tcsi = ic->str + ic->sz;	// moveon - can we tell if there is another??
//  DBP(" str %d sz %d cptr %d\n",ic->str,ic->sz,csi);
  Icode *nextic = (Icode *) tcsi;
  if (nextic == NULL)
    rv = 0;
  else {
    if (nextic->opcode != STORER)
      rv = 0;
  }
  return rv;
}

Icode *
Statement::ResetIC ()
{
  csi = icblock;
  Icode *ic = (Icode *) icblock;
  return ic;
}



const char *
opcodetype (int opci)
{

  static const char *e[] = {
    "INIT",
    "CREATEV",
    "FINDV",
    "LOADH",
    "LOADRS",
    "STORER",
    "OPERA",
    "ENDIC",
    "NOOP",
    "LOADRN",
    "PUSHN",
    "NOOP",
    "PUSH_SIV",
    "TRAN_R_H",
    "CALLF",
    "CALLP",
    "LOADR_CLARG",
    "PUSH_SIVELE",
    "APPLY_SIVSUBS",
    "CREATE_PV",
    "REDIMNV",
    "CLEARSUBI_SIV",
    "CWON_SIV",
    "CWOFF_SIV",
    "EVALRANGE_SIV",
    "SUBIELE_SIV",
    "SUBIVEC_SIV",
    "INVSUBI_SIV",
    "MKSUBSET_SIV",
    "RANGE_SIV",
    "COPYPUSH_SIV",
    "BUILDVEC",
    "PUSH_ISIV",
    "CALLVMF",
    "ACLASS",
    "CALLCMF",
    "CALLMYCMF",
    "POP_OBJELE",
    "PUSHS",
    "PEX",
    "SHCOM",
    "CAT_SIV",
    "CAT_STR",
    "PRT_OUT",
    "PRT_FH",
    "PRT_MROW",
    "PUSH_OBJ",
    "PUSH_LSIVELE",
    "MKSUBSET_RSIV",
    "PRT_EXP",
    "LH_EVALRANGE_SIV",
    "VFILL",
    "VFILLR",
    "REFERV",
    "LFILL",
    "LFILLR",
    "PUSHCAT",
    "PUSH_SIVOFFSET",
    "CAT_TID",
    "PROC_DEF",
    "PUSH_SIVELELOC",
    "AWON_SIV",
    "AWOFF_SIV",
    "SET_ERROR",
    "PUSHI",
    "PUSHF",
    "PUSH_OBJELE",
    "PUSHTAG",
    "PUSH_LH_SIVELE",
    "PUSH_CMV",
    "NOTKNOWN"
  };

  int k = sizeof (e) / sizeof (char *);

  if (opci >= 0 && opci < k)
    return e[opci];
  else
    return ("UNKNOWN_CODE");
}

// need one per thread?




int
Statement::Pic (Parset * parset, FILE *pf)
{
  // only run this in debug mode
  Icode *ic;
  int kc = 1;
  ICpar *icpar;

  if (pf != NULL) {

#if CDB_PIC || CDB_IC
   DBP ("<%d> %d %s\n", id, getState (), PrintState ());
#endif

  //    if (TestState(SSPR)) return 0;
  if (!TestState (SSC) || !TestState (SSW))
    return 0;

  char *txt = getTxt ();
  // no other debugs for this proc

  if (txt != NULL) {

  //DBsl->Suspend ();

#if CDB_PIC || CDB_IC
    // CHECK code is never set and it should be pointing to a code block!

    if (code != NULL) {
    DBP("[%d] [%d] <%d> %d  %s   %s \n", linec->lnum, code->id, id, state, stype (type), txt);
    }
    else {
    DBP("[%d] [0] <%d> %d  %s   %s \n", linec->lnum,  id, state, stype (type), txt);
    }
#endif

  int ks = 0;

  //  if (code != NULL) 
     fprintf (pf, "###\n%d %d %d\t%x\t<%d> %s\t%s\n", code->id,linec->lnum,ks,state, id, stype (type), txt);
     // else {
     // fprintf (pf, "###\n-1 %d %d\t%x\t<%d> %s\t%s\n", linec->lnum, ks,state, id, stype (type), txt);
     // }
 

  fflush(pf);

  int done = 0;

  ic = ResetIC ();

  while (!done)
    {
      ks++;
      //if (code != NULL) 
      fprintf (pf, "%d %d %d \t<%d> %2d [%3d] %s :",code->id,linec->lnum,ks,id, kc++, ic->opcode,
	       opcodetype (ic->opcode));
      //else
      //fprintf (pf, "-1 %d %d \t<%d> %2d [%3d] %s :",linec->lnum,ks,id, kc++, ic->opcode, opcodetype (ic->opcode));

      switch (ic->opcode)
	{
	case 0:
	  ICerrc = 1;
	  break;

	case NOOP:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, "%s \n", cp);
	    cp += ic->vlen;	// start of following info- after sivp
	  }
	  break;

	case PRT_OUT:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, "%s \n", cp);
	    cp += ic->vlen;	// start of following info- after sivp
	  }
	  break;

	case PEX:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, "%s \n", cp);
	    cp += ic->vlen;	// start of following info- after sivp
	  }
	  break;

	case SHCOM:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, "%s \n", cp);
	    cp += ic->vlen;	// start of following info- after sivp
	  }
	  break;

	case CALLF:
          {
	    char *cp = &ic->str[0];
	    int *ip = (int *) cp;
	    cp += sizeof (int);
	    fprintf (pf, " %d na %d\n", *ip, ic->na);
	  }
            break;

	case SET_ERROR:
	case PUSHI:
	  {
	    char *cp = &ic->str[0];
	    int *ip = (int *) cp;
	    cp += sizeof (int);
	    fprintf (pf, " %d \n", *ip);
	  }
	  break;

	case PUSHF:
	  {
	    char *cp = &ic->str[0];
	    float *fp = (float *) cp;
	    cp += sizeof (float);
	    fprintf (pf, " %f \n", *fp);
	  }
          break;

	case CALLVMF:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, " %s na %d\n", cp, ic->na);
	  }
	  break;

	case CALLCMF:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, " %s na %d\n", cp, ic->na);
	  }
	  break;
	case CALLMYCMF:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, " %s na %d\n", cp, ic->na);
	  }
	  break;
	case POP_OBJELE:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, " %s na %d\n", cp, ic->na);
	  }
	  break;

	case PUSH_OBJ:
	  {
	    char *cp = &ic->str[0];
	    fprintf (pf, " %s na %d\n", cp, ic->na);
	  }
	  break;

	case CALLP:
	  {

	    char *cp = &ic->str[0];
	    int *ip = (int *) cp;
	    cp += sizeof (int);
	    fprintf (pf, "CALLP %d na %d\n", *ip, ic->na);
	  }

	  break;

	case CREATEV:
	  fprintf (pf, "%s %s array? %d \n", ic->GetName (), dtype (ic->type),
		   ic->state);
	  break;

	case ACLASS:
	  {
	    fprintf (pf, " %s \n", ic->GetName ());
	  }
	  break;
	case PUSH_ISIV:
	  fprintf (pf, "%s %s %d \n", ic->GetName (), dtype (ic->type),
		   ic->state);
	  break;

	case CREATE_PV:
	  fprintf (pf, "%s %s array? %d\n", ic->GetName (), dtype (ic->type), ic->state);
	  break;

	case FINDV:
	  fprintf (pf, " %d %d %d %s\n", ic->state, ic->sivp->slot, ic->sz,
		   ic->str);

	  break;
	case PUSH_SIV:
	    //	    if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;

	case CAT_SIV:

	  // if (ic->sivp->isValid())
	    {
	      fprintf (pf, "%s  %d\n",ic->GetName (), ic->state);
	    }


	  break;

	case CAT_TID:
	  {
	  //if (ic->sivp->isValid())
        
	    fprintf (pf, "%s slot %d\n", ic->GetName (),
		     ic->slot);

	  }
	  break;
	case LOADRN:		// load number into result
	  {
	    fprintf (pf,"LOADRN NOP \n");
          }

          break;
	case PUSHN:		
	  {
	    int *ip = (int *) &ic->str[0];
	    if (ic->type == INT)
	      fprintf (pf, " %d \n", *ip);
	    else if (ic->type == FLOAT)
	      {
		float *fp = (float *) &ic->str[0]; 
		fprintf (pf, " %f \n", *fp);
	      }
	    else
	      fprintf (pf, "\n");
	  }
	    break;

	case STORER:

	  //	  if (ic->sivp->isValid())
	    {
	      //         dbp( " _R  => %s  %s %d\n",ic->GetName(),ic->sivp->GetName(),ic->sivp->slot);
	      fprintf (pf, " _R  => %s   %d\n", ic->GetName (), ic->slot);
	    }

	  break;

	case REFERV:

	  //if (ic->sivp->isValid())
	    {
	      //         dbp( " _R  => %s  %s %d\n",ic->GetName(),ic->sivp->GetName(),ic->sivp->slot);
	      fprintf (pf, " _V  => %s   %d\n", ic->GetName (), ic->slot);
	    }

	  break;


	case OPERA:
	  fprintf (pf, "  %s\n", optype (ic->state));
	  break;
	case TRAN_R_H:
	  fprintf (pf, " !NOOP!\n");	// FIX - is tran_R_H operation ever done?
	  break;
	case LOADRS:
	  // load a string/svar
	  fprintf (pf, " <-- icsvar %s \n", ic->str);
	  //fprintf(pf," %s \n", ic->str);

	  break;

	case PUSHS:
	  // load a string/svar
	  fprintf (pf, " <%s> \n", ic->str);
	  break;

	case PUSHCAT:
	case PUSHTAG:
	  // load a string/svar
	  fprintf (pf, " <%s> \n", ic->str);
	  break;

	case CAT_STR:
	  // load a string/svar

	  fprintf (pf, " %s \n", ic->str);

	  break;

	case PRT_EXP:
	  // load a string/svar

	  fprintf (pf, " %s \n", ic->str);

	  break;

	case PRT_FH:
	  // load a string/svar

	  fprintf (pf, " FH \n");

	  break;

#if 0
	case PRT_ARRSEP:
	  // load a string/svar
	  fprintf (pf, " ARRSEP \n");
	  break;
#endif

	case PRT_MROW:

	  fprintf (pf, " MROW \n");

	  break;

	case PUSH_OBJELE:
	case PUSH_SIVELE:
	case PUSH_LH_SIVELE:
	case PUSH_LSIVELE:
	case PUSH_SIVOFFSET:
	case PUSH_SIVELELOC:
	  // load a string/svar
	  //	  if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;



	case REDIMNV:

	  // load a string/svar
	  //if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;

	case VFILL:


	  //if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %s %d %d %d\n", ic->GetName (), dtype(ic->type),ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;
	case LFILL:
	  //if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;

	case VFILLR:
	  //if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state);
	    }

	  break;

	case APPLY_SIVSUBS:
	  // load a string/svar

	  // 	  if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state, ic->na);
	    }

	  break;

	case CLEARSUBI_SIV:

	  // if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state, ic->na);
	    }

	  break;

	case CWON_SIV:

	  //  if (ic->sivp->isValid())
	    {
	      fprintf (pf, " %s %d \n", ic->GetName (), ic->state);
	    }

	  break;
	case CWOFF_SIV:

	  //  if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state, ic->na);
	    }

	  break;
	case AWON_SIV:

	  //  if (ic->sivp->isValid())
	    {
	      fprintf (pf, " %s %d \n", ic->GetName (), ic->state);
	    }

	  break;
	case AWOFF_SIV:

	  //  if (ic->sivp->isValid())
	    {
	      fprintf (pf, "   %s %d %d %d %d\n", ic->GetName (), ic->slot,
		       ic->cmslot, ic->state, ic->na);
	    }

	  break;

	case EVALRANGE_SIV:
	case LH_EVALRANGE_SIV:
	  {

	    ic->GetSivp (parset);	// locate variable
	    char *cp = &ic->str[ic->vlen];	// start of subop info
	    icpar = (ICpar *) cp;
	    Range r;
	    r.setCW (icpar->cw, ON);
	    fprintf (pf, "   %s wd %d rc %d   %s\n", ic->GetName (),
		     icpar->wd, ic->state, r.PrintCW ());
	  }
	  break;
	case INVSUBI_SIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case SUBIELE_SIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case SUBIVEC_SIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case MKSUBSET_SIV:
	case MKSUBSET_RSIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case RANGE_SIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case COPYPUSH_SIV:
	  fprintf (pf, "   %s  %d\n", ic->GetName (), ic->state);
	  break;
	case BUILDVEC:
	  fprintf (pf, "   %d\n", ic->state);
	  break;
	case LOADR_CLARG:
	  fprintf (pf, " clarg %d\n", ic->state);
	  break;
	case PROC_DEF:
          // which proc name ?
	  fprintf (pf, " proc_def\n");
	  break;
	case ENDIC:
	  //             dbp( "XIC ENDIC \n");
	  done = 1;
	  break;
	}

      if ((ic = NextIC (ic)) == NULL)
	{
	  break;
	}
    }

  fprintf (pf, "\n");
  fflush(pf);

  }


  SetState (SSPR, 1);

  }
//  DBsl->Resume ();


  return ICerrc;
}


void
Statement::Close (Parset * parset)
{

  if (No_IC)
    ;
  else {

  if (!TestState (SSWF))
    {
      //  we need to compile these!!

      WriteIC (ENDIC, NOTANOP, NULL, "", NULL);

#if CDB_IC
      DBP ("--->Close St <%d> csz %d msz %d state %d\n", id, csz, msz, getState());
#endif

      // realloc mem
      if (csz < 0)
	csz = msz;

      if (csz < msz)
	{
	  icblock = (char *) srealloc (icblock, ((csz + 1) * sizeof (char)));
	  msz = csz;
	}


      SetState (SSC | SSWF, 1);

      if (eost != NULL)
	eost_id = eost->id;

      if (parset->TestPCW (WRTPIC))
	{
	  Pic (parset,Pf);
	}


      if (TestCW(DBaction,DBPIC)) {
           Pic (parset,Jf);
        }


#if CDB_IC
      DBP ("<---- Close St <%d> msz %d state %d\n", id, msz, getState());
#endif


    }
  }


}





Siv *
icstack::GetSSV ()
{
  Siv *xresultp;
  Siv *svp;
  char an[64];

#if CDB_IC
  DBP("GetSSV xic_rn %d \n",xic_rn );
#endif

  if (xic_rn < 0)
    xic_rn = 0;

  // should be on a stack of intermediate results
  xresultp = SSV[xic_rn];

  if (xresultp == NULL)
    {

      DBP ("run out of stack pointers xic_rn %d \n", xic_rn);

      sprintf (an, "xic_result_%d", xic_rn);

      svp = new Siv (an);

      SSV[xic_rn] = svp;

      if (svp == NULL) {
	DBPERROR ("init stack variables\n");
      }
      else
	{
	  svp->setCW (SI_STACKV, ON);
	  xresultp = SSV[xic_rn];
	}
    }


  xic_rn++;

#if CDB_IC
  DBP ("\tpush xic_rn %d \n", xic_rn);
#endif

  return xresultp;
}


void
icstack::pushIR (void *a1, int vtype, Parset * parset)
{
  // get a number -- put it into an Siv and push onto stack

  Siv *xresultp = GetSSV ();

  // we should just copy this - if pan
  // right now we alloc double

  if (vtype == UNSET) {

      vtype = DOUBLE;

      DBP ("WARNING  could not type forcing %s DOUBLE  \n", xresultp->GetName());

  }

  if (vtype == STRV) {
    DBPERROR("can't do this !! \n");
  }
  else {

    xresultp->ReallocMem (DOUBLE, 1);
    xresultp->type = vtype;

   if (!TypeConvert (xresultp->Memp (),(void *) a1, vtype, vtype))
     {
       DBP ("could not type convert %s %s mloc %u %p\n", xresultp->GetName(),  dtype (vtype),xresultp->Memp (), a1);
     }



  // makeit scalar
  xresultp->setCW (SVPTR | SI_ARRAY, OFF);
  xresultp->setAW(TAG_ARG,OFF);
  xresultp->size = 0;
  xresultp->offset = 0;

#if CDB_IC
  DBP("\n");
  //        wiceval.GetVarAsStr(xresultp);
  //      dbp("\t\t\textracting number %s %s  => push on stack\n",dtype(xresultp->type),wiceval.cptr(0));
#endif

  }

  Push (xresultp, 0);

}

/////////////////////  use TEMPLATES  ///////////////////////////////////////////

void
icstack::pushI (int value, Parset * parset)
{
  // get a int -- put it into an Siv and push onto stack

  Siv *xresultp = GetSSV ();
  xresultp->ReallocMem (INT, 1);
  int *ip = (int *) xresultp->getMemp(); 
  if (ip != NULL) {
  xresultp->type = INT;
  xresultp->setCW (SVPTR | SI_ARRAY, OFF);
  xresultp->setAW(TAG_ARG,OFF);
  xresultp->size = 0;   // makeit scalar
  xresultp->offset = 0;
  *ip = value;
  //DBP("value %d %d\n",*ip,value);
  }

  Push (xresultp, 0);
}


void
icstack::pushF (float value, Parset * parset)
{
  // get a int -- put it into an Siv and push onto stack

  Siv *xresultp = GetSSV ();
  xresultp->ReallocMem (FLOAT, 1);
  float *fp = (float *) xresultp->getMemp(); 
  if (fp != NULL) {
  xresultp->type = FLOAT;
  xresultp->setCW (SVPTR | SI_ARRAY, OFF);
  xresultp->setAW(TAG_ARG,OFF);
  xresultp->size = 0;   // makeit scalar
  xresultp->offset = 0;
  *fp = value;
  }

  Push (xresultp, 0);
}


///////////////////////////////////////////////////////////////////



void
icstack::pushEleLoc (int ele)
{
  // storing ele location for array
  // for MD array - the bounds are used to compute actual element referenced
  Siv *xresultp = GetSSV ();

  xresultp->ReallocMem (INT, 1);
  xresultp->offset = 0;
  xresultp->type = INT;
  xresultp->Store (ele);
  xresultp->setAW(TAG_ARG,OFF);
  xresultp->setCW (SVPTR, OFF);
  xresultp->setCW (ARRAY_ELE | REF_LH, ON);
  xresultp->setCW (SUBSC_ARRAY_LH | SUBSC_ARRAY, OFF);	// set this so we know 
  Push (xresultp, 0);

}




void
icstack::CopyPush (Siv * sivp)
{
  Siv *xresultp = GetSSV ();

//      ShowSivFlags ("copypush", sivp);

  xresultp->setCW (SVPTR, OFF);
  xresultp->FreeMem();

#if CDB_IC

  DBP ("%s %s --> %s %s %u\n", sivp->GetName(), sivp->Dtype (),
       xresultp->GetName(), xresultp->Dtype () , xresultp->getList());

  DBP ("SVPTR? %s size %d offset %d  nd %d\n", yorn(sivp->testCW (SVPTR)),
       sivp->size, sivp->offset, sivp->getND());

  DBP("array? %s subsc? %s range? %s\n", yorn(sivp->testCW (SI_ARRAY)),yorn(sivp->testCW (SUBSC_ARRAY)),
      yorn(sivp->testCW (SUBSC_RANGE)));

#endif


  xresultp->Copy (sivp);	// Copy will FreeMem first

#if CDB_IC
  DBP ("after copy %s %s\n", xresultp->GetName(), xresultp->Dtype ());
#endif
  // check what has been copied

  xresultp->setCW (SI_ARRAY, sivp->testCW (SI_ARRAY));
  xresultp->setCW ((SUBSC_ARRAY|SUBSC_RANGE), OFF);
  xresultp->setCW (ARRAY_ELE, OFF);
  xresultp->offset = sivp->offset;


#if CDB_IC



  if (xresultp->type == SVAR) {

    DBP ("SVAR [0] %s \n", xresultp->value->cptr (0));
    if (xresultp->value->getNarg() > 1) {
    DBP ("SVAR [1] %s \n", xresultp->value->cptr (1));
    }
  }

  DBP("%s array? %s size %d type %s\n",xresultp->getName(),yes_or_no(xresultp->testCW (SI_ARRAY)), xresultp->getSize(),  xresultp->Dtype ());

  if ( !xresultp->testCW (SI_ARRAY)) {
  
	  Iceval.GetVarAsStr(xresultp);
  DBP ("\t\t\textracting number %s %s  => push on stack\n",
       xresultp->Dtype (), Iceval.cptr (0));
  }

#endif

    if (xresultp->testCW (SI_ARRAY) && xresultp->getSize() <= 0) {
        dberror("array size zero %d\n", xresultp->getSize());
    }

  Push (xresultp, 0);

#if CDB_IC
  DBP ("%s %s CW %d\n", sivp->GetName(), sivp->Dtype (),sivp->getCW());
#endif

}

void
icstack::PushTV (Siv * stresult, Parset * parset)
{

  Siv *xresultp = GetSSV ();

  stresult->svptrOFF();

  xresultp->FreeMem ();

  if (stresult->checkType(SVAR))  {
   xresultp->TransferSvar (stresult);

  }
  else {
    if (stresult->testCW (SI_STACKV) ) {
       xresultp->TransferArray (stresult);
#if CDB_IC
  DBP ("transfer vector %d %s to stack %s from %s\n", xresultp->size,
       xresultp->Dtype (), xresultp->GetName(), stresult->GetName());
#endif
    }
    else {

         xresultp->CopyArray (stresult);
#if CDB_IC
  DBP ("COPY vector %d %s to stack %s from %s\n", xresultp->size,
       xresultp->Dtype (), xresultp->GetName(), stresult->GetName());
#endif
  
    }
  }


  xresultp->svptrOFF();



  Push (xresultp, 0);
}


void
icstack::pushS (const char *str, Parset * parset)
{
  Siv *xresultp = GetSSV ();
  xresultp->FreeMem ();
  //  DBP("<%s>\n",str);
  xresultp->Store (str);
  xresultp->value->SetNarg (1);
  xresultp->setAW(TAG_ARG,OFF);
  Push (xresultp, 0);
}

void
icstack::pushT (const char *str, Parset * parset)
{
  Siv *xresultp = GetSSV ();
  xresultp->FreeMem ();
  //  DBP("<%s>\n",str);
  xresultp->Store (str);
  xresultp->value->SetNarg (1);
  xresultp->setAW(TAG_ARG,ON);
  Push (xresultp, 0);
}




int
Parset::shcom (int store)
{
  // push then popping same info ???
  //  SlotStack.pushS (icsvar.cptr (0), this);
  // clear for next 
  // icsvar.clear (0);
  // pop paraexpanded string expression of of stack

  Siv *popresult = SlotStack.PopR ();


  if (popresult->isValid())
    {

      //DBP ("trying SHCOM %s\n", popresult->Dtype ());

      if (popresult->checkIsStr ())
	{
	  const char *cp = stptr;

	  //DBP ("popping SHCOM %s\n", popresult->value->cptr (0));
	  // want !!" " added back

	  popresult->value->cpy ("!!", 1);
	  popresult->value->cat (popresult->value->cptr (0), 1);

	  //      popresult->value->cat("\"",1);

	  stptr = popresult->value->cptr (1);

	  // DBP ("trying SHCOM %s\n", popresult->value->cptr (1));

	  Scommand (!store, 1);

	  stptr = cp;
	  // push result on stack
	  // clear
	  popresult->value->clear (1);

	  //DBP ("SHCOM returns %s\n", result->Dtype ());
	  if (result->checkType(SVAR))
	    {
	      //  Dbp ("SHCOM returns %s\n", result->value->cptr (0));
	      // want to CopyPush
	      SlotStack.CopyPush (result);
	      result->FreeMem ();
	    }
	}
    }
}

void
Parset::loadrn (Icode * ic)
{
  // what about PAN
  // extract number store in result/hold??
  void *a1 = (void *) &ic->str[0];
  // need to make sure result has memory to store this number

#if CDB_IC
  int *ip = (int *) a1;
  if (ic->type == INT) {
    DBP ("\t\t\t extracting %d \n", *ip);
  }
#endif
  // now store it on stack

  SlotStack.pushIR (a1, ic->type, this);
}

void
Parset::pushn (Icode * ic)
{
  // what about PAN
  // extract number store in result/hold??
  void *a1 = (void *) &ic->str[0];

#if CDB_IC
  int *ip = (int *) a1;
  if (ic->type == INT) {
    DBP ("\t\t\t extracting %d \n", *ip);
  }
#endif
  // now store it on stack

  SlotStack.pushIR (a1, ic->type, this);

}

void
Parset::pushi (Icode * ic)
{
  void *a1 = (void *) &ic->str[0];
  //DBP("%d \n",* (int *) a1);
  SlotStack.pushI ( * (int *) a1, this);
}

void
Parset::pushf (Icode * ic)
{
  void *a1 = (void *) &ic->str[0];
  SlotStack.pushF ( * (float *) a1, this);
}


void
Parset::pushCat (Icode * ic)
{
  // string has been built up in ParamExpand 
  // --- need to put it on the stack for func argument
  SlotStack.pushS ( (char *) icsvar.cptr (0), this);
  icsvar.clear (0);
}

void
Parset::pushTag (Icode * ic)
{
  // string has been built up in ParamExpand 
  // --- need to put it on the stack for func argument
  SlotStack.pushT ( (char *) icsvar.cptr (0), this);
  icsvar.clear (0);
}



void
Parset::pushs (Icode * ic)
{
  // redo -- to push str
  // string has been built up in ParamExpand 
  // --- need to put it on the stack for func argument
  //  DBP("<%s> \n",icsvar.cptr (0));
    SlotStack.pushS (ic->str, this);

  //  SlotStack.pushS ((char *) icsvar.cptr (0), this);
  // clear for next 
  //icsvar.clear (0);

}




void
Parset::loadrs (Icode * ic)
{
  // string has been built --- need to put it on the stack for func argument
   SlotStack.pushS (ic->str,this);
  // check works for args
  //DBP("<%s> \n",icsvar.cptr (0));

  // popoff stack until not a string and 
  // pop paraexpanded string expression of of stack

  //SlotStack.pushS ((char *) icsvar.cptr (0), this); //FIXME svar  char ptr export
  // clear for next 
  //icsvar.clear (0);
}

void
Parset::pex (Icode * ic)
{
  Svar sprintPst; // CHECK
  char *cp = &ic->str[0];
  //    Dbp ("PEX this %s \n", cp);
#if CDB_IC
  DBP ("PEX this %s \n", cp);
#endif

  // cp -->SprinPst -- make this a local

  sprintPst.clear (0);
  sprintPst.clear (1);
  //  SprintState.clear (0);
  //SprintState.clear (1);
  sprintPst.cpy (cp, 0);

  paramExpand (&sprintPst, 0,0);

  SlotStack.pushS ((const char *) sprintPst.cptr (0), this);

  // remove quotes
}


void
Parset::set_error (Icode * ic)
{
  char *cp = &ic->str[0];
  int *ip = (int *) cp;
  // which thread ?
  N_error++;
  Last_error = *ip;
  dberror("%d %s in execution!\n",Last_error,si_error_msg(Last_error));
}


void
Parset::callf (Icode * ic)
{
  char *cp = &ic->str[0];
  int *ip = (int *) cp;

#if CDB_IC 
  DBP ("%d() na %d \n", *ip, ic->na);
#endif

  // need to know number of args to pop off stack

  Sfunc (*ip, ic->na);

  // lets push  this result onto stack
  if (result->type == SVAR)
    result->CheckSvarBounds ();

#if CDB_IC 

  if (!result->testCW (SI_ARRAY))
    {
	  iceval.GetVarAsStr(result);
     
      DBP ("\t\t\t result %s  \n", iceval.cptr (0));
    }
  else
    {

      DBP ("Func returns %s vector sz %d type %s \n", result->getName(), result->size, result->Dtype ());
     

    }
#endif

  if (result->testCW(SVPTR)) {
   
    DBP ("but return ptr ? %s  ---> %s\n", yorn(result->testCW(SVPTR)), result->psiv->getName());
    result = result->findPsiv();
    DBP ("Func returns %s vector sz %d type %s \n", result->getName(), result->size, result->Dtype ());
  }


  result->offset = 0;

  if (result->checkType(SVAR))
    {

      SlotStack.PushTV (result, this);

    }
  else if (result->isStrType())
    {
      // want to CopyPush
      SlotStack.CopyPush (result);
      result->FreeMem ();
    }

  else if (result->testCW (SI_ARRAY))
    {
      SlotStack.PushTV (result, this);
    }
  else {
      SlotStack.pushIR (result->Memp (), result->type, this);
  }



}


void
Parset::callvmf (Icode * ic)
{

  ic->GetSivp (this);

  // now find VMF index


  if (ic->sivp->isValid())
    {

      //      char *cp = &ic->str[ic->vlen];	// start of following info- after sivp
      // int *ip = (int *) cp;

      int *ip = (int *)  &ic->str[ic->vlen];	// start of following info- after sivp
      Siv *asivp = ic->sivp->findPsiv ();

#if CDB_IC
      DBP (" %d()vmf args na %d \n", *ip, ic->na);
#endif
      // need to know number of args to pop off stack
#if 0
      if (asivp->testCW (SI_ARRAY))
	{
	  int ele;
#if CDB_IC
	  //              SlotStack.Examine ();
	  DBP ("VMF rotating stack na %d \n", ic->na);
#endif

	  SlotStack.Rotate (ic->na);

	  Siv *popresult = SlotStack.PopR ();

	  if (popresult != NULL) {

	    popresult->getVal (&ele);

#if CDB_IC
          DBP("%d which ele %d \n",popresult->GetName(),ele);
#endif
	  asivp->offset = ele;
            
          }


	}
#endif

       this->Svmf (asivp, *ip, ic->na);

#if CDB_IC
       DBP("result %d \n",result->type);
#endif


      // lets push  this result onto stack
      if (result->type == SVAR) {
#if CDB_IC
	DBP("result SVAR \n");
#endif
	result->CheckSvarBounds ();

      }

#if CDB_IC_FIXME


      ShowSivFlags ("callvmf", result);

      if (!result->isVectorType())
	{
	  iceval.GetVarAsStr(result);
	  
	  DBP ("\t\t\t result %s  \n", iceval.cptr (0));
	}
      else
	{
	  DBP ("Func returns vector result sz %d type %s \n",
	       result->size, result->Dtype ());
	}

#endif


      result->offset = 0;

      if (result->type == SVAR || result->type == STRV)
	{
	  // want to CopyPush
	  SlotStack.CopyPush (result);
	  result->FreeMem ();
	}
      else if (result->getType() == LIST)
	{
          //DBP("LIST PushTV \n");
	  SlotStack.PushTV (result, this);
	}

      else if (result->testCW (SI_ARRAY))
	{
	  SlotStack.PushTV (result, this);
	}
      else {
	//	DBP("type ?? %d\n", result->type);

	SlotStack.pushIR (result->Memp (), result->type, this);

      }

    }
  else {

    DBP("invalid \n");
  }

}

void
Parset::callcmf (Icode * ic)
{

  Siv *popresult;

  ic->GetSivp (this);

  // now find  index

  if (ic->sivp->isValid())
    {
      char *cp = &ic->str[ic->vlen];	// start of following info- after sivp

      int *ip = (int *) cp;

      Siv *objptr = ic->sivp->findPsiv ();

      int ele = 0;

      // if objptr is pointing to object array need to
      // find which ele of this array
      // need to know number of ic->na args to pop off stack
      // obj_offset is underneath args on stack
      // need to skip that to the top if nargs > 0

      //  CHECK we can now store offset on stack with ptr to siv

      // FIXME --- this won't take care of a range spec
      // unless we have mechanism to type pop-result as an ele or range-spec
      // or subset array
      // similar to VMF --- these should be the same

      if (objptr->testCW (SI_ARRAY))
	{
#if CDB_IC
	  //              SlotStack.Examine ();
	  DBP ("CALLCMF rotating stack na %d \n", ic->na);
#endif

	  SlotStack.Rotate (ic->na);

	  popresult = SlotStack.PopR ();

	  if (popresult != NULL) {

	    popresult->getVal (&ele);
#if CDB_IC
          DBP("%d which ele %d \n",popresult->GetName(),ele);
#endif
          }
	}

#if CDB_IC
      DBP ("CALLCMF %d() na %d %s [%d]\n", *ip, ic->na, objptr->GetName(), ele);
#endif

      this->SprocXic (*ip, ic->na, objptr, ele,1);

      // if proc has returned a value it is already on stack!
    }
}


void
Parset::callmycmf (Icode * ic)
{
      char *cp = &ic->str[ic->vlen];
      int *ip = (int *) cp;


  ic->GetSivp (this);

  // now find  index

  if (ic->sivp->isValid())
    {
      // Siv *objptr = ic->sivp->findPsiv ();
      // if objptr is pointing to object array need to find
      // which ele of this array
      // here we assume it is the current "parent" executing object
      // referenced by this->obptr & this->oboffset
      //  CHECK we can now store offset on stack with ptr to siv

#if CDB_IC
      DBP ("CALLMYCMF %d() na %d %s offset %d\n", *ip, ic->na, ic->sivp->GetName(), this->oboffset);
#endif

        this->SprocXic (*ip, ic->na, ic->sivp, this->oboffset,1);

#if CDB_IC
      DBP ("BACK FROM CALLMYCMF \n");
#endif


    }
      // if proc has returned a value it is already on stack!

}





void
Parset::store_r_to_siv (Siv * sivp, Siv *result, Siv *vinfo)
{
  // result (may be a subscripted array)
  // stored to sivp  using subscripted/ele info referenced by vinfo
  // and vinfo may be UNSET -- type,array determined via RHS parse
  // in which case result specs determine sivp type, vector
  // currently modelled on l1_store -- which needs revision

  // we have to check 
  // scalar/array
  // svar,str
  // element index or range sivp LH_SUBSC - result SUBSC
  // 
  // can we transfer or have to copy ?
  int debug_it = 0;
  int convert_needed = (result->getType() != sivp->getType());


  if (!sivp->testCW(SI_ARRAY)) {
    sivp->setND(0);
  }

#if CDB_IC || debug_it

 DBP("%s --> %s with info from %s \n",result->getName(), sivp->getName(), vinfo->getName());
 result->showSivFlags();
 sivp->showSivFlags();
 DBP("vinfo ELE? %s \n", yorn(vinfo->testCW(ARRAY_ELE)));
 DBP("%s --> %s  Convert %s\n",result->Dtype(), sivp->Dtype(), yorn(convert_needed));

       if (sivp->testCW(SI_MEMBER)) {
                   DBP("%s is MEMBER of %s\n",sivp->getName(),sivp->getMyObjName()) ;
       }


       if (result->testCW(SI_MEMBER)) {
                   DBP("%s is MEMBER of %s\n",result->getName(),result->getMyObjName()) ;
       }


#endif


  int wele;
  int ok;


      if ((sivp->type == UNSET || sivp->type == LIST) && result->type == LIST ) {

	      sivp->storeList(result); // will need a vinfo version

      } 
      else if (sivp->type == UNSET && result->testCW (SI_ARRAY) ) {

	    ok =arrayToUnsetVar(sivp, result);

      } 

      else if ( ((sivp->testCW (SI_ARRAY) || sivp->testCW (DYNAMIC_ARRAY) || sivp->checkType(SVAR)) && !sivp->testCW (ARRAY_ELE)) 
		 && !sivp->checkType(STRV)
                 && !vinfo->testCW (ARRAY_ELE)
                 && !vinfo->testCW (SUBSC_ARRAY_LH)

                 ) 
      {

#if CDB_IC || debug_it
        DBP("%s type is %s  result %s\n",sivp->getName(),sivp->Dtype(), result->Dtype());
#endif

	if ((sivp->checkType(CHAR) || sivp->checkType(UCHAR)) && result->checkType(STRV)) {

#if CDB_IC || debug_it
	  DBP("string to char/uchar array %s\n",result->value->cptr(0)); 
#endif

	     ok = sivp->storeStringToChar(result->value->cptr(0));     

	}
        else if (!result->testCW(SI_ARRAY) && !result->testCW(SVPTR)) {
#if CDB_IC || debug_it
		 DBP("scalarSetArray\n");
#endif

		     ok = scalarSetArray (sivp, result);

               }
               else {

	           if (result->testCW (SI_STACKV)) 
                    {

		      ok = arrayTransfer(sivp,result);
		    }
                   else 
                    {

#if CDB_IC || debug_it
		    DBP("store array to %s \n", sivp->GetName());
#endif
                     sivp->storeArray(result);

                   }
	       }
      }
      ////////     USE VINFO   ///////////////////////
      else if (vinfo->testCW (ARRAY_ELE)
		       && vinfo->testCW (REF_LH))
		{


                  vinfo->getVal(&wele);

#if CDB_IC || debug_it
		  DBP ("vinfo get ele location wele %d   sivp %s  sz %d\n", wele, sivp->getName(), sivp->getSize());
#endif

                  if (sivp->TestCW(SI_ARRAY)) {

		  sivp->setCW (SUBSC_ARRAY | SUBSC_ARRAY_LH, OFF);
                  sivp->setCW (ARRAY_ELE, ON);

                  if (wele < sivp->getSize()) {
                    sivp->offset = wele;
                  }
                  else if (sivp->checkType(SVAR) || sivp->checkType(LIST)) {
		    // these can dynamically expand -- so W[n] = "new" is OK where n > current size
                      sivp->offset = wele;
		    //DBP("WARNING ele %d  wrong size %d\n",wele, sivp->getSize());

                  }
                  else {

		      DBP("WARNING ele %d  wrong size %d\n",wele, sivp->getSize());

                  }

                  }

		  store_var (sivp, result, this);

		}

             else if (sivp->testCW(SI_MEMBER)) 
             {

	       Siv *wobj = sivp->getMyObj();
 
             // OBJ->MEMBER --> OBJ->MEMBER
#if CDB_IC || debug_it
	       DBP("%s is MEMBER of %s id %d type %s\n",sivp->getName(),sivp->getMyObjName(),wobj->getID(),wobj->Dtype()) ;
#endif

                   store_var (sivp, result, this);

             }
             //  SUBSC INFO

	     // ARRAY  ---> ARRAY

             // plain scalar 
	     else { 

#if CDB_IC || debug_it
	       DBP ("plain scalar store to %s ND %d from %s\n",sivp->getName(),sivp->getND(), result->getName() );
#endif
                   store_var (sivp, result, this);

	     }


#if CDB_IC 
      DBP("<--- \n");
#endif



}





void
Parset::storer_to_w (Icode * ic, Siv *popresult, Siv *popwhere)
{
// way too much here !
//  FIX   this should be how to transfer the popresult
//   to the stored location  -- using subscripted LHS/ELE information stored in popwhere
//  -- rename to storehow
// at the moment it looks like the store to variable is modified 
// LHsubscripted and storehow is not always relevant
  int debug_it = 0;


#if CDB_IC || debug_it

	  DBP ("popresult %s type %s  Vector %d? SIM %d\n", popresult->GetName(),
	       popresult->Dtype (), popresult->testCW (SI_ARRAY), popresult->testCW (SI_MEMBER));

	  DBP ("popwhere type %s  Vector %d? LH_S %d ? REF_LH %d SIM %d\n",
	       popwhere->Dtype (), popwhere->testCW (SI_ARRAY),
	       popwhere->testCW (SUBSC_ARRAY_LH), popwhere->testCW (REF_LH),popwhere->testCW (SI_MEMBER));

	  if (popresult->testCW (SI_ARRAY))
	    {
	      DBP ("popresult range start %d  end %d?\n",
		   popresult->range.start, popresult->range.end);
	    }
#endif


// ??? revise --- wayto complex

	  if (!popresult->checkIsStr ()
	      && (popresult->testCW (SI_ARRAY)  || popresult->type == SVAR)
	      && !popwhere->testCW (ARRAY_ELE))
	    {

	      if (!popwhere->testCW (SI_ARRAY))
		{

		  if (ic->sivp->type != UNSET)
		    {

   DBPERROR ("ic popres %s type %s sz %d popwhere %s storing array to scalar %s \n",popresult->GetName(),popresult->Dtype (),popresult->size,
   popwhere->GetName(), ic->sivp->GetName());

		      ShowSivFlags ("storer", ic->sivp);
		    }

		}


	      if (strncmp (popresult->GetName(), "xic_result", 10) == 0)
		{

#if CDB_IC || debug_it
    popwhere->showSivFlags();
#endif

		  if (popwhere->testCW (SUBSC_ARRAY_LH)
		      && popwhere->testCW (REF_LH))
		    {

		      // copy over the subset

		      // ic->sivp->VSetSubSet (popwhere );  

                      // we don't do this !!??

		      // do subscript store
		      // setting subset to values in popresult array/or subset

#if CDB_IC || debug_it
		      DBP
			("LHSubScriptStore from %s %s %d to %s %s %d\n",
			 popresult->GetName(), popresult->Dtype (),
			 popresult->size, ic->sivp->GetName(), ic->sivp->Dtype (),
			 ic->sivp->size);
#endif

		      ic->sivp->LHSubScriptStore (popresult);

		    }
		  else if (popresult->type == SVAR)
		    {
		      ic->sivp->TransferSvar (popresult);
		    }
		  else
		    {


     	              if (!popwhere->testCW (SI_ARRAY) && popresult->size == 1) {
                           popresult->setCW(SI_ARRAY,OFF);
       	                   store_var (ic->sivp, popresult, this);
                      }
                      else  {

#if CDB_IC || debug_it
		      DBP
			(" transfer array from %s %s %d to %s %s %d\n",
			 popresult->GetName(), popresult->Dtype (),
			 popresult->size, ic->sivp->GetName(), ic->sivp->Dtype (),
			 ic->sivp->size);
#endif

		      ic->sivp->TransferArray (popresult);

                      }

		    }
		}
	      else
		{
#if CDB_IC || debug_it
		  DBP ("CopyArray %s  %s \n", ic->sivp->GetName(), popresult->GetName());
#endif

	      if (popwhere->testCW (SUBSC_ARRAY_LH)
		  && popwhere->testCW (REF_LH))
		{
		  ic->sivp->LHSubScriptStore (popresult);
		}
                else {
		  ic->sivp->CopyArray (popresult);
                }

            }

// when do we want to reduce degenerate dimns??
 
	      //     ic->sivp->Degenerate();

#if CDB_IC || debug_it
	      DBP
		("popresult %s transfer to %s type %s  Vector %d?\n",
		 popresult->GetName(), ic->sivp->GetName(), popresult->Dtype (),
		 popresult->testCW (SI_ARRAY));
#endif

	    }
	  else
	    {

#if CDB_IC || debug_it
	      DBP ("popwhere %s SUBSC_ARRAY_LH? %d ARRAY_ELE? %d REF_LH %d \n",
		   popwhere->getName(),popwhere->testCW (SUBSC_ARRAY_LH),
		   popwhere->testCW (ARRAY_ELE), popwhere->testCW (REF_LH));
#endif
	      // ic->sivp->offset = 0;


	      if (popwhere->testCW (SUBSC_ARRAY_LH)
		  && popwhere->testCW (REF_LH))
		{

		  // setting subset to one value
		  // copy over the subset
		  // ic->sivp->VSetSubSet (popwhere );
		  // ic->sivp->SubScriptStore (popresult);
		  // do subscript store
		  // use LHsubset

		  ic->sivp->LHSubScriptStore (popresult);


		}

	      else if (popwhere->testCW (ARRAY_ELE)
		       && popwhere->testCW (REF_LH))
		{


		  if (ic->sivp->offset < 0)
		    {
		      DBP ("WARNING neg offset  %d?\n", ic->sivp->offset);
                      adjustNegOffset(ic->sivp->offset, ic->sivp->size);
		      //ic->sivp->offset = 0;
		    }

#if CDB_IC || debug_it
		  DBP ("popresult ARRAY? %d \n",
		       popresult->testCW (SI_ARRAY));
#endif



		  ic->sivp->setCW (SUBSC_ARRAY | SUBSC_ARRAY_LH, OFF);

                  //TBD -- CHECK --- should this store be to popwhere ??

		  store_var (ic->sivp, popresult, this);

		  // make & use this
		  // ic->sivp->StoreArrayEle(popresult, wele);

		}
	      else
		{

#if CDB_IC || debug_it
      DBP ("store %s to ? %s or %s\n", popresult->getName(), popwhere->getName(), ic->sivp->getName());
      DBP ("store %d to ? %d or %d\n", popresult->GetID(), popwhere->GetID(), ic->sivp->GetID());

                  // is popwhere pointing to ic->sivp ??
                  if (popwhere->testCW(SVPTR)) {
		    DBP("popwhere ---> %s \n",popwhere->psiv->getName());
		    }


                  DBP("ic->sivp %s %d\n",ic->sivp->getName(),ic->sivp->testCW(ARRAY_ELE));
#endif
                  // if4 ICAO_SA[i][k] = i * 2;
                  // TBD -- FIXME

                  if (ic->sivp->GetID() != popresult->GetID())

		    store_var (ic->sivp, popresult, this);

                  else {
		  // but  obj ref 
                  // think this should always be to popwhere ??
		    store_var (popwhere, popresult, this);

                  }

		}
	    }
}







void
Parset::storer (Icode * ic, int in_stack_depth)
{
  // way too much here !
  // to where ?

  int debug_it = 0;

#if CDB_IC || debug_it
  DBP("--->\n"); 
#endif

  ic->GetSivp (this);

#if CDB_IC || debug_it
   
  DBP (" slot %d mslot %d in_stack_depth %d\n", ic->slot, ic->cmslot, in_stack_depth);
  DBP (" _R  =>  %s\n", ic->GetName ());
#endif


  if (ic->sivp->isValid())
    {

#if CDB_IC || debug_it 
      DBP (" _R  => %s %s %d  ele? %s member %s\n", ic->sivp->GetName(), ic->sivp->Dtype (), 
	   ic->sivp->slot, yorn(ic->sivp->testCW (ARRAY_ELE)), yorn(ic->sivp->testCW(SI_MEMBER)));
#endif

    Siv *popresult = SlotStack.PopW ();

    if (!popresult->testCW(SI_ARRAY)) {
         popresult->setND(0);
     }

#if CDB_IC || debug_it 

      if (popresult != NULL) {

	   DBP ("popped %s to store \n",popresult->getName());

	   if (!popresult->testCW(SI_ARRAY)) {
	      iceval.GetVarAsStr(popresult);
              DBP ("%s is value  %s \n", popresult->getName(),iceval.cptr (0));
	   }

           if (popresult->testCW(SI_MEMBER)) {
	     DBP("is MEMBER of %s type %s\n",popresult->getMyObjName(),popresult->getMyObj()->Dtype()) ;
           }


	   }
#endif


      Siv *popwhere = NULL;

#if CDB_IC || debug_it 
      DBP("depth %d in_stack_depth %d \n",SlotStack.getDepth (), in_stack_depth);
#endif 


      if (SlotStack.getDepth() > in_stack_depth)
	{    

// ? expression may have started at depth > 0 

#if CDB_IC || debug_it 
	  DBP("where does result go ? depth %d \n", in_stack_depth);
#endif 

	    popwhere = SlotStack.PopW ();	// this is an array ele or array subset specification

#if CDB_IC || debug_it 

	  if (popwhere != NULL)
	    {
	      DBP ("\npopwhere %s type %s  Vector? %s Dynamic? %s SUBS? %s LH? %s ELE %s\n",popwhere->GetName(),
		   popwhere->Dtype (), yorn(popwhere->testCW (SI_ARRAY)),yorn(popwhere->testCW (DYNAMIC_ARRAY)),
		   yorn(popwhere->testCW (SUBSC_ARRAY)),  yorn(popwhere->testCW (SUBSC_ARRAY_LH)),
                   yorn(popwhere->testCW (ARRAY_ELE)) );


              if (popwhere->testCW(SI_MEMBER)) {
                   DBP("is MEMBER of %s\n",popwhere->getMyObjName()) ;
              }

	    }
#endif
	}

      // what to put ?


      if (popresult != NULL && popwhere != NULL)
	{

	  //	  DBP("popresult and popwhere KNOWN \n");

                  if (popwhere->testCW(SI_MEMBER)) {

		    // TBD --- use of ic->sivp versus popwhere needs to be reworked 
                    // push_membersiv ?? 

                     store_r_to_siv (popwhere, popresult, popwhere);
                  }

                  else {


	  	     store_r_to_siv (ic->sivp, popresult, popwhere);

#if CDB_IC
		     // DBP("scalar store \n");
      if (popresult->getType() != UNSET) {
         iceval.GetVarAsStr(popresult);
         DBP ("value  %s stored to %s id %d\n", iceval.cptr (0), ic->sivp->GetName(), ic->sivp->getID());
      }
#endif

                  }
		  // member to member ??

		//              storer_to_w (ic, popresult, popwhere);

	}

      else if (popresult != NULL)
	{

	  if (popresult->testCW (SI_ARRAY))
	    {

//        DBP ("storer popw null-- popresult type %s  Vector %d?\n", popresult->Dtype (), popresult->testCW (SI_ARRAY));

	      if (strncmp (popresult->GetName(), "xic_result", 10) == 0)
		{
		  if (popresult->type == SVAR)
		    ic->sivp->TransferSvar (popresult);
		  else  {

#if 0
     	              if ( popresult->size == 1) {
                           popresult->setCW(SI_ARRAY,OFF);
       	                   store_var (ic->sivp, popresult, this);
                      }
#endif


#if CDB_IC
                   DBP("%s LHS %s\n",ic->sivp->GetName(),yorn(ic->sivp->testCW (SUBSC_ARRAY_LH)) );
#endif


                      if (ic->sivp->testCW (SUBSC_ARRAY_LH)) {

#if CDB_IC
			DBP("LHSubS \n");
#endif

		        ic->sivp->LHSubScriptStore (popresult);
                        //ic->sivp->CopyArray (popresult);
                      }
                      else {
#if CDB_IC
			DBP("Transferarray \n");
#endif
		        ic->sivp->TransferArray (popresult);

		      }
                  }

		}
	      else
		{
		  ic->sivp->CopyArray (popresult);
		}
	    }
	  else
	    {
#if CDB_IC
      DBP("2scalar store \n");
      iceval.GetVarAsStr(popresult);
      DBP ("\t\t\tvalue  %s stored to %s id %d\n", iceval.cptr (0), ic->sivp->GetName(), ic->sivp->getID());
#endif


	      store_var (ic->sivp, popresult, this);

	    }

#if CDB_IC
      iceval.GetVarAsStr(ic->sivp);
      DBP ("\t\t\tvalue  %s stored to %s id %d\n", iceval.cptr (0), ic->sivp->GetName(), ic->sivp->getID());
#endif

	}



      // now back on stack for further operations
      // don't think we need this if this is final statement
      // SlotStack.Push (ic->sivp, ic->state);

    }

#if CDB_IC || debug_it
  DBP("<---\n"); 
#endif

}



void
Parset::referv (Icode * ic)
{

  ic->GetSivp (this);

#if CDB_IC
  DBP ("slot %d mslot %d\n", ic->slot, ic->cmslot);
  DBP (" _R  => %s\n", ic->GetName ());
#endif

  if (ic->sivp->isValid())
    {

#if CDB_IC
  DBP (" _REFV  => %s %s %d  \n", ic->sivp->GetName(), ic->sivp->Dtype (), ic->sivp->slot);
#endif

      Siv *popresult = SlotStack.PopW ();

      if (popresult != NULL )
	{
	  ic->sivp->setPsiv(popresult);
          // REMOVE ic->sivp->setCW(SVREF,ON);
	}

#if CDB_IC
      DBP ("\t\t %s refered to %s\n", ic->sivp->GetName(),popresult->GetName());
#endif

    }

}

void
Parset::procdef (Icode * ic)
{

  DBP("  xxx procdef \n");


}


void
Parset::pushsiv (Icode * ic)
{
  // check ic->state - bit field - proc variable??

#if CDB_IC
  DBP ("pushsiv  %d %s %d  pindex %d \n", ic->slot,
       ic->GetName (), ic->state, this->pindex);
#endif


  // resolve - proc-class-variable
  // if so recursion/thread - scope
  // 
  // will need to check scope at run time to determine
  // what level of recursion/thread is current for a proc variable
  // use if in proc use pvars  which is specific per proc call

  ic->GetSivp (this);

  if (ic->sivp->isValid())
    {
      //              DBP ("PUSH_SIV  nd %d \n",ic->sivp->getND());

      Siv *asivp = ic->sivp->findPsiv ();
 
      asivp->setCW (SUBSC_ARRAY | SUBSC_RANGE | ARRAY_ELE | REF_LH, OFF);
      asivp->offset = 0; // it sticks from previous ele reference
      SlotStack.Push (asivp, ic->state);

    }
  else
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot, ic->GetName ());
    }


  // and place on stack
}

void
Parset::pushcmv (Icode * ic)
{


}


void
Parset::catSiv (Icode * ic)
{
  char *fmt;

#if CDB_IC
  DBP ("%d  \n", ic->state);
#endif

  // at this point the variable or its subscripted copy should be on the stack
  // pop it off and print it to svar!

  Siv *popresult = SlotStack.Pop ();

  // recover fmt

  if (popresult != NULL)
    {

      fmt = ic->str;
      int next_fmt = 0;
      int len = strLen (fmt);

      if (len > 0)
	{
	  next_fmt = 1;
	  //DBP("PRT_SIV type %s len %d fmt %s \n",popresult->Dtype(),len,fmt);
	}


      // ShowSivFlags("PRT_SIV",popresult);

      iceval.clear (0);

      if (popresult->type == SVAR)
	popresult->expandSvar (&iceval, next_fmt, fmt, this);
      else if (popresult->type == LIST) {
	popresult->expandList (&iceval, next_fmt, fmt, this);
      }
      else if (popresult->type == RECORD)
	popresult->expandRecord (&iceval, next_fmt, fmt, this);
      else if (popresult->testCW (SI_ARRAY))
	popresult->expandArray (&iceval, next_fmt, fmt, this);
      else
	{
	  if (len > 1)
	    iceval.GetVarAsStr(popresult, fmt);
	  else
	    iceval.GetVarAsStr(popresult);

	}


      //      DBP ("\t\t\t prtvalue  <%s> \n", iceval.cptr (0));
      // are we printing to stream -- or -- catting to svar
      // assume to stdout now



      //printf("%s",iceval.cptr(0));
      icsvar.cat (iceval.cptr (0), 0);
    }
  else
    {
      DBPERROR ("SlotStack can't get SIV\n");
    }

}


void
Parset::cattid (Icode * ic)
{
    char *fmt;

#if CDB_IC
  DBP ("%d  \n", ic->state);
#endif

  // at this point the variable name slot is in ic storage
  // print the <id><type> to svar!

  ic->GetSivp (this);

#if CDB_IC
  DBP ("slot %d mslot %d\n", ic->slot, ic->cmslot);
  DBP (" _R  => %s\n", ic->GetName ());
#endif

  if (ic->sivp->isValid())
    {

      iceval.clear (0);
      if (ic->sivp->testCW(SI_ARRAY))
       iceval.StrPrintf(0,"<%d><%s[]>[%s] ",ic->sivp->GetID(),dtype(ic->sivp->getType()),ic->sivp->showScopeFlags());
      else
       iceval.StrPrintf(0,"<%d><%s>[%s] ",ic->sivp->GetID(),dtype(ic->sivp->getType()),ic->sivp->showScopeFlags());
      // iceval.StrPrintf(0,"<%d><%s>[%s] ",ic->sivp->GetID(),ic->sivp->Vtype(),ic->sivp->showScopeFlags());
      // DBP("<%d><%s>[%s] ",ic->sivp->GetID(),dtype(ic->sivp->getType()),ic->sivp->showScopeFlags());
 
       //  DBP("<%d><%s>[%s] ",ic->sivp->GetID(),ic->sivp->Vtype(),ic->sivp->showScopeFlags());

      icsvar.cat (iceval.cptr (0), 0);

    }



}


void
Parset::prtfh (Icode * ic)
{
  int fh;

#if CDB_IC
  DBP ("PRT_FH %d  \n", ic->state);
#endif
  // at this point a variable which contains the File Handle value is on the stack
  // pop it off and set Fpt[]

  Siv *popresult = SlotStack.Pop ();

  if (popresult != NULL)
    {
      popresult->getVal (&fh);
//      DBP ("PRT_FH popped fh %d  \n",  fh);
      if (fh >= 1 || fh < 0)
	{
	  Fh = fh;		// global needs to be part of parset ??
	}
    }
  else
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot,
	       ic->GetName ());
    }
}



void
Parset::prtmrow (Icode * ic)
{

  // stack should have 4 items for setting up rpap
  // check and fill in struct
  // stack is n? deep  
  int err;
  char *cp;
  Siv *popresult;
  int deep = SlotStack.getDepth ();

  rpap.itemsperline = 10; //default

  if (deep >= 4) {
    

    popresult = SlotStack.PopR ();
    if (popresult->isValid()) {

      if (popresult->checkIsStr ()) {
      // should be postrow
      cp = popresult->getAsStr(&err);
      DBP("str <%s> err %d\n",cp,err);
      if (err == R_SUCCESS && cp != NULL)
      strcpy(rpap.rowpostfix,cp);
      }
    else
      DBP("postfix NOT STR!\n");
    }

    popresult = SlotStack.PopR ();
    if (popresult->isValid()) {
      // should be arraysep
      if (popresult->checkIsStr ()) {
      cp = popresult->getAsStr(&err);
      if (err == R_SUCCESS && cp != NULL)
      strcpy(rpap.asep,cp);
    }
    else
      DBP("asep NOT STR!\n");
    }

    popresult = SlotStack.PopR ();

    if (popresult->isValid()) {
      // should be prerow
      cp = popresult->getAsStr(&err);
      //      DBP("str <%s> err %d\n",cp,err);
      if (err == R_SUCCESS && cp != NULL)
      strcpy(rpap.rowprefix,cp);

    }

    popresult = SlotStack.PopR ();

    if (popresult->isValid()) {
      // should be nitemsperline
      int err;
      int ni = popresult->getAsInt(&err);
      // DBP("ni %d err %d\n",ni,err);
      rpap.itemsperline = ni; 
    }

  }

}


// WANT A PRINT LITERAL STRING --- NO EXPANSION 

void
Parset::prtlitstr (Icode * ic)
{


}

void
Parset::catStr (Icode * ic)
{


  // either out to stream or cat to string
  if (ic->str != NULL)
    {
      //printf("%s",ic->str);
      icsvar.cat (ic->str, 0);
    }
  // should cat NULL to 

}



void
Parset::prtExp (Icode * ic)
{
// either out to stream or cat to string

char *vp;
Siv *sivp = NULL;
int nxt_fmt = 0;
char *fmt = NULL;
ICpar *icpar;

  char *cp = &ic->str[ic->vlen];	// start of subop info

  icpar = (ICpar *) cp;

  nxt_fmt = icpar->wd;
  fmt = icpar->fmt;

  if (ic->str != NULL)
    {
      // getexp and print
     vp = ic->str;

//DBP ("%s\n", vp);

     iceval.clear (0);        

	      if (*vp == '$')
		{
		  vp++;

		  sivp = ExpandVar (vp, &iceval, this, NULL, 0, 0);

		  vp = (char *) iceval.cptr (0); //FIXME svar  char ptr export
//                  DBP ("$-> %s\n", vp);
		}

	         this->exprn.cpy (vp, 0);
//                  DBP ("GetExp %s\n", vp);
                 this->GetExp (&this->exprn);
	         sivp = this->result;


//	      DBP ("now expand siv   %s \n", this->result->GetName());


	      if (this->result->type == SINUM && nxt_fmt == SINUM)
		{
		  get_sinum_str (this->result, &iceval,1);
		}
	      else
		{
// reclear 
                  iceval.clear (0);        
		  if (result->checkType(SVAR)) {
//                    DBP("result is svar %s\n",this->result->value->cptr(0)); 
  		    this->result->expandSvar ( &iceval, nxt_fmt, fmt, this);

                  }
		  else if (result->checkType(LIST)) {
  	            result->expandList (&iceval, nxt_fmt, fmt, this);
                  }
		  else if (this->result->testCW (SI_ARRAY)) {
  	            result->expandArray (&iceval, nxt_fmt, fmt, this);
                  }
		  else {

                    if (nxt_fmt > 0) {
  //                  DBP("fmt %s \n",fmt);
	            iceval.GetVarAsStr(this->result,fmt);
                    }
                    else
	            iceval.GetVarAsStr(this->result);


	//            DBP ("exp returns  %s \n", iceval.ap[0]);

                  }
		}

                 icsvar.cat (iceval.ap[0], 0);


    }

}




void
Parset::prtout (Icode * ic)
{
  // which  stream ??
  // printf("ICPRTOUT %s",icsvar.cptr(0));

  if (Fh == -1) {
      fprintf (Jf, "%s", icsvar.cptr (0));
  }
  else {
      fprintf (Fpt[Fh], "%s", icsvar.cptr (0));

	if (Use_gwm && PrintToGwm)
	  {
	    GS_MSG (-1, 0,icsvar.cptr (0));
	  }
  }

  //strcpy (ArraySep, " "); // TBD -- hack to clear
}


void
Parset::pushisiv (Icode * ic)
{

#if CDB_IC
  DBP ("%s \n", ic->GetName ());
#endif
  Varcon varcon;
  Varcon *vc = &varcon;


  // use name to get a value - push that onto stack

  //  result = Inresult;

  ic->sivp = indirect_varptr (ic->GetName (), vc);

  if (ic->sivp->isValid())
    {
#if CDB_IC
      DBP ("PUSH_ISIV indirect is  %s  offset %d \n", ic->sivp->GetName(),
	   ic->sivp->offset);
#endif
      // if it is clarg - which one or all ?
      if (strcmp (ic->sivp->GetName(), "_clarg") == 0)
	SlotStack.pushS (ic->sivp->value->cptr (ic->sivp->offset), this);
      else
	SlotStack.CopyPush (ic->sivp);
    }

}


void
Parset::redimnv (Icode * ic)
{
// pop off stack the dimensions
// then pop off the just created Siv - or Siv to be redimensioned
// don't look up via name!!

  int numb = 0;
  ICpar *icpar;

//  ic->GetSivp (this);

  int nd = ic->na;
#if CDB_IC 
      DBP ("REDIMNV nd %d toget \n",nd);
#endif

    if (nd < 0) nd = 0;

    if (nd > 512) {
             nd = 512;
      // arbitary??
      DBP("max dimns 512 !!\n");

     }

  int dimn[512]; // calloc this to nd
  int tsize = 1;
  int j = nd - 1;

      Siv *popresult;

      for (int k = 0; k < nd; k++)
	{
	  popresult = SlotStack.PopR ();

	  if (popresult != NULL)
	    {
	      popresult->getVal (&numb);
	    }

	  dimn[j] = numb;
	  j--;
	  tsize *= numb;

#if CDB_IC 
      DBP ("REDIMNV got %d  [%d] tsize %d \n",k, numb, tsize);
#endif

	}

     ic->sivp = SlotStack.PopR ();

     if (ic->sivp->isValid()) {

#if CDB_IC 
       DBP ("REDIMNV init array? %d \n",ic->sivp->testCW(SI_ARRAY));
#endif




      // since we are doing a redimn --- it MUST be an array
      

      if (ic->sivp->type == SCLASS)
	{
	  // just increase size - subsequent ACLASS
	  // will fill asclass vector
	  ic->sivp->size = tsize;
          ic->sivp->setCW (SI_ARRAY|DYNAMIC_ARRAY,ON);
	}
      else {

       if (!ic->sivp->testCW(SI_ARRAY)) {

         ic->sivp->FreeMem();

       }

      ic->sivp->setCW (SI_ARRAY|DYNAMIC_ARRAY,ON);
      ic->sivp->ReallocMem (ic->sivp->type, tsize);

      }

#if CDB_IC
      DBP ("%s id %d %s size %d array %d\n", ic->sivp->GetName(), ic->sivp->getID(), ic->sivp->Dtype (), ic->sivp->size, ic->sivp->testCW (SI_ARRAY) );
#endif

      ic->sivp->ReallocBounds (nd);

      for (int k = 0; k < nd; k++)
	{
	  ic->sivp->bounds[k] = dimn[k];
#if CDB_IC 
             DBP ("dim %d bounds %d\n", k, ic->sivp->bounds[k]);
#endif
	}


      ic->sivp->setND (nd);


#if CDB_IC 
      DBP ("REDIMNV  %d %s tsize %d \n", ic->slot, ic->GetName (), tsize);
      DBP ("REDIMNV  %s id %d type %s size %d nd %d offset %d\n", ic->sivp->GetName(),ic->sivp->getID(),
	   ic->sivp->Dtype (), ic->sivp->size, ic->sivp->getND(),ic->sivp->offset);
#endif
    }

}


void
Parset::vfill (Icode * ic)
{
  // is this always an initial set from ele 0,... n-1 ?

  int numb = 0;
  int sz;

  ic->GetSivp (this);

  if (ic->sivp == NULL) {
       dberror("no valid siv \n");
      return;
  }

  int nele_to_set = ic->na;

  bool cando = TRUE;

  sz = ic->sivp->size;

#if CDB_IC
  DBP ("nele %d %d current sz %d need %d\n",nele_to_set,ic->na,sz, ic->state);
  DBP(" %s  ic %s stored %d %s\n",ic->sivp->getName(),ic->sivp->Dtype(),ic->type, dtype(ic->type));
#endif

  if (ic->sivp->getType() == NOT_KNOWN_DTYPE) {

    ic->sivp->setType(ic->type);
#if CDB_IC
  DBP(" now type is to %s  ic stored %s\n",ic->sivp->Dtype(), dtype(ic->type));
#endif

     if (ic->type == SVAR) {
         ic->sivp->NewSvar (ic->na);
    }

  }


  sz = ic->sivp->size;


  if (sz < ic->na) {
    // dynamic expand ?? or abort ?

    if (ic->sivp->type == SVAR) {

         sz = ic->na; // should autoexpand --- do we limit for large??
         //DBP("resized to %d %d\n",ic->na,sz); 
    }
    else {
   
      if ( ic->sivp->testCW(DYNAMIC_ARRAY)) {
	ic->sivp->VectorResize(ic->na);
      }
      else  {
	ic->sivp->VectorResize(ic->na); // part of declare 
	//cando = FALSE;

      }

       sz = ic->sivp->size;
    }

    
    if (ic->sivp->type == SVAR) {
      // DBP("size? %d na to %d\n",sz,ic->sivp->value->getNarg()); 
    }


    
  }


// check sivp->size 



    Siv *popresult;
    int wele;

    // this extraction has to looked at what is being popped
    // number or sting 
    // in what context --- filling a char array -- use char values of string
    // for len of string then move on len elements

    int k = 0;

    while ( k < nele_to_set)
	{

	  popresult = SlotStack.PopR ();

          wele = sz-1-k;

	  if (popresult != NULL  && cando)
	    {

#if CDB_IC
   DBP("sz %d setting from %s --> %s ele [%d] \n",ic->sivp->getSize(),popresult->Dtype(),ic->sivp->Dtype(),wele);
#endif

		     k += ic->sivp->StoreValInEle(popresult, wele);

	    }

	}

    if (!cando) {
      dberror("can't expand this array %s to %d\n",ic->sivp->GetName(),sz);
    }

}



void
Parset::vfillr (Icode * ic)
{
  int numb = 0;

// make an internal parse var
// array - type ?
// size is ?
// then fill it
  int wtype = ic->type;
  int nele_to_set = ic->na;

//      DBP (" %d toset wtype %d\n",nele_to_set, wtype);

  Siv *xresultp = SlotStack.GetSSV ();

  xresultp->ReallocMem (wtype, ic->na );
  xresultp->offset = 0;
  xresultp->setCW (SI_ARRAY, ON);
  int sz = xresultp->size;

#if CDB_IC
      DBP (" %s %d \n",xresultp->GetName(), sz);
#endif

// check sivp->size 
      Siv *popresult;
      int wele;
      bool cando = TRUE;
      if (nele_to_set > sz) {
        if ( xresultp->testCW(DYNAMIC_ARRAY)) {
	    xresultp->VectorResize(sz);
        }
        else 
         cando = FALSE;
      }

   
    for (int k = 0; k < nele_to_set; k++)
	{
	  popresult = SlotStack.PopR ();
          wele = sz-1-k;
	  if (popresult != NULL && cando)
	    {
        //DBP("setting ele [%d] to ? \n",wele);
		      xresultp->StoreValInEle(popresult, wele);
	    }

	}
// push xresultp?

  SlotStack.Push (xresultp, 0);

}


void
Parset::pushsivele (Icode * ic, int lh)
{

  // this actually stores element value!
  // where is the ele information stored ??
  // cannot be overwritten by subsequent  sivele operations
  // won't work for PAN or RECORD

  Siv *popresult;

  // result = Inresult;
  // check ic->state - bit field - proc variable??
  // will have to do something more complex for subscripted arrays

  int ele = 0;			// get ele off of stack

#if CDB_IC
  DBP ("%s icslot %d %s %d  pindex %d \n",
       opcodetype (ic->opcode), ic->slot, ic->GetName (),
       ic->state, this->pindex);
#endif


  ic->GetSivp (this);


  if (ic->sivp->isValid())
    {
      // when this is a proc var pointing at main
      // need to dereference

      Siv *asivp = ic->sivp->findPsiv ();

      // pop each dimension specifier off stack
      // find which ele -> pop it off stack

      int kd = 0;
      int mnd = asivp->getND();

      // !! offset will be overwritten by subsequent sivele opeation!!
      asivp->offset = 0;

#if CDB_IC
  DBP ("IC Computing SIVELE for %s nd %d array? %s dynamic %s\n",asivp->GetName(), asivp->getND(), 
       yorn(asivp->testCW(SI_ARRAY)),yorn(asivp->testCW(DYNAMIC_ARRAY)));
#endif
      


      // need to do special case nd == 1 for SVAR
      if (asivp->type == SVAR)
	{
	  asivp->CheckSvarBounds ();
	}

      if (asivp->getND() <=0 || asivp->getSize() == 0) {
	if (asivp->testCW(DYNAMIC_ARRAY)) {
	  // DBP("DYNAMIC EXPANDING \n");
          asivp->setND(1);
          if (asivp->getSize() == 0) {
	    asivp->ReallocMem(asivp->getType(),1);
          }
        } 
      }



      int rcn = 1;

      while (kd < asivp->getND())
	{

	  popresult = SlotStack.PopR ();

	  if (popresult != NULL)
	    {

	      popresult->getVal (&ele);
#if CDB_IC
	      DBP (" which ELE [%d] ?\n", ele);
#endif
	    }

	  if (asivp->getND() == 1 || kd == 0)
	    {

	      asivp->offset = ele;

	      //dbp("setting  %s ele offset to %d %d\n",asivp->GetName(),asivp->offset,ele);

	    }
	  else
	    {
	      rcn *= asivp->bounds[mnd - kd];
	      asivp->offset += (ele * rcn);
	    }
	  kd++;

// offset is set - ele was referenced

	  asivp->setCW (ARRAY_ELE, ON);

          if (lh) {

          asivp->setCW (SUBSC_ARRAY_LH|LH_SUBSC_RANGE, OFF);

          }

#if CDB_IC
    DBP ("LH? %s SIVELE dimn %d ele %d rcn %d offset %d ele %s\n",yorn(lh), kd, ele, rcn, asivp->offset, yorn(asivp->testCW(ARRAY_ELE)));
#endif

	}


      //      dbp ("UNSETTING %s \n", result->GetName());
      // result->type = UNSET;

      if (asivp->type == SVAR || asivp->type == STRV)
	{
	  // just the referenced field!!
	  // FIX - should be already set
	  //        asivp->offset = ele;
#if CDB_IC
  DBP ("SVAR %s nargs %d ele %d offset %d  val %s \n",asivp->GetName(), asivp->value->getNarg(),ele, asivp->offset,asivp->value->cptr (asivp->offset));
#endif

	  if (asivp->offset < asivp->value->getNarg ())
	    {
	      SlotStack.pushS (asivp->value->cptr (asivp->offset), this);
	    }
	  else
	    {

	      DBP
		("WARNING pushing null SVAR field %d - extending\n",
		 asivp->offset);

	      // check this should be a LH ele setting 

	      asivp->value->cpy ("", asivp->offset);
	      asivp->setCW (ARRAY_ELE, ON);
	      SlotStack.pushS (" ", this);
	    }

	}
      else if (asivp->type == LIST)
	{
	  // ele will be stored as STRV
	  //DBP("push LIST ele - trying !\n");

	  SlotStack.pushS(asivp->getList()->getItemAsStr(asivp->offset),this);

        }
      else if (asivp->type == RECORD) {

         DBP("push record row - not implemented !\n");

      }
      else
	{

          if (asivp->getSize() <= asivp->offset) {
	    if (asivp->testCW(DYNAMIC_ARRAY) || asivp->checkType(SVAR)) {
#if CDB_IC
           DBP("DYNAMIC EXPANDING to %d\n", asivp->offset );
#endif	   
         }
         else {
	   dbwarning("NON_DYNAMIC ARRAY but have to EXPAND to %d\n", asivp->offset );
         }

	    if (!asivp->checkType(SVAR)) {
	    asivp->ReallocMem(asivp->getType(),asivp->offset+1);
            }

          }


	  //  store_var (result, asivp, this);
          adjustNegOffset(asivp->offset,asivp->size);

          asivp->setCW (ARRAY_ELE, ON);

          if (lh) {

#if CDB_IC
          DBP("want to push a ref to %s with an offset of\n",asivp->getName(), asivp->offset);
#endif

          }

#if CDB_IC
          DBP("pushIR of %s offset %d\n",asivp->getName(), asivp->offset);
#endif

	  SlotStack.pushIR (asivp->Memp (asivp->offset), asivp->type, this);


	}
    }
  else
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n",
	       ic->slot, ic->GetName ());
    }
  // and place on stack
}


void
Parset::pushobjele (Icode * ic)
{
  // this actually stores element value!
  // where is the ele information stored ??
  // cannot be overwritten by subsequent  sivele operations
  // won't work for PAN or RECORD

  Siv *popresult;

  // result = Inresult;
  // check ic->state - bit field - proc variable??
  // will have to do something more complex for subscripted arrays

  int ele = 0;			// get ele off of stack

#if CDB_IC
  DBP ("%s icslot %d %s %d  pindex %d \n",
       opcodetype (ic->opcode), ic->slot, ic->GetName (),
       ic->state, this->pindex);
#endif


  ic->GetSivp (this);


  if (ic->sivp->isValid())
    {
      // when this is a proc var pointing at main
      // need to dereference

      Siv *asivp = ic->sivp->findPsiv ();

      // pop each dimension specifier off stack
      // find which ele -> pop it off stack

      int kd = 0;

      int mnd = asivp->getND();

      // !! offset will be overwritten by subsequent sivele opeation!!
      asivp->offset = 0;

#if CDB_IC
      DBP ("IC Computing OBJELE for %s nd %d array? %s\n",asivp->GetName(), mnd, yorn(asivp->testCW(SI_ARRAY)));
#endif

      // need to do special case nd == 1 for SVAR
      if (asivp->type != SCLASS)
	{
	  //DBPERROR("wrong type !!\n");
           DBP("wrong type !!\n");
	}

      if (mnd <= 0)
	{
          // CHECKME -- should never happen

	  //  DBPERROR("wrong nd %d has to be at least 1! - set to 1\n");
	  DBP("ERROR wrong nd %d has to be at least 1! - set to 1\n",mnd);

          asivp->setND(1);
	}

      int rcn = 1;

#if CDB_IC
      DBP ("object  %s  size  [%d]?  ND %d\n", asivp->getName(),asivp->getSize(), mnd);
#endif

      while (kd < asivp->getND())
	{

	  popresult = SlotStack.PopR ();

	  if (popresult != NULL)
	    {

	      popresult->getVal (&ele);
#if CDB_IC
	      DBP ("which ELE [%d] ?\n", ele);
#endif
	    }

	  if (asivp->getND() == 1 || kd == 0)
	    {
	      asivp->offset = ele;

	      //dbp("setting  %s ele offset to %d %d\n",asivp->GetName(),asivp->offset,ele);

	    }
	  else
	    {
	      rcn *= asivp->bounds[mnd - kd];
	      asivp->offset += (ele * rcn);
	    }
	  kd++;

// offset is set - ele was referenced

#if CDB_IC
	  DBP ("OBJELE dimn %d ele %d rcn %d offset %d ele %s\n", kd, ele, rcn, asivp->offset, yorn(asivp->testCW(ARRAY_ELE)));
#endif

	}


	  asivp->setCW (ARRAY_ELE, ON);

	  // set parse PCW 

          this->SetPCW (OBJELE, ON);
          obptr = asivp->asclass[ele]->sivobjp; // so obptr is pointing at an object
          obptr->offset  = ele; // so obptr is pointing at an object



      //      dbp ("UNSETTING %s \n", result->GetName());
      // result->type = UNSET;

	{
	  // Do we need to set asivp offset at all ?
          // just put the ele value onto the stack
          // and the CMF call will pop off the value


	  //  store_var (result, asivp, this);
          adjustNegOffset(asivp->offset,asivp->size);
          asivp->setCW (ARRAY_ELE, ON);
          //DBP("pushIR of %s\n",asivp->getName());
	  //	  SlotStack.pushIR (asivp->Memp (asivp->offset), asivp->type, this);
          // now just push ele onto stack

          SlotStack.pushI (asivp->offset, this);


	}


    }
  else
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n",
	       ic->slot, ic->GetName ());
    }
  // and place on stack
}




void
Parset::pushlsivele (Icode * ic)
{
  //  this actually stores element value!
  //  find out which element from previous items on stack   
  //  set offset -- on the stack will be the array 
  //  subsequent store will be an element value to that offset

  Siv *popresult;

  //        result = Inresult;
  // check ic->state - bit field - proc variable??
  // will have to do something more complex for subscripted arrays

  int ele = 0;			// get ele of stack
  int roffset = 0;

#if CDB_IC

  DBP ("%s %d %s %d  pindex %d \n",
       opcodetype (ic->opcode), ic->slot, ic->GetName (),
       ic->state, this->pindex);

#endif


  ic->GetSivp (this);

  if (!ic->sivp->isValid())
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot,
	       ic->GetName ());
    }
  else
    {
      // when this is a proc var pointing at main
      // need to dereference

      Siv *asivp = ic->sivp->findPsiv ();

      // pop each dimension specifier off stack

      // find which ele -> pop it off stack

      int kd = 0;
      int mnd = asivp->getND();

#if CDB_IC 
      DBP ("IC Computing LSIVELE for %s nd %d\n",asivp->GetName(), asivp->getND());
#endif

      // need to do special case nd == 1 for SVAR

      if (asivp->type == SVAR)
	{
	  asivp->CheckSvarBounds ();
	}


      int rcn = 1;

      while (kd < asivp->getND())
	{

	  popresult = SlotStack.PopR ();


	  if (popresult != NULL)
	    {

	      popresult->getVal (&ele);
#if CDB_IC 
      DBP("which ELE [%d] ?\n", ele);
#endif
	    }

	  if (asivp->getND() == 1 || kd == 0)
	    {

	      roffset = ele;
#if CDB_IC 
      DBP("setting  %s  roffset %d ele %d\n",asivp->GetName(),roffset,ele);
#endif

	    }
	  else
	    {


	      rcn *= asivp->bounds[mnd - kd];

	      roffset += (ele * rcn);
#if CDB_IC 
	      DBP("rcn %d mnd %d kd %d ele %d roffset %d\n",rcn,mnd,kd,ele,roffset);
#endif
	    }

	  kd++;

// offset is set - ele was referenced
	}


        asivp->setCW (ARRAY_ELE, ON);
        asivp->setCW (SUBSC_ARRAY_LH|LH_SUBSC_RANGE, OFF);
        asivp->offset = roffset;
#if CDB_IC 
	        DBP("setting ele cw for %s %d \n",asivp->getName(),asivp->getCW());
#endif

      //      dbp ("UNSETTING %s \n", result->GetName());
		 // result->type = UNSET;


	if (asivp->checkType(SVAR))
	{
	  // just the referenced field!!
	  // FIX - should be already set
	  //        asivp->offset = ele;

#if CDB_IC
	  DBP ("SVAR ele %d val <%s> \n", ele, asivp->value->cptr (ele));
#endif

	  if (roffset >= asivp->value->getNarg ())
	    {
	      // check this should be a LH ele setting 
	      asivp->value->cpy (" ", roffset);

#if CDB_IC
              if (roffset > asivp->value->getNarg ()) {
	      DBP("WARNING pushing null SVAR field %d - extending\n",roffset);
              }
#endif
	    }

	  if (roffset < asivp->value->getNarg ())
	    {
              adjustNegOffset(roffset,asivp->value->getNarg ());
	      SlotStack.pushS (asivp->value->cptr (roffset), this);

	    }
	  else
	    {
	      DBP
		("WARNING pushing null SVAR field %d - extending\n",
		 roffset);
	      SlotStack.pushS (" ", this);
	    }
	}
      else {

          // get a ptr to ele in siv memory use that

          if (roffset >= asivp->getSize()) {

	    DBP("referencing ele outside of bounds %s\n",asivp->getName());

	    roffset = 0;
          }

          if (roffset < 0) {

	    //DBP("referencing ele %d outside of bounds %s\n",roffset, asivp->getName());

	    adjustNegOffset(roffset, asivp->getSize());
          }


	  // and why put value on stack for LH operation ?? because we use for args??
          // FIX not value just ptr to the array

	  SlotStack.pushIR (asivp->Memp (roffset), asivp->type, this);

      }

    }


}



void
Parset::pushSivEleLoc (Icode * ic)
{
  //  this stores element location!
  //  find out which element from previous items on stack   
  //  then this index is stored in ssv which is pushed onto to stack

  Siv *popresult;
  Siv *asivp = NULL;
  int ele = 0;			// get ele of stack
  int roffset = 0;

#if CDB_IC

  DBP ("%s %d %s %d  pindex %d \n",
       opcodetype (ic->opcode), ic->slot, ic->GetName (),
       ic->state, this->pindex);

#endif


  ic->GetSivp (this);

  if (!ic->sivp->isValid())
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot,
	       ic->GetName ());
    }
  else
    {
      // when this is a proc var pointing at main
      // need to dereference

      asivp =  ic->sivp->findPsiv ();

      // pop each dimension specifier off stack

      // find which ele -> pop it off stack

      int kd = 0;
      int mnd = asivp->getND();

#if CDB_IC 
      DBP ("IC Computing LSIVELE for %s nd %d\n",asivp->GetName(), asivp->getND());
#endif

      // need to do special case nd == 1 for SVAR

      if (asivp->type == SVAR)
	{
	  asivp->CheckSvarBounds ();
	}


      if (asivp->getND() <=0 || asivp->getSize() == 0) {
	if (asivp->testCW(DYNAMIC_ARRAY)) {
	  // DBP("DYNAMIC EXPANDING \n");
          asivp->setND(1);
          if (asivp->getSize() == 0) {
	    asivp->ReallocMem(asivp->getType(),1);
          }
        } 
      }


      int rcn = 1;

      while (kd < asivp->getND())
	{

	  popresult = SlotStack.PopR ();


	  if (popresult != NULL)
	    {

	      popresult->getVal (&ele);
#if CDB_IC 
      DBP("which ELE [%d] ?\n", ele);
#endif
	    }

	  if (asivp->getND() == 1 || kd == 0)
	    {

	      roffset = ele;
#if CDB_IC 
      DBP("setting  %s  roffset %d ele %d\n",asivp->GetName(),roffset,ele);
#endif

	    }
	  else
	    {


	      rcn *= asivp->bounds[mnd - kd];

	      roffset += (ele * rcn);
#if CDB_IC 
	      DBP("rcn %d mnd %d kd %d ele %d roffset %d\n",rcn,mnd,kd,ele,roffset);
#endif
	    }

	  kd++;

// offset is set - ele was referenced
	}
    }

#if CDB_IC 
	      DBP("stored eleloc %d\n",roffset);
#endif

	      // check dynamic needs expansion ?

          if (asivp->getSize() <= roffset && !asivp->checkType(SCLASS)) {
             if (asivp->testCW(DYNAMIC_ARRAY) || asivp->checkType(SVAR)) {
#if CDB_IC
           DBP("DYNAMIC EXPANDING to %d\n", roffset );
#endif	   
         }
         else {
	   dbwarning("NON_DYNAMIC ARRAY but have to EXPAND to %d\n", roffset );
         }

	     if (!asivp->checkType(SVAR)) {
	          asivp->ReallocMem(asivp->getType(),roffset+1);
	     }

          }



	if (asivp != NULL && asivp->checkType(SCLASS)) {

#if CDB_IC 
	      DBP("updated obptr offset to  %d\n",roffset);
#endif
	      // FIX --- 
              // need push_objmember --- that pops off element specification if needed

          this->SetPCW (OBJELE, ON);
          obptr = asivp->asclass[roffset]->sivobjp; // so obptr is pointing at an object
          obptr->offset  = roffset; // so obptr is pointing at an object
	  }

	  SlotStack.pushEleLoc (roffset);

}



void
Parset::pushsivoffset (Icode * ic)
{
  //  find out which element if siv is referenced   
  //  then push siv and offset to stack ?
  // 

  Siv *popresult;

  //        result = Inresult;
  // check ic->state - bit field - proc variable??
  // will have to do something more complex for subscripted arrays

  int ele = 0;			// get ele of stack
  int roffset = 0;

#if CDB_IC

  DBP ("%s %d %s %d  pindex %d \n",
       opcodetype (ic->opcode), ic->slot, ic->GetName (),
       ic->state, this->pindex);

#endif


  ic->GetSivp (this);

  if (!ic->sivp->isValid())
    {
      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot,
	       ic->GetName ());
    }
  else
    {
      // when this is a proc var pointing at main
      // need to dereference

      Siv *asivp = ic->sivp->findPsiv ();

      // pop each dimension specifier off stack

      // find which ele -> pop it off stack

      int kd = 0;
      int mnd = asivp->getND();

#if CDB_IC 
      DBP ("IC Computing LSIVELE for %s nd %d\n",asivp->GetName(), asivp->getND());
#endif

      // need to do special case nd == 1 for SVAR

      if (asivp->type == SVAR)
	{
	  asivp->CheckSvarBounds ();
	}


      int rcn = 1;

      while (kd < asivp->getND())
	{

	  popresult = SlotStack.PopR ();


	  if (popresult != NULL)
	    {
	      popresult->getVal (&ele);
#if CDB_IC 
      DBP("which ELE [%d] ?\n", ele);
#endif
	    }

	  if (asivp->getND() == 1 || kd == 0)
	    {

	      roffset = ele;
#if CDB_IC 
      DBP("setting  %s  roffset %d ele %d\n",asivp->GetName(),roffset,ele);
#endif
	    }
	  else
	    {
	      rcn *= asivp->bounds[mnd - kd];

	      roffset += (ele * rcn);
#if CDB_IC 
	      DBP("rcn %d mnd %d kd %d ele %d roffset %d\n",rcn,mnd,kd,ele,roffset);
#endif
	    }

	  kd++;

// offset is set - ele was referenced
	}


        asivp->setCW (ARRAY_ELE, ON);
        asivp->offset = roffset;

        if (asivp->checkType(SVAR)) {

	  if (roffset >= asivp->value->getNarg ())
	    {
#if CDB_IC
              if (roffset > asivp->value->getNarg ()) {
	      DBP("WARNING pushing null SVAR field %d \n",roffset);
              }
#endif
	      roffset = asivp->value->getNarg ()-1;
          }
	}

        // this captures current offset - and resets when popped - parameter used to set flag
	SlotStack.Push(asivp, ASLVAR_REF);
    }

}


void
Parset::evalrangesiv (Icode * ic, int wr)
{
  Siv *popresult;
  ICpar *icpar;

// which range ?? lhrange or RH range --- which dimension ??

  int ele = 0;

#if CDB_IC
  DBP ("---> %s  %d %s  wr %d\n", opcodetype (ic->opcode), ic->state, ic->GetName (), wr);
#endif

  // resolve - proc-class-variable
  // if so recursion/thread - scope
  // 
  // will need to check scope at run time to determine
  // what level of recursion/thread is current for a proc variable
  // use if in proc use pvars  which is specific per proc call
  // find siv

  ic->GetSivp (this);		// locate variable

  char *cp = &ic->str[ic->vlen];	// start of subop info

  icpar = (ICpar *) cp;

  if (ic->sivp->isValid())
    {

      // pop each dimension specifier off stack
      // find which ele -> pop it off stack
      if (wr == LHS) {
       ic->sivp->crange = &ic->sivp->lhrange;
       ic->sivp->setCW(SUBSC_ARRAY_LH,ON);
       if (ic->sivp->getND() ==1) {
       ic->sivp->setCW(LH_SUBSC_RANGE,ON);
       }
      }
      else {
       ic->sivp->crange = &ic->sivp->range;
       ic->sivp->setCW(SUBSC_RANGE,ON);
      }


#if CDB_IC
      DBP("ic->state %d used for ?\n",ic->state);
#endif

      if (ic->state == 2) {
	ele = -1;  // in second posn -1 default is end of range we set in case not specified
      }

      ic->sivp->offset = 0;
#if CDB_IC
      DBP(" ic->sivp->crange->rc %d set to ic->state\n",ic->sivp->crange->rc,ic->state);
#endif

      ic->sivp->crange->rc = ic->state;

      ic->sivp->crange->ClearCW ();
      ic->sivp->crange->setCW (icpar->cw, ON);


      if (!ic->sivp->crange->testCW (RNGALL))
	{

	  popresult = SlotStack.PopR ();

	  if (popresult != NULL)
	    {
	      popresult->getVal (&ele);
#if CDB_IC
	      DBP(" ele is %d \n",ele);
#endif
	    }
          

	}

      // DBP (" %d nd %d wd %d ele %d\n", ic->state,ic->sivp->getND(), icpar->wd, ele);

      ic->sivp->EvalRange (icpar->wd, ele, 1);
      ic->sivp->crange->getStride();

#if CDB_IC
      DBP("start %d end %d \n",ic->sivp->crange->getStart(),ic->sivp->crange->getEnd());
#endif

    }

}


void
Parset::subielesiv (Icode * ic)
{
  Siv *popresult;
  ICpar *icpar;
  int ele = 0;

#if CDB_IC
  DBP ("%s  %d %s \n", opcodetype (ic->opcode), ic->state, ic->GetName ());
#endif

  ic->GetSivp (this);		// locate variable

  char *cp = &ic->str[ic->vlen];	// start of subop info

  icpar = (ICpar *) cp;

  if (ic->sivp->isValid())
    {

      popresult = SlotStack.PopR ();

      if (popresult != NULL)
	{
	  popresult->getVal (&ele);

#if CDB_IC
	  DBP("state %d nd %d bounds[0] %d bounds[%d] %d ele %d\n",ic->state, ic->sivp->getND(), ic->sivp->bounds[0],icpar->wd, ic->sivp->bounds[icpar->wd], ele);
#endif

       if (ele < ic->sivp->bounds[icpar->wd] && ele >= 0) {
	    ic->sivp->subi[icpar->wd][ele] = 1;
       }

	}
    }
}


void
Parset::mksubset_rsiv (Icode * ic)
{
  ic->GetSivp (this);		// locate variable
  if (ic->sivp->isValid())
    {
      ic->sivp->MakeLHSubSet ();
      // copy and push this subset onto stack ?
      // so we can use for subscripted store
      // N.B. we currently do not allow subsequent use of sivp lhsubset 
      // but we could - transfer - pointer to lhsubset onto stack
      // and null lhsubset -- using wstate as ptr to - 
      // CW and subset structure
      SlotStack.Push (ic->sivp, (SUBSC_ARRAY_LH | REF_LH));
    }
}

void
Parset::subivecsiv (Icode * ic)
{
  Siv *popresult;
  ICpar *icpar;

  ic->GetSivp (this);		// locate variable
  char *cp = &ic->str[ic->vlen];	// start of subop info
  icpar = (ICpar *) cp;


  popresult = SlotStack.PopR ();

  if (popresult != NULL)
    {
#if CDB_IC
      DBP ("using %s sz %d for subscripting rsubs %d\n",
	   popresult->GetName(), popresult->size);
#endif

      if (popresult->testCW (SI_ARRAY))
	{
	  int rsubs = ic->state;
	  ic->sivp->SubScriptDimViaArray (popresult, icpar->wd, &rsubs);
	}
    }
}



void
Parset::buildvec (Icode * ic)
{
  Siv *popresult;
  // how many to pop off and make temp vec
  //      dbp ("BV pop %d  \n", ic->slot);
  int n = ic->slot;
  Siv *xresultp = SlotStack.GetSSV ();


  xresultp->ReallocMem (ic->state, n);
  xresultp->type = ic->state;
  xresultp->svptrOFF();
  xresultp->offset = n - 1;
  xresultp->size = n;
  xresultp->setCW (SI_ARRAY, ON);
  for (int i = 0; i < ic->slot; i++)
    {
      popresult = SlotStack.PopR ();

      if (popresult != NULL)
	{
	  xresultp->StoreVal (popresult);
	}
      xresultp->offset--;
    }

  SlotStack.Push (xresultp, 0);

}

void
Parset::popobjele (Icode * ic)
{
  Siv *popresult;

  // check ic->state - bit field - proc variable??

#if CDB_IC
  DBP ("GET_OBJELE  %d %s %d  pindex %d \n", ic->slot,
       ic->GetName (), ic->state, this->pindex);
#endif

  ic->GetSivp (this);

  int ele = 0;

  if (ic->sivp->isValid())
    {
      Siv *asivp = ic->sivp->findPsiv ();

      // previous stack item specifies ele of this object
      popresult = SlotStack.PopR ();

      if (popresult != NULL)
	{
	  popresult->getVal (&ele);

#if CDB_IC
	  DBP ("obj ELE [%d] ?\n", ele);
#endif
	}

      asivp->offset = ele;

      this->SetPCW (OBJELE, ON);

      obptr = asivp->asclass[ele]->sivobjp; // so obptr is pointing at an object
                                            // which is an element of an object array


      obptr->offset = ele; // TRY
#if CDB_IC
      DBP ("obptr %s   offset [%d] ?\n", obptr->getName(), obptr->offset);
#endif

      //      obptr = asivp;

    }

}


void
Parset::pushobj (Icode * ic)
{
  // check ic->state - bit field - proc variable??

#if CDB_IC
  DBP ("PUSH_OBJ  %d %s %d  pindex %d \n", ic->slot,
       ic->GetName (), ic->state, this->pindex);
#endif

  Siv *popresult;

  ic->GetSivp (this);

  int ele = 0;

  if (ic->sivp->isValid())
    {
      Siv *asivp = ic->sivp->findPsiv ();
      // previous stack item specifies ele of this object
      asivp->offset = 0;
      this->SetPCW (SOBJ, ON);
      obptr = asivp;
    }

}

void
Parset::createv (Icode * ic)
{

  Varcon varcon;
  Varcon *vc = &varcon;

  vc->init = SIV_CREATE;

#if CDB_IC
  DBP ("creating!? %s as %s\n", ic->GetName (), dtype(ic->type));
#endif


  vc->d_type = ic->type;

  ic->sivp = var_ptr (ic->GetName (), vc);

  if (ic->sivp == NULL)
    {
      ICerrc = VAR_NOT_DEFINED;
      return;
    }
  else
    {

      ic->sivp->setCW (SI_FREE, OFF);

      if (ic->type == SVAR)
	{
	  store_value (ic->sivp, 0, "", SVAR);
	}
      else if (ic->type == STRV)
	{
	  store_value (ic->sivp, 0, "", STRV);
	}
      else if (ic->type == LIST)
	{
	  ic->sivp->newList();

	}
      else if (ic->type == PAN)
	{
          // WARNING PAN needs rewrite/revise
	  store_value (ic->sivp, 0, "", PAN);
	}
      else
	{

//          if (ic->type == UNSET) {
//          use generic size DOUBLE for now??
//           DBP("WARNING  type unset \n");
//          }

	  ic->sivp->ReallocMem (ic->type, 1);

          ic->sivp->size =0;

	  ic->sivp->setCW (SI_ARRAY | SUBSC_ARRAY | SUBSC_ARRAY_LH, OFF);


	  if (ic->testCW(SI_ARRAY))
	    {
#if CDB_IC
              DBP("making array \n");
#endif
	      ic->sivp->setCW (SI_ARRAY | DYNAMIC_ARRAY, ON);
	      ic->sivp->ReallocBounds (1);
	      ic->sivp->size = 1;
              ic->sivp->setND(1);
	    }

	}


     if (ic->sivp->isValid())

#if CDB_IC
       DBP("created %s id %d slot %d\n",  ic->sivp->getName(),  ic->sivp->getID(), ic->sivp->getSlot());
#endif

          SlotStack.Push (ic->sivp, ic->state);

    }
}


void
Parset::createpv (Icode * ic)
{

  Proc *proc = GetProc (this->pindex);

  ic->sivp = NULL;  // CHECKME

  if (proc != NULL)
    {

#if CDB_IC
      DBP ("declare prov var variable pindex %d  type %d \n", this->pindex, ic->type , dtype(ic->type));
#endif
      ic->sivp = proc->FindSiv (ic->GetName (), SIV_DECLARE, this);
    }

  if (ic->sivp == NULL)
    {
      ICerrc = VAR_NOT_DEFINED;
      DBPERROR (" did not create %s\n", ic->GetName());
      return;
    }

  if (ic->type == SVAR)
    {
      if (ic->sivp->value == NULL)
	{
	  ic->sivp->NewSvar (1);
	  ic->sivp->value->cpy ("x", 0);
#if CDB_IC
	  DBP ("SVAR %s\n", ic->sivp->value->cptr (0));
#endif
	}
    }
  else if (ic->type == STRV)
    {
      if (ic->sivp->value == NULL)
	{
	  ic->sivp->NewSvar (1);
	  ic->sivp->value->cpy (" ", 0);
          ic->sivp->setCW(SI_ARRAY,OFF);
          ic->sivp->setType(STRV);
#if CDB_IC
	  DBP ("STRV %s\n", ic->sivp->value->cptr (0));
#endif
	}
    }
  else {


    int prior_type = ic->sivp->getType();
    int prior_array = ic->sivp->testCW(SI_ARRAY);
    // this will prevent unnecessary - convert- realloc if this is within a loop 


    if (prior_type != ic->type && ic->type != UNSET) {
          ic->sivp->Convert (ic->type);
    }

    if (ic->type == UNSET) {
      ic->sivp->type = UNSET;
    }


#if CDB_IC
 DBP ("prior_array %d prior_type %d ic_type %d ic_array? %d\n", prior_array, prior_type , ic->type, ic->testCW(SI_ARRAY));
#endif

          ic->sivp->setCW(SI_ARRAY, OFF);

	  if (ic->testCW(SI_ARRAY)) // is an array -- following instructions will setup array
	    {
	      //  DBP ("CREATE_PV makeing %s array\n",ic->sivp->getName());
	      ic->sivp->setCW (SI_ARRAY | DYNAMIC_ARRAY, ON);

	      ic->sivp->ReallocBounds (1);
	      ic->sivp->size = 1;
              ic->sivp->setND(1);
   	    }
  }


  if (ic->sivp->isValid()) {
     ic->sivp->setCW (SI_FREE, OFF);
     SlotStack.Push (ic->sivp, ic->state);
    }

#if CDB_IC
  DBP ("pindex %d slot %d lvc %d %d %s\n",
       this->pindex, ic->sivp->slot, this->lvc,
       this->lvsvec, ic->sivp->Dtype ());
#endif

}


void
Parset::findv (Icode * ic)
{
  int var_context = 0;
#if CDB_IC
  DBP ("%d %d %d %s\n", ic->state, ic->sivp->slot, ic->sz, ic->str);
#endif

  Varcon varcon;
  Varcon *vc = &varcon;
  vc->init = SIV_CHECK_EXIST;

  vc->vop = COPY_TO_RESULT;

  if (ic->state == INIT)
    {

   //      Siv *sivp = this->FindVar (ic->GetName (), 0, UNSET, &icres, COPY_TO_RESULT,0);

   Siv *sivp = this->FindVar (ic->GetName (), &icres, vc);

      ic->sivp = sivp;
    }
  if (ic->sivp == NULL)
    {
      ICerrc = VAR_NOT_DEFINED;
      DBPERROR ("FINDV \n");
    }
  else
    SlotStack.Push (ic->sivp, ic->state);
}


void
Parset::opera_ic (Icode * ic, Statement * st, Siv * holdp)
{
  Siv *inresult = NULL;

  int opr = ic->state;

#if CDB_IC
  DBP ("opera_ic %s\n", optype (opr));
  //  if (SlotStack.getDepth ())     SlotStack.Examine ();
#endif

  // all two operand operations
  // which operations will pop two operands off stack?
  // unary??
  // not if unary
  // result = Inresult;

  inresult = result;

  if (opr == PTR_ADDR) {
    // want call func to get siv ptrs --- 

    //	DBP("PTR_ADDR - NULL OP here leave result  on stack\n");

  }
  else {

  if (!unaryordinc_op (opr))
    {

#if CDB_IC
	  DBP ("\t\t\t holdp %s vector? %s  size %d offset %d nd %d %s\n",
	       holdp->GetName(), yorn(holdp->testCW (SI_ARRAY)), holdp->size,
	       holdp->offset, holdp->getND(), holdp->Dtype ());
#endif

      // if this is not a opera tmp variable -- don't we have to copy contents- susbset
      // use SVPTR

      holdp->setPsiv(SlotStack.Pop ());

      // copy to HOLD - may not need this until opera

      if (holdp != NULL)
	{

#if CDB_IC

	  DBP ("\t\t\t holdp %s vector? %s  size %d offset %d nd %d %s\n",
	       holdp->GetName(), yorn(holdp->testCW (SI_ARRAY)), holdp->size,
	       holdp->offset, holdp->getND(), holdp->Dtype ());
          DBP("holdp pointing @ %s \n",holdp->psiv->getName());
#endif
	}


    }

  Siv *v = SlotStack.PopW ();

  if (opequal (opr) || opdinc (opr) || op_predinc(opr) )
    {

//                ShowSivFlags("opeq/dinc",v);

#if CDB_IC
      DBP("%s \n",v->getName());
#endif

      if (v->isValid()) {
          result = v;
      }

      // operate on the variable itself
      // this operation - should set ARRAY_ELE
      // or LH_SUBSC
      // or just use whole array ??

    }
  else
    {

      //      v = SlotStack.PopR ();
      //      v = SlotStack.PopW ();


      if (v->isValid())
	{

#if CDB_IC
	  DBP ("%s  vector? %s sz %d offset %d nd %d type %s \n",
	       v->GetName(),yorn( v->testCW (SI_ARRAY)), v->size, v->offset, v->getND(),
	       v->Dtype ()); 
	  	  iceval.GetVarAsStr(v);
	   DBP ("v val  %s \n", iceval.cptr (0));
#endif

	  // but if v is scalar why not just copy !!
	  result->setPsiv( v ); // opera will do copy if it needs to!

         // result->setCW (SI_ARRAY, result->psiv->testCW (SI_ARRAY));

	  // make this reflect - whether pointing to array or not
	  // reset this

	  result->size = 0;
	  result->offset = 0;

          if (v->testCW(ARRAY_ELE)) {

           if (v->testCW(REF_LH)) 
               v->offset = v->lhsize;

#if CDB_IC
      DBP("copy over lhsize %d ele %d of %s to %s\n",v->lhsize,v->offset,v->GetName(), result->GetName());
#endif

            result->setCW(SI_ARRAY,OFF);
            result->svptrOFF();
            result->StoreVal(v);
           }


	}

    }


#if CDB_IC
         iceval.GetVarAsStr(result);
	 DBP ("\t\t %s svptr? %s %s %s val %s  \n",result->getName(), yorn(result->testCW(SVPTR)), result->Dtype(), optype (opr), iceval.cptr (0));
#endif


  if (unaryop (opr))
    {
       unary (opr, result, st, this);
    }
  else
    {

      if (!opdinc (opr) ) 
	{

#if CDB_IC

  if (holdp != NULL)
    {
      //  iceval.GetVarAsStr(holdp,1);
      
      //    DBP ("\t\t\t holdp %s\n", iceval.cptr (1));
    }

#endif
	}

      // if it is PIC/DECR push the current value to stack


      if (opr == PTR_ADDR) {

	  DBP("PTR_ADDR - NULL OP here result needs to go back on stack\n");

  
      }
      else {

#if CDB_IC
	DBP("%s result svptr %s holdp svptr %s \n", optype(opr), yorn(result->testCW (SVPTR)), yorn(holdp->testCW (SVPTR)));
#endif

         opera_f (opr, result, holdp, this);


      }


      if (op_predinc(opr))
	{
	  if (result->isNumberArray())
	    {
	      SlotStack.PushTV (result, this);
	    }
	  else
	    SlotStack.CopyPush (result);
	}


    }


#if CDB_IC
  //int ans = get_int_svar (result);

   DBP ("result sz %d offset %d \n", result->size, result->offset);
  
   iceval.GetVarAsStr(result);
  // if opdinc result should be v
  DBP ("\t\t\t  %s value computed  %s\n", result->GetName(), iceval.cptr (0));
#endif


  // now push back onto stack
  // if PAN ??

  if (opr == PTR_ADDR) {

     DBP ("PTR_ADDR of result %s\n", result->getName());

     SlotStack.CopyPush (result);


  }
  else if (!opequal (opr) && !opdinc (opr)  && !op_predinc(opr))
    {

      if (result->isNumberArray())
	{
	  SlotStack.PushTV (result, this);
	}
      else
  	   SlotStack.CopyPush (result);

    }
  else
    {
      result = inresult;
      // redirect result away from selfop variable ++,-- += 
    }
  }

#if CDB_IC
  // don't examine stack -- some vars memory not setup as yet
  //SlotStack.Examine ();
#endif
}



int
Statement::Xic (Parset * parset)
{
  // in all instances in code result is parset->result
  // each thread should have its own stack
  Siv *result = parset->result;
  int in_rn;
  int in_stdepth = 0;
  int do_end_pop = 1;
  int done = 0;
  int kc = 1;

  int s_fh = parset->Fh;

  ICpar *icpar;

  if (No_IC)
    return -1;

  int entry_id = parset->St->id;;

  parset->rn_xic++;

  // what depth do we need ?
  // what about per thread
  // 


  Siv *popresult;
  Siv *sivp;
  Siv *Inresult;

  Inresult = result;
  int a1;

  // but we can recurse into this!!

  parset->icsvar.clear (0);	// handle recursion??

  ICerrc = 0;

  Icode *ic = ResetIC ();

  if (this == NULL || type == SUNSET)
    {
      DBPERROR ("trying to execute uncompiled statement! %d \n", id);
      ICerrc = SUNSET;
      goto exit;
    }

  // if (testCW(DBaction,DBPLINE)) {

 if (Sp_debug > 0) {
    dbp ("\n###XIC <%d>[%d]<%d>{%s}\t\t%s\n\n",id,ln, parset->thread->GetId(), stype (type), getTxt ());
 }


  in_stdepth = parset->SlotStack.getDepth ();

  in_rn = parset->SlotStack.xic_rn;	// check  stack_depth at start

#if CDB_IC
      dbp ("------------------------------------------------------------------------\n");
      dbp ("<%d> BEGIN_IC  nic %d ntx %d xic_rn %d stdepth %d type %s   %s \n",
	   id, nic, ntx, in_rn, in_stdepth, Stype (), getTxt ());
      dbp ("------------------------------------------------------------------------\n");
#endif


  if (ReturnType (type))
    {
#if CDB_IC
      DBP (" no pop of return val - leave on stack for lhs of proc !! state %d\n", ic->state);
#endif
      do_end_pop = 0;

      if (ic->opcode == PUSH_SIV && ic->testCW(PROC_VAR))
	{
#if CDB_IC
	    DBP(" %s doing copy push of return val - leave on stack for lsh of proc \n",Stype ());
#endif
	  ic->opcode = COPYPUSH_SIV;

	}
    }

  SetState (SSX, 1);		// executing

  if (TestState(SSOO)) {

    // but has this already been done in first pass -- check 
    // statement xecution count ??

    DBP("skipping once only code!\n");

    done = 1;

  }

  while (!done)
    {

#if CDB_IC 
      dbp ("------------------------------------------------------------------------\n");
      dbp ("XIC:<%d> %2d [%3d] %s :\n", id, kc++, ic->opcode,  opcodetype (ic->opcode));
      dbp ("------------------------------------------------------------------------\n");
#endif


      switch (ic->opcode)
	{

	case NOOP:
	  {
	    char *cp = &ic->str[0];
#if CDB_IC
	    DBP (" %s \n", cp);
#endif
	  }
	  break;

	case PEX:
	  parset->pex (ic);
	  break;

	case CALLF:
	  parset->callf (ic);
	  break;

	case SET_ERROR:
	  parset->set_error (ic);
	  break;

	case ACLASS:
	  {
	    ic->GetSivp (parset);
	    // assigning what class ??
	    if (ic->sivp->isValid())
	      {
		char *cp = &ic->str[ic->vlen];	// start of following info- after sivp
		int *ip = (int *) cp;
#if CDB_IC
		DBP ("ACLASS  %s size %d \n", ic->sivp->GetName(), ic->sivp->size);
#endif
		parset->Sclass_dec (ic->sivp, *ip);
	      }
	  }
	  break;

	case CALLVMF:
	  parset->callvmf (ic);
	  break;

	case CALLP:
	  {
	    char *cp = &ic->str[0];
	    int *ip = (int *) cp;
#if CDB_IC
	    DBP ("CALLP %d() na %d \n", *ip, ic->na);
#endif
	    // need to know number of args to pop off stack

	    parset->SprocXic (*ip, ic->na, NULL, 0, 0);
#if CDB_IC
	    DBP ("<--- Sproc \n");
#endif

	    // if proc has returned a value it is already on stack!

	  }
	  break;

	case CALLCMF:
	  parset->callcmf (ic);
	  break;

	case CALLMYCMF:
	  parset->callmycmf (ic);
	  break;

	case CREATEV:
	  parset->createv (ic);
	  break;

	case CREATE_PV:
	  parset->createpv (ic);
	  break;

	case FINDV:
	  parset->findv (ic);
	  break;

	case PUSH_SIV:
	  parset->pushsiv (ic);
	  break;

	case PUSH_CMV:
	  parset->pushcmv (ic);
	  break;

	case PROC_DEF:
	  parset->procdef (ic);
	  break;

	case CAT_SIV:
	  parset->catSiv (ic);
	  break;

	case CAT_TID:
	  parset->cattid (ic);
	  break;

	case PRT_FH:
	  parset->prtfh (ic);
	  break;

#if 0
	case PRT_ARRSEP:
	  parset->prtarrsep (ic);
	  break;
#endif

	case PRT_MROW:
	  parset->prtmrow (ic);
	  break;

	case PRT_OUT:
	  parset->prtout (ic);
	  break;

	case POP_OBJELE:
	  parset->popobjele (ic);
	  break;

	case PUSH_OBJ:
	  parset->pushobj (ic);
	  break;

	case PUSH_ISIV:
	  parset->pushisiv (ic);
	  break;

	case COPYPUSH_SIV:

#if CDB_IC
	  DBP ("COPYPUSH_SIV  %d %s %d  pindex %d \n", ic->slot,
	       ic->GetName (), ic->state, parset->pindex);
#endif
	  ic->GetSivp (parset);

	  if (ic->sivp->isValid())
	    {
	      parset->SlotStack.CopyPush (ic->sivp);
	    }
	  else
	    {
	      DBPERROR ("SlotStack can't get sivp from slot %d %s\n", ic->slot,
		       ic->GetName ());
	    }
	  break;

	case CLEARSUBI_SIV:

	  ic->GetSivp (parset);

	  if (ic->sivp->isValid())
	    ic->sivp->ClearSubi ();

	  break;


	case CWON_SIV:

 	   ic->GetSivp (parset);

	  if (ic->sivp->isValid()) {
	    /// FIX TBD --- think this should be 	    ic->sivp->setCW (ic->cw, ON); 
#if CDB_IC
	    DBP("cwon_siv !!!CHECK!!! which (state %d or cw %d?)\n",ic->state, ic->cw);
#endif
	    //ic->sivp->setCW (ic->state, ON);
            ic->sivp->setCW (ic->cw, ON);

          }
	  break;


	case CWOFF_SIV:

	  ic->GetSivp (parset);

	  if (ic->sivp->isValid()) {
	    /// CHECK FIX TBD
	    //ic->sivp->setCW (ic->state, OFF);
            ic->sivp->setCW (ic->cw, OFF);
          }

	  break;

	case AWON_SIV:
          {
 	   ic->GetSivp (parset);

	  if (ic->sivp->isValid()) {
            ic->sivp->setAW (ic->aw, ON);

          }
          }
	  break;


	case AWOFF_SIV:

	  ic->GetSivp (parset);

	  if (ic->sivp->isValid()) {
            ic->sivp->setCW (ic->aw, OFF);
          }

	  break;

	case REDIMNV:
	  parset->redimnv (ic);
	  break;

	case VFILL:
	  parset->vfill (ic);
	  break;
	case LFILL:
	  parset->lfill (ic);
	  break;
	case VFILLR:
	  parset->vfillr (ic);
	  break;

	case PUSH_SIVELE:
	  parset->pushsivele (ic);
	  break;

	case PUSH_LH_SIVELE:
	  //parset->pushsivele (ic,1);
          parset->pushSivEleLoc (ic); // partially works? fix -
                                      // now passes -- problem with zero sized dynamic array not expanding
	  break;

	case PUSH_OBJELE:
	  parset->pushobjele (ic);
	  break;

	case PUSH_SIVELELOC:
	  parset->pushSivEleLoc (ic);
	  break;

	case PUSH_LSIVELE:
	  parset->pushlsivele (ic);
	  break;

	case PUSH_SIVOFFSET:
	  parset->pushsivoffset (ic);

	  break;

	case EVALRANGE_SIV:
	  parset->evalrangesiv (ic,RHS);
	  break;

	case LH_EVALRANGE_SIV:
	  parset->evalrangesiv (ic,LHS);
	  break;

	case SUBIELE_SIV:
	  parset->subielesiv (ic);
	  break;

	case SUBIVEC_SIV:
	  parset->subivecsiv (ic);
	  break;

	case MKSUBSET_SIV:
	  ic->GetSivp (parset);	// locate variable
	  if (ic->sivp->isValid()) {
	    ic->sivp->MakeSubSet ();
	  }
	  break;
	case MKSUBSET_RSIV:
	  parset->mksubset_rsiv (ic);
	  break;

	case BUILDVEC:
	  parset->buildvec (ic);
	  break;

	case RANGE_SIV:  // not used!!
	  ic->GetSivp (parset);
	  if (ic->sivp->isValid())
	    ic->sivp->range.rc = ic->state;
	  break;

	case LOADRN:
	  DBP("LOADRN NOP as yet \n");
	  //	  parset->loadrn (ic);
	  break;

	case PUSHN:
	  parset->pushn (ic);
	  break;

	case PUSHI:
	  parset->pushi (ic);
	  break;

	case PUSHF:
	  parset->pushf (ic);
	  break;

	case LOADRS:
	  parset->loadrs (ic);
	  break;

	case PUSHS:
	  parset->pushs (ic);
	  break;

	case PUSHCAT:
	  parset->pushCat (ic);
	  break;

	case PUSHTAG:
	  parset->pushTag (ic);
	  break;

	case CAT_STR:
	  parset->catStr (ic);
	  break;

	case PRT_EXP:
	  parset->prtExp (ic);
	  break;

	case LOADR_CLARG:
#if CDB_IC
	  DBP ("\t\t\t extracting clar_arg %d \n", ic->state);
#endif

	  store_value (result, 0, get_CL_arg (ic->state), UNSET);
	  if (result->type == SVAR || result->type == STRV)
	    parset->SlotStack.pushS (result->value->cptr (0), parset);
	  else
	    parset->SlotStack.pushIR (result->Memp (), result->type, parset);

	  break;

	case STORER:
	    parset->storer (ic, in_stdepth);
	  break;

	case REFERV:
	  parset->referv (ic);
	  break;

	case OPERA:

#if  CDB_ASL
    DBP(" %s", optype(ic->state));
#endif 
	  parset->opera_ic (ic, this, &parset->xic_hold);


	  break;

	case TRAN_R_H:
#if CDB_IC
	  DBP (" !NOOP!\n");
#endif
	  break;
	case SHCOM:
          {
	    int store = checkNextIC(ic);
	  parset->shcom (store);

          }
	  break;

	case ENDIC:

	  // if something in stack - pop to result
	  // check if necessary ??  - return should leave result on stack

	  result = Inresult;

#if CDB_IC
	  DBP ("\n");

	  DBP ("do_end_pop? %d %d %d %d %d \n", do_end_pop, in_stdepth,
	       parset->SlotStack.getDepth (), parset->SlotStack.xic_rn,
	       in_rn);
#endif

	  int nendpop = 0;

	  if (do_end_pop)
	    {
	      // only really necessary if LHS assignment - not done
	      // or done via STORER

	      while (in_stdepth < parset->SlotStack.getDepth ()
		     || parset->SlotStack.xic_rn > in_rn)
		{
		  // need to pop off result
		  popresult = parset->SlotStack.PopR ();

		  nendpop++;

		  if (nendpop > 200)
		    {
		      DBP ("end_pop %d :too many in_st %d in_rn %d \n",
			   nendpop, in_stdepth, in_rn);
		      break;
		    }

		}

	      if (nendpop > 0)
		{
		  if (popresult != NULL)
		    {
#if CDB_IC
		      DBP ("ENDIC PopR %d %s  %s\n", nendpop, popresult->GetName(),
			   popresult->Dtype ());
#endif

		      // do we ever need to store this
		      // yes for exp like  --- if (a)  ??
		      // TBD --- IS THIS NEEDED???

                      if (!popresult->checkType(UNSET)) {
			 store_var (result, popresult, parset);
                      }
		    }
		}

	    }

	  // make sure St pointer is at this statement
	  // check this doesn't move us back


	  //         DBP("entry_id %d exit_id %d id %d\n",entry_id,parset->St->id,id);

	  if (parset->St == NULL)
	    parset->St = this;
	  else if (parset->St->id != entry_id)
	    parset->St = this;

	  done = 1;
	  break;
	}

#if  CDB_IC
    dbp("\n");
#endif 
      if ((ic = NextIC (ic)) == NULL)
	{
	  break;
	}

    }


  if (parset->SlotStack.xic_rn > in_rn && in_rn > 30)
    {
      DBP (" XIC StackDepth Increase  <%d> in_rn %d xic_rn %d \n", id,
	   in_rn, parset->SlotStack.xic_rn);
    }

exit:

  parset->rn_xic--;
// restore output print file handle

  parset->Fh = s_fh;

#if CDB_IC
  DBP ("DONE <%d> xic_rn %d depth %d %d rn_xic %d\n", id,
       parset->SlotStack.xic_rn, in_stdepth, parset->SlotStack.getDepth (),
       parset->rn_xic);
#endif


  SetState (SSX, 0);		// done executing

  if (!TestState(SSOO))
    ntx++;

  if (type == STATIC) {
    // mark as once only -so we don't repeat
    // SetState (SSX, 1);		
      SetState (SSOO, 1);		// we don't want to execute again
  }


  return ICerrc;
}



void
icstack::ClearStack ()
{

  // delete stack variables if over ??
  // FIX - want to do this when - out side of any proc calling
  // only when back in main
  for (int i = RUNSTACKSZ; i < MAXSTACKSZ; i++)
    {
      if (SSV[i] != NULL)
	{
	  delete SSV[i];
	  SSV[i] = NULL;
	}
    }

}


icstack::~icstack ()
{
  // delete stack variables if over ??
  // FIX - want to do this when - out side of any proc calling
  // only when back in main
  for (int i = 0; i < MAXSTACKSZ; i++)
    {
      if (SSV[i] != NULL)
	{
	  delete SSV[i];
	  SSV[i] = NULL;
	}
    }
}



void
Parset::PushSivOnStack (Siv * sivp)
{
  // actually copy push
#if CDB_IC
  DBP ("Copy and push siv %s on stack\n", sivp->GetName());
  if (sivp->testCW (SVPTR)) {
    DBP ("Copy and push siv %s ---> %s on stack\n", sivp->GetName(),
	 sivp->psiv->GetName());
   }
#endif
  if (sivp->testCW (SVPTR))
    SlotStack.CopyPush (sivp->psiv);
  else
    SlotStack.CopyPush (sivp);
}

Siv *
Parset::PopSivOffStack ()
{
  // pop arg off stack - is it pointer to Siv?
  // number/string constant - need to make copy?
  // will have to copy ??

  Siv *sivp;

  sivp = SlotStack.Pop ();

#if CDB_IC
  if (sivp != NULL) {
    DBP ("popped siv off stack %s offset %d\n", sivp->GetName(), sivp->offset);
  }
#endif

  return sivp;
}

Siv *
Parset::TopSivOnStack ()
{
  Siv *sivp = SlotStack.Top ();

#if CDB_IC
  if (sivp != NULL) {
    DBP ("point at top siv on stack %s\n", sivp->GetName());
  }
#endif

  return sivp;
}


/////////////////////////////////////////////////////////////////////////////////





int
CheckWic (Statement * st)
{
  int ret = 0;

  if (st != NULL && !st->TestState (SSC) &&!st->TestState(SNW))
    ret = 1;
   return ret;
}


void
Statement::storeICN (Siv *sivp)
{
	  int err;
              if (sivp->getType() == INT) {

#if CDB_IC
	  DBP ("PUSHI \n");
#endif
		WriteIC (PUSHI, sivp->getIntVal(&err) , NULL, "", NULL);
              }
              else if (sivp->getType() == FLOAT) {
#if CDB_IC
	  DBP ("PUSHF \n");
#endif
	         WriteIC (PUSHF, NOTANOP, NULL, "", NULL, sivp->getFloatVal(&err));
              }
              else {
#if CDB_IC
	  DBP ("PUSHN \n");
#endif
	        WriteIC (PUSHN, NOTANOP, sivp, "", NULL);
	      }

}

///////////////////////////////////////// TBD /////////////////////////////////////////////////////////////
// with separate gpthreads -- we will need to compile each statement prior to execution
// and mutex lock that operation - until done  
// else we could have multiple threads compiling same statement !!
//
// each thread needs it own stack SSV - DONE  - 12-21-05
