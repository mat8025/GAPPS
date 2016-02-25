#

setdebug(1)

OpenDll("math")


Graphic = CheckGwm()

<<"%V$Graphic \n"
     if (!Graphic) {
//     X=spawngwm()
     }


include "event"






fname = _clarg[1]

// this is a must do --- to read in NED -- 1 arc second approx 30 m resolution
ned_stem = _clarg[2]


///////////////////////////  Scenery /////////////////////////////////////////////

scene = CreateScene(fname)

<<"$fname scene is  $scene \n"




int nrows = 10
int ncols = 10

// our elevation files usually in NED directory 

if (scmp(ned_stem,"NED/",4)) {
  ned_stem = spat(ned_stem,"NED/",1)
}


<<"input  NED directory is $ned_stem \n"

map_ul_lat = 0.0
map_ul_long = 0.0
map_deg = 1.0

Svar Wd

  nf = ofr("/home/mark/GLIDE/NED/$ned_stem/${ned_stem}.blw")

  if (nf == -1) {

  nf = ofr("/home/mark/NED/$ned_stem/${ned_stem}.blw")

  if (nf == -1) {
     <<" can't open ${ned_stem}.blw \n"
     stop!
  }

  }



   nwr=Wd->Read(nf)

<<"%V$nwr \n"

   map_deg = atof(Wd[0])

<<"%V$map_deg \n"



   nwr=Wd->Read(nf)
   nwr=Wd->Read(nf,3)

   map_ul_long = atof(Wd[0])
   map_ul_long *= -1

<<"  $map_ul_long \n"

   nwr=Wd->Read(nf)
   map_ul_lat = atof(Wd[0])

<<" $map_ul_lat $map_ul_long $map_deg \n"

   cf(nf)

   nf = ofr("/home/mark/GLIDE/NED/$ned_stem/${ned_stem}.hdr")

   nwr=Wd->Read(nf,2)


   nrows = atoi(Wd[1])
  //<<"$nrows \n"

   nwr=Wd->Read(nf)
  //<<" $Wd \n"
   ncols = atoi(Wd[1])

  //<<" %V $nrows $ncols \n"

   Map = ReadBIL("/home/mark/GLIDE/NED/$ned_stem/${ned_stem}.bil", nrows, ncols)



<<"%V$map_ul_lat $map_ul_long $map_deg\n"


    mapok = SetWgrid(Map,map_ul_lat,map_ul_long, map_deg)

<<"%V$mapok Dmn $(Cab(Map)) Sz $(Caz(Map)) \n"

   wg =GetWgrid()

 <<"%V$wg \n"




 LatN=wg[0]
 LongW=wg[1]

 LatS = LatN - (wg[2] * wg[5])
 LongE = LongW - (wg[2] * wg[6])

 <<"%V$LatN $LongW $LatS $LongE \n"


 setgwob(mapwo, "scales", LongW, LatS, LongE, LatN )



mh = getElev( LatN,LongW)

<<"%V$mh \n"


mh = getElev( LatS,LongE)

<<"%V$mh \n"

Lat_mid = (LatN-LatS)/2.0 + LatN
Long_mid = (LongW-LongE)/2.0 + LongE


mh = getElev( Lat_mid,Long_mid)

<<"%V$Lat_mid  $Long_mid $mh \n"

 for (j = 0; j < 10; j++) {

<<"$Map[0][j] "

 }

<<"\n"


Track = getTrack(LatN,LongW,LatS,LongE)

sz= Caz(Track)
dmn = Cab(Track)

<<"%V$sz $dmn \n"

 for (j = 0; j < 10; j++) {

  <<"$Track[j][0] $Track[j][1]\n "

 }


 Elev = getElev(Track)

sz= Caz(Elev)
dmn = Cab(Elev)

<<"%V$sz $dmn \n"



A=ofw("ElevNW_SE")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

Track = getTrack(LatS,LongW,LatN,LongE)
Elev = getElev(Track)

A=ofw("ElevSW_NE")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

PTrack = parallelTrack(Track,-90,20)
Elev = getElev(PTrack)

A=ofw("ElevSW_NE_PL")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

<<"MAP \n"

 for (j = 0; j < 10; j++) {

<<"$Map[0][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$Map[1][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$Map[2][j] "

 }

<<"\n"


short SG[128][128]


   SG[0][::] = Map[0][0:127]
   SG[1][::] = Map[1][0:127]

<<"SG \n"

 for (j = 0; j < 10; j++) {

<<"$SG[0][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$SG[1][j] "

 }

<<"\n"



   SG[0:127][::] = Map[0:127][0:127]


 for (j = 0; j < 10; j++) {

<<"$SG[2][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$SG[3][j] "

 }

<<"\n"


//  get a subset of the Wgrid for display as a Matrix Object!
   offr = 10
   offc = 200
   er = offr+127
   ec = offc+127

   SG[0:127][::] = Map[offr:er][offc:ec]

 for (j = 0; j < 10; j++) {

<<"$SG[3][j] "

 }

<<"\n"




stop!
