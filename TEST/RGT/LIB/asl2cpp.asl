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

Str asl_file =  _clarg[1];

  A=ofr(asl_file);

if (A == -1)
     exit(-1);

int done =0;
int wl = 1;

Str st="xyz";

int stype;
Str ltag = "xyz";
  while (!done) {


 ln = readline(A);



  if (ferror(A) == EOF_ERROR_) {
    done = 1;
    break;
   } 

   // read a line -- find statement type
  st = checkState(ln);
  stype = checkStateType(ln);
<<"$wl $stype $st <|$ln|> ";
   // if declare - then find datatype for that variable
  //  int a= 77;
  // when see  asl print   e.g.  <<"%V $a\n";
  // parse and reformat to
  // cprintf(" a %d\n",a);  // <<"%V $a\n";
// can we run AslState (ln) ?
//  if (stype != EMPTY_ && stype != COMMENT_ && stype != ELSE_ && stype != IF_ ) {
  if (stype == PRSTDOUT_ || stype == DECLARE_ ) {
    ltag="$wl";
<<"evaluate $ltag <|$ln|> ?";  
    aslState (ln, "T $wl "); // parse and execute -- xic ??

    //aslState (ln, ltag); // parse and execute -- xic ??

}

//<<"$wl $st  \n"




wl++;

  }

S=variables();
// this gives us variables and types
// first run through

// then convert expand DQ's



<<"%(1,,,\n)$S\n"


exit(0);