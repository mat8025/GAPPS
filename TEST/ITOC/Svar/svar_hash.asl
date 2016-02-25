

Svar  H = { "Sun", "Sunday",\
            "Mon", "Monday",\
            "Tue", "Tuesday" ,\
            "Wed", "Wednesday",\
            "Thu", "Thursday",\
            "Fri", "Friday",\
            "Sat",  "Saturday"           };




<<"%(2,\t--, ,--\n)$H \n"

wd = H->LookUp("Wed")


<<"  $wd $(typeof(wd))\n"


//  FIXME
//<<" $(H->LookUp(\"Sat\")) \n"
// FIXME
//<<" $(H->LookUp('Sat')) \n"


wd = H->LookUp("Thu")

<<" $wd $(typeof(wd))\n"


wd = H->LookUp("Thx")

<<" $wd $(typeof(wd))\n"


stop!
;

