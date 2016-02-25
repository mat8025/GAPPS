#! /usr/local/GASP/bin/asl


dir = $2
la = 1

<<" %I $dir $la \n"

    if (dir @= "E") {
         la *= -1
      }

    if (dir @= "S") {
           la *= -1
	     }

<<" %I $dir $la \n"

la = 1

<<" %I $dir $la \n"

    if ((dir @= "E") || (dir @= "S")) {
         la *= -1
      }


<<" %I $dir $la \n"
la = 1
<<" %I $dir $la \n"
// FIX
    if ( dir @= "E" || dir @= "S") {
         la *= -1
      }


<<" %I $dir $la \n"


  STOP("DONE!\n")

proc ValidO2(eo2)
{
min = 20.0
max = 105
rtval = 0

  if ((eo2 > 20.0) && (eo2 < 101) && (rtval == 0)) {
<<"$_cproc  $eo2 is valid!! using and test\n"
        return 2
	  }
//  else {
<<"$_cproc $eo2 is invalid  using and test\n"
//        return rtval
//  }

//  Gmin = 21
        return rtval
}


proc RValidO2(eo2)
{
min = 20.0
max = 105
rtval = 0

  if ((eo2 > 20.0) && (eo2 < 101) && (rtval == 0)) {
<<"$_cproc  $eo2 is valid!! using and test\n"
        rtval = 1
	  }
  else {
<<"$_cproc $eo2 is invalid  using and test\n"
        rtval = 0
  }

//  Gmin = 21
        return rtval
}





Gmin = 17
vo2 = 115.0
vo2 = 100.0


 while ( vo2 < 130) {

  if ((vo2 > 20.0) && (vo2 < 101) && (Gmin == 17)) {
<<" $vo2 is valid !  $Gmin\n"
 }
 else {
<<" $vo2 is invalid ! \n"

     

 }

 ok = ValidO2(vo2)

<<"%V $vo2 $ok $Gmin \n"

 ok = RValidO2(vo2)

<<"%V $vo2 $ok $Gmin \n"

  vo2 += 5

}



STOP!

vo2 = -5.0

  if ((vo2 > 20.0) && (vo2 < 101)) {
<<" $vo2 is valid ! \n"
 }
 else {
<<" $vo2 is invalid ! \n"

 }

 ok = ValidO2(vo2)

<<"%V $vo2 $ok $Gmin \n"

vo2 = 86.0

  if ((vo2 > 20.0) && (vo2 < 101)) {
<<" $vo2 is valid ! \n"
 }
 else {
<<" $vo2 is invalid ! \n"

 }

 ok = ValidO2(vo2)

<<"%V $vo2 $ok $Gmin \n"

vo2 = 120.0

  if ((vo2 > 20.0) && (vo2 < 101) && (Gmin == 17)) {
<<" $vo2 is valid ! \n"
 }
 else {
<<" $vo2 is invalid ! \n"

 }

 ok = ValidO2(vo2)

<<" %V $vo2 $ok $Gmin \n"


STOP!





  vo2 = -5
 int i = 0

 while (vo2 < 120) {
 i++

<<" %V now $vo2 \n"
 ok = ValidO2(vo2)

<<"$i %V $vo2 $ok $Gmin \n"

    vo2 += 7

}

STOP!
