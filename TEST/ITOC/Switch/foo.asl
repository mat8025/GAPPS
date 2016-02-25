int k

  v = _argv[0]

  k = atoi(_argv[1])

<<"%V$_argv[::] \n"

<<"%V$_argv[0] \n"

<<"%V$v \n"

<<"%V$k \n"


<<" %V$_argv[::] \n"
nv = ""
  if (k == 1) {

<<"k1 %V$k \n"
   nas = _argv
<<" nas set \n"
   nv = nas[0]
<<"%V $nv \n"
<<" $nas[0]  \n"

<<"k1 %V$_argv[::] \n"

  }


<<" in between \n"

  if (k == 2) {

<<"k2 \n"
<<"k2 %V$_argv[::] \n"

  }



<<"DONE \n"
