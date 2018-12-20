/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    args_parse_e                       
///   CopyRight   - RootMeanSquare                               
//    Mark Terry  - 1998 -->                                            
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include "args_parse_e.h"


Siv * find_or_make_var (Parset * parset, char *tmp_char);

#if 0
void
parse_number_arg (Svarg * svarg, Parset * parset, char *tmp_char, int i)
{
  // this is never called!!
  svarg->NewSivArg (i);

  if (svarg->sv[i] == NULL)
    {
      DBPERROR ("init svarg %d is_number_str\n", i);
    }
  else
    {
      // set existing type to UNSET
      svarg->sv[i]->checkFreeSivMem ();
      svarg->type[i] = TMPVAR;
      svarg->sv[i]->setType(UNSET);	// to allow free choice of number type

      store_value (svarg->sv[i], 0, tmp_char, UNSET);

      
      // tries to store as the smartest number choice
      // then pushn pushes smart number choice?
      DBPF  ("WIC PUSHN  %d\n",svarg->sv[i]->getType() );
      

      parset->St->WIC (__FUNCTION__,PUSHN, NOTANOP, svarg->sv[i], "", NULL);


      DBPF  ("storing %s as number  %s\n", tmp_char,
	     dtype (svarg->sv[i]->getType()));
    }
}

//[EF]===================================================//

void
parse_array_arg (Svarg * svarg, Parset * parset, char *tmp_char, int i,
		 Siv * sivp)
{
// if subscript or ele --- make local copy here

  DBPF  (" %s %s\n", tmp_char, sivp->getName ());

  if (errno != 0)
    {
      if (errno > 0 && errno < 1000)
	{
	  DBPERROR ("[%d] %s\n", errno, strerror (errno));
	}
      errno = 0;
    }

  Siv *asivp;

  if (sivp->testCW (SVPTR))
    {

      DBPF  ("%s points at ---> %s\n", sivp->getName (),
		  sivp->psiv->getName ());

      asivp = sivp->psiv;
      // dangerous 
      while (asivp->testCW (SVPTR))
	asivp = asivp->psiv;
    }
  else
    asivp = sivp;

// all the subscripting has been done in alpha_arg!!

  // NB operate on psiv !!


  DBPF  ("passing array %s %s %s\n", asivp->getName (), asivp->Dtype (),
	      tmp_char);

  if (!asivp->testCW (SUBSC_ARRAY) && !asivp->testCW (ARRAY_ELE))
    {
      if (asivp->offset == 0 && !asivp->isStrType ())
	{
	  svarg->type[i] = ASLVAR_REF;
	}

      else if (asivp->checkType (STRV))
	{
	  DBPF  ("STRV %s %s \n", asivp->getName (), asivp->Dtype ());
	  //  svarg->type[i] = ASLVAR;
	  svarg->type[i] = ASLVAR_REF;
	  svarg->offset[i] = asivp->offset;
	}

      else if (asivp->getType() == SVAR)
	{
          DBPF("svar arg\n");
	  if (asivp->getValue()->getNarg () <= 1)
	    {
	      svarg->type[i] = ASLVAR;
	      svarg->offset[i] = 0;
	    }
	  else
	    {
	      svarg->type[i] = ASLVAR_REF;
	      svarg->offset[i] = asivp->offset;
	    }

	}
      else if (asivp->getType() == SCLASS)
	{
	  
          // TBD  object array ?? - use asivp->offset;
	  // like SVAR?
	   DBPF("sclass arg\n");
	  if (asivp->getSclass() != NULL)
	    {
	      svarg->type[i] = ASLVAR;
	      svarg->offset[i] = 0;
	    }

	}
      else if (asivp->getType () == LIST)
	{
	  DBPF  ("LIST  %s %s \n", asivp->getName (), asivp->Dtype ());
	  svarg->type[i] = ASLVAR_REF;
	  svarg->offset[i] = asivp->offset;
	}
      else if (asivp->getType () == RECORD)
	{
	  DBPF  ("RECORD VAR ARG %s %s \n", asivp->getName (), asivp->Dtype ());
	  svarg->type[i] = ASLVAR_REF;
	  svarg->offset[i] = asivp->offset;
	}

      
      //DBP("sv[%d]\n",i);
      svarg->DeleteSivArg (i);
      // NB still want to use sivp -- why?
      svarg->sv[i] = sivp;

      if (!svarg->ChkProcRecur ())
	{

	  DBPF  ("WIC PUSH_SIVP \n");

	  parset->St->WIC (__FUNCTION__,PUSH_SIVP, svarg->type[i], sivp, "", NULL);
	}
    }

  else if (asivp->testCW (SUBSC_ARRAY))
    {
      // WHY not use tmp arg variable and copy subset to it here 
      // rather than in function body

      asivp->setCW (SUBSC_ARRAY, ON);

      DBPF
	 ("Args Checksubscript array copy of %s nd %d \n",
	       asivp->getName (), asivp->getND ());

      DBPF  ("array subscript eval RANGE %d \n",
		  asivp->testCW (SUBSC_RANGE));

      // since it is subscripted - we need to take local copy
      // otherwise subsequent arg for same variable which was also subscripted would
      // overwrite previous subset/range
      // WHEN does subscript get processed !?! -- in alpha_arg sivp identification !!
      // make local subscripted/range copy here!!

      DBPF  ("array subscript sz %d \n", sivp->size);

      svarg->NewSivArg (i);
      svarg->type[i] = TMPVAR;
      sivp->SubScriptCopyConvert (svarg->sv[i], sivp->getType());

      DBPF  ("array subscript sz %d \n", svarg->sv[i]->size);

    }
  else
    {

      DBPF 
	    ("%s array %d  ele referenced? offset %d\n", asivp->getName (),
	     asivp->isArray (), asivp->offset);

      // JUST copy over referenced element here!!
      // where do we find which ele
      // if we are referencing different elements need to know its offset

      svarg->NewSivArg (i);
      svarg->type[i] = TMPVAR;
      svarg->offset[i] = 0;
      svarg->sv[i]->setType(asivp->getType());
      svarg->sv[i]->offset = 0;
      svarg->sv[i]->storeConvert (asivp);

      DBPF 
	    ("array_ele copied to %s type %s \n", svarg->sv[i]->getName (),
	     svarg->sv[i]->Dtype ());

      // FIX why not copy the referenced field into string arg ??
      // ASLVAR_ELE ??

      if (!svarg->ChkProcRecur ())
	{
	  DBPF  ("WIC SIVELE?? \n");
	}
    }

// switch off - 
  asivp->setCW ((SUBSC_ARRAY | ARRAY_ELE | SUBSC_RANGE), OFF);
}

