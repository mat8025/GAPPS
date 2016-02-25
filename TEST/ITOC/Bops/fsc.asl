

 xp = 0.9
 yp = -0.3

<<"first entry val  %V $xp $yp \n"
iread()

    if (yp  < -1.0) {

     <<"reset yp @ $yp  < -1.0 \n"

      yp = 1.0
    }


   k = 0

   while (1) {

   <<" %V $xp $yp \n"
    xp += 0.2
    yp -= 0.2

    iread()

    if (yp  < -1.0) {

     <<"reset yp @ $yp  < -1.0 \n"

      yp = 1.0
    }

    if (xp  > 1.0) {

     <<"reset xp @ $xp  > 1.0 \n"

      xp = -1.0
    }

    if (k++ > 10)
       break

   }
<<" break @ $k \n"

;