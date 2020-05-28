// test quicksort

opendll("math")

 N= atoi(_clarg[1])

<<"%V$N\n"

 I = vgen(INT_,100,0,1)

 I[5] = 47

<<"$I \n"


 I->shuffle(100)

<<"$I \n"

 quicksort(I)



<<"$I \n"



 F = vgen(FLOAT_,N,0,1)

 F[5] = 47

//<<"$F \n"

 F->shuffle(200)

//<<"$F \n"
T=fineTime()

 bubble(F)

bdt=fineTimeSince(T)
<<"Bubble $(bdt/1000.0) msec\n"

 F->shuffle(200)

//<<"$F \n"
T=fineTime()
 quicksort(F)
qdt=fineTimeSince(T)
<<"Quick $(qdt/1000.0) msec\n"


if (qdt < bdt) {
x = Log10(N)
<<"quick won! $N elements  $(N*x)  $((bdt-qdt)/1000.0)\n"
}
else {

<<"bubble won! $N elements $(N*N) $((qdt-bdt)/1000.0)\n"
}


//<<"$F \n"

