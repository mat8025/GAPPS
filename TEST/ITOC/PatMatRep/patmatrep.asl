///
///
///

// want to get the string between " "
// and insert after ::
// sfd_alias ("setnetconn", &Ann:: , "    ");

setdebug(0)

str tmpl =  'sfd_alias ("TAR,", &Imgsf::TAR, "TAR     ");'

<<"input pattern is :$tmpl\n\n";

 A= 0; // stdin
 int k = 0;
 while (1) {

  bv = readline(A)
  if (f_error(A) == EOF_ERROR_)
  break;
//<<"$bv\n"
pat1 = spat(bv,"(Sv");
//<<"%V$pat1\n"
pat2 = spat(pat1,"int ",1);
//<<"%V$pat2\n"
res = ssub(tmpl,"TAR","$pat2",0)
<<"     $res\n"
  k++;
 // if (k ==1)  break

 }

<<"\n$k lines processed\n"