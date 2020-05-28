//

tc = 180.0       // deg
dist = 500.0  // km

lata_d = -20.0
lnga_d = 90.0

/{
newpos = latlongfromtcopad(tc,lata_d,lnga_d,dist)

<<"$newpos \n"

latb_d = newpos[0]

<<"%V$latb_d \n"
lngb_d = newpos[1]
/}



radial = tc

<<"inputs %V$radial $lata_d $lnga_d $dist \n"

newpos = latlongfromradialopad(radial,lata_d,lnga_d,dist)

<<"$newpos \n"

latb_d = newpos[0]

//<<"%V$latb_d \n"

lngb_d = newpos[1]

//<<"%V$lngb_d \n"

chk_radial = newpos[2]

//<<"%V$chk_radial \n"

chk_dist = newpos[3]

//<<"%V$chk_dist \n"

<<"outputs %V$chk_radial $latb_d $lngb_d $chk_dist \n"
