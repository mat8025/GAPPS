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

#include "debug"


chkIn(_dblevel)

// if no supplied  file use this file as default



 fname = _clarg[1]



//if (fname @= NULL_) {
if (fname @= "") {

   fname = "readfile.asl"
}


// A = ofr(fname)
//<<"%V $A $fname \n"

  S=readfile(fname)

  en= errno()


<<" error? $en  $(errname()) $(errornum())  $(errorname())\n"

 if (errornum()){
     exit(en, errorName()))
  }




BC=split(S[0])

<<"$BC \n"

<<"BN $BC[3]\n"



<<"$S\n"
nlines = Caz(S);
<<"%V $nlines\n"


  for (i=0; i < nlines; i++) {
<<"<|$i|>  $S[i]"
  }




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


chkT((err>0));

chkN(err,6)

chkOut()
