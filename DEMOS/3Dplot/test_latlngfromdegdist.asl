setdebug(1)
   LatN= 40.0;
   LongW = -106.0
   LatS = 38.0;
   LongE= -105.0
   


<<"%V $LatN $LongW $LatS $LongE \n"

    ll= latlongfromradialopad(130.0, LatN,LongW,3)

<<"%V$ll \n"

    ll= latlongfromradialopad(130.0, LatN,-LongW,3)

<<"%V$ll \n"


    ll= latlongfromradialopad(350.0, LatN,LongW,3)

<<"%V$ll \n"

    ll= latlongfromradialopad(350.0, LatN,-LongW,3)

<<"%V$ll \n"
