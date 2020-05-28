

float Psp[20]

 for (i = 0; i < 20 ; i++) {

 Psp =fgen(20,i,1)


sz = Cab(Psp)

<<"$sz : %6.1f$Psp \n"


 tmp = Psp

Redimn(tmp,5,4)

sz = Cab(tmp)

 <<"$sz : %6.1f$tmp\n"


 Fbank = Sum(tmp,0)

sz = Cab(Fbank)

<<"$sz : %6.1f$Fbank \n"


  Redimn(Fbank)


sz = Cab(Fbank)

<<"$sz : %6.1f$Fbank \n"

}