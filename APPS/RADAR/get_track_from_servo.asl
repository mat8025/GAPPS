

// this is a must do --- to read in NED -- 1 arc second approx 30 m resolution

ned_dir= _clarg[1]

int nrows = 10
int ncols = 10

// our elevation files usually in NED directory 


ned_stem = spat(ned_dir,"NED/",1)

ned_dir = scat(spat(ned_dir,"NED/",-1),"NED")

<<"input  %V$ned_dir  $ned_stem \n"




map_ul_lat = 0.0
map_ul_long = 0.0
map_deg = 1.0

Svar Wd



  nf = ofr("$ned_dir/$ned_stem/${ned_stem}.blw")

  if (nf == -1) {
     <<" can't open ${ned_stem}.blw \n"
     stop!
  }



   nwr=Wd->Read(nf)

<<"%V$nwr \n"

   map_deg = atof(Wd[0])

<<"%V$map_deg \n"



   nwr=Wd->Read(nf)
   nwr=Wd->Read(nf,3)

<<" read_blw $Wd[0] $Wd[1]\n"

   map_ul_long = atof(Wd[0])


<<"  $map_ul_long \n"

   nwr=Wd->Read(nf)

   map_ul_lat = atof(Wd[0])

<<" $map_ul_lat $map_ul_long $map_deg \n"

   cf(nf)

   nf = ofr("$ned_dir/$ned_stem/${ned_stem}.hdr")

   nwr=Wd->Read(nf,2)


   nrows = atoi(Wd[1])
  //<<"$nrows \n"

   nwr=Wd->Read(nf)
  //<<" $Wd \n"
   ncols = atoi(Wd[1])

  //<<" %V $nrows $ncols \n"

   Map = ReadBIL("$ned_dir/$ned_stem/${ned_stem}.bil", nrows, ncols)



<<"%V$map_ul_lat $map_ul_long $map_deg\n"

//i_read()

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


i_read(" read in track file ")


servo_f= _clarg[2]

A=ofr(servo_f)

if (A == -1) {
  stop("bad file!")
}


R = ReadRecord(A,@type,FLOAT)

sz = Caz(R)

<<"%V$sz \n"



<<"%(2,, ,\n)${R[0:5][3,4]} "

Track = R[::][3,4]

//<<"%(2,, ,\n)$Track "

 for (j = 0; j < 10; j++) {

  <<"$Track[j][0] $Track[j][1]\n "

 }


mm= stats(Track[::][0])

<<"%V$mm \n"

mm= stats(Track[::][1])

<<"%V$mm \n"

stop!

Elev = getElev(Track)

sz= Caz(Elev)
dmn = Cab(Elev)

<<"%V$sz $dmn \n"

<<"%(1,, ,\n)6.0f$Elev"

A=ofw("Flight_elev")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)



stop!