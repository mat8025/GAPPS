/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    args_e                        
///   CopyRight   - RootMeanSquare                            
//    Mark Terry  - 1998 -->                                           
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include "args_e.h"

#define PXARG 1

char Arg_err_msg[256];

void process_args (Svarg * svarg, Parset * parset);

void
protect_quotes (char *cp)
{

  Svar *pq =getPoolSvar();  
  int len = strLen (cp);

  if (cp[0] == '"' && cp[len - 1] == '"')
    {
      pq->cpy ("\\", 0);
      pq->cat (cp, 0);
      pq->cat ("\\", 0);
      checkscpy (cp, pq->cptr (0), (len + 4));
    }

    releasePoolSvar(pq);
}
//[EF]===================================================////

int
get_args (char ap[], Svarg * svarg, Parset * parset)
{
///
/// if we need thread proof - will need a mutex around argument processing
  static int rcn = 0;
  //Svar GA_l_exp(__FUNCTION__,10);		/* needs to be arbitary len */

  Svar *GA_l_exp =getPoolSvar();  

  int rn = 0;
  char *ptr;
  int i = 0;
  int  k;
  int nal;
  int l_brack = 0;
  int r_brack = 0;
  //  int bslash = 0;
  int cc = 0;
  int got_arg = 0;
  int exit_now;
  int ac = 0;
  int ok;
  int lastc = 0;

  parset->fcallg_in (WHEREFUNC);

  Svar *sarg;
  sarg = &svarg->sarg;
  sarg->argc = 0;
  
  try {
    
  DBPF  ("rcn %d\n", rcn);

  if (errno != 0)
    {
      if (errno > 0 && errno < 1000 && errno != 11)
	{
	  DBPERROR ("[%d] %s\n", errno, strerror (errno));
	}
      if (errno == 11)
	{
	  wc_wait (0.005);	// resource temp unavailable ?? --- so spin
	}
      errno = 0;
    }


  ok = find_match_brack (ap);

  if (ok)
    ap[ok] = '\0';
  else
    throw -1;


  DBPF  ("%s \n", ap);


  ptr = ap;

  while (*ptr)
    {
      if (*ptr != ' ' && *ptr != '\t' && *ptr != '(' && *ptr != ')')
	{
	  nal = 1;
	  break;
	}
      ptr++;
    }

  if (!nal)
    throw 1;

  nal = strLen (ap);

  if (!GA_l_exp->cpy (ap, rn))
    {
      TERROR (MALLOC_ERROR);
      throw -1;
    }

  if (ap[nal - 1] == '\n' || ap[nal - 1] == '\r' || ap[nal - 1] == '\f')
    ap[nal - 1] = '\0';


  DBPF  ("%s  nal %d\n", ap, nal);


  /* probably should go right until matched brackets or ; */
  /* match brackets */

  DBPF  ("b4 sob %s \n", ap);

  //k = sob (ap); //

  k = parset->sob (ap); //

  k = strLen (ap);

  DBPF  ("after sob %s \n", ap);


  if (k == 0)
    {
      sarg->argc = 0;
      throw 1;
    }

  while (iswhite (*ap))
    {
      cc++;
      ap++;
    }


  while (1)
    {
      got_arg = 0;

      while (is_in (*ap, "      ,)"))
	{
	  ap++;
	  cc++;
	}

      ptr = GA_l_exp->cptr(rn);

      DBPF  ("this arg starts at %s\n", ap);

      if (*ap == DQUOTE)
	{

	  // just copy over entire "" string - do pexp later in prepare arg!!
	  // FIX this has  to care of backquoted quote
	  char last_ap = *ap;
	  char nblast_ap = 0;

	  *ptr++ = *ap++;
	  cc++;


	  //while ((*ap != DQUOTE) || (*ap == DQUOTE && last_ap == '\\'))
	  while ((*ap != DQUOTE) || (*ap == DQUOTE && (last_ap == '\\' && nblast_ap != '\\')))
	    {
	      nblast_ap = last_ap;
	      last_ap = *ap;
	      *ptr++ = *ap++;
	      cc++;
	    }
	  *ptr++ = *ap++;
	  cc++;
	  *ptr = '\0';


	  ptr = GA_l_exp->cptr(rn);

	  DBPF  ("DQ got_arg now at %s arg is %s\n", ap, ptr);


	  got_arg = 1;
	}

      else if (*ap == SQUOTE)
	{
	  *ptr++ = *ap++;
	  cc++;
	  got_arg = 1;

	  while (*ap != SQUOTE)
	    {
	      *ptr++ = *ap++;
	      cc++;
	    }
	  *ptr++ = *ap++;
	  cc++;
	  *ptr = '\0';

	  DBPF  ("SQ got_arg now at %s\n", ap);

	}
      else if (*ap == '{')
	{
	  DBPF  ("array %s list expression ->temp array { \n", ap);
	  *ptr++ = *ap++;
	  cc++;
	  got_arg = 1;
	  while (*ap != '}')
	    {
	      if (*ap == ' ' || *ap == '\t')
		ap++;
	      else
		{
		  *ptr++ = *ap++;
		  cc++;
		}
	    }
	  *ptr++ = *ap++;
	  cc++;
	  *ptr = '\0';
	}
      else if (*ap == '[')
	{
	  //      DBPF( "got_args array %s [\n", ap;

	  *ptr++ = *ap++;
	  cc++;
	  got_arg = 1;
	  while (*ap != ']')
	    {
	      if (*ap == ' ' || *ap == '\t')
		ap++;
	      else
		{
		  *ptr++ = *ap++;
		  cc++;
		}
	    }
	  *ptr++ = *ap++;
	  cc++;
	  *ptr = '\0';
	}
      else
	{
	  l_brack = 0;
	  r_brack = 0;
	  int l_paren = 0;
	  int r_paren = 0;

	  exit_now = 0;

	  while (!exit_now)
	    {
	      switch (*ap)
		{
		case ',':
		  if (l_paren == r_paren && (l_brack == r_brack))
		    exit_now = 1;
		  break;
		case '\0':
		  exit_now = 1;
		  break;
		case '\r':
		  if (lastc != '\\')
		    exit_now = 1;
		  else
		    {
		      ap++;
		      cc++;
		      ptr--;
		    }
		  break;
		case '\n':
		  if (lastc != '\\')
		    exit_now = 1;
		  else
		    {
		      ap++;
		      cc++;
		      ptr--;
		    }
		  break;
		case '[':
		  l_brack++;
		  break;
		case ']':
		  r_brack++;
		  break;

		case '(':
		  l_paren++;
		  break;
		case ')':
		  r_paren++;
		  if (r_paren > l_paren && l_paren > 0)
		    exit_now = 1;
		  break;
		default:
		  break;
		}

	      lastc = *ap;

	      if (!exit_now)
		{
		  if (!iswhite (*ap))
		    got_arg = 1;
		  *ptr++ = *ap++;
		  cc++;
		  if (cc >= nal)
		    exit_now = 1;
		}

	    }
	  *ptr = '\0';
	}

      DBPF  ("this arg[%d] finishes at %s\n", i, ap);

      if (got_arg)
	{

	  ptr = GA_l_exp->cptr(rn);

	  while (*ptr)
	    {
	      if (*ptr != ' ' && *ptr != '\t')
		break;
	      ptr++;
	    }


	  DBPF  ("[%d] %s cc %d\n", i, ptr, cc);

	  sarg->cpy (ptr, i);
	  ac = i + 1;
	  i++;

	}


      if (cc >= nal || (*ap == '\r' && lastc != '\\')
	  || (*ap == '\n' && lastc != '\\') || *ap == '\0')
	break;

      lastc = *ap;
      if (ac >= svarg->na)
	{
	  break;
	}
    }

  sarg->argc = ac;

  rn++;
  rcn++;

  DBPF  ("argc %d %d\n", ac, rcn);

  process_args (svarg, parset);

  rcn--;
  }
  
  catch (int ball) {

  }
  
  releasePoolSvar(GA_l_exp);
  
  parset->fcallg_out (__FUNCTION__);
  return sarg->argc;
}