//[EF]===================================================//


void
parse_dquote_arg (Svarg * svarg, Parset * parset, char *tmp_char, int i)
{
  parset->fcallg_in (WHEREFUNC);

  Svar *DQ_lvar =  getPoolSvar();  		/* needs to be arbitary len */

  //  Svar *sarg;
  // sarg = &svarg->sarg;

  svarg->NewSivArg (i);

  if (svarg->sv[i] == NULL)
    {
      DBPERROR (" init svarg %d -quotes\n", i);
    }
  else
    {

      svarg->sv[i]->checkFreeSivMem ();

      svarg->type[i] = TMPVAR;


      DBPF  ("DQ storing arg %d %s \n", i, tmp_char);

      // do PEX here
      int len = strLen (tmp_char);
      DQ_lvar->clear (0);
      DQ_lvar->clear (1);
      DQ_lvar->cpy (tmp_char, 0);

      parset->paramExpand (DQ_lvar, 1);

      // removequotes
      char *cp = (char *) DQ_lvar->cptr (0);	//FIXME svar  char ptr export


      DBPF  ("DQ paraexp arg to %s \n", cp);


      len = strLen (cp);
      if (len > 1)
	{
	  cp[len - 1] = 0;

	  store_value (svarg->sv[i], 0, ++cp, SVAR);

	  //      if (!prc)
	  //  parset->St->WIC (__FUNCTION__,PUSH_STR, NOTANOP, svarg->sv[i], "", NULL);

	}
    }

  releasePoolSvar(DQ_lvar);
   parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//


void
parse_alpha_arg (Svarg * svarg, Parset * parset, char *tmp_char, int i)
{
  parset->fcallg_in (WHEREFUNC);
  Siv *sivp;
  Varcon varcon(parset);
  Varcon *vc = &varcon;
  vc->init = SIV_CHECK_EXIST;

  /* what we want to do is fill in svarg list with pointers to variables
   * rather than get string values
   */

  DBPF  ("%s  %d \n", tmp_char, i);

  try {
  vc->init = SIV_CHECK_ARG;
  if ((sivp = parset->var_ptr (tmp_char, vc)) != NULL)
    {

      DBPF  (" passing  %s size %d  nd %d type %s array? %d \n",
		  sivp->getName (), sivp->size, sivp->getND (),
		  sivp->Dtype (), sivp->isArray ());


      if (sivp->isArray () || sivp->getType() == SVAR)
	{
	  parse_array_arg (svarg, parset, tmp_char, i, sivp);
	}
      else
	{
	  if (sivp->getType() == PTR)
	    {
	      //  get new sivp and set its offset          
	      //DBP("PTR argument - find its reference variable \n");

	      int offset = sivp->getBounds (0);

	      if (sivp->getBlen() >= 0)
		sivp = c_vars[sivp->getBlen()];
	      else
		sivp = NULL;

	      if (sivp == NULL)
		{
		  sprintf (Arg_err_msg, "%s\n", tmp_char);
		  serror (VAR_NOT_DEFINED, Arg_err_msg);
		  throw VAR_NOT_DEFINED;
		}

	      if (sivp->getType() == UNSET)
		sivp->setCW (DYNAMIC_ARRAY, ON);

	      if (sivp->getSlot() == -1)
		  throw VAR_NOT_DEFINED;
		
	      
	      //DBP("sv[%d]\n",i);
	      svarg->DeleteSivArg (i);

	      sivp->offset = offset;
	      svarg->offset[i] = sivp->offset;
	      svarg->type[i] = ASLVAR_REF;

	      svarg->sv[i] = sivp;

	      // FIX - need to include type ASLVAR_REF info into compiled sivp

	      if (svarg->pin_pindex != -2)
		{
		  DBPF  ("pci %d arg  variable %s %s\n",
			      svarg->cproc->pci, sivp->getName (),
			      svarg->sv[i]->Dtype ());
		}

	      if (!svarg->ChkProcRecur ())
		{

		  DBPF  ("WIC  PUSH_SIVP parse_alpha_arg for %s \n",
			      sivp->getName ());

		  parset->St->WIC (__FUNCTION__,PUSH_SIVP, ASLVAR_REF, sivp, "", NULL);
		}
	    }
	  else
	    {
	      //DBP("sv[%d]\n",i);
	      svarg->DeleteSivArg (i);

	      svarg->type[i] = ASLVAR;

	      svarg->sv[i] = sivp;

	      if (!svarg->ChkProcRecur ())
		{

		  DBPF  ("WIC  PUSH_SIVP parse_alpha_arg for %s \n",
			      sivp->getName ());

		  parset->St->WIC (__FUNCTION__,PUSH_SIVP, ASLVAR, sivp, "", NULL);

		}

	    }

	}

      DBPF  ("args [%d] \n", i);

    }
  else
    {
      // auto make
      sivp = find_or_make_var (parset, tmp_char);

      if (sivp == NULL)
	{
	  serror (VAR_NOT_DEFINED, __FUNCTION__);
	}
      else
	{
	  //DBP("sv[%d]\n",i);
	  svarg->DeleteSivArg (i);
	  svarg->type[i] = ASLVAR;

	  svarg->sv[i] = sivp;
	  if (!svarg->ChkProcRecur ())
	    {
	      parset->St->WIC (__FUNCTION__,PUSH_SIVP, ASLVAR, sivp, "", NULL);
	    }

	}
    }
  }
  
  catch (int ball) {

    	      DBE(" \n");

  }
  
  parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//

void
parse_squote_arg (Svarg * svarg, Parset * parset, char *tmp_char, int i)
{
  parset->fcallg_in (WHEREFUNC);
  Svar *sarg;
  sarg = &svarg->sarg;
  int j = strLen (tmp_char);


  DBT("---> %s\n", tmp_char);
  if (tmp_char[j - 1] == '\'')
    {
      tmp_char[j - 1] = '\0';
      sarg->cpy (&tmp_char[1], i);
    }

  /* should we remove quotes ? */

  if (svarg->NewSivArg (i))
    {

      svarg->sv[i]->checkFreeSivMem ();
      svarg->type[i] = TMPVAR;

      if (svarg->sv[i] == NULL)
	{
	  DBPERROR ("init svarg %d -quotes\n", i);
	}
      else
	{
          /// if this a single char e.g. 'a' or '\''
	  /// store this a char - else as a string
	  int len = strlen(&tmp_char[1]);
	  DBT("store SQ len len %d %c %d %s\n",len, tmp_char[1], tmp_char[1],  &tmp_char[1]); 
          if (len == 1) {

           store_value (svarg->sv[i], 0, tmp_char[1], CHAR);

           parset->St->WIC (__FUNCTION__,PUSHI, NOTANOP, NULL, &tmp_char[1], NULL);

	  }
	  else
	  {
	      DBPF  ("SQ storing arg %d %s \n", i, &tmp_char[1]);

	  store_value (svarg->sv[i], 0, &tmp_char[1], SVAR);

	  parset->St->WIC (__FUNCTION__,PUSH_STR, NOTANOP, NULL, &tmp_char[1], NULL);
	  // FIX store string constant
	  }
	}
    }
   parset->fcallg_out (__FUNCTION__);
}
//[EF]===================================================//
#endif

int
parse_args (char *temp, Svarg * svarg, Parset * parset)
{
  int argc = 0;
  // move these to parset - thread - check pa_tv recursion fields work
  //  int nmb = 0;
  //nmb =CountMemBlocks();

  parset->fcallg_in (WHEREFUNC);

  DBPF  (" %s  %s  \n", temp, parset->scope);

  if (*temp == '!')
    {
      //      DBP("exclamation function! - no args - just call \n");
    }
  else
    {
      get_args (temp, svarg, parset);
      argc = svarg->sarg.argc;
    }

  parset->fcallg_out (__FUNCTION__);
  return argc;
}
//[EF]===================================================//
