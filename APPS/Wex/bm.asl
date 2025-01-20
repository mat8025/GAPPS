# BodyMeasure




bmt = "p"
val = "1"
<<" p = pee, w = weight , m = waist, g = gki "
bmt = ask("p,w,m,g: ",1)
if (bmt == "p") {
   val = "1"
   }
else {
 val = ask("$bmt value? ",1)
}

dt = date()

<<" $dt  $bmt $val\n"

fname ="bodymeasures.dat"
sz=f_exist(fname, 0,1)
 
if (sz == -1)
A=o_file("bodymeasures.dat","w+") ;
else 
A=o_file("bodymeasures.dat","r+") ;

//<<" %V $A\n"

f_seek(A,0,2)

<<[A],"$dt $bmt $val\n"
f_seek(A,0,0)

C=readfile(A)

cf(A)

<<" $C \n"