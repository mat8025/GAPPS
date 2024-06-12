//%*********************************************** 
//*  @script vmf-white.asl 
//* 
//*  @comment test vmf - var member function 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Mon Apr 13 11:35:45 2020 
//*  @cdate Sat Apr 11 23:11:04 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

<|Use_=
Dewhite(S)
Dewhites a string variable (or array of strings)
S->Dewhite() - dewhites a string
S[a:b]->Dewhite()
would dewhite a range of an array of strings - where S is an array 
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_ \n"       
}

//filterFileDebug(REJECT_,"scopesindex_e.cpp","array_parse.cpp");
//filterFuncDebug(REJECT_,"~storeSiv","checkProcFunc");

chkIn()



svar SV;

SV[0] = "hey now"
SV[1] = "dog barking"

<<"$SV\n"

SV.pinfo()



//svar  T = "123 456   789  "
svar  T;
T[0] = "123 456   789  "

<<"T =$T\n"

<<"T[0] =$T[0]\n"







T[1] = T[0]
<<"T[1] =$T[1]\n"

T[2] = T[1]

T.pinfo()
//query()


for (i=3;i<=10;i++) {
T[i] = T[0]
<<"$T[i]  $T[0]\n"
}

T.info(1)
<<"%(1,,,\n)$T \n"


T[2].dewhite()
T.info(1)
ns="123 456   789  ";

<<"<|$T[2]|>\n"
wsin = T[2]
<<"$wsin\n"

chkStr(T[2],"123456789")
chkStr(T[0],ns)



chkStr(T[0],"123 456   789  ")

T.info(1)

<<"%(1,,,|>\n)$T \n"

T[4:6].dewhite()

<<"%(1,<|,,|>\n)$T \n"

chkStr(T[4],"123456789")
chkStr(T[6],"123456789")

len=slen(T[8])
len2=slen(ns)
<<"%V$len $len2\n"
chkStr(T[8],ns)

<<"<|$T[8]|>\n"
<<"<|$ns|>\n"


k=scmp(T[8],ns)
<<"%V$len $len2 $k\n"

chkOut()
