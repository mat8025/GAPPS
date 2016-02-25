#! /usr/local/GASP/bin/asl



// internal member functions


s= $2

<<" $s \n"

sdw = DeWhite(s)

<<" <${sdw}> \n"

 s->DeWhite()

<<" $s \n"

 s->Reverse()

<<" $s \n"


STOP("DONE \n")
