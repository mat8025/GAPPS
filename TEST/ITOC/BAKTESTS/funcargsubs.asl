

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


 CepWt = Fgen(Csz,0.1, 25/Csz)

 <<" $CepWt \n"

 Lwt = Log10(CepWt)

<<"LOG10: $Lwt \n"


 Slwt = Log10(CepWt[0:3])

<<"LOG10: $Slwt \n"

 int j = 0
 int k = 3

 while (j < 3) {

 Slwt = Log10(CepWt[j:k])

<<"LOG10: $j : $k $Slwt \n"

 j++
 k++
 }


STOP!


 i = 1.0
 while (i < 20) {

 f = i/Csz

 CepWt = Fgen(Csz,0, i/Csz)


 <<"$i $f --> $CepWt \n"

 i++
 }



STOP!
