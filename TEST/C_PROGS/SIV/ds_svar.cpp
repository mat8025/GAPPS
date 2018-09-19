/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|
////                                    ds_svar                       
///   CopyRight   - RootMeanSquare                             
//    Mark Terry  - 1998 -->                                          
/////////////////////////////////////////<v_|_v>///////////////////////////////
// /. .\
// \ ' /
//   -

//#include "ds_svar.h"

#include "defs.h"
#include "svar.h"
#include "debug.h"


int DBSVAR;



////////////////////////////////////////////////
/*  Svar can hold a variable large number (upto 8192) of string arguments - default 1
 *  all operations by default are on cindex argument
 *  which is last used (starts off as 0)
 *  else if n th argument doesn't exist it will be created
 *  with n-1,n-2 also created if not present
 *
 *  strings are realloced/freed as necessary
 */

//int  Svar::SvarID = 0;
//int  Svar::Npcal = 0;

int  SvarID = 0;
int  Npcal = 0;

char SVES[7]="NULL";

Svar::Svar ()
{
  int _dbl = 0;
  narg = 0;

  id = SvarID++;

  sprintf (name, "sv_%d",id);
  
  init (1);

  Npcal++;

  //DBLF
    ("construct svar %s id %d Npcal %d narg %d\n",name, id, Npcal, narg);

}
//[EF]===================================================//

Svar::Svar (const char *tag)
{
  int _dbl = 0;
  narg = 0;

  StrNCopy (name, tag, SV_NAME_LEN);

  name[SV_NAME_LEN] = 0;

  id = SvarID++;

  init (1);

  Npcal++;
  //DBLF("construct svar  %s id %d Npcal %d name %s\n",name, id, Npcal, name);
}
//[EF]===================================================//

Svar::Svar (int n)
{
  int _dbl =0;
  narg = 0;
  //  DBT("n %d\n",n);
  id = SvarID++;
  sprintf (name, "sv_%d",id);
  init (n);
  Npcal++;

  //DBLF( "construct svar  %s id %d nargs %d total Svar %d\n",name, id, n, Npcal);
}
//[EF]===================================================//


Svar::Svar (const char *tag, int n)
{
  int _dbl = 0;
  narg = 0;

  StrNCopy (name, tag, SV_NAME_LEN);

  name[SV_NAME_LEN] = 0;

  id = SvarID++;

  init (n);

  Npcal++;

  //DBLF( "construct svar %s  id %d nargs %d total Svar %d\n", name, id, n,Npcal);

}
//[EF]===================================================//


Svar::~Svar ()
{
  int _dbl = 0;
  vfree ();

  Npcal--;
}
//[EF]===================================================//

int
Svar::init (int n)	
{
  int _dbl =0;
	// might be able to use constructor instead
  //DBLF("n %d\n",n);
  
  if (narg > 0)
    {
      //DBPERROR( "svar init already done id %d \n", id);
      return 0;
    }

  // FIX  why limit ?
  if (n > MAXSVARSZ || narg > MAXSVARSZ)
    {
      //dberror("warning too many slots for Svar %d limit to \n", n, MAXSVARSZ);
      n = MAXSVARSZ;
    }

  argc = 0;			/* when using as arg list */
  cindex = 0;			/* use this to refer to desired arg */
  narg = n;			/* default number - we can realloc more */
  lhindex = 0;

  ap = (char **) scalloc_id(narg , sizeof (char *),"svar_init: ap");

  sz = (int *) scalloc_id (narg , sizeof (int *), "svar_init: sz");

  //if (si == NULL || sz == NULL || ap == NULL )

  if (sz == NULL || ap == NULL )
    {
      DBE( "can't malloc Svar\n");
      return 0;
    }

  char ocname[64];
  char *cp;
  for (int i = 0; i < n; i++)
    {
       sprintf (ocname, "svar %s %d :ap[%d]", name, id, i);
       cp = (char *) scalloc_id (SVALUELEN + 1, 1, ocname);
      if (cp != NULL)
	{
	  ap[i] = cp;
	  sz[i] = SVALUELEN;
	}
    }
  setSVCW(MEMALC,ON);
  subsize = 0;
  lhsubsize = 0;
  subset = NULL;
  lhsubset = NULL;
  keycol = 0;
  nfields = 1; // default - 1D array - if 2 or more key,value pairs, hash table

  //DBLF("%s default nfields %d\n",name,nfields);
  return 1;
}
//[EF]===================================================//

void
Svar::vfree ()
{
  int _dbl = 0;
  //DBLF ( "freeing %s id %d narg %d \n",name, id, narg);

  int ok;

  if (narg > 50000) {
    DBW ("large narg %d - corrupt NOP!?? ignore\n",narg);
    narg =0;
  }
  
  if (narg > 0)
    {
      for (int i = 0; i < narg; i++)
	{
	  if (ap[i] != 0)
	    {
	      ok =sfree (ap[i],name);
	      ap[i] = 0;
	      if (ok != SUCCESS) {
		DBE("free of ap[%d]\n",i);
	      }
	    }
	}


      if (ap != NULL)
	{
	  //DBLF("~svar %d free p %d npcal %d\n",id,ap,Npcal); 
	  ok=sfree ((void *) ap,name);
	  ap = 0;
	  if (ok != SUCCESS) {
		DBE("free of ap\n");
	  }
	}

      if (sz != NULL)
	{
	  //DBLF("~svar id %d free sz %d \n",id,sz); 
	  ok=sfree ((void *) sz,name);
	  sz = 0;
	       if (ok != SUCCESS) {
		DBE("free of sz\n");
	      }
	}
      

      if (subset != NULL)
	{
	  //DBLF("~svar %d free subset %d\n",id,subset); 
	  ok=sfree ((void *) subset,name);
	  subset = 0;
	      if (ok != SUCCESS) {
		DBE("free of subset\n");
	      }
	}
    }

  if (lhsubset != NULL) {

    ok=sfree ((void *) lhsubset,name); 
    lhsubset = 0;
    	       if (ok != SUCCESS) {
		DBE("free of lhsubset\n");
	      }
  }

  narg = 0;
  setSVCW(MEMALC,OFF);
  //DBLF ( "<--- id %d narg %d\n", id, narg);
  
  return;
}
//[EF]===================================================//

int
Svar::resize (int n)
{
  // expand or reduce
  // keep the first field - even if null
  int ok =1;
  if (n > narg) {
    // expand
    ok = cset(0,0,n,1); //may not work
  }
  else if (n < narg) { // should always work
    for (int i = (narg -1); i >= n; i--)
	{
	  if (ap[i] != 0)
	    {
	      sfree (ap[i]);
	      ap[i] = 0;
	    }
	  sz[i] = 0;
	}
    narg = n;
  }

  return ok;

}
//[EF]===================================================//

