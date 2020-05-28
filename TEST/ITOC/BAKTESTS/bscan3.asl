
opendll("image")
short x
short y
char idrn
char curve
char lev
char code


Gcontour gc[3]

   setcontour(&gc[0],2,3,4)


   bscan(&gc[0],0,&x,&y,&idrn,&curve,&lev,&code)


<<"%V $x $y $idrn $curve $lev $code\n"



Gcontour sgc

   setcontour(&sgc,6,7,47)

   bscan(&sgc,0,&x,&y,&idrn,&curve,&lev,&code)

<<"%V $x $y $idrn $curve $lev $code\n"