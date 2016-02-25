

int ADA[12+] 

<<" $ADA \n"
ADA[0:28:2] = 1
<<" $ADA \n"
// test array indexing

N = 15

 Csz = N

<<" $N $Csz \n"

 f = 20/Csz

<<" $f \n"


// CepWt = Fgen(Csz,0, f)
// <<" $CepWt \n"

 CepWt = Fgen(Csz,0, 25/Csz)


 <<" $CepWt \n"
 i = 1.0
 while (i < 20) {

 f = i/Csz

 CepWt = Fgen(Csz,0, i/Csz)


 <<"$i $f --> $CepWt \n"

 i++
 }



STOP!
