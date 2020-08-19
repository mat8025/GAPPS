#! /usr/local/GASP/bin/asl

OpenDll("math")

Rreal = Fgen(10,1,1)



<<" $Rreal \n"

<<" $Rreal[0:5] \n"


specsz = 5

<<" $Rreal[0:specsz] \n"

	Rlogspec = log10(Rreal[0 : specsz ]) * 10.0


<<" $Rlogspec \n"

<<" ${Rreal}[0:specsz] \n"
STOP!
