


/// TDB FIX 




float SpeechThres = 4.9

last_rbv = 0

int recblksz = 256

<<" %v $recblksz \n"

//ip = iread()
crv = 0
proc RecVox( mv, spi )
{
<<" calling recvox $crv\n"
int wb
  crv++
  dorec = 0
<<" $mv > $SpeechThres \n"

//<<" doing iread \n"
//  mv = iread("enter $mv ")

  if (mv > SpeechThres) {

<<"%V $spi $recblksz \n"


  wb= spi / recblksz
  hmb = wb - last_rbv
// want to record this block - plus upto 3? prior unrecorded blocks

     dorec = 1

    if (hmb > 0 ) {

       nb2r = hmb

    if (hmb > 3) {
       nb2r = 3
    }

    wbs = (wb - hmb +1) * recblksz

    wbe = wbs + nb2r * recblksz -1

//    w_data(voxfd,Sbuf[wbs:wbe])

<<"\n $dorec  $mv $wb  $wbs $wbe ---> vox \n"
    

    }

    last_rbv = wb

  }

  <<" return %v $dorec \n"

     return dorec
}

proc DisplayBuff()
{
 
mv = -4.0
st = 1024
  for (j = 0 ; j < 3; j++) {

     mvt = RecVox( mv, st)
      <<" %V $mv $mvt \n"
   st += 512
   mv += 0.5
 }
 


}

mv = 4.0
float mvt

  for (j = 0 ; j < 3; j++) {

     mvt = RecVox( mv, 1024)

      <<" %V $mv $mvt \n"
   mv += 0.5
 }


// DisplayBuff()





STOP!