int
Svar::initTable (int n, int ttype, int nf)	
{
  
  vfree ();
  narg =0;
  if (n > MAXSVARSZ )
    {
      DBE("too many slots for Svar %d \n", n);
      n = MAXSVARSZ;
    }

  type = ttype;
  argc = 0;			/* when using as arg list */
  cindex = 0;			/* use this to refer to desired arg */

  lhindex = 0;

  if (nf <=0) nf =1;

  if (ttype == SVAR_HASH) {
    n *= 2; // make it larger than initial size of number of entries
            // if dynamic than as increases will have to do a auto rehash
    nrecords = n;
  if (nf < 2) nf =2;

  }

  nfields = nf;
  //DBT("name %s nfields %d\n",name,nfields);

  int nv = n * nf;			/* default number - we can realloc more */
  ap = (char **) scalloc_id(nv + nf, sizeof (char *),"sv_itable");

  sz = (int *) scalloc_id(nv + nf, sizeof (int *),__FUNCTION__);

   if (sz == NULL || ap == NULL )
    {
      dbprintf (-1, "can't malloc Svar\n");
      return 0;
    }

  char *cp;
  for (int i = 0; i < nv; i++)
    {
      cp = (char *) scalloc_id(SFVALUELEN + 1, 1,__FUNCTION__);

      if (cp != NULL)
	{
	  ap[i] = cp;
	  sz[i] = SFVALUELEN;
	}
    }

  subsize = 0;
  lhsubsize = 0;
  subset = NULL;
  lhsubset = NULL;
  narg = nv;
  return 1;
}
//[EF]===================================================//

char *
Svar::sscan (const char *value, int index)
{
  /* scan a word into arg */
  // this ignores WS until non-white - then stops scan if it sees white space
  int len;
  //int alen = 0;
  char *ptr;
  char *cp = NULL;

  //DBT("svar::sscan String IN %s index %d\n",value,index);

  if (narg == 0)
    init (1);

  if (index < 0)
    return NULL;

  cindex = index;

  if (index >= (int) narg)
    if (!this->vrealloc (index + 2))
      return NULL;

  //  if (ap[index] != NULL)
  //  alen = strLen (ap[index]);

  ptr = (char *) value;

  len = strLen ((char *)value);

  if (len == 0)
    return NULL;

  //      DBT("svar::sscan String IN %s \n",value);
  // TBC !!
  while (*ptr == 32 || *ptr == 9 || *ptr == '\n')
    {
      ptr++;
      if (*ptr == '\0')
	break;
    }

  if (*ptr == '\0')
    {
      len = 1;
    }
  else
    {
      cp = ptr;
      len = 0;

      while (*cp != 32 && *cp != 9 && *cp != '\n')
	{
	  if (*cp == '\0')
	    break;
	  len++;
	  cp++;
	}
    }

  if (len >= sz[index] || ap[index] == NULL)
    {

      if (!this->valloc (index, len + SVARCHARINC))
	return NULL;
    }

  strncpy (ap[index], ptr, len);
  /* add terminating null */
  ap[index][len] = '\0';

  // return current char pos
  //DBT("svar::sscan String OUT %s \n",cp);

  return cp;
}
//[EF]===================================================//



char *
Svar::sscan (const char *s)
{
  return this->sscan (s, cindex);
}
//[EF]===================================================//

char *
Svar::sscan (Svar * svar)
{
  return this->sscan (svar->ap[svar->cindex], cindex);
}
//[EF]===================================================//

char *
Svar::sscan (Svar * svar, int index)
{
  return this->sscan (svar->ap[svar->cindex], index);
}
//[EF]===================================================//

int
Svar::cset (char value, int sindex, int index , int nc)
{
  int ok = 1;

  // DBT("c %c sindex %d index %d \n",value, sindex, index);

  if (index >= 0 && sindex >= 0)
    {

      if (narg == 0)
	init (index + 1);

      if (index >= narg)
	ok = this->vrealloc (index + 1);

      if (ok)
	{
	  cindex = index;

	  if ((sindex+nc) >= sz[index] || ap[index] == NULL)
	    {
	      //   DBT("cset valloc  now %d %d\n",sindex,SVARCHARINC);
	      ok = this->valloc (index, sindex + SVARCHARINC);
	    }

	  if (ok)
	    {
	      char *cp = ap[index];
	      //      DBT("pre cset %s \n",cp);
	      for (int i = 0; i < nc; i++)
	         cp[sindex+i] = value;
	      // DBT("post cset %s \n",cp);
	      return 1;
	    }
	}
    }

  dberror( "WARNING %s Malloc in cset sindex %d index %d %c\n", name, sindex, index, value);

  return 0;
}
//[EF]===================================================//
int
Svar::cset (char value, int sindex)
{
  //  DBT("cset  sindex %d  cindex %d\n",sindex,cindex);
  return this->cset (value, sindex, cindex);
}
//[EF]===================================================//

int
Svar::ncat (const char *value, int ilen, int index)
{
  int alen = 0;
  if (narg == 0)
    init (1);
  if (index < 0)
    return 0;
  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;
  cindex = index;
  if (ap[index] != NULL)
    alen = strLen (ap[index]);

  int len = alen + ilen;
  if (len >= sz[index] || ap[index] == NULL)
    if (!this->valloc (index, len + SVARCHARINC))
      return 0;
  strncat (ap[index], value, ilen);
  return 1;
}
//[EF]===================================================//

int
Svar::ncat (const char *value, int ilen)
{
  return (this->ncat (value, ilen, cindex));

}
//[EF]===================================================//

int
Svar::cat (const char *value, int index)
{
  int len, alen;

  if (narg == 0)
    init (1);

  alen = 0;
  if (index < 0)
    return 0;
  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;
  cindex = index;
  if (ap[index] != NULL)
    alen = strLen (ap[index]);

  len = strLen ((char *) value) + alen;

  if (len >= sz[index] || ap[index] == NULL)
    {

      if (len < SVARPADLEN)
	{
	  if (!this->valloc (index, len + ARGPADLEN))
	    return 0;
	}
      else
	{
	  if (!this->valloc (index, 2 * len))
	    return 0;
	}
    }

  strcat (ap[index], value);
  //DBT("post cat %s\n",ap[index]);
  return 1;
}
//[EF]===================================================//

int
Svar::cat (const char *s)
{
  return this->cat (s, 0);
}
//[EF]===================================================//

