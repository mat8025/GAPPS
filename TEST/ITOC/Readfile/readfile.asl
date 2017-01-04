///   readfile
setdebug(1);

checkIn()

 A = ofr("readfile.asl")


  S=readfile(A)

<<"$S\n"

 cf(A)


 A = ofr("readfile.asl")
 k = 0;
 while (1) {

  res =readline(A)
  err = f_error(A)
  <<"$k $err :: $res \n";
  if (f_error(A) == EOF_ERROR_) {
    <<"@ EOF\n"
       break;
	   }
	   
  k++;
   if (k > 40)
    break;
 }


checkTrue((err>0));

checkNum(err,6)

checkOut()