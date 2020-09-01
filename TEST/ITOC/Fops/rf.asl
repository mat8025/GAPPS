///   readfile

include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


 A = ofr("rf.asl")


  S=readfile(A)

<<"$S\n"

 cf(A)

 sz = Caz(S);

<<"%V$sz \n"

 A = ofr("rf.asl")
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
   if (k > (sz+10))
    break;
 }


chkT((err>0));

<<"%V$k\n"
chkT((k<(sz+10)));

chkN(err,6)

chkOut()