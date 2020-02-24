//%*********************************************** 
//*  @script regex.asl 
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


str C = "mat.vox"

str D = "terry.pcm"

str E = "terry.vox"

str F = "terry.phn"

str H = "mark.vox"

G = scat(D,"|",E,":",C,",",F,";",H)

<<"$G\n"


p = regex(C,"vox")

<<"$p \n"


p = regex(G,"vox")

<<"$p \n"

p = regex(G,'vox|phn')

<<"$p \n"


p = regex(G,"vox|phn")

<<"$p \n"



p = regex(G,"vox\|phn")

<<"$p \n"

p = regex(G,"vox|phn")

<<"$p \n"



exit()


checkNum(p[0],4)

p = regex(D,"pcm")

checkNum(p[0],6)

//p = regex(D,'pcm\|vox')
p = regex(D,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)

p = regex(E,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)

p = regex(F,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)





svar S;
S[0] = "DBPR   (";
S[1] = "DBPR  				(";
S[2] = "DBPR(";
S[3] = "DBPR[";



for ( i =0; i< 3; i++) {
p = regex(S[i],'DBPR ?+')

<<"$p\n"
checkNum(p[0],0)
}

p = regex(S[3],"DBPR *\t*\\(")

<<"$p\n"
checkNum(p[0],-1)


<<"//////////////////////\n"
<<"DQ  single line\n"
/{/*
T= "Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. In the search panel that appears near the bottom, type in regex in the box labeled \"Search Text\". Mark the \"Regular expression\" checkbox, and click the Find First button. This is the leftmost button on the search panel. See how EditPad Pro's regex engine finds the first match. Click the Find Next button, which sits next to the Find First button, to find further matches. When there are no further matches, the Find Next button's icon flashes briefly.";
/}*/

T= "Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. ";
<<"$T\n"


<<"//////////////////////\n"
<<"SQ\n"

R= 'Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. In the search panel that appears near the bottom, type in regex in the box labeled "Search Text". Mark the "Regular expression" checkbox, and click the Find First button. This is the leftmost button on the search panel. See how EditPad Pro\'s regex engine finds the first match. Click the Find Next button, which sits next to the Find First button, to find further matches. When there are no further matches, the Find Next button\'s icon flashes briefly.xxx';

<<"$R\n"


//////
<<"b4 txtbox \n"
<|W=
Highlighting regular expression matches in EditPad Pro.
As a quick test, copy and paste the text of this page into EditPad Pro.
Then select Search|Multiline Search Panel in the menu. 
In the search panel that appears near the bottom, type in regex in the box labeled "Search Text".
Mark the "Regular expression" checkbox, and click the Find First button. This is the leftmost button on the search panel. 
See how EditPad Pro's regex engine finds the first match. 
Click the Find Next button, which sits next to the Find First button, to find further matches.
When there are no further matches, the Find Next button's icon flashes briefly.zzz
|>

<<"after txtbox \n $W[0]\n"

<<"%(1,->>,,\n)$W\n"



<|?! W=
So this is the next txtbox
which is much smaller
tiny in fact
?!not sure about the escape mechanism tho
?!|> can be in TXT_BOX
?!?! too
|>

<<"after txtbox%(1, ,, ) \n $W\n"

//sz= W->getSize();
sz= Csz(W);

for (i=0;i<sz; i++) {
<<"W<$i> $W[i]\n"
}
//does this go into exe?
//also this??

checkOut(); 


