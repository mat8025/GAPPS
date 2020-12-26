//%*********************************************** 
//*  @script top.asl 
//* 
//*  @comment Test  transcendental funcs Sin,Cos ... 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Thu Dec 24 09:58:43 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

chkIn(_dblevel)

y = Sin(0)

<<"$y \n"
chkR(y,0.0)

y = Cos(0)

<<"$y \n"
chkR(y,1.0)
y = Tan(1.0)

<<"$y \n"

chkR(y,1.557408)

msg=whatis("Cos")
<<"$msg \n"

msg=whatis("sinh")
<<"$msg \n"

msg=whatis("exp")
<<"$msg \n"

y = Exp(1.0);

<<"$y \n"
<<"$y $(whatis(\"exp\"))\n"
y = Exp(1.0) * 2.0;

<<"$y \n"

pi1 = 2.0 * Atan(1.0);

chkR(pi1,(3.141593/2))
<<"pi $pi1\n"

pi = Atan(1.0) * 4.0;

<<"pi $pi\n"

chkR(pi,3.141593)

chkOut()


/*

bug xic y = Exp(1.0) * 2.0; returns 2.0 ???

*/