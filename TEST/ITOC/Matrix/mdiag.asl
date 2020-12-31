//%*********************************************** 
//*  @script mdiag.asl 
//* 
//*  @comment test Mdiag func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/*
mdiag
M=mdiag(V)
take a vector and make it as leading diagonal of a square matrix 
other elements are zero
*/

#include "debug.asl"
debugON()
//  diag

chkIn()

// print out 2D mat easily ?


float a = 3.14159
<<"%5.2f \n"
<<"%v4.2f $a\n"
<<"%V4.2f$a \n"
<<"%5.2f g \n"


float e[] = {1.1,2.2,3.3,4.4}

<<"%5.3f <${e}> \n\n"
<<"<%5.3f${e}> \n\n"
<<"%5.3f <${e}> \n\n"
<<"<${e}>\n"

nd = cnd(e)

<<"e %V $nd\n"

 E = mdiag(e)

 nd = cnd(E)

<<"E %V $nd\n"

<<"Bounds $(Cab(E)) \n"
<<"Size   $(Caz(E)) \n"

<<"%(4, , ,\n)%6.2f$E \n"

<<"\n %V$E[0][0] \n"
<<"\n %V$E[1][1] \n"
<<"\n %V$E[2][2] \n"
<<"\n %V$E[3][3] \n"

   vv = 1.1

   chkR(E[0][0],vv,6)
   chkR(E[1][1],2.2,6)
   chkR(E[2][2],3.3,6)
   chkR(E[3][3],4.4,6)

   for(i= 0; i < 4; i++) {
      for (j=0;j<4;j++) {
        if (j != i) {
        chkR(E[i][j],0.0,6)
	}
     }
    }

   chkOut()

exit()


