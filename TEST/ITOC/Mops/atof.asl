#! /usr/local/GASP/bin/asl
#/* -*- c -*- */


A= Split($2)

<<" $A \n"

F=Atof(A)


<<" $F \n"

G = Atof(Split($2))

<<" $G \n"


I = Atoi(Split($2))

<<" $I \n"

STOP!