//[EF]===================================================////


int
Parset::pa_indargval (char *tmp_char, Svar * sarg, int index)
{
  // can this recurse -
  static int rn = 0;
  int cli;
  char *tchar;
  Siv *sivp;
  Varcon varcon(this);
  Varcon *vc = &varcon;
  vc->init = SIV_CHECK_EXIST;


  DBPF  (" %s \n", tchar);


  rn++;

  try {
  
  if ((sivp = var_ptr (tmp_char, vc)) == NULL)
    {
      serror (VAR_NOT_DEFINED, __FUNCTION__);
      throw -1;
    }

  if (!PA_indsvar.getVarAsStr (sivp))
    {
      DBPERROR ("pa_indarg \n");
      throw -1;
    }

  tchar = PA_indsvar.ap[0];

  if (isdigit (*tchar))
    {
      /* which cl arg ? */
      sscanf (tchar, "%d", &cli);
      sarg->cpy (get_CL_arg (cli), index);

      DBPF 
	    ("VARIABLE CL %s cli %d %s\n", tchar, cli, get_CL_arg (cli));

    }
  else
    {
      if ((sivp = var_ptr (tchar, vc)) == NULL)
	{
	  serror (VAR_NOT_DEFINED, __FUNCTION__);
	}
      else
	{
	  /* var_ptr now deals with multi-indirection- how about multi levels */

	  DBPF  ("indirect VARIABLE %s %s\n", tchar, sivp->getName ());

	  PA_indsvar.getVarAsStr (sivp);
	  sarg->cpy (PA_indsvar.ap[0], index);
	}
    }
  /* if var_value is quoted string wrap up in quotes to protect */
  protect_quotes (sarg->ap[index]);

  }

  catch (int ball) {

  }

  rn--;

  if (rn > 0)
    {
      DBPERROR ("pa_indargval recursed rn %d \n", rn);
    }

  return 1;
}

