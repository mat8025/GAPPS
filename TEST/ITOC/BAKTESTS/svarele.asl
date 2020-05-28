///
/// test svar indexing
///

proc poo( pval	)
{
<<" $_proc $pval \n"

<<" $pval[0] \n"

<<" $pval[1] \n"

<<" finding pval size \n"

   psz = Caz(pval)

<<" %v $psz \n"
   lv = pval
<<" %v $lv \n"

   if (psz > 3) {
   av = pval[2]

<<" got proc svar ele 2 $av \n"

   av = pval[3]

<<" got proc svar ele 3 $av \n"
  }

<<" exit $_proc $pval \n"
}

checkIn()

int k

<<" %v $k \n"

I = Igen(10,5,1)

<<" $I \n"

<<" $I[1:5] \n"

V= I[0:8:2]

<<" $V \n"

Y = I[3,4,7]

<<" $Y \n"

j = 1
Y = I[3,j,7]
<<" $Y \n"
 while (j++ < 10) {
Y = I[3,j,7]
<<"$j $Y \n"
 }





svar W
<<" %v $W \n"


W[0] = "Calm"
sz= Caz(W)
<<"$sz $W\n"

w = W[0]
<<"%v $w \n"


W[1] = "Down"
sz= Caz(W)
<<"$sz $W\n"
w = W[1]
<<"%v $w \n"

W[3] = "Focus"
sz= Caz(W)
<<"$sz $W\n"
W[2] = "and"
sz= Caz(W)
<<"$sz $W\n"
W[4] = "gobbledygook"
sz= Caz(W)
<<"$sz $W\n"
W[5] = "all"
<<"$(Caz(w)) $W\n"
ans=iread()
W[6] = "speed"
W[7] = "up"
W[8] = "why"
W[9] = "not"
W[10] = "Me"

w = W[0]

<<"%v $w \n"
<<" %v $W \n"
<<" %v $W[3] \n"
<<" %v $W[*] \n"

 W->Sort()

<<" %v $W \n"

<<" $W[1:7:2] \n"

j = 8;

T= W[1:j-2:2]

<<"%I $T \n"

j = 0

<<"$W\n"
U= W[1,j,3]

<<"$j $U \n"
ans=iread()

while (j++ < 7) {

U= W[1,j,3]

<<"$j $U \n"
}

checkOut()
exit()

svar S

S[0] = "Stay"
S[1] = "Focused"
S[2] = "Kool"
S[3] = "and"
S[4] = "Collected"

<<" show sen \n"
<<" $S \n"
sz = Caz(S)


svar val

 val = W[0]

<<" $val $W[0] \n"

 val = W[1]

<<" $val $W[1] \n"

<<"calling with $S \n"
 poo(S)
<<" not moving on ?? \n"

<<"after calling with $S \n"



<<"now calling with $W \n"
 poo(W)
<<"after calling with $W \n"

STOP("DONE !\n")
 poo(val)








STOP("DONE!")


S = "once upon a time in the Kingdom of Arthur ruler of the Britons"
<<" $S \n"
P = split(S)

<<" $P \n"

N=Caz(P)

<<" $N words \n"

W=split("once upon a time in the Kingdom of Arthur ruler of the Britons")

<<" $W \n"

N=Caz(W)

<<" $N words \n"

 val = W[0]
<<"0 $val \n"

 val = W[1]
<<"1 $val \n"

 vi = 3

 val = W[vi]
<<"$vi $val \n"



<<" ${W[0:5]} \n"

int nloop = 0

while ( nloop < N) {

   val = W[nloop]

  <<"$nloop  $val \n"

 nloop++
}




<<" DONE \n"
STOP!
