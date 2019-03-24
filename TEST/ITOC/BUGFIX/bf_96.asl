///
///
///

include "debug.asl"; 
   
debugON();  
 

setdebug(1,@trace,@~stderr,@pline,@showresults,@filter,0)
//   nvm[np-1] += 1;  // FIX THIS!
FilterFileDebug(REJECT_,"~storetype_e");
FilterFuncDebug(REJECT_,"~ArraySpecs",);
   
checkIn()

np = 7;
char nvm[10];

nvm[5] = 58+5;
<<" $nvm\n"

//<<"%c $nvm\n"

k = 7;
jp = 3;
nvm[jp] = k+48;
nvm[jp-1] = 8+48;

nvm[0] = 2;
z= nvm[jp-1];
<<"%V $z\n"

<<"%d $nvm\n"

<<"%c $nvm\n"

nvm[jp-1] = z +1;  
<<"$(typeof(nvm)) $(Cab(nvm))\n"
<<"%d $nvm \n"
<<"$nvm[jp] \n"

nvm[jp] += 3;  // FIX THIS!
<<"$nvm[jp] \n"
<<"$(typeof(nvm)) $(Cab(nvm))\n"
<<"%d $nvm\n"

checkNum(nvm[2],57)
checkNum(nvm[3],58)


///////////// SHORT/////////////////////////////////
short svm[10];
np = 7;


svm[5] = 58+5;
<<" $svm\n"



k = 7;
jp = 3;
svm[jp] = k+48;
svm[jp-1] = 8+48;


iz= svm[jp-1];
<<"$svm \n"

svm[jp-1] = z +1;  
<<"$(typeof(svm)) $(Cab(svm))\n"
<<"$svm \n"

svm[jp] += 3  

<<"$svm \n"
checknum(svm[2],57)
checknum(svm[3],58)


/////////////INT/////////////////////////////////
int ivm[10];
np = 7;


ivm[5] = 58+5;
<<" $ivm\n"



k = 7;
jp = 3;
ivm[jp] = k+48;
ivm[jp-1] = 8+48;


iz= ivm[jp-1];
<<"$ivm \n"

ivm[jp-1] = z +1;  
<<"$(typeof(ivm)) $(Cab(ivm))\n"
<<"$ivm \n"

ivm[jp] += 3  

<<"$ivm \n"
checknum(ivm[2],57)
checknum(ivm[3],58)



/////////////FLOAT/////////////////////////////////
float fvm[10];
np = 7;


fvm[5] = 58+5;
<<" $fvm\n"



k = 7;
jp = 3;
fvm[jp] = k+48;
fvm[jp-1] = 8+48;


z= fvm[jp-1];
<<"$fvm \n"

fvm[jp-1] = z +1;  
<<"$(typeof(fvm)) $(Cab(fvm))\n"
<<"$fvm \n"

fvm[jp] += 3  // FIX THIS!

<<"$(typeof(fvm)) $(Cab(fvm))\n"
<<"%6.1f$fvm \n"
checkFnum(fvm[2],57)
checkFnum(fvm[3],58)



//////////////////////////////   DOUBLE////////////////////////
double dvm[10];
np = 7;


dvm[5] = 58+5;
<<" $dvm\n"



k = 7;
jp = 3;
dvm[jp] = k+48;
dvm[jp-1] = 8+48;


z= dvm[jp-1];
<<"$dvm \n"

dvm[jp-1] = z +1;  
<<"$(typeof(dvm)) $(Cab(dvm))\n"
<<"$dvm\n"

dvm[jp] += 1;  // FIX THIS!

<<"$(typeof(dvm)) $(Cab(dvm))\n"
<<"%6.1f $dvm \n"

checkFnum(dvm[2],57)
checkFnum(dvm[3],56)

dvm[jp] -= 1;  // FIX THIS!

checkFnum(dvm[3],55)
<<"%6.1f $dvm \n"

checkOut() ; exit()


