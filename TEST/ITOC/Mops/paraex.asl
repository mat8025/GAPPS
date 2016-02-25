#! /usr/local/GASP/bin/asl

int ok = 0
int bad = 0
int ntest = 0

OpenDll("math")

YV = FGen(10,0,1)


<<" $YV \n"

R = YV[1:3]

<<" $(YV[1:3]) \n"

<<" $YV[0:3] \n"

<<" $R \n"

<<" DONE \n"

STOP!
