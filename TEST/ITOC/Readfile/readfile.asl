/* 
 *  @script readfile.asl 
 * 
 *  @comment test readfile 
 *  @release CARBON 
 *  @vers 1.7 N Nitrogen [asl 6.3.49 C-Li-In] 
 *  @date 08/23/2021 08:06:28 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                         
<|Use_=
Demo  of readfile function
C=readfile(A)
reads the entire  file attached to file handle  A into svar variable C
or
C=readfile("filename")
where the file is opened then read and then closed.
line 0 is C[0], line 1 is C[1], ...
the line will contain the final cr/lf character.
The last character cr \n can be removed using option
C=readfile(A,1) that element in svar C will then be null.
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}



chkIn(_dblevel)

// if no supplied  file use this file as default



 fname = _clarg[1]



//if (fname @= NULL_) {
if (fname == "") {

   fname = "readfile.asl"
}


// A = ofr(fname)
<<"%V $fname \n"

  S=readfile(fname)

  en= errno()


<<" error? $en  $(errname()) $(errornum())  $(errorname())\n"

 if (en){
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
