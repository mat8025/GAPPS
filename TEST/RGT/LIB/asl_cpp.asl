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


  while (!done) {


 ln = readline(A);



  if (ferror(A) == EOF_ERROR_) {
    done = 1;
    break;
   } 

   // read a line -- find statement type
  st = checkState(ln);

<<"$wl $st $ln ";
   // if declare - then find datatype for that variable
  //  int a= 77;
  // when see  asl print   e.g.  <<"%V $a\n";
  // parse and reformat to
  // cprintf(" a %d\n",a);  // <<"%V $a\n";
// can we run AslState (ln) ?
  if (st != "EMPTY" && st != "ELSE") {
<<"evaluate <|$ln|> ?\n";  
    AslState (ln);
 }

//<<"$wl $st  \n"




wl++;

  }

S=variables();



<<"%(1,,,\n)$S\n"


exit(0);