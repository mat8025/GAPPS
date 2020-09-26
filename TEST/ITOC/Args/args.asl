//%*********************************************** 
//*  @script args.asl 
//* 
//*  @comment test args processing 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.73 C-He-Ta]                               
//*  @date Tue Sep 22 06:42:12 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///
///



include "debug";

sdb(_dblevel,@trace)

if (_dblevel >0) {
   debugON()
}

//filterFuncDebug(ALLOW_,"Setup","opera_f","Cmath","storeScalar","storeSiv","Pluseq","l_3",\
//"l_1","l_2","l_4","l1_store","l1_opera","resolveResult","Variable","setLho","setRho","findSiv",\
//"checkProcVars","FindVar","Get","Number","primitive","primitive_store_var","getExp");

//filterFuncDebug(ALLOWALL_,"Setup")

filterFileDebug(ALLOWALL_,"xxx")


filterFuncDebug(ALLOW_,"CheckProcFunc")
filterFuncDebug(ALLOWALL_,"xxx")

//openDll("plot")
//include "graphic"


char c = '?';

float f = atan(1.0) *4;

F=vgen(INT_,5,20,1)
D = vgen(FLOAT_,20,10,1)

D->redimn(2,5,2)

//svar help="Ayudame ahora"
svar help

help[0] = "Ayudame ahora";
help[1] = "que esta pasando?";

//Pan P = exp(1.0); // TBF

Pan R;
R = exp(1.0);

P = &R;

 k = 0
 
 A = testargs(k++,help,47,f,"hey",1.2,1,',',"*",c,F,D,R,P,@hue,"red",&F[2])



<<"%(1,-->, , \n)$A\n"
//asn=iread(":");
//<<"%(1,,,\n)$A\n"


<<"%V$k \n"
chkN(k,1)
 int b = ',';

<<"%V %c $b $(',') $c\n"

for (i = 0; i <10; i++) {
<<"<$i> value $A[i] \n"
}

ans = A[11];

chkStr(ans,"47")

<<"$help\n"

 c_index = 0;
 ret=testargs(c_index++)

<<"%V$c_index \n"
chkN(c_index,1)

 c_index = 0;
 setRGB(++c_index)

<<"%V$c_index \n"
chkN(c_index,1)



chkOut();