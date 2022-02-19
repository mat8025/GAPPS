/* 
 *  @script spat.asl 
 * 
 *  @comment test Spat func 
 *  @release CARBON 
 *  @vers 1.4 Be 6.3.83 C-Li-Bi 
 *  @date 02/16/2022 10:08:43          
 *  @cdate Tue Mar 12 07:50:33 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                   

/*

spat
matches string w2 in w1 returns the characters before or after the match (default before)
depending on optional parameters (posn, dir).
if posn = 1 rest of characters from right of match
posn = 0 including match string, posn = -1 before match, (default -1)
If dir = 1 search starts at the left, -1 from right. (default 1)
If the variables match vector supplied
then match[0] is one if there was a match
and how many characters are remaining is in match[1].
also spat will return the string "" if no match
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
For regex patterns use
cresult =spatrgx(w1,w2,{posn,dir, [match[2] })
or
regex " pma=regex(w1,w2) "
where w2 is a regex pattern and pma is array of start and end indices
for that pattern if found,
if first entry in pma is [-1,-1] then the pattern was not found. 

*/

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

int match[2];

fname = "mt_20100422_112017.txt"

fname.pinfo()


ss = "."

posn = -1 ;
dir = 1;


fstem = spat(fname,ss,posn,dir,match)

fstem.pinfo()




cc = slen(fname)


stem_len = slen(fstem)
!p stem_len

<<"%V$fname $cc $stem_len $ss $fstem\n"



chkStr(fstem,"mt_20100422_112017");

posn = 0 ; dir = 1

fstem = spat(fname,ss,posn,dir,match)

<<"%V $posn $dir  $fstem $match\n"

chkStr(fstem,".txt")

posn = 1 ; dir = 1;

fstem = spat(fname,ss,posn,dir,match)

<<"%V $posn $dir  $fstem $match\n"

chkStr(fstem,"txt")


fname = "mad_about you baby - just mad!"

ss="mad"

posn = 1 ; dir = 1;

fstem = spat(fname,ss,posn,dir,match)

<<"%V $posn  $dir : $fstem $match\n"


posn = 1 ; dir = -1;

fstem = spat(fname,ss,posn,dir,match)

<<"%V $posn  $dir : $fstem $match \n"


posn = 1 ; dir = -1;

fstem = spat(fname,ss,posn,dir,match)


<<"%V $posn  $dir : $fstem \n"


rem = spat("whatremains","rem",posn,dir,match)

<<"%V $rem $match \n"

rem = spat("whatremains","at",0,dir,match)

<<"%V $rem $match \n"


//////////////////////// spatrgx

fname = "mt_20100422_112017.txt"

ss = "\\."

fstem = SpatRgx(fname,ss,-1,1,match)

cc = slen(fname)
stem_len = slen(fstem)

<<"%V$fname $cc $stem_len $ss $fstem $match \n"

chkN(match[0],1);

chkStr(fstem,"mt_20100422_112017");

///////////////



chkOut();


/*
 TBD - test each option
 position , direction, global 
 simple, spat
 regex, spatrgx


*/