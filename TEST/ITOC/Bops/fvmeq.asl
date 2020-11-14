//%*********************************************** 
//*  @script fvmeq.asl 
//* 
//*  @comment test basic ops  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Thu Mar  7 23:24:30 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug"


debugOFF()

chkIn(_dblevel)



na = argc()

if (na >= 1) {
 for (i = 0; i < argc() ; i++) {
<<"arg $i $_clarg[i] \n"
 }
}


F =vgen(FLOAT_,10,0,1)

<<"%V $F \n"


chkR(F[1],1.0,6)
chkR(F[9],9.0,6)


<<" vec -= 1.5 \n"

  F -= 1.5

<<"%V $F \n"

chkR(F[1],-0.5,6)
chkR(F[9],7.5,6)

 F += 1.5

<<"%V $F \n"

chkR(F[1],1.0,6)
chkR(F[9],9.0,6)


 F *= 2.0

<<"%V $F \n"

chkR(F[1],2.0,6)
chkR(F[9],18.0,6)

 F /= 2.0

<<"%V $F \n"

chkR(F[1],1.0,6)
chkR(F[9],9.0,6)


chkOut()

