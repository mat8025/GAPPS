//%*********************************************** 
//*  @script readfile.asl 
//* 
//*  @comment test readfile 
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Sun Apr 28 07:40:38 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///   readfile
include "debug"
debugON()
checkIn()

 A = ofr("readfile.asl")


  S=readfile(A)

<<"$S\n"
nlines = Caz(S);
<<"%V $nlines\n"
 cf(A)


 A = ofr("readfile.asl")
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