int
Svar::cat (Svar * svar)
{
  return this->cat (svar->ap[0], 0);
}
//[EF]===================================================//


int
Svar::vrealloc (int na)
{
  int _dbl = 0;
  char **ip;
  int *cap;
  int i;
  char ocname[124];

  //DBLF("changing args for %s svar id %d from %d to %d ap %u \n",name,id,narg,na,ap);

  if (narg < 0) {
    //DBPF("ERROR id %dnarg %d \n",id,narg);
   narg = 0;
  }

  if (narg == 0)
    init (na);

  for (i = narg-1; i < narg; i++) {
    //DBLF("ap[%d] %u sz %d\n",i,ap[i],sz[i]); // what was there before?
  }

  if (na < narg && narg > 0)
    {
      for (i = narg - 1; i >= na; i--)
	if (ap[i] != NULL)
	  {
	    //DBLF("changing args freeing arg %d\n",i);
	    sfree ((void *) ap[i]); 	    
            ap[i] = NULL;
	  }
    }

#if 0
  // want to increase so ready for next - but this fails
  if (na > narg) {
    if ((na-narg) == 1) {
      na += 3; // presume it will get larger
    }
  }
#endif

   ip = (char **) srealloc_id (ap, ((na + 1) * sizeof (char *)),"svar_vrealloc: ip");


  if (ip == NULL)
    {
      DBPERROR ("srealloc fail svar vrealloc %d\n", na);
      return 0;
    }

  ap = ip;

   cap = (int *) srealloc_id (sz, ((na + 1) * sizeof (int *)), "svar_vrealloc: cap");


  if (cap == NULL)
    {
      DBPERROR("srealloc2 fail svar vrealloc %d\n", na);
      return 0;
    }

  sz = cap;

  if (na > narg)
    {
      char *cp;
  


      for (i = narg; i < na; i++)
	{
	   sprintf (ocname, "svar_vrealloc %s %d :ap[%d]", name, id, i);

	  ap[i] = NULL;
	  sz[i] = 0;
	  //	  si[i] = 0;
	  cp = (char *) scalloc_id (SVALUELEN, 1, ocname);

	  if (cp != NULL)
	    {
	      ap[i] = cp;
	      sz[i] = SVALUELEN;
	      // DBPF("ap[%d] %u sz %d\n",i,ap[i],sz[i]); // what was there before?
	    }
	  else {
	    DBPERROR("calloc fail svar vrealloc %d\n", i);
          }
	}
    }

  narg = na;

  return 1;
}
//[EF]===================================================//

int
Svar::valloc (int index, int len)
{
  int _dbl = 0;
  // allocs string len for svar arg index
  char *cp;
  int osz;

  if (narg == 0)
    init (index + 1);

  if (index >= narg)
    return 0;

  osz = sz[index];

  // get more or reduce char space
  // align on 32 word boundary 

  //  DBT("srealloc valloc index %d\n",index);

  if ((len + 1) > osz)
    {

      cp = (char *) srealloc_id (ap[index], ((len + 3) * sizeof (char)), "svar_valloc :cp");


      if (cp == NULL)
	{
	  DBPERROR("extending svar  %d to %d\n", sz[index], len);
	  return 0;

	}
      //dbp("extending svar id %d  index %d %d to %d\n",id, index, osz,len);

      ap[index] = cp;

      sz[index] = len;

      //  dbprintf(DBSVAR," valloc index %d ptr %d len %d\n",index,ap[index],sz[index]);

    }

  cp = ap[index];
  cp[len] = 0;

  /*
     for (int i = osz; i < len; i++)
     cp[i] = 0;
   */

  return 1;
}
//[EF]===================================================//

int
Svar::pastesubset (Svar * from, int index)
{
   dbwarning("NOOP Svar::pastesubset\n");
   return 1;
}

//[EF]===================================================//
int
Svar::paste (const char *value, int sindex, int index)
{
  // paste string into var stating @sindex
  char *cp;
  int i;
  int len = strlen (value);

  if (narg == 0)
    init (1);
  if (len <= 0 || index < 0 || sindex < 0)
    return 0;
  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;
  cindex = index;

  //  int clen = vstrlen(index);

  if ((len + sindex + 1) >= sz[index] || ap[index] == NULL)
    if (!this->valloc (index, len + sindex + SVARCHARINC))
      return 0;

  cp = (char *) ap[index];
  int j = sindex;
  for (i = 0; i < len; i++)
    cp[j++] = *value++;

  //DBT("done paste %s\n",ap[index]);

  return 1;
}
//[EF]===================================================//
int
Svar::paste (const char *value, int sindex)
{
  return this->paste (value, sindex, cindex);
}
//[EF]===================================================//

int
Svar::splice (const char *value, int sindex, int index)
{
  /// splice string into var starting @ sindex
  /// assumes that splice index is within current length
  char *cp;
  int i;

  int len = strLen ((char *)value);

  if (narg == 0)
    init (1);

  if (len <= 0 || index < 0 || sindex < 0)
    return 0;

  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;

  cindex = index;

  int clen = vstrlen (index);

  if (sindex > clen) {
    dbwarning("trying to splice outside the string index %d clen %d\n",sindex,clen);
       return 0;
  }
  
  if (((len + clen + 1) >= sz[index]) || ap[index] == NULL) {
    if (!this->valloc (index, len + clen + SVARCHARINC)) {
      dberror("can't valloc\n");
      return 0;
    }
  }
  
  cp = (char *) ap[index];
  int j = clen - 1;
  int nend = clen - sindex;

  // move splice pt to  end up splice length
  // nend = 0 means splice at end
  // which means must add a null because current null will be overwritten
  //DBT("j %d nend %d\n",j,nend);
  for (i = 0; i < nend; i++)
    {
      cp[j + len] = cp[j];
      j--;
    }

  // insert splice

  j = sindex;

  char *scp = &cp[sindex];
  for (i = 0; i < len; i++) {
    *scp++ = *value++;
  }
  
  if (nend == 0) {
    *scp = '\0';
  }

  // DBT("done splice len %d %s\n",strlen(ap[index]),ap[index]);

  return 1;
}
//[EF]===================================================//
int
Svar::splice (const char *value, int sindex)
{
  return this->splice (value, sindex, cindex);
}
//[EF]===================================================//

