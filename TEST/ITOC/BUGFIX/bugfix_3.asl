// BUG_FIX 

SetPCW("writeexe","writepic")
SetDebug(1)

//  FIXME_PARSE         
//  version 1.2.39
double xxx = -1.7
double yr0 = -1.5
double yrx = -1.5
double yr1 = 1.5
xr0 = -1.5
xr1 = 1.5
<<"%V  $yrx $yr0 $yr1 $xxx\n"

<<"%V  $xr0 $ $xr1 \n"

// BUG  yr0 0 in exe not -1.5
#{
[9] <3> 16835  DECLARE   double yr0 = -1.5 
	<3>  1 [  1] CREATEV :yr DOUBLE array? 0 
	<3>  2 [  9] LOADRN : 1.500000 
	<3>  3 [  6] OPERA :  UMINUS
	<3>  4 [  1] CREATEV :yr0 DOUBLE array? 0 
	<3>  5 [  5] STORER : _R  => yr0   283
	<3>  6 [  7] ENDIC :
#}
// FIX PruneName function had typo of 0 for ) !!!!!!






STOP!