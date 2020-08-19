
opendll("image")

gcontour gc[3]

<<"$(typeof (gc)) \n"

 setgcontour(&gc[0],47,79)

 setgcontour(&gc[1],80,28)

short x
short y

bscan(&gc[0],0,&x,&y)
<<"%V$x $y \n"

bscan(&gc[1],0,&x,&y)
<<"%V$x $y \n"

gcontour gc1

 setgcontour(&gc1,12,14)

bscan(&gc1,0,&x,&y)
<<"%V$x $y \n"

