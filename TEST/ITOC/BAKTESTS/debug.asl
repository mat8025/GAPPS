///
/// debug
///


 DB=debugEnv() ; // checks GS_DEBUG env var if exists sets the debug level - returns current debug level
 

<<"$V $DB\n" ; // error in this line
	   lename=lastErrorName ();
<<"%V $lename\n"
le =lastError ();
<<"%V $le\n"
leln =lastErrorLine ();
<<"%V $leln\n"	   
errv=getNumOfErrors ();
<<"%V $errv\n"


 a= foo();

 b =  c +d;

lename=lastErrorName ();
<<"%V $lename\n"

errv=getNumOfErrors ();
<<"%V $errv\n"
exit();
