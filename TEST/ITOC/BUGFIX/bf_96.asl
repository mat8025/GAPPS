///
///
///


//   nvm[np-1] += 1;  // FIX THIS!

checkIn()

np = 7;
char nvm[10];

nvm[5] = 58+5;
<<" $nvm\n"

<<"%c $nvm\n"

k = 7;
jp = 3;
nvm[jp] = k+48;
nvm[jp-1] = 8+48;


z= nvm[jp-1];
<<"%d $nvm %c $nvm\n"
setdebug(1,@trace,@~stderr,@pline,@showresults,@filter,0)
nvm[jp-1] = z +1;  
<<"$(typeof(nvm)) $(Cab(nvm))\n"
<<"%d $nvm %c $nvm\n"

nvm[jp] += 1;  // FIX THIS!

<<"$(typeof(nvm)) $(Cab(nvm))\n"
<<"%d $nvm %c $nvm\n"

checkNum(nvm[2],57)
checkNum(nvm[3],56)

///////////////////////////////////////////////////////
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

fvm[jp] += 1;  // FIX THIS!

<<"$(typeof(fvm)) $(Cab(fvm))\n"
<<"%6.1f$fvm \n"
checkFnum(fvm[2],57)
checkFnum(fvm[3],56)

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

checkOut()

exit()


nvm[jp-2] += 1;  // FIX THIS!