int
Svar::dewhite (int index)
{
  if (narg == 0)
    init (1);

  if (index < 0 || index >= narg)
    return 0;

  cindex = index;

  // remove white space
  int len = this->vstrlen (index);
  char *cp = this->ap[index];
  char *nws;

  nws = cp;

  int j = 0;
  DBPF("len %d <%s>\n",len,cp);
  for (int i = 0; i < len; i++)
    {
      if (*nws != ' ' && *nws != 9) {
	*cp++ = *nws;
        j++;
      }

      nws++;
    }

  for (int i = j; i < len; i++)
    *cp++ = 0;

  DBPF("done dewhite %s\n",ap[index]);
  return 1;
}
//[EF]===================================================//
int
Svar::eatWhiteEnds (int index)
{
  if (narg == 0)
    init (1);
  if (index < 0 || index >= narg)
    return 0;
  cindex = index;

  // remove white space from ends of string
  int len = this->vstrlen (index);
  char *cp = this->ap[index];
  char *nws;
  nws = cp;
  //  int j = 0;


  int sti = 0;
  int eti = 0;
  int i;
  for ( i = 0; i < len; i++)
    {
      if (*nws == ' ' || *nws == 9) {
	sti++;
        nws++;
      }
      else 
	break;
  }

  nws = &cp[len-1];

  for (i = len-1; i > 0; i--)
    {
      if (*nws == ' ' || *nws == 9) {
	eti++;
        nws--;
      }
      else 
	break;
  }

  int nlen = len - sti -eti;

  char *scp;

  if (nlen <=0 ) {
    *cp = 0; // we have NULL str now
  }
  else {
    scp = &cp[sti];
    for(i= 0; i < nlen; i++) {
      cp[i] = *scp++;
    }
    cp[nlen] = 0;
  }

  return 1;
}
//[EF]===================================================//

int
Svar::dewhite ()
{
  return this->dewhite (cindex);
}
//[EF]===================================================////


int
Svar::white (int len, int sindex, int index)
{
  
  if (narg == 0)
    init (index + 1);
  if (index < 0)
    return 0;

  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;

  if ((len + sindex) >= sz[index] || ap[index] == NULL)
    if (!this->valloc (index, len + sindex))
      return 0;

  cindex = index;

  // whiten string using space
  char *cp = (char *) ap[index];

  //  DBT("done white %s\n",ap[index]);
  int j = sindex;
  for (int i = 0; i < len; i++)
    cp[j++] = ' ';

  return 1;
  //DBT("done white %s\n",ap[index]);
}
//[EF]===================================================//

void
Svar::clear (int index)
{
  ///
  /// sets all char elements to \0
  ///
  
  if (narg == 0)
    init (1);

  if (index < 0)
    return;

  if (index >= narg)
    return;

  cindex = index;

  char *cp = (char *) ap[index];

  int len = sz[index];

// do we need to clear the first location 
//
  
  if (cp != NULL)
      cp[0]  = 0;

  for (int i = 0; i < len; i++)
    cp[i] = 0;
  
}
//[EF]===================================================//

void
Svar::efree (int index)
{
  ///
  /// frees this element of svar if it had been used
  ///
  
  if (narg == 0)
    init (1);

  if (index < 0)
    return;

  if (index >= narg)
    return;

  cindex = index;

  char *cp = (char *) ap[index];

  if (sz[index] > 0) {
    if (cp != NULL)     sfree (cp);
     sz[index] = 0;
     cp = NULL;
    }
    else {
      DBT("ERROR freeing svar item %d\n",index);
    }
  
}
//[EF]===================================================//


int
Svar::clear (int sindex, int index)
{

  int ok = 1;
  int ret = 1;
  try {

  if (index >= 0)
    {

      if (narg == 0)
	init (index + 1);

      if (index >= narg)
	ok = this->vrealloc (index + 1);

      if (ok)
	{
	  cindex = index;

	  if (sindex >= sz[index] || ap[index] == NULL)
	    {
	      //    DBT("cset valloc  now %d %d\n",sindex,SVARCHARINC);
	      ok = this->valloc (index, sindex + SVARCHARINC);
	    }
	  if (ok)
	    {
	      //  DBT("c %c sindex %d index %d \n",value, sindex, index);
	      char *cp = ap[index];
	      //DBT("pre cset %s \n",cp);
              for (int i = 0; i <=sindex; i++)
	      cp[i] = 0;
	      }
	  else 
	    throw MALLOC_ERROR;
	}
    }
  }

  catch (asl_error_codes ball) {

    if (ball != SUCCESS) {
      dbp("ERROR %d \n",ball);
      ret = 0;
    }
  }

  return ret;
}
//[EF]===================================================//

int
Svar::white (int len, int sindex)
{
  return this->white (len, sindex, cindex);
}
//[EF]===================================================//

int
Svar::vstrlen ()
{
  return (strLen (this->ap[cindex]));
}
//[EF]===================================================//

int
Svar::vstrlen (int index)
{
  if (index < this->narg)
    {
      cindex = index;
      return (strLen (this->ap[index]));
    }
  else
    return -1;
}
//[EF]===================================================//

int
Svar::slen (int index)
{
  return vstrlen (index);
}
//[EF]===================================================//

int
Svar::setsubset (int index[], int n)
{
  int *ip;

  DBPF("index %d n %d\n",index,n);
  
  if (narg == 0)
    init (1);

  subsize = n;


  ip = (int *) srealloc_id (subset, ((n + 1) * sizeof (int)),"svar_setsubset: ip");


  if (ip == NULL)
    return 0;

  subset = ip;

  for (int i = 0; i < n; i++)
    subset[i] = index[i];

  return 1;
}
//[EF]===================================================//

int
Svar::lhsetsubset ( int n)
{

  int *ip;
  if (narg == 0)
    init (1);

  lhsubsize = n;

  DBPF("svar LHsetsubset to %d\n", n);

  /*
     for (int i = 0; i < n; i++)
     dbprintf(DBSVAR, " %d", index[i]);
     dbprintf(DBSVAR, " \n");
   */

  //  DBT("srealloc lhsetsubset\n");

  ip = (int *) srealloc_id (lhsubset, ((n + 1) * sizeof (int)), __FUNCTION__);


  if (ip == NULL)
    return 0;

  lhsubset = ip;

  for (int i = 0; i < n; i++)
    lhsubset[i] = subset[i];

  return 1;
}
//[EF]===================================================//

