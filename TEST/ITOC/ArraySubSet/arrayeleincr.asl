

/// 
<|Use_=
 test incr of vec element
/////////////////////// 
|>


#include "debug"

if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn()


ignoreErrors()


<<" $Use_\n"

//float XYP[]  = {770,1.65,910,1.65,1000,1.65,945,1.81,760,1.81,755,1.65};
float  XYP[]  = {770,1.65,910,1.65,1000,1.65,945,1.81,760,1.81,755,1.65};

BXYP = XYP

//!z XYP



dx= XYP[0];

//!? dx


dx +=4;


XYP[0] = dx;

//!z XYP


XYP[1] = XYP[1] -0.1
dx = 4.0;
XYP[0] = XYP[0] + dx;





XYP[1] -= 0.1;   // TBF  check no opera promotion


chkN(XYP[2],910);


XYP= BXYP

  XYP.pinfo()

// this works !!
XYP[0:11:2] += 5;
XYP[1:11:2] += 0.05;


  XYP.pinfo()


int  MNP[]  = {770,165,910,165,1000,165,945,181,760,181,755,165};

 MNP.pinfo()


MNP [1] -= 2 ;   


 MNP.pinfo()


chkN(MNP[2],910);

<<"$MNP\n"

chkOut()
