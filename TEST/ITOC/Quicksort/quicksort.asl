/* 
 *  @script quicksort.asl 
 * 
 *  @comment test Qsort vs Bubble  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.7 C-Li-N]                                  
 *  @date Fri Jan  8 11:14:35 2021 
 *  @cdate 1/1/2002 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"

filterFileDebug(REJECT_,"array_","exp","store","tok","args")

chkIn()

// test quicksort

//opendll("math")
 N = 100;
 fa=_clarg[1]
 <<"$fa \n"
 if (!( fa @="")) {
 N= atoi(_clarg[1])
}
<<"%V$N\n"

 I = vgen(INT_,100,0,1)

// I[5] = 47

<<"$I \n"


 I->shuffle(100)

<<"$I \n"

 quicksort(I)



<<"$I \n"



 F = vgen(FLOAT_,N,0,1)

// F[5] = 47

//<<"$F \n"

 F.shuffle(200)

//<<"$F \n"
T=fineTime()

 bubble(F)

bdt=fineTimeSince(T)
<<"Bubble $(bdt/1000.0) msec\n"

 F.shuffle(200)

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

chkN(F[0],0)

chkN(F[1],1)
F.pinfo()

f = F[7];

<<"%V $f $F[7]\n"

chkN(F[7],7)




F.pinfo()
int q= 8;

chkN(F[q],8)




chkN(F[N-1],N-1)

f = F[N-1]

chkN(f,N-1)

<<"%V $N $F[0]  $F[1] $F[N-1]\n"

chkOut()

//<<"$F \n"

