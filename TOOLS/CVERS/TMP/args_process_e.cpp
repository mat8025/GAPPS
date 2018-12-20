/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    args_process_e                     
///   CopyRight   - RootMeanSquare                                       
//    Mark Terry  - 1998 -->                                             
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -


#include "args_process_e.h"

//void make_ascii_arg (Parset * parset, Svar * sarg, int wi);

void
make_ascii_arg (Parset * parset, Svar * sarg, int wi)
{

  if ((!parset->pt_result->isArray () && !(parset->pt_result->getType() == LIST))
      || (parset->pt_result->getType() == SVAR && parset->pt_result->getSize() < 2))
    {

      // we don't want an ascii copy of an array !!
      // CHECK -----
      // TBD === check array,svar,list strings  ---- > GWM 
      // TBD as value func args
      // do this when required -- i.e. GWM func?


      sarg->cpy ("ARGS_SCALAR_EXPR", wi);

      // FIXME for ascii arg necessary  sending to GWM?? - obsolete

      parset->icsvar.getVarAsStr (parset->pt_result);
      parset->icsvar.cpy ("\"", 1);
      parset->icsvar.cat (parset->icsvar.ap[0], 1);
      parset->icsvar.cat ("\"", 1);

      sarg->cpy (parset->icsvar.ap[1], wi);

      DBPF  ("ascii val arg[%d] <%s> <%s>\n", wi, parset->icsvar.ap[0],
		   parset->icsvar.ap[1]);

    }
  else
    {
      DBPF  (" ARRAY, SVAR or LIST ?\n");
      sarg->cpy ("ARGS_ARRAY_EXPR", wi);
    }

}

//[EF]===================================================//

void
decode_ec (char ec[])
{
  char *ls = ec;

  if (ls[1] == 't')
    {
      *ls = '\t';
    }
  else if (ls[1] == 'r')
    {
      *ls = '\r';
    }
  else if (ls[1] == 'v')
    {
      *ls = '\v';
    }
  else if (ls[1] == 'b')
    {
      *ls = '\b';
    }
  else if (ls[1] == 'v')
    {
      *ls = '\f';
    }
  else if (ls[1] == 'a')
    {
      *ls = '\a';
    }
  else if (ls[1] == '\\')
    {
      *ls++ = '\\';
    }
  else if (ls[1] == 'n')
    {
      *ls = '\n';  // CHECK used to not process \n - why ?
    }
}