int
Svar::parseTokens (char *s1,int windex)
{
  // int _dbl = 0;
  /// has default arg 
  /// parse through the string putting WS deliminated tokens
  /// into svar fields

  int len = strLen (s1);

  if (len <= 0)
    return 0;

  if (narg == 0)
    init (1);

  int index = 0;
  int k;

  if (windex == -1)
    index = cindex;
  else if (windex >= 0)
    index = windex;

  while (isspace(*s1)) s1++;

  //DBPF("%s\n",s1);
  
  if (!*s1) return 0;

  while (1)
    {

      cindex = index;

      k = 0;

      while ( !isspace(*s1)  && *s1 != 0)
	{
	  cset (*s1++, k++, index);
	}

      cset (0, k, index);

      index++;

      while ( isspace(*s1)) s1++;

      if (!*s1)
	break;

      if (strLen (s1) == 0) break;
    }


  return index;
}
//[EF]===================================================//

int
Svar::SelTokens (char *s1, int P[] , int n, int do_rem)
{
  // use position vector to split string into subfields
  // into svar fields
  // values in P are in ascending order
  vfree ();
  if (s1 == NULL)
      return 0;
  int len = strLen (s1);
  if (len <= 0)
    return 0;

  if (narg == 0)
    init (1);

  int index = 0;
  int k;
  //  DBT("SelTokens %s \n",s1);
  int j =0;

  int m = 0;
  int p;
  int rem;

  while (1)
    {
      cindex = index;
      k = 0;
      p = P[m];
      m++;
      if (p >= len) p = len -1;

      if (p >= 0 ) {

      while (j <= p)
	{
	  cset (*s1++, k++);
          j++;
	}

      cset (0, k);
      index++;
      }

      if ((rem=strLen (s1)) == 0) break;
      if (m >= n) break;
    }


  if (do_rem && rem) {
    // put remaining into last field
   cindex = index;
   cpy (s1);
  }

  return index;
}
//[EF]===================================================//

//const char *  --- really needs to be this
char *
Svar::cptr ()
{
  if (narg == 0)
    init (1);
  return (this->ap[cindex]);
}
//[EF]===================================================//

char *
Svar::cptr (int index)
{
  if (narg == 0)
    init (1);

  if (index < 0) index = 0;
  if (index < this->narg)
    {
      cindex = index;
      return (this->ap[index]);
    }
  else
    return NULL;
}
//[EF]===================================================//

const char *
Svar::getCptr (int windex)
{
  if (narg == 0 || windex >= narg)
    return NULL;
  return (this->ap[windex]);
}
//[EF]===================================================//

int 
Svar::getWord (int nthw, Svar *ans, int windex)
{
  /// return the nth word in the specified element string

  Svar findword;
  int nwrds = 0;
  char *wd = NULL;
  if (narg == 0)
    init (1);
  ans->cpy("",0);
  if (windex < 0) windex = cindex;

  if (windex < this->narg)
    {
      cindex = windex;
      if (this->ap[windex] == NULL)
	return 0;
      else {
        // split string into words WS delimiter
	// return nth word (0,n-1) else NULL
          nwrds =findword.findWsTokens (this->ap[windex],0);
	  // DBT("nwrds found %d nthw %d\n",nwrds,nthw);
	  if (nthw < nwrds) {
	    // DBT("found %s\n",findword.cptr(nthw));
            wd = findword.cptr(nthw);
	    ans->cpy(wd,0);
	    return strlen(wd) ;
	  }
	  else
          return 0;
      }
    }
  else
    return 0;
}
//[EF]===================================================//

char
Svar::cval (int sindex, int index)
{
  if (index < this->narg)
    {
      if (sindex < this->vstrlen (index)) {
        char *cp = this->ap[index];
	return (cp[sindex]);
      }
    }
  return 0;
}
//[EF]===================================================//
int
Svar::cCmp (char v, int sindex, int index)
{
  if (index < this->narg)
    {
      if (sindex < this->vstrlen (index))
	{
          char *cp = this->ap[index];
	  return (cp[sindex] == v);
	}
    }
  return 0;
}
//[EF]===================================================//

int
Svar::cCmp (char v, int sindex)
{
      if (sindex < this->vstrlen (cindex))
	{
          char *cp = this->ap[cindex];
	  return (cp[sindex] == v);
	}
  return 0;
}
//[EF]===================================================//

void
Svar::shuffle (int ns)
{
  // shuffle elements ns times

  if (narg > 1) {
  int n = narg;

  int k,j;
  Svar tmp("shuffle");
  for (int i = 0; i < ns; i++)
    {
      k = rand () % n;
      j = rand () % n;
      tmp.cpy(this->ap[k],0);
      cpy(ap[j],k);
      cpy(tmp.ap[0],j);
    }
  }

}
//[EF]===================================================//

void 
Svar::swapRow(int si)
{
         char *tap0;
         int sz0;
         int row = (si/nfields);
         int j = (row * nfields); // first element in the row
         for (int k = 0; k < nfields; k++) {
	   // which rows are we sawpping?

         tap0 = ap[j];
         sz0 = sz[j];
         ap[j] = ap[j+nfields];
         sz[j] = sz[j+nfields];
         ap[j+nfields] = tap0;
         sz[j+nfields] = sz0;
         j++;
	 }
}
//[EF]===================================================//
int
Svar::sort ()
{
  //  sort on a designated field with a record
  //  i.e. svar has records of n fields arranged consecutively
  //  sort will swop records --
  //  treat as alphabet sort -- or convert field val to number 
  //  and sort numerically
  //

 int nswaps = 0;

  if (narg > 1) {

  int n = narg;


  Svar tmp;
  // bubble sort
  char *cpa;
  char *cpb;
 
  if (n > nfields) {

    int i = 0;
    int sweeps = 0;

    while (1) {
  
     i = keycol;
     int swop = 0;

     while (i < (n-nfields)) {

       cpa = ap[i];
       cpb = ap[i+nfields];

       int alen = strlen(cpa);
       int blen = strlen(cpb);
       int s_len = (alen < blen) ? alen : blen;
       int kc = 0;

       int swop_item = 0;  
       //DBT("[%d] a %s %d b %s %d s_len %d \n",i,cpa,alen,cpb, blen,s_len);
       
       while (kc++ < s_len) {
	 //         DBT("kc %d %s %s \n",kc,cpb,cpa);
         if (*cpb == *cpa);
         else if (*cpb < *cpa) {
	 swop_item = 1;
         break;
         }
         else
	   break;
         cpa++; cpb++;
       }

       if (swop_item) {  // has to swap row -- nfields

         nswaps++;
         swop = 1;
         // have to work through 'row' sort based on keycol
         // 
         swapRow(i);
	 // DBT("i %d k %d j %d nfields %d keycol %d\n",i,k,j,nfields,keycol);
         
       }

       i += nfields;
     }

    if (!swop)
      break;

    sweeps++;
    }
   }
  }

  return nswaps;
}
//[EF]===================================================//




