//%*********************************************** 
//*  @script regex_inv.asl 
//* 
//*  @comment test 
//*  @release CARBON 
//*  @vers 1.41 Nb Niobium                                                 
//*  @date Mon Apr  8 09:51:04 2019 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
#

#include "debug.asl"

debugON();


setdebug (1, @pline, @~step, @~trace, @soe) ;

checkIn()


str C = "abc(SUBSC)"

str D = "abc(LH_SUBSC)"

str E = "abc(SUBSC_ARRAY)"


str F = "abc(SUBSC_ARRAY) ||  def(SUBSC_LOCK) "


p = regex(C,"[^_]SUBSC")

<<"$p \n"

if (p[0] != -1) {
pat = sele(C,p[0],p[1]-p[0])
<<"$pat \n"
}

checkStr(pat,"(SUBSC")

checkStage(" REGEX [^_]")

p = regex(D,"[^_]SUBSC")

<<"$p \n"



p = regex(C,"\([^_]\)SUBSC")


<<"$p \n"

if (p[0] != -1) {
pat = sele(C,3,p[1]-p[0])

<<"$pat \n"
}


p = regex(E,"([^_])SUBSC_([A-Z])")

<<"$p \n"


if (p[0] != -1) {
pat = sele(E,p[0],p[1]-p[0])

<<"$pat \n"
}


p = regex(E,'([^_])SUBSC_([A-P])') ;
sdb(1,@~pline)
sz= p->Caz()
<<"$sz $p \n"


int j = 0;
while (1) {
 if (p[j] != -1) {
 <<"$p[j] $p[j+1] \n"
  pat = sele(E,p[j],p[j+1]-p[j])
 <<"$pat \n"
 }

j += 2;
if (p[j] == -1)
   break;
if (j >= sz)
  break;
}



p = regex(F,'([^_])SUBSC_([A-P])') ;

sz= p->Caz()
<<"$sz $p \n"

svar svpat;
svi = 0
j = 0;
while (1) {
 if (p[j] != -1) {
 <<"$p[j] $p[j+1] \n"
  svpat[svi] = sele(F,p[j],p[j+1]-p[j])
 <<"$svpat[svi] \n"
 }

j += 2;
svi++;
if (p[j] == -1)
   break;
if (j >= sz)
  break;
}



checkStr(svpat[0], "(SUBSC_A")
checkStr(svpat[1], "(")
checkStr(svpat[2], "A")

checkStr(svpat[3], "(SUBSC_L")
checkStr(svpat[4], "(")
checkStr(svpat[5], "L")

checkStage("SUB EXPRESSIONS")

checkOut();