//[EF]===================================================//
void
process_args_ls (Svarg * svarg, Parset * parset, Svar * pa_svar, int wi)
{
  parset->fcallg_in (WHEREFUNC);
  char *ls = (char *) pa_svar->cptr (1);	// remove SQ
  int len = pa_svar->vstrlen (1);

  ls++;

  if (*ls == '\\' && len == 4)
    {
      // take care of escape char \n,\t,\\ ...

      decode_ec (ls);

      pa_svar->ncpy (ls, 1, 2);

      DBPF  ("SQ escape arg %d %c\n", *ls, *ls);

      svarg->sv[wi]->setType (INT);
      svarg->sv[wi]->Store ((int) *ls);

      if (CheckWic (parset->St)) {
	parset->St->WIC (__FUNCTION__,PUSHI, (int) *ls, NULL, "", NULL);
      }
    }
  else if ( len == 3)
    {

      pa_svar->ncpy (ls, 1, 2);

      DBPF  ("SQ  arg %d %c\n", *ls, *ls);

      svarg->sv[wi]->setType (CHAR);
      svarg->sv[wi]->Store ((char) *ls);

      if (CheckWic (parset->St)) {
	parset->St->WIC (__FUNCTION__,PUSHC, (int) *ls, NULL, "", NULL);
      }
    }
  else
    {

      pa_svar->ncpy (ls, len - 2, 2);
      //DBP("check dobject is freed correctly first %s\n", svarg->sv[wi]->info());
      svarg->sv[wi]->setType (STRV);
      //  DBP("[%d] %s\n",i,pa_svar.cptr(2));
      svarg->sv[wi]->storeString (pa_svar->cptr (2));
      //  no expression to evaluate just push the literal string for IC operation
      svarg->sv[wi]->setAW (LS_ARG, ON);

      if (CheckWic (parset->St))
	{
	  parset->St->WIC (__FUNCTION__,CAT_STR, NOTANOP, NULL, pa_svar->cptr (2),
			       NULL);
	  parset->St->WIC (__FUNCTION__,PUSHCAT, NOTANOP, NULL, "args_litstr", NULL);
	}

    }
   parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//
void
process_args_tag (Svarg * svarg, Parset * parset, Svar * pa_svar, int wi)
{
  parset->fcallg_in (WHEREFUNC);
  char *cptag = pa_svar->cptr (1);
  cptag++;

  svarg->sv[wi]->setCW (SVPTR, OFF);
  //  DBP("%s\n", svarg->sv[wi]->info());
  svarg->sv[wi]->setType (STRV);
  svarg->sv[wi]->setAW (TAG_ARG, ON);

  svarg->sv[wi]->storeString (cptag);

  parset->pt_result = svarg->sv[wi];

  DBPF
    	("PUSHTAG %s sv_val %s\n", cptag, 
	 SIV_AS_STRING (svarg->sv[wi]));

  if (CheckWic (parset->St))
    {
      parset->St->WIC (__FUNCTION__,CAT_STR, NOTANOP, NULL, cptag, NULL);
      DBPF ("WIC PUSHTAG %s \n", cptag); 
      parset->St->WIC (__FUNCTION__,PUSHTAG, NOTANOP, NULL, "@tag", NULL);
    }
     parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//
void
process_args_list (Svarg * svarg, Parset * parset, Svar * pa_svar, int wi)
{

// RESTRICTION ---- 
//              parset->pt_result->nd = 1;
// is it vector or 2D ?
  parset->fcallg_in (WHEREFUNC);
  parset->pt_result = svarg->sv[wi];
  parset->pt_result->setType(GENERIC);
  parset->pt_result->setCW (DYNAMIC_ARRAY, ON);

  parset->pt_result->fillArray ((char *) pa_svar->cptr (1), 1, 3, parset);	//FIXME svar  char ptr export       
//          parset->St->WIC (__FUNCTION__,BUILDVEC, parset->pt_result->size, parset->pt_result, "", NULL);
  svarg->sv[wi]->setAW (LIST_ARG, ON);
     parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//

void
process_args_ptr (Svarg * svarg, Parset * parset, Svar * pa_svar, int wi)
{
  parset->fcallg_in (WHEREFUNC);

  DBPF("svarg arg %d\n", wi);
  svarg->type[wi] = ASLVAR_REF;

  //svarg->offset[wi] = svarg->sv[wi]->psiv->getOffSet ();
  // DBPF("svarg offset %d\n", svarg->offset[wi]);
  // svarg->sv[wi]->setType (svarg->sv[wi]->psiv->getType());	// make it same so checkArgType works

  DBPF  (" arg->sv[%d] %s  pointer to a variable? %s\n",
	      wi, svarg->sv[wi]->getName (),
	      yorn (svarg->sv[wi]->testCW (SVPTR)));

  if (svarg->sv[wi]->testCW (SVPTR))
    {

      DBPF  ("arg->sv[wi] pointing to %s nd %d  type %s\n",
		  svarg->sv[wi]->psiv->getName (),
		  svarg->sv[wi]->psiv->getND (),
		  svarg->sv[wi]->psiv->Dtype ());

      //                      Siv *tsiv =  svarg->sv[wi]->findPsiv();

      DBPF  ("target is %s \n", svarg->sv[wi]->findPsiv ()->getName ());

    }
     svarg->sv[wi]->setAW (PTR_ARG, ON);
     parset->fcallg_out (__FUNCTION__);
}


//[EF]===================================================//
void
process_args_array_name (Svarg * svarg, Parset * parset, int wi)
{
  parset->fcallg_in (WHEREFUNC);
  svarg->type[wi] = ASLVAR_REF;
  svarg->offset[wi] = svarg->sv[wi]->psiv->getOffSet();
  svarg->sv[wi]->setType(svarg->sv[wi]->psiv->getType());	// make it same so checkArgType works

  DBPF  ("ptr_arg arg->sv[%d] %s  pointer to a variable? %s\n",
	      wi, svarg->sv[wi]->getName (),
	      yorn (svarg->sv[wi]->testCW (SVPTR)));

  if (svarg->sv[wi]->testCW (SVPTR))
    {
      DBPF  ("arg->sv[wi] pointing to %s nd %d  type %s\n",
		  svarg->sv[wi]->psiv->getName (),
		  svarg->sv[wi]->psiv->getND (),
		  svarg->sv[wi]->psiv->Dtype ());
      DBPF  ("target is %s \n", svarg->sv[wi]->findPsiv ()->getName ());

    }

  if (CheckWic (parset->St))
    {

      DBPF("WIC PUSH_SIVP %s\n", svarg->sv[wi]->getName());
      parset->St->WIC (__FUNCTION__,PUSH_SIVP, NOTANOP, svarg->sv[wi]->psiv, "",NULL);

      if (svarg->sv[wi]->psiv->checkType(SCLASS)) {
      DBPF("WIC PUSH_SCLASS %s\n", svarg->sv[wi]->getName());
      parset->St->WIC (__FUNCTION__,OPERA, PTR_ADDR, svarg->sv[wi]->psiv, "",NULL);
      }

    }

  svarg->sv[wi]->setAW (PTR_ARG, ON);
  parset->fcallg_out (__FUNCTION__);
}
//[EF]===================================================//

void
process_args_exprn (Svarg * svarg, Parset * parset)
{
  int ret = 0;
  //
  // this should give us
  // a siv that has the value (maybe array of values) 
  // or a ptr to a siv &a or &Array (maybe indexed into siv memory e.g. &A[4])
  //
  static int rn = 0;

  rn++;

  parset->fcallg_in (WHEREFUNC);

  DBPF  ("GetExp <|%s|>\n", parset->exprn.cptr (0));

  // this does all the arg processing -- if it is an expression e.g. 4*pi 

  Svar *argexp =getPoolSvar();  // TBC pool svar does not work here why?

  argexp->cpy (parset->exprn.cptr (0), 0);

  if (argexp->slen (0) == 3 && *argexp->cptr (0) == '\'')
    {
      // make arg  = to '?'
      DBPF  (" just do char assign? %s \n", argexp->cptr (0));
    }

  ret = parset->getExp (argexp, parset->pt_result);

  // this could obviously recurse  foo(&A[4], A[a*b], A[b[i+k]],&A[c[poo(j)]])
  if (rn > 1) {
    DBW(" recursed %d\n",rn);  //  TBD/TBC --- is  pt_result -delivered to arg correctly - if recursed??
  }
  
  DBPF 
	 ("result %s ID %d SVPTR? %s \n", parset->pt_result->getName (),
	  parset->pt_result->getID (), yorn (parset->pt_result->testCW (SVPTR)));

  releasePoolSvar(argexp);
  rn--;
  parset->fcallg_out (__FUNCTION__);
}

//[EF]===================================================//
int
process_args_type (Svarg * svarg, Parset * parset, Svar * pa_svar, int wi)
{
  parset->fcallg_in (WHEREFUNC);
  int arg_type = 0;

  char fc = *pa_svar->cptr (1);
  char *cps = pa_svar->cptr (1);
  svarg->sv[wi]->setAW ((PTR_ARG | LIST_ARG | LS_ARG | TAG_ARG), OFF);

  DBPF ("fc %c  %s\n", fc, pa_svar->cptr (1));
  int alen = pa_svar->vstrlen (1);
  DBPF ("fc %c alen %d %s\n", fc, alen, pa_svar->cptr (1));
  
  if (fc == LEFTCURLYB)
    {
      arg_type = LIST_ARG;
      svarg->sv[wi]->setAW (LIST_ARG, ON);
    }
  else if (fc == '@')
    {
      arg_type = TAG_ARG;
      svarg->sv[wi]->setAW (TAG_ARG, ON);
    }
  else if (fc == '&')
    {
      arg_type = PTR_ARG;
      svarg->type[wi] = ASLVAR_REF;
      DBPF ("PTR ARG arg [%d]\n", wi);
      svarg->sv[wi]->setAW (PTR_ARG, ON);
    }
  //else if (fc == '\'' && (alen > 3) && !(alen == 4 && cps[1] == '\\'))
  else if (fc == '\'' && (alen >= 3) && !(alen == 4 && cps[1] == '\\'))
    {
      //   arg == 'G'  want the char constant  arg ='%f %s' want the non paraexpanded str
      //   what to with escaped chars?
      arg_type = LS_ARG;
      svarg->sv[wi]->setAW (LS_ARG, ON);
    }
  else {

    if (pa_svar->vstrlen (1) > 0)
       {

       Siv *sivp = NULL;
       char *cp = pa_svar->cptr(1);


//   DBP( "is %s an array name - therefore a reference? scope %s\n", pa_svar.ap[1], i, parset->scope);
//   no & and no ops [ *,+,-,/ ] expression

       if (isVarName (cp))
	    {
            DBPF  ("array name? %s arg %d scope %s\n",
		  cp, wi, parset->scope);
  
	      if (!is_in_str ("[+-/*", cp))
		{
		  sivp = find_siv (cp, 0, parset);
		  if (sivp != NULL
		      && (sivp->testCW (SI_ARRAY)
			  || sivp->checkType (SCLASS)
			  || sivp->testAW(PTR_VAR)
			  || sivp->checkType (SVAR)
			  || sivp->checkType (RECORD) // TBC
			  || sivp->checkType (LIST)  // TBC --?? GEVENT
			  ))
		    {
                      arg_type = ARRAY_NAME_ARG;
 DBPF( "yes %s is an array name  -and not subscripted or in expression\n %s\n", cp, sivp->info());

 // arg siv should now point to the found array
                      svarg->type[wi] = ASLVAR_REF;
		      // do we have a svarg siv yet??
                      // keep identified sivp on parset 
                      if (svarg->sv[wi] != NULL) {
                        svarg->sv[wi]->setAW (ARRAY_NAME_ARG, ON);
		        svarg->sv[wi]->setCW (SVPTR, ON);
			svarg->sv[wi]->setAW (ARGTMPVAR, OFF);
                        svarg->sv[wi]->psiv = sivp;
                      }
		    }
		}
	    }
       }
  }

  // if we have an array name and no subscript specification e.g. A  not A[2:8]
  // then it is an array_name_ref_arg

  if (arg_type == 0) {
    arg_type = VALUE_ARG;
    svarg->sv[wi]->setAW (VALUE_ARG, ON);
  }
  
  DBPF  ("arg_type %d arg %s \n", arg_type, pa_svar->cptr (1));
  
  parset->fcallg_out (__FUNCTION__);
  return arg_type;
}
//[EF]===================================================//

void
process_args_svptr (Svarg * svarg, Parset * parset, int wi)
{
  parset->fcallg_in (WHEREFUNC);
  DBPF  ("arg[%d] %s -->\n", wi,	parset->pt_result->info ());
  DBPF  ("%s  \n", parset->pt_result->psiv->info ());

  // strv just get value

  if ( parset->pt_result->testCW(ARRAY_ELE) ) {
     DBPF  ("store ele [%d] of  array %s\n", parset->pt_result->getOffSet(), parset->pt_result->psiv->getName());

     svarg->sv[wi]->setType (parset->pt_result->psiv->getType());
      // svarg->sv[wi]->ElementStore(parset->pt_result->psiv, index);
  }
  
  else if (parset->pt_result->psiv->getType() == STRV)
    {

      DBPF  ("getting strv value\n");

      DBPF  ("getting strv value  &Str[i] ?  offset %d  PoffSet %d\n",parset->pt_result->psiv->getOffSet(),
	   parset->pt_result->psiv->getPoffSet());
      //DBP("check dobject %s\n", svarg->sv[wi]->info());
      svarg->offset[wi] = parset->pt_result->psiv->offset;
      svarg->sv[wi]->setType (STRV);
      svarg->sv[wi]->offset = parset->pt_result->psiv->offset;
      svarg->sv[wi]->storeString (parset->pt_result->psiv->getValue()->cptr ());
      parset->pt_result = svarg->sv[wi];
      
    }

  // is svarg->sv[i] pointing at array ?

  else if (parset->pt_result->psiv->isArray ()) {

    DBPF  ("getting &A[i] ?  offset %d  PoffSet %d\n",parset->pt_result->psiv->getOffSet(),
	   parset->pt_result->psiv->getPoffSet());

    
    svarg->offset[wi] = parset->pt_result->psiv->offset;
    
    svarg->sv[wi]->offset = parset->pt_result->psiv->offset;
    
  }
  
     parset->fcallg_out (__FUNCTION__);

}

//[EF]===================================================//

void
process_args (Svarg * svarg, Parset * parset)
{
  ///
  /// any local expression or array element specification is evaluated and stored in
  /// arg Siv variable svarg->sv[i]
  /// Note if we subscript in one array arg
  /// a subsequent use of that array in a arg  would overwrite the array subscript
  /// so we have to subscript copy each array arg 
  /// this is just like taking the value of an element of the array
  /// an address reference   &C[5] is handeled by passing a pointer to the siv variable
  /// and its offset -- offset is set in the array offset vector so that multiple references
  /// to the same siv array &C[5],&C[10]  will work as the ASL function accesses the calling
  /// args -- we dont pass ptrs to memory
  /// needs a reorg

  Svar *pa_svar = getPoolSvar();  		// FIX this has to be rentrant & thread proof
  Svar *sarg;
  int a_len, len;
  int arg_type;
  Datat dt;
  int need_ascii_arg = 0;
  
  sarg = &svarg->sarg;

  parset->fcallg_in (WHEREFUNC);

  // where is the check that we don't have more args than we initted or do we expand ?

  DBPF  ("parset id %d %d \n", parset->getID(),  sarg->argc);

  /* what we want here is to process the args into an array of Siv's
   * so they can be any types (not convert each into string)
   * or pointers to arrays (done currently by passing slot)
   * or temporary arrays created via expressions in argument list
   */

  parset->SetPCW (PROCESS_ARGS, ON);

  for (int i = 0; i < sarg->argc; i++)
    {
      len = strLen (sarg->ap[i]);

      //      pa_svar->sscan (sarg->cptr (0), 0);	// memset char vector
            pa_svar->sscan (sarg->cptr (i), 0);	// memset char vector

      DBPF("sarg->cptr(i) %s \n",sarg->cptr (i), pa_svar->cptr (0));
      
      check_declare_type (pa_svar->cptr (0), &dt);

      a_len = (dt.getType () != -1) ? len : chk_expr (sarg->ap[i]);

      if (*sarg->ap[i] == LEFTCURLYB)
	a_len = 1;

      DBPF 
	    ("%d chk_exp %d %s  type %d\n", i, a_len, sarg->ap[i],
	     svarg->type[i]);

      // not TMPVAR CLEAR

      if (svarg->type[i] == ASLVAR || svarg->type[i] == ASLVAR_REF)
	{

	  // previously pointed at a ASL  VARIABLE
	  // so now point it to NULL

	  if (svarg->sv[i] != NULL)
	    {
	      //  DBP("sv[%d]\n",i);
	      if (svarg->sv[i]->testAW (ARGTMPVAR))
		{
		  // DBPERROR("clearing a argtmpvar !! %s\n",svarg->sv[i]->getName() );
		  // CHECKME ---  not error  --- where would this be deleted prior to here?
                  DBPF("sv[%d]   was this previously pointing at SVAR,RECORD?? \n",i);
		  svarg->DeleteSivArg (i);
		}
	      else
		{
		  svarg->sv[i] = NULL;	// clear it for this pass
		}
	    }

	  svarg->type[i] = UNSET;

	}
      else if (svarg->type[i] == TMPVAR)
	{
	  svarg->type[i] = PRETMPVAR;
	}

      svarg->offset[i] = 0;

      if (a_len > 0)
	{

	  Siv *inresult = parset->pt_result;	// must be Some Local Expression or List 

	  pa_svar->cpy (sarg->ap[i], 1);	// copy expression 

	  svarg->NewSivArg (i);  // create a NewArg only if necessary

	  svarg->sv[i]->checkFreeSivMem ();

	  arg_type = process_args_type (svarg, parset, pa_svar, i);

	  //////////////////////  CHECK -- eval local exp code   /////////////////
	  /// PROCESS_ARGS EVAL LOCAL EXP ////

	  parset->exprn.cpy (pa_svar->cptr (1), 0);

	  DBPF  ("arg is %s\n", parset->exprn.cptr (0));

	  //      svarg->sv[i]->setCW (ARGPTR,ptr_arg);

	  if (arg_type != PTR_ARG && arg_type != ARRAY_NAME_ARG) {
	    svarg->type[i] = TMPVAR;	//tmpsivar
           DBPF  ("TMPVAR \n");
          }
	  // run getexp -- result will be svarg->sv[i] ?
	  parset->pt_result = svarg->sv[i];

	  DBPF  ("to result @ %s\n", parset->pt_result->info ());

	  // do we want to replace all escaped chars in lstring 'abc\n\t\vdef'   ??
	  // char *ls = (char *) pa_svar->cptr (1);
	  // transfer result to svarg->sv[i]

	  if (arg_type == LS_ARG)
	    {
	      process_args_ls (svarg, parset, pa_svar, i);
	    }
	  else if (arg_type == TAG_ARG)
	    {
	      process_args_tag (svarg, parset, pa_svar, i);
	    }
	  else if (arg_type == LIST_ARG)
	    {
	      process_args_list (svarg, parset, pa_svar, i);
	    }
#if 0
	  else if (arg_type == PTR_ARG)
	   {
	     process_args_ptr (svarg, parset, pa_svar, i); // TBD check why we don't do this!
	     // not evaluated &A[i] yet
	    }
#endif
	  else if (arg_type == ARRAY_NAME_ARG)
            {
	      process_args_array_name (svarg, parset, i);
            }
	  else
	    {

	      process_args_exprn (svarg, parset);

	      if (parset->pt_result->testCW (SVPTR))
		{
		  process_args_svptr (svarg, parset, i);
		}
	      else
		{    // TBC DEBUG
		  DBPF  ("pointing args at result of expression @ %s\n", parset->pt_result->getName());
		  svarg->sv[i]->psiv = parset->pt_result;
		  svarg->sv[i]->setCW (SVPTR, ON);
		}
	    }


	  if (need_ascii_arg)
	    {			// may only need this for IPC with window manager 
	      make_ascii_arg (parset, sarg, i);
	    }

	  parset->pt_result = inresult;

	  if (svarg->type[i] == ASLVAR_REF)
	    {
	      DBPF  (" produced %s PTR to ? %s\n", dtype (svarg->sv[i]->getType()),
		     svarg->sv[i]->psiv->getName ());

	      //  svarg->sv[i]->psiv->setCW (SVPTR, OFF);	// make sure we don't self-reference

	    }
	}

          DBPF  ("calling %d %s offset %d\n", i, sarg->ap[i], svarg->offset[i]);

    }

#if CDB_ARGS_X
  for (int i = 0; i < sarg->argc; i++)
    {
      DBPF  ("calling %d %s \n", i, sarg->ap[i]);
    }
#endif

  releasePoolSvar(pa_svar);

  parset->SetPCW (PROCESS_ARGS, OFF);

  parset->fcallg_out (__FUNCTION__);

}
//[EF]===================================================//