int
Svar::valueNumSort ()
{
  //  sort on a designated field with a record
  //  i.e. svar has records of n fields arranged consecutively
  //  sort will swop records --
  //  and sort numerically
  //
 int nswaps = 0;

  if (narg > 1) {

  int n = narg;

  Svar tmp;
  // bubble sort
  char *cpa;
  char *cpb;
 
  if (n > 1) {

    int i = 0;
    int sweeps = 0;

    while (1) {
  
      i = keycol;
     int swop = 0;
     while (i < (n-nfields)) {

       cpa = ap[i];
       cpb = ap[i+nfields];

       //       DBT("i %d %s %s %s %s\n",i,ap[i],ap[i+1],ap[i+2],ap[i+3]);

       int anum = atoi(cpa);
       int bnum = atoi(cpb);

       int swop_item = 0;  
       //       DBT("a %s %d b %s %d  \n",cpa,anum,cpb, bnum);      

       if (bnum < anum)
	 swop_item =1;

       if (swop_item) {  // has to swap row -- nfields

         nswaps++;
         swop = 1;
         // have to work through 'row' sort based on keycol
         // 
         swapRow(i);
       }

       i += nfields;
    }

    if (!swop)
      break;

    sweeps++;
    }
   }
  }

  return nswaps;
}
//[EF]===================================================//



void
Svar::reverse ()
{
  // need to cpy items - since they have been malloced

  if (narg > 1) {

  int n = narg;
  int m = n/2;
  int j = n - 1;
  Svar tmp;

      for (int i = 0; i < m; i++)
	{
         tmp.cpy(this->ap[i],0);
         cpy(ap[j],i);
         cpy(tmp.ap[0],j);
         j--;
	}
  }

}
//[EF]===================================================//

int
Svar::join ()
{
  // need to cpy items - since they have been malloced
  int rv = 0;
  if (narg > 1) {

  int n = narg;

      for (int i = 1; i < n; i++)
	{
	  cat(ap[i],0);
	}

      for (int i = 1; i < n; i++)
	{
	  if (ap[i] != 0)
	    {
	      sfree (ap[i]);
	      ap[i] = 0;
	    }
	}

      narg = 1;
      rv = 1;
  }
  return rv;
}
//[EF]===================================================//
// input a range or vec of indices to delete
int
Svar::cut (int vec[], int n)
{
  
  int rv = 0;

  if (narg >= 1) {

   int na = narg;
    int nr = na;
    int j;


      for (int i = 0; i < n; i++)
	{
	 
          j = vec[i];
	  //DBT(" i %d j %d \n",i,j);
          if (j >= 0 && j < na) {

	  if (ap[j] != 0)
	    {
	      sfree (ap[j]);
	      ap[j] = 0;
              nr--;
	    }
          }

	}

      // now we have to adjoin

      for (int i = 0; i < na; i++)
	{
	 
	  if (ap[i] == 0)
	    {
	      j = i+1;
              while (j < na) {
                if (ap[j] != 0) {
		  ap[i] = ap[j];
                  ap[j] = 0;
                  break;
                }
                j++;
              }

	    }
	}



      narg = nr;
      rv = 1;
  }

  //  DBT(" narg %d \n", narg);

  return rv;
}
//[EF]===================================================//

void Svar::setType(int wtype)
{

  type = wtype;
  if (type == SVAR_HASH) {
    nfields = 2; // default - search indexing in pairs
  }

}
//[EF]===================================================//


int
Svar::ncpy (const char *value, int ilen, int index)
{
  int rv = 0;

  try {

    if (value == NULL) {
     throw NULL_PARA;
    }
    
DBPF("narg %d %s slen %d ilen %d index %d\n",narg,value,strlen(value),ilen, index);



  if (narg == 0) {
    DBPF(" svar not innited yet ?!\n");
    init (1);
  }

  if (index < 0)
    throw NEG_PARA;

  if (index >= narg) {
    if (!this->vrealloc (index+2))
      //if (!this->vrealloc (index + 2))
      throw MALLOC_ERROR;
  }

  cindex = index;

  int len = ilen;

  if (len == -1 && value != NULL) {
    len = strlen (value);
  }

  if (len == -1)
    len = 0;


  // DBPF("index %d len %d na %d\n",index,len, narg);
  // DBT("value <%s>\n",value);
  // DBT("index %d len %d sz[index] %d na %d\n",index,len,sz[index], narg);

  if (len >= sz[index] || ap[index] == NULL)
    {
      if (!this->valloc (index, len + 2*SVARCHARINC))
	throw MALLOC_ERROR;
    }

  char *acp = (char *) ap[index];
  if (len > 0) {
          strncpy (acp, value, len);
    }

  acp[len] = '\0';  

  rv = 1;
  //DBT("<%s> \n",acp);

  
  }
  
  catch (asl_error_codes ball)
    {
      if (ball != SUCCESS) {

	DBT("bad svarcpy %s\n", asl_error_msg(ball));

      }
    }

  return rv;
}
//[EF]===================================================//

int
Svar::ncpy (const char *value, int ilen)
{
  return (this->ncpy (value, ilen, cindex));

}
//[EF]===================================================//


int
Svar::cpy (const char *value, int index)
{
  // may be make this do strcpy instead of ncpy

int rv = 0;

  try {


    
DBPF("narg %d %s slen %d index %d\n",narg,value,strlen(value),index);

 //DBT("narg %d  index %d\n",narg,index);

 //DBT("narg %d %s slen %d index %d\n",narg,value,strlen(value),index);


  if (narg == 0) {
    DBPF(" warning svar not innited ?!\n");
    init (1);
  }

  if (index < 0)
    throw NEG_PARA;

  if (index >= narg) {
    if (!this->vrealloc (index+1))
      //if (!this->vrealloc (index + 2))
      throw MALLOC_ERROR;
  }

  cindex = index;

  int len = 0;

  if (value != NULL) {
    len = strlen (value);
  }
  
  // DBPF("index %d len %d na %d\n",index,len, narg);
  //  DBT("value <%s>\n",value);
  //  DBT("index %d len %d sz[index] %d na %d\n",index,len,sz[index], narg);

  if (len+1 >= sz[index] || ap[index] == NULL)
    {
      if (!this->valloc (index, len + 2*SVARCHARINC))
	throw MALLOC_ERROR;
    }

  char *acp = (char *) ap[index];
  acp[len] = '\0';
 
    if (value == NULL) {
      // trying to set string to null??
      DBT("null string copy?\n");    
     throw NULL_PARA;
    }

  
  if (len > 0) {
          strcpy (acp, value);
    }

  rv = 1;
  //DBT("<%s> \n",acp);

  if (len > 0 && (strcmp(acp,value) != 0)) {
    // if this was a cpy -- did it work?
       DBPF("cpyerror <%s> <%s>\n",acp, value);
       DBPF("index %d len %d sz[index] %d na %d\n",index,len,sz[index], narg);
       valloc (index, len + 3*SVARCHARINC );
       strcpy (acp, value); //retry
     if (strcmp(acp,value) != 0) {
       throw STRING_ERROR;
     }
  }
  
  }
  
  catch (asl_error_codes ball)
    {
      if (ball != SUCCESS) {
	DBT("bad svarcpy %s\n", asl_error_msg(ball));
      }
    }

  return rv;
}
//[EF]===================================================//

