//%*********************************************** 
//*  @script unaryexp.asl 
//* 
//*  @comment test unary syntax 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.100 C-He-Fm]                               
//*  @date Sat Dec 26 23:26:26 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

chkIn()

r = 1.0

<<"%V $r \n"

rspo2 = -8.5 * r * r  

<<" %v $rspo2 \n"

chkR(rspo2,-8.5)

rspo2 = +8.5 * r * r  

<<" %v $rspo2 \n"

chkR(rspo2,8.5)


rspo2 = -8.5 * r * r  + -14.6 

<<" %v $rspo2 \n"

chkR(rspo2,-23.1)


rspo2 = -8.5 * r * r + -14.6 * r 

<<"%V $rspo2 \n"
chkR(rspo2,-23.1)

rspo2 = -8.5 * r * r + -14.6 * r + 108.25 

chkR(rspo2,85.15)
<<"%V $rspo2 \n"

rspo2 = -8.5 * r * r + -14.6 * r + (+107.25) 

chkR(rspo2,84.15)
<<"%V $rspo2 \n"

rspo2 = -8.5 * r * r + -14.6 * r + -107.25 

chkR(rspo2,-130.35)
<<"%V $rspo2 \n"

rspo2 = -8.5 * r * r + -14.6 * r - -107.25 

chkR(rspo2,84.15)
<<"%V $rspo2 \n"


chkOut()

