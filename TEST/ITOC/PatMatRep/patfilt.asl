///
///
///

// want to get the string between " "
// and insert after ::
// sfd_alias ("setnetconn", &Ann:: , "    ");

setdebug(0)


 A= 0; // stdin
 int k = 0;
 while (1) {

  bv = readline(A)
  if (f_error(A) == EOF_ERROR_)
  break;
//<<"$bv\n"
pat1 = spat(bv,"sfalias");
//<<"%V$pat1\n"
 if (pat1 @="") 
<<"     $bv\n"
  k++;
  //if (k ==3)  break

 }

<<"\n$k lines processed\n"