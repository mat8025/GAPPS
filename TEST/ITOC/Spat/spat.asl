//%*********************************************** 
//*  @script spat.asl 
//* 
//*  @comment test Spat func 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.98 C-He-Cf]                           
//*  @date Wed Dec 23 11:17:59 2020 9 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/*

spat
spat(w1,w2,posn,dir,&match,&charrem)
matches string w2 in w1 returns the characters 
before or after the match (default before)
depending on optional parameters (posn, dir).
if posn = 1 rest of characters from right of match
posn = 0 including match string, posn = -1 before match, (default -1)
If dir = 1 search starts at the left, -1 from right. (default 1)
If the variables match and charrem are given they will contain,
if there was a match (1 or 0) and how many characters are remaining in rest of w1.
spat will return the string "" if No match,
use match and charrem to determine the result of pattern search.
e.g.
a is 4.0,0.5,0.7  b is ,
c = spat(a,b)  : c is 4.0
c = spat(a,b,1)   : c is 0.5,0.7
c = spat(a,b,-1)  : c is 4.0
spat(a,b,0)   : c is ,0.5,0.7
c = spat(a,b,1,-1) : c is 0.7
c = spat(a,b,-1,-1) : c is 4.0,0.5 
c = spat(a,b,0,-1) : c is ,0.7

(for regex patterns use regex " pma=regex(w1,w2) "

*/

#include "debug"

if (_dblevel >0) {
   debugON()
}



chkIn()

fname = "mt_20100422_112017.txt"

fname->info(1)

mat = 0
index = 0
ss = "."

posn = -1 ;
dir = 1;


fstem = spat(fname,ss,posn,dir,&mat,&index)

fstem->info(1)




cc = slen(fname)


stem_len = slen(fstem)
!p stem_len

<<"%V$fname $cc $stem_len $ss $fstem $mat $index \n"


chkN(mat,1);

chkStr(fstem,"mt_20100422_112017");

posn = 0 ; dir = 1

fstem = spat(fname,ss,posn,dir,&mat,&index)

<<"%V $posn $dir  $fstem \n"

chkStr(fstem,".txt")

posn = 1 ; dir = 1;

fstem = spat(fname,ss,posn,dir,&mat,&index)

<<"%V $posn $dir  $fstem \n"

chkStr(fstem,"txt")


fname = "mad_about you baby - just mad!"

ss="mad"

posn = 1 ; dir = 1;

fstem = spat(fname,ss,posn,dir,&mat,&index)

<<"%V $posn  $dir : $fstem \n"


posn = 1 ; dir = -1;

fstem = spat(fname,ss,posn,dir,&mat,&index)

<<"%V $posn  $dir : $fstem \n"


posn = 1 ; dir = -1;

fstem = spat(fname,ss,posn,dir,&mat,&index)


<<"%V $posn  $dir : $fstem \n"



//////////////////////// spatrgx

fname = "mt_20100422_112017.txt"

ss = "\\."

fstem = SpatRgx(fname,ss,-1,1,&mat,&index)

cc = slen(fname)
stem_len = slen(fstem)

<<"%V$fname $cc $stem_len $ss $fstem $mat $index \n"

chkN(mat,1);

chkStr(fstem,"mt_20100422_112017");

///////////////



chkOut();


/*
 TBD - test each option
 position , direction, global 
 simple, spat
 regex, spatrgx


*/