//[EF]===================================================////


Siv *
find_or_make_var (Parset * parset, char *tmp_char)
{
  Siv *sivp = NULL;
  Varcon varcon(parset);
  Varcon *vc = &varcon;
  vc->init = SIV_CHECK_EXIST;
  //    DBPF("makeing var in parse args %s\n",tmp_char);

  if (*tmp_char == '"' || *tmp_char == '&')
    return NULL;

  if ((sivp = parset->var_ptr (tmp_char, vc)) == NULL)
    {				/* make SVAR if not exist */
      sprintf (Arg_err_msg, "%s\n", tmp_char);
      serror (VAR_NOT_DEFINED, Arg_err_msg);
    }


  if (sivp != NULL   && sivp->getType() == UNSET)
    {

      DBPF  ("arg type UNSET %s called function/proc should set it\n",
		  sivp->getName ());

      sivp->setCW (DYNAMIC_ARRAY, ON);
    }

  
  //   DBPF("find_or_make_var %s   %s \n",sivp->getName(),dtype(sivp->getType());

  return sivp;
}

//[EF]===================================================////



char *
Svarg::getArgStr (int wa)
{

  if (wa < this->sarg.argc)
    {
      return GetStrOpt (this, wa);
    }

  DBPERROR ("wa %d nargs %d \n", wa, this->sarg.argc);
  return NULL;
}
//[EF]===================================================//

char *
Svarg::getArgStr ()
{
  if (j < this->sarg.argc)
    {
      return GetStrOpt (this, j++);
    }

  DBPERROR ("j %d nargs %d \n", j, this->sarg.argc);

  return NULL;
}
//[EF]===================================================//


char *
Svarg::OptionalArg (char *cdefault)
{
  if (j < this->sarg.argc)
    {
      return GetStrOpt (this, j++);
    }
  return cdefault;
}
//[EF]===================================================//

char *
Svarg::makeStrFromArg ()
{
  // current arg
  if (j < this->sarg.argc)
    {
      return GetStrFromOpt (this, j++);
    }
  // ERROR
  return NULL;
}
//[EF]===================================================//

char *
Svarg::makeStrFromArg (int wa)
{
  if (wa < this->sarg.argc)
    {
      return GetStrFromOpt (this, wa);
    }
  dberror("arg > argc %d %d\n",wa, sarg.argc);
  return NULL;
}
//[EF]===================================================//

char *
Svarg::makeStrFromArrayArg (int vi)
{
  // so we index into the array arg and make a string from that element
  // hoff is if we offset into the array already in the argument -- typically it would be zero
  char *val;
  if (j < this->sarg.argc)
    {
      int hoff = sv[j]->offset;
      sv[j]->offset = vi + hoff;

      val = GetStrFromOpt (this, j);
      sv[j]->offset = hoff;
      j++;
      return val;
    }
  // ERROR
  return NULL;
}
//[EF]===================================================//

