//%*********************************************** 
//*  @script sfunc_test.asl 
//* 
//*  @comment create template script for sfunc 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Mar 31 17:06:30 2019 
//*  @cdate Sun Mar 31 17:06:30 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

wf = _clarg[1];
comment = _clarg[2];
S= whatis(wf)

<<"$S\n"
if (S @= "Not Found") {
  exit()
}

T=!!"sinfo $wf"

A=ofw("${wf}.asl")

<<[A]"///\n"
<<[A]"///\n"
<<[A]"///\n"

<<[A]"\n"

<<[A]"/{/*\n"
<<[A]"$S\n\n"
<<[A]"%(1, ,,\n)$T\n"
<<[A]"\/}*/\n"
<<[A]"\n\n\n\n"
<<[A]"include \"debug.asl\"\n"
<<[A]"debugON()\n"


<<[A]"checkIn()\n"

<<[A]"\n\n\n\n"


<<[A]"checkOut()"

<<[A]"\n\n\n\n"

<<[A]"////////////// TBD ////////////////////\n"

cf(A)


!!"asl shead.asl ${wf}.asl  '${comment}'  1.1 "