int
Svar::cpy (const char *value)
{
  return (this->cpy (value, cindex));
}
//[EF]===================================================//

int
Svar::cpy (Svar * svar, int index)
{
  return this->cpy (svar->ap[svar->cindex], index);
}
//[EF]===================================================//

int
Svar::cpy (Svar * svar, int vindex, int index)
{
  return this->cpy (svar->ap[vindex], index);
}
//[EF]===================================================//

int
Svar::cpy (Svar * svar)
{
  return this->cpy (svar->ap[svar->cindex], cindex);
}
//[EF]===================================================//

int
Svar::cpy (int frindex, int toindex)
{
   if (frindex < 0 || toindex < 0 || frindex >= narg)
     return 0;
   if (frindex != toindex)
     return this->cpy (this->ap[frindex], toindex);

  return 1;
}
//[EF]===================================================//


int
Svar::cpysubset (Svar * from, int index)
{
  // copies subset of from svar string  to index of this svar

  if (narg == 0)
    init (1);

  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;
  cindex = index;

  int len = from->subsize;
  if ((len + 1) >= sz[index] || ap[index] == NULL)
    if (!this->valloc (index, len + 3))
      return 0;
  char *cp = ap[index];
  char *fcp = from->ap[from->cindex];
  for (int i = 0; i < len; i++) {

     cp[i] = fcp[from->subset[i]];

//   DBT("cpysubset %d [%d] %c \n", i,from->subset[i], cp[i]);   

  }

  return 1;
}
//[EF]===================================================//

int
Svar::copy (char *value, int len, int index)
{
  char *cp;
  int i;

  if (narg == 0)
    init (1);

  if (len <= 0 || index < 0)
    return 0;
  if (index >= narg)
    if (!this->vrealloc (index + 1))
      return 0;

  cindex = index;

  if ((len + 1) >= sz[index] || ap[index] == NULL)
    if (!this->valloc (index, len + SVARCHARINC))
      return 0;
  cp = (char *) ap[index];
  for (i = 0; i < len; i++)
    cp[i] = *value++;
  return 1;
}
//[EF]===================================================//
//[EF]===================================================//

int
Svar::copy (Svar *sv)
{
  
  for (int i = 0; i < sv->getNarg() ; i++) {
     DBPF(" i %d %s\n",i,sv->ap[i]);
      this->cpy(sv->ap[i],i);
       
  }
  return narg;
}
//[EF]===================================================//







int isNameDel( char bcp)
{
  // look for subsets
    return (isspace(bcp) 
	    || ( bcp >= 33 && bcp <= 47) // ! --- /
	    || ( bcp >= 58 && bcp <= 64) // : --- @
            || ( bcp >= 91 && bcp <= 94) 
            || ( bcp >= 123 && bcp <= 126) 
            || bcp == '\''
            || bcp == '\\'
	    //|| bcp == '('
	    // || bcp == ')'
	    //    || bcp == '['
	    //    || bcp == ']'
	    //   || bcp == '|'
	    //     || bcp == '&'
	    //        || bcp == '~'
	    //        || bcp == '%'
	    //        || bcp == '*'
	    //|| bcp == '+'
	    //        || bcp == '-'
	    //|| bcp == ';'
	    //|| bcp == ','
	    //    || bcp == ':'
	    //        || bcp == '<'
	    //        || bcp == '>'
	    //|| bcp == '^'
	    //|| bcp == '='
	    //        || bcp == '{'
	    // || bcp == '}'
	    //        || bcp == '"'
	    //        || bcp == '$'

	    //        || bcp == '!'
	    //|| bcp == '/'
	    //|| bcp == '@'
	    //|| bcp == '#'
	    );
}
//[EF]===================================================//

int
Svar::findStr (const char *pat, int index, int sindex, int ignore_case)
{
  char *cp = NULL;
  int rv = -1;

  if (narg <= index  || index < 0) {
    DBPERROR("SVAR_FIELD_ERROR\n");
  }
  else {
    
    int vslen = vstrlen(index);

    //DBT("vslen %d index %d sindex %d\n",vslen,index, sindex);
    
    if (sindex >= 0  && sindex < vslen ) {

      const char *scp = (const char*) &ap[index][sindex];

      if (ignore_case) {

	//	cp = (char *) strcasestr(scp ,pat);
	cp = (char *) strcasestr(scp ,pat);

        //DBT("anycase scp %s pat %s cp %s \n",scp,pat,cp);

      }
      else {
	cp = (char *) strstr(scp ,pat);
      }

    if (cp != NULL) {
      rv = sindex + (cp - scp);
    }


   //DBT("scp %s pat %s cp %s rv %d ignore_case %d\n",scp,pat,cp,rv, ignore_case);


    }
  else {
    DBPERROR("SVAR_SLEN_ERROR index %d si %d vsl %d %s\n", index, sindex, vslen, pat);
  }
  }
  return rv;
}
//[EF]===================================================//


int
Svar::findExpBetween (char *s1, char delb, char dele, int index)
{
  // find exp between delimiters
  int k;
  int nb, ne;
  char *cp;
  char *lcp;
  char *ap;

  int len = strLen (s1);
  
  if (len <= 1)
    return -1;

  cp = s1;

  cset (0, len, index);		// make var capable of holding s1
  cset (0, len+3, index);	       // make var capable of holding s1
  ap = (char *) cptr (index);    // really make sure

  /* find first del */

  k = 0;

  if (delb != -1)
    {
      while (*cp != delb)
	{
	  cp++;
	  k++;
	  if (k >= len)
	    return -1;
	}
    }

  /* eat_white */
  cp++;
  k++;

  lcp = AdvancePastWhite (cp);

  k += lcp - cp;

  cp = lcp;

  if (cp == NULL)
    return -1;

  /* find matching del */
  /* if nested find matching ? */
  /* workfor [N[k]] */

  nb = 1;
  ne = 0;

  while (1)
    {

      if (*cp == dele)
	{
	  ne++;
	  if (ne == nb)
	    break;
	}
      if (*cp == delb)
	nb++;
      *ap++ = *cp++;
      k++;
      if (k > len)
	return -1;
    }
  *ap = '\0';

  k++;

  return k;
}
//[EF]===================================================//