int
Svarg::MakeIntFromArg ()
{
  if (j < this->sarg.argc)
    {
      int k = 0;
      Siv *sivp = sv[j];

      if (sv[j]->testCW (SVPTR)) {
	sivp = sv[j]->psiv;
      }

      
      //  dbp("MakeInt type %s \n",sivp->Dtype());

      if (sivp == NULL)
	return 0;

      if (sivp->getType() == SVAR)
	{
	  int woffset = offset[j];

	  if (woffset >= sivp->getValue()->getNarg ())
	    woffset = 0;
	  k = atoi (sivp->getValue()->ap[woffset]);
	  //      dbp("k %d woffset %d %d \n",k,woffset,sivp->getValue()->getNarg());
	}
      else if (sivp->getType() == STRV)
	{
	  k = atoi (sivp->getValue()->ap[0]);
	}
      else if (sivp->getType() == ASCII)
	{
	  k = (int) (*(char *) sivp->Memi ());
	}
      else
	{
	  sivp->getVal (&k);
	}
      return k;
    }

  return 0;
}
//[EF]===================================================//

char
Svarg::getArgC ()
{

  if (j < this->sarg.argc)
    {
      return GetCOpt (this, j++);
    }
  // ERROR
  return -1;
}

//[EF]===================================================////

long
GetLOpt (Svarg * svarg, int i)
{
  long l;
  if (i >= svarg->sarg.argc)
    return 0.0;			// an error - perhaps NAN better
  //    Dbp("GetDOpt %d %d \n",i,svarg->sv[i]->getType());
  GetSvarVal (svarg->sv[i], &l);
  return l;
}
//[EF]===================================================//

double
GetDOpt (Svarg * svarg, int i)
{
  double d;
  if (i >= svarg->sarg.argc)
    return 0.0;			// an error - perhaps NAN better
  //    Dbp("GetDOpt %d %d \n",i,svarg->sv[i]->getType());
  GetSvarVal (svarg->sv[i], &d);
  return d;
}

//[EF]===================================================////

double
GetOpt (Svarg * s, int i)
{
  double d = GetDOpt (s, i);
  return d;
}
//[EF]===================================================////

float
GetFOpt (Svarg * s, int i)
{
  double d = GetOpt (s, i);
  return (float) d;
}
//[EF]===================================================////

int
GetIOpt (Svarg * s, int i)
{
  double d = GetOpt (s, i);
  return (int) d;
}

//[EF]===================================================////



char
GetCOpt (Svarg * s, int i)
{
  char *cp;
  char c;

  if (s->sv[i]->getType() == SVAR)
    {
      cp = GetSvarVal (s->sv[i]);
      c = *cp;
    }
  else
    {
      c = (char) GetIOpt (s, i);
    }

  return c;
}

//[EF]===================================================////


double
GetOptDef (Svarg * svarg, int i, double def)
{
  double d;
  if (i < svarg->sarg.argc)
    GetSvarVal (svarg->sv[i], &d);
  else
    d = def;
  return d;
}

//[EF]===================================================////


