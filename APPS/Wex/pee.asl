
# PeeFrq

bmt = "p"
val = "1"

dt = date()

<<" $dt  $bmt $val\n"

fname ="peefrq.dat"
sz=f_exist(fname, 0,1)
 
if (sz == -1) {
A=o_file(fname,"w+")
}
else { 
A=o_file(fname,"r+") ;
}

//<<" %V $A\n"

f_seek(A,0,2)

<<[A],"$dt $bmt $val\n"
f_seek(A,0,0)

C=readfile(A)

cf(A)

<<" $C \n"

