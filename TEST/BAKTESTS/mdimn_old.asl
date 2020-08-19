SetDebug(1)


int trki = 0

proc SetTrack(x,y,z)
{
  Track[trki][0] = x
  Track[trki][1] = y
  Track[trki][2] = z

}



float Track[15+][3]


<<" $(Cab(Track)) \n"

obpx = 1.0
obpy = 2.0
obpz = 3.0


  for (i = 0; i < 10 ; i++) {


   SetTrack(obpx,obpy,obpz)
   obpx += 0.5
   obpy += 0.7
   obpz -= 0.4
  trki++
  }



// FIX
     trkX= Track[*][0]
     trkY= Track[*][1]
     trkZ= Track[*][2]





<<"%v \n$trkX \n\n"

<<"%v \n$trkY \n\n"

<<"%v \n$trkZ \n\n"

<<"\n %r $Track[*][*] \n"


STOP!