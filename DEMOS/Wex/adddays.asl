///
///
///

setDebug(1,"keep");
// add a month

yr=2020;
mn = 2;
//mname= "feb"
yr = _clarg[1];
mn = atoi(_clarg[2]);
mname= _clarg[3];
<<"%V $mn $yr \n"

<<"$yr $(typeof(yr)) \n"
<<"$mname $(typeof(mname)) \n"



jd = julian("$mn/01/$yr")

int dim[] = {0,31,28,31,30,31,30,31,31,30,31,30,31} ;

<<"$dim \n"

lyr = !(yr % 4);

<<"\n\n"

if (lyr) {
<<"$yr is a $lyr\n"
dim[2] = 29;
<<"$dim \n"
}





for (i= 1; i <= dim[mn] ; i++) {

wday = julday(jd)
dmy= julmdy(jd)

<<"$i $jd  $dmy  $wday \n"

jd++;

}

<<"/////////////////\n"


jd = julian("$mn/01/$yr")

<<"#date,Wt,walk,hike,run,bike,swim,Ydwk,Exer,Bpress,armcurl, \n"
mname = month(mn);
<<"#$mname \n";

for (i= 1; i <= dim[mn] ; i++) {

wday = julday(jd)
dmy= julmdy(jd)

<<"$dmy, 203,10,0,0,0,0,0,0,0,0, \n"

jd++;

}