char *
GetStrOpt (Svarg * svarg, int i)
{
  char *cp = NULL;

  try
  {

    DBPF("i %d svarg->sarg.argc %d\n",i,svarg->sarg.argc);

    if (i >= svarg->sarg.argc)
      throw ARG_CNT_ERROR;

    Siv *sivp = svarg->sv[i];
    int offset = svarg->offset[i];

    if (!isSivValid (sivp))
      throw INVALID_SIV_ERROR;

   DBPF("i %d %s %s offset %d sivp %s \n",i, sivp->getName(), sivp->Dtype(),offset,yorn(sivp->testCW (SVPTR)));

    
    if (sivp->testCW (SVPTR))
      {
        Siv *rsiv = sivp;

	//	 sivp = sivp->findPsiv();

	sivp = sivp->findFsiv();

	     if (sivp != rsiv) {
	 	  DBPF("points to %s \n",sivp->getName());
	 	//  throw INVALID_SIV_ERROR;
	    }

	if (sivp == NULL || !isSivValid (sivp))
	  throw INVALID_SIV_ERROR;
      }

    sivp->offset = offset;	// if it was &C[4] as arg -- sivp->offset now 4

    DBPF(" %s type %s offset %d\n",sivp->getName(), sivp->Dtype() , sivp->offset);

    if (sivp->getType() == STRV)
      {
	cp = sivp->getValue()->ap[0];
	dbp("STRV  %s \n",sivp->getValue()->ap[0]);
	int len = sivp->getValue()->slen(0);
	if (offset >= 0 && offset < len) {
	  cp += offset;
	  dbp("STRV offset to  %s \n",cp);
	}
      }

    else if (sivp->getType() == SVAR)
      {

        if (sivp->getValue() == NULL) {
	  DBPF("Bad svar\n");
            throw INVALID_SIV_ERROR;
        }

        int nargs = sivp->getValue()->getNarg ();

      	DBPF("svar narg %d\n",nargs);

	if (offset > sivp->getValue()->getNarg ())
	  {
	    DBPF("offset > svar na - limiting !\n",offset,sivp->getValue()->getNarg());
	    offset = sivp->getValue()->getNarg () - 1;
	  }

	if (offset < 0)
	  {
	    offset = 0;
	  }

	DBPF("SVAR %s offset %d %s \n",sivp->getName(),offset,sivp->getValue()->ap[offset]);

	cp = sivp->getValue()->ap[offset];
      }

    else if (sivp->checkType (CHAR) || sivp->checkType (UCHAR))
      {
  
        DBPF("name %s CHAR  sz %d offset %d %s \n", sivp->getName(),sivp->getSize(),sivp->getOffSet(),
	     (char *) (sivp->Memi() + sivp->offset)) ;

	cp = (char *) (sivp->MemOffSet ());
	
        //cp[sivp->getSize()] = 0; // we should always have extra byte at end of any array
	
      }
    else if (sivp->getType() == ASCII)
      {
	cp = (char *) sivp->Memi ();
      }
     else if (sivp->getType() == LIST)
      {
	GS_Litem *item = sivp->getList()->getNthItem(sivp->offset);
       if (item != NULL) {
	cp = (char *) item->getValue ();
       }
	
      }
  }

  catch (asl_error_codes ball)
  {
    if (ball != SUCCESS)
      {
	TERROR ((int) ball);
	cp = NULL;
      }
  }

  return cp;
}

//[EF]===================================================////

char *
GetStrFromOpt (Svarg * s, int i)
{
  // forces a string value from any type
  char *cp = NULL;

  if (s->sv[i]->isCharType ())
    {
      cp = GetStrOpt (s, i);
      return cp;
    }
  else
    {
      s->sarg.getVarAsStr (s->sv[i], i);
      // DBP("forced string return from arg %d get %s\n",i,s->sarg.ap[i]);
      return s->sarg.ap[i];
    }
}
//[EF]===================================================////

int
GetOptHue (Svarg * s, int arg)
{

  int hue = -1;

  if (arg < s->sarg.argc)
    {
      if (s->checkArgType (SVAR) || s->checkArgType (STRV))
	{
	  char color[120];
	  strncpy (color, GetStrOpt (s, arg), 120);
	  get_color_num (color, &hue);
	}
      else
	{
	  hue = GetIOpt (s, arg);
	  //      Dbp( "hue %d\n", hue);
	}
    }
  return hue;
}
//[EF]===================================================////


Siv *
ArgCopyConvert (Siv * s1, Siv * s2, int type)
{
  // is s1 pointing at a sivp
  if (s1 != NULL && s1->testCW (SVPTR))
    {
//    DBP("ArgCopyConvert points at another sivp ! so redirect %s\n",s1->psiv->name);
      s1 = s1->psiv;
    }
  // make this always
  if (s1->getType() != type || s1->testCW (SUBSC_ARRAY))
    {
      if (!s1->SubScriptCopyConvert (s2, type))
	s1 = NULL;
      else
	s1 = s2;
    }
  else
    {
      // just copy
      s2->CopyArray (s1);
      s1 = s2;
    }


  CheckInputSiv (s1);
  return s1;
}

//[EF]===================================================////



////////////////////////////////////////////// TODO ///////////////////////////////////////
//
//           XIC version - need to construct xic instructions for strings,char number 
//           type info needs to be transfer to args for CALLF, CALLP , CCLASS
//           @tag args XIC version -- currently just processed as string
//
//
//
//
//
//
