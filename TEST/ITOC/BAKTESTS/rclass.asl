///
setdebug(1,"trace")




class Rec {

 public:
    svar srec;

}




Rec FI[10];


 FI[0]->srec = Split("how did we get here")

 FI[1]->srec = Split("just evolved with many trials")



 r00 = FI[0]->srec[0];

 r01 = FI[0]->srec[1];

 r02 = FI[0]->srec[2];


<<"%V $r00 $r01 $r02\n"


 r10 = FI[1]->srec[0];

 r11 = FI[1]->srec[1];

 r12 = FI[1]->srec[2];


<<"%V $r10 $r11 $r12\n"


