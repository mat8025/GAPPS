#! /usr/local/GASP/bin/asl
#/* -*- c -*- */


Red = 2


<<" $Red \n"

<<"\$Red \n"

name= "$Red"
      len = slen(name)
<<" $name $len\n"


name2= "\$Red"

      len = slen(name2)

<<" %v <${name2}> $len \n"


<<" DONE \n"
STOP!
