SetPCW("writepic","writeexe")
SetDebug(1)

ds = 4
ls = 55
<<"%I $ds $ls\n"


dt = (ds-ls)

<<"%i $dt \n"


dtx = abs(ds-ls)


<<"%i $dtx \n"

f  = ds/ls

<<"%i $f \n"

STOP!