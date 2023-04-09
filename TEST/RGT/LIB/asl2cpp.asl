///
///
///



///   read the asl script -
///   for all DQ expand statements
///    e.g <<" $a  \n"

///   or a= $b  -- indirect pointing expansion
///   convert to something the cpp compiler will understang

///  <<"%V $a \n";   ==> cprintf(" a %d\n",a);
///  where the %fmt  is deduced from previous declaration

///  have this script do all the declarations  -- so it can deduce the type

///

Str rwd="xyz";
int iv[256];

Str ws;
Svar wst;
Svar lnpars;




int transToCpp()
{

int done=0;
int na =0;
int ncd=0;
int start_cpr = 0;
Str tln;
int kl = 0;
int err=0;
 //setErrorNum(NO_ERROR_);
  setFerror(CF,0);
 err=ferror(CF);
// <<"%V$done   $err\n"

 while (!done) {
  kl++;
  tln = readline(CF);
//<<"$kl tln <|$tln|> "
// err=ferror(CF);
// <<"%V$kl   $err\n"
  if (ferror(CF) == EOF_ERROR_) {
  //<<" got EOF_ERROR_  line $kl\n"
    done = 1;
    break;
   }

  iv= sstr(tln,"PRSTDOUT");
  if (iv[0] != -1) {
   iv = sstr(tln,"#C<|T");
   if (iv[0] != -1) {
   lnpars=split(tln);
   rwd = lnpars[4];
   //rwd=spat(lnpars[4]," |",-1);
  // <<"<|$lnpars[4]|> ";
   <<"$rwd : ";
   start_cpr = 1;
   cptxt="cprintf(\"";
   args="";
   }
  }
// chk for PRSTDOUT 
   if (start_cpr) {
  //<<"$tln";
    iv= sstr(tln,"CAT_STR");
    if (iv[0] != -1) {
     rwd=spat(tln,"<|",1);
     wd= spat(rwd,"|>",-1,-1)
     cptxt.cat(wd);
    }
     iv= sstr(tln,"PUSH_SIVP");
    if (iv[0] != -1) {
     rwd=spat(tln,": ",1);
     // get ws tokens
     wst=split(rwd);
     args.cat(",");     
     args.cat(wst[0]);
     ncd=scmp(wst[1],"INT"); 

     if (scmp(wst[1],"INT"))  {
    // if (wst[1]=="INT")  {

         cptxt.cat('%d');
     //<<"$ncd <|$wst[1]|> INT $cptxt     \n"
      }
     else if (scmp(wst[1],"FLOAT")) {
        cptxt.cat('%f');
	}
     else if (scmp(wst[1],"DOUBLE")) {
        cptxt.cat('%f');
	}	
     else if (scmp(wst[1],"ULONG")) {
        cptxt.cat('%ld');
	}
     else if (scmp(wst[1],"LONG")) {
        cptxt.cat('%ld');
	}		
     else if (scmp(wst[1],"STRV")) { 
        cptxt.cat('%S');
	}

     na++;
    }
    
    iv= sstr(tln,"ENDIC");
     if (iv[0] != -1) {

     //done = 1;
     start_cpr = 0;
      //<<"trying ENDIC \n";
      cptxt.cat( '"' );  // works
    // cptxt.cat( "\");" );  //  works
      //ws=scat(cptxt,'");');
      //cptxt = ws;
         if (na > 0) {
             cptxt.cat(args);  //  works
          }
            cptxt.cat( ");" ); 
           <<"$cptxt \n"
	   <<[OF]"$cptxt \n"
	   }
       }
     }
    return 1;
}

//EP=======================================//

/// the tic file should be 

Str asl_file =  _clarg[1];

  A=ofr(asl_file);
  CF=ofr("asl2cpp.tic");
  OF=ofw("${asl_file}.tic")
  
if (A == -1)
     exit(-1);


 if (CF == -1) {
   <<" can't find tic file\n";
  exit(-1);
     }

int done =0;
int wl = 1;

Str st="xyz";

int stype;
Str ltag = "xyz";
  while (!done) {


   ln = readline(A,-1,1);

  if (ferror(A) == EOF_ERROR_) {
    done = 1;
    break;
   }

///
///  if conline \ will have to read until last line to complete statement
///



   // read a line -- find statement type
  st = checkState(ln);
  stype = checkStateType(ln);
 
<<"$wl $stype $st <|$ln|> \n";
   // if declare - then find datatype for that variable
  //  int a= 77;
  // when see  asl print   e.g.  <<"%V $a\n";
  // parse and reformat to
  // cprintf(" a %d\n",a);  // <<"%V $a\n";
// can we run AslState (ln) ?

// extract prog args and declare them

// end of proc delete them

  if (checkAssignType(stype) || stype == FUNCTION_) {
    ltag="$wl";
//<<"evaluate $ltag <|$ln|> ?";  
    aslState (ln, "A $wl "); // parse and execute -- xic ??
    //aslState (ln, ltag); // parse and execute -- xic ??
}

  if (stype == PRSTDOUT_  ) {
    ltag="$wl";
//<<"cprintf == <|$ln|> ?\n";  
    aslState (ln, "T $wl "); // parse and execute -- xic ??
    setFerror(CF,0);

    seekLine(CF,-1);

    transToCpp();

}
!a
<<[OF]"$wl $ln  \n"

 // write each line (transformed) to new 'cpp compatible' file


wl++;

  }

S=variables();
// this gives us variables and types
// first run through

// then convert expand DQ's



<<"%(1,,,\n)$S\n"
cf(OF);

exit(0);


/////////////////////////////////////////////////
/*

  main vars OK
  use preprocess tic file from asl -dT  xxx.asl
  then xxx.tic is a list of statements and var names and types

  use this  to to do the cpp preprocess translation
  for proc arg vars
  need to keep a list of the proc arg names, types

  and the in proc / main context
  as the asl2cpp  thread proceeds






   problem of conlines ---  do we need to just remove for cpp
   and keep original  or use margin call -
   or mark up via 
   !c  -- move to /*!c*/
   
   so that asl can use the margincall for con lines ?







*/