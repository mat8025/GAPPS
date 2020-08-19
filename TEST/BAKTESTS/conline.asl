
setdebug(0)

int n = 4


V0 = " Happy days are here again, \
      the skies above are clear again, \
      So let's sing a song of cheer again, \
      Happy days are here again, \
,                         \
      Altogether shout it now, \
      There's no one Who can doubt it now, \
      So let's tell the world about it now, \
      Happy days are here again" ;

//<<"%s $V0 \n"

m = Split(V0,",")
n= Caz(m)
<<" %v $n \n"



//<<" $m[0] \n"
//<<" $m[1] \n"
//<<" $m[2] \n"


<<" %1\nR $m \n"

I = Igen(10,0,2)

<<" %2\nR $I \n"

stop!


V1 = " Happy days are here again \
      the skies above are clear again \
      So let's sing a song of cheer again \
      Happy days are here again ";

<<" $V1 \n"




V2 = "                       \
      Altogether shout it now \
      There's no one Who can doubt it now \
      So let's tell the world about it now \
      Happy days are here again" ;

<<" $V2 \n"


T = V1 @+ V2


<<" $T \n"


Stop!


;
