//
// GlideDEM
//


ned_stem = "";

int nrows = 10
int ncols = 10

float map_ul_lat = 0.0;
float map_ul_long = 0.0;
map_deg = 1.0

short Map[];
float wg[];

 LatN= -10.0;
 LongW= -10.0;

 LatS = -10.0;
 LongE = -10.0;


proc ReadNED(nedname)
{
  
<<"input  NED file $ned_stem \n"

  ned_stem = spat(nedname,"NED/",1)
  ned_path = spat(nedname,"NED/",-1)

  ned_path = scat(ned_path,"/NED/");

<<" NED directory is $ned_stem  path is $ned_path\n"


 Svar Wd=""
 
 nf = ofr("$ned_path/$ned_stem/${ned_stem}.blw")

 if (nf == -1) {
 <<" can't open ${ned_stem}.blw \n"
   exit()
 }

   nwr=Wd->Read(nf)
   map_deg = atof(Wd[0])

<<"%V $map_deg \n"

   //nwr=Wd->Read(nf)
   nwr=Wd->Read(nf,3)
   
   map_ul_long = atof(Wd[0])
 //  map_ul_long *= -1;

<<"%V $map_ul_long \n"

   nwr=Wd->Read(nf)
   map_ul_lat = atof(Wd[0])

<<" $map_ul_lat $map_ul_long $map_deg \n"
 
  cf(nf)
  
   nf = ofr("$ned_path/$ned_stem/${ned_stem}.hdr")

<<"%V $nf\n"
  
   nwr=Wd->Read(nf,2)

<<" $Wd $Wd[1]\n"
   nrows = atoi(Wd[1])
   nwr=Wd->Read(nf)
<<" $Wd $Wd[1] \n"

  ncols = atoi(Wd[1])

<<"%V $nrows $ncols \n"

 //  nrows = 2;
 //  ncols = 5;

  Map = ReadBIL("$ned_path/$ned_stem/${ned_stem}.bil", nrows, ncols)


<<"DONE READ of BIL $Map[0][0] $Map[1][1] \n"

/{
     for (km = 0; km < nrows ; km++) {
          for (kc = 0; kc < ncols ; kc++) {
         <<" Map $km $kc  $Map[km][kc] \n"
          }
     }
/}

      msz = Caz(Map)
      mbd = Cab(Map)
     
<<"Map %V $msz  $mbd \n"
<<"now setwgrid \n"
   
     mapok = 0;

     mapok = SetWgrid(Map,map_ul_lat,map_ul_long, map_deg)

    <<"%V $mapok \n"

    wg = GetWgrid()
    
    msz = Caz(wg)
    mbd = Cab(wg)
     
<<"WG %V $msz  $mbd \n"

 <<"%V $wg[0] $wg[1] \n"

LatN= wg[0];
LongW= wg[1];

LatS = LatN - (wg[2] * wg[5])

LongE = LongW + (wg[2] * wg[6])

<<"%V $LatN $LongW $LatS $LongE \n"
 
<<"Done read DEM\n"


}

//================================================