// Svar::findWsQTokens (const char *s1,int windex)
// space inside of quotes ignored  ab cd "ef gh"
// returned as strings <ab> <ce> <"ef gh">

int
Svar::findWsTokens (const char *s1,int windex)
{
  /// parse through the string putting WS deliminated tokens into fields

  int len = strLen (s1);
  int index = 0;
  try {

  if (len <= 0)
    throw 0;

  if (narg == 0)
    init (1);

  int k;

  if (windex == -1)
    index = cindex;
  else if (windex >= 0)
    index = windex;

  while (isspace(*s1)) s1++;

  if (!*s1)
         throw 0;

  while (1)
    {

      cindex = index;

      k = 0;

      while ( !isspace(*s1)  && *s1 != 0)
	{
	  cset (*s1++, k++, index);
	}

      cset (0, k, index);

      index++;

      while ( isspace(*s1)) s1++;

      if (!*s1)
	break;

      if (strLen (s1) == 0) break;
    }
  }

  catch (int err) 
  {
    ;
  }

  return index;
}
//[EF]===================================================//

int Svar::findWords (const char *s1)
{
/// the string s1 is parsed via white space
/// each delimited string so found is placed into Svar fields 0..n-1
/// returns number of words found


  return findWsTokens(s1);

}
//[EF]===================================================////


int Svar::findTokens (const char *s1, char del, int windex, int quoted, int step, int online)
{
  /// default arg int windex = 0
  /// parse through the string putting deliminated tokens
  /// into svar fields
  /// need a version to ignore del in quotes

  // should put the string into windex - if no delimiter found ?

  int len = strLen (s1);

  if (len <= 0)
    return 0;

  DBPF("%s len %d quoted %d\n",s1,len, quoted);
  
  if (narg == 0)
    init (1);

  int index = 0;

  if (windex == -1)
    index = cindex;
  else if (windex >= 0)
    index = windex;
 
  int k;

  int j = 0;
  int kf = 0;

  if (!quoted) {

  while (1)
    {
      
      cindex = index;

      k = 0;

      while (*s1 != del && *s1 != 0)
	{
	  cset (*s1++, k++);
          j++;
	}

      cset (0, k);

      DBPF("index %d %s\n",index,cptr(index));
      index += step;


      kf++;

      if (*s1 == del) { s1++; j++; }

      if (!*s1)
	break;

      if ( j >= len) break;
      if (online) {
	if (*s1 == '\n' || *s1 == '\r') {
           DBPF("break eol found %d toks \n",kf);
	  break;
	}
      }
    }
  DBPF("found %d toks \n",kf);
  }
  else {
    bool in_squote = 0;
    bool in_dquote = 0;
    bool bslash = 0;
    char last_char = 0;
    // take care of escape quote
    while (1)
    {

      cindex = index;

      k = 0;
      DBPF(("%s\n",s1));

    while ((*s1 != del || in_squote || in_dquote) && *s1 != 0)
	{
 
	  if (*s1 == '"' && last_char != '\\' && !in_squote) {    // need to take care of escaped dquote 
            in_dquote = !in_dquote;
          }

	  if (*s1 == '\'' && last_char != '\\' && !in_dquote) {    // need to take care of escaped squote 
            in_squote = !in_squote;
          }
	  
          last_char = *s1;  // backslashes left in

	  if (online) {
	     if (*s1 == '\n' || *s1 == '\r')
	     break;
          }
	  
	  cset (*s1++, k++);
          j++;

	}
      

      cset (0, k);
      DBPF(("index %d %s\n",index,cptr(index)));
      index += step;

      if (k > 0)
         kf++;

      if (*s1 == del) { s1++; j++; }

      if (!*s1)
	break;

       if (online) {
	     if (*s1 == '\n' || *s1 == '\r')
	     break;
          }
      
      if ( j >= len) break;

    }
  } 

  return kf;
}
//[EF]===================================================//


int
Svar::findMatch (char *s1, int case_s, int nc, int si, int dir)
{
  ///
  /// find match of s1 from svar fields
  /// return field/arg number

  // first
  int index = si;
  int ret = -1;

  try {
    
  if (narg == 0) throw -1;

  char *cp = NULL;

  while (1)
    {
      
      if (index >= narg)  
	throw -1;
      if (index < 0)
	throw -1;

      if (case_s) {

	if (nc == 1) {


	  
        if (strcmp(s1,this->ap[index]) == 0) {
	   dbp("found index @ %d strcmp %s %s\n",index,s1, this->ap[index]); 
	    throw index;
	}

        }
        else {
	  
           const char *scp = (const char*) ap[index];
           cp = (char *) strstr(scp ,s1);
           dbp("strstr %s %s\n",s1, scp);
           if (cp != NULL) {
             throw  index;
           }
	}
      }
      else {

        if (nc == 1) {
         if (strcasecmp(s1,this->ap[index]) == 0)
         throw index;
        }
        else {
           const char *scp = (const char*) ap[index];
           cp = (char *) strcasestr(scp ,s1);
           if (cp != NULL) {
             throw index;
           }
        }

      }

    if (dir == 1)
    index++;
    else
    index--;

    }

  throw -1; // not found

  }

  catch (int ball) {

    ret  = ball;

  }

  
  return ret;
}
//[EF]===================================================//

int
Svar::findVal (char *s1 , int sindex, int direction, int all, int rvec[])
{
  /// find match of s1 from svar fields
  /// return field/arg number
  /// if all rvec must be as big as narg
  /// not using direction ??

  int case_s = 1;

  // first

  int index = sindex;

  if (narg == 0) return -1;
  int k = 0;

  // DBT("%s sindex %d dir %d all %d \n",s1,sindex,direction,all);

  while (1)
    {
      if (case_s) {

	if (strcmp(s1,this->ap[index]) == 0) {

        rvec[k++] = index;
        if (!all)
        return 1;

        }
      }
      else {
      if (strcasecmp(s1,this->ap[index]) == 0)
                 rvec[k++] = index;
        if (!all)
        return 1;
      }

      if (direction == -1)
	index--;
      else
        index++;

    if (index >= narg || index < 0) break;
    }

  return k;
}
//[EF]===================================================//


///////////////////  TBD ///////////////////
// C/C++ standards 
