//%*********************************************** 
//*  @script fitconv_sf.asl 
//* 
//*  @comment convert garmin fit to tsv - location and HB 
//*  @release CARBON 
//*  @vers 1.5 B Boron [asl 6.2.75 C-He-Re]                                  
//*  @date Mon Oct 12 08:53:19 2020 
//*  @cdate 3/1/2017 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///  convert fit file --- extract lon,lat, time,speed, pulse
///
include "debug"

debugON()

fname = _clarg[1];
//ask = atoi(_clarg[2]);

//file_size= fstat(fname,"size")
file_size= fexist(fname)

<<"%V$file_size";

   TL=FineTime()
AF= ofr(fname);

outname = scut(fname,-3);

outname = scat(outname,"tsv");

<<"$fname $outname\n"
BF=ofw(outname);
p2= 2 ^31;
double scdeg = 180.0/ (2 ^31);

<<"%V $p2 %e $scdeg\n"

DF = -1
DF= ofw("fit_debug")
<<"debug $DF to file fit_debug\n"

   fitconv(AF,BF,DF);



 dt=FineTimeSince(TL)
 secs = dt/1000000.0


<<"took %V$secs\n"
exit()