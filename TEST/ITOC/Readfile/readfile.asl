//%*********************************************** 
//*  @script readfile.asl 
//* 
//*  @comment test readfile 
//*  @release CARBON 
//*  @vers 1.6 C Carbon                                                    
//*  @date Fri Apr  3 19:25:54 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug"
debugON()
checkIn()

// if no supplied  file use this file as default



 fname = _clarg[1]



//if (fname @= NULL_) {
if (fname @= "") {

   fname = "readfile.asl"
}


 A = ofr(fname)
<<"%V $A $fname \n"

  S=readfile(A)

<<"$S\n"
nlines = Caz(S);
<<"%V $nlines\n"
 cf(A)

  for (i=0; i < nlines; i++) {
<<"<|$i|>  $S[i]"
  }



exit()


 A = ofr(fname)
 k = 0;
 
 while (1) {

  res =readline(A)
  err = f_error(A)
  wc=slen(res)
  <<"$k $wc $err :: $res \n";
 
  if (f_error(A) == EOF_ERROR_) {
    <<"@ EOF\n"
       break;
	   }
	   
  k++;
   if (k > nlines)
    break;
 }


checkTrue((err>0));

checkNum(err,6)

checkOut()
