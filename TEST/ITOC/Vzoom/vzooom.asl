SetDebug(1)
opendll("math","stat")

 F = Vgen(DOUBLE,8,0,1)

 fsz = Caz(F)

<<"%V$fsz $(typeof(F))\n"

<<"$F \n"

 G = vzoom(F,15)

 gsz = Caz(G)

<<"%V$gsz $(typeof(G))\n"

<<"$G\n"