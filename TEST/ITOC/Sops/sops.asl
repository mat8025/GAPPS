/* 
 *  @script sops.asl 
 * 
 *  @comment test str ops 
 *  @release CARBON 
 *  @vers 1.5 B Boron [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 12:06:24 2021 
 *  @cdate Sun Apr 12 12:28:34 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
<|Use_=
Demo  of str-ops;
///////////////////////
|>
                                                              

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

 S = "hey how are you?"

<<"$S\n"

 col= split(S)

<<"$col \n"

<<"$col[0] \n"

  fwrd = col[1]

<<"first wrd was $fwrd \n"

   if (fwrd @= "how") {

     <<" fine\n"
   }


<<"$col[1] \n"

<<"$col[1:3] \n"



   if (col[1] @= "how") {

     <<" fine\n"

   }
   else {

     <<" not so good\n"

   }
  

//=============================//



/*
scat
ws=scat(w1,w2,{w3,w4,...})
concatenates w2 to w1 (or more args) returns the result
*/



EC= vgen(CHAR_,10,60,1)

<<"$EC\n"

ac= EC[1]

<<"$EC[0] $EC[1] $EC[2] $ac\n"



ws=scat("Happy"," Hols")
<<"%V$ws\n"

chkStr(ws,"Happy Hols")

chkStage("single cat")

char E[>3]

E.pinfo();

//query()

hh=  scat("Happy"," Hols")
hh.pinfo()
<<"$hh\n"

E = scat("Happy"," Hols")

<<"%d$E \n"

E.pinfo()

ac= E[1]

<<"$E[0] $E[1] $E[2] $ac\n"



chkN(E[0],72);
chkN(E[1],97);
chkN(E[1],'a');


<<"%c$E[0] \n"
<<"%d$E[1] \n"
<<"%c$E[1] \n"
<<"%d$E[::] \n"
<<"%c$E[::] \n"

chkStage("char cat")

ws=scat("Happy"," Hols"," are"," here", " again")
<<"%V$ws\n"

chkStr(ws,"Happy Hols are here again");

chkStage("Scat: multiple cats")

//============================//


/*
 w2=scut(w1,nc) :- cuts nc chars of string from head or tail if nc is negative 
 or a section scut(w1,startc,endc) returns result
*/




 w1="a_winters-tale.cpp"

<<"$w1\n"

 wt= scut(w1,-4)

<<"$wt\n"

 chkStr(wt,"a_winters-tale")

 wh= scut(w1,2)

<<"$wh\n"

 chkStr(wh,"winters-tale.cpp")


 wm= scut(w1,2,9)

<<"$wm\n"

 chkStr(wm,"a_tale.cpp")


 wm= scut(w1,-9,-5)

<<"<|$wm|>\n"

 chkStr(wm,"a_winters.cpp")

svar Sv = "una larga noche"

Sv[1] = "el gato mira la puerta"

Sv[2] = "y espera ratones"

Sv[3] = "un plan simple"


Sv.pinfo()
<<"$Sv \n"


str T=Sv[3]

T.scut(-3)

<<"$T \n"

T=S

T.scut(3)


<<"$T \n"



//======================= SSUB ========================//

/*
ssub
ssub(w1,w2,w3,{dir})
substitutes string w3 into w1 for  first occurrence of w2 returns the result.
if dir 1 (default) starts at left, -1 from right, dir = 0 global substitute.
if w3 set to "" (i.e. NULL)  delete operation (deletes occurence of w2).
if dir > 1 then that many substitutions are performed from the left if possible.
*/

//S->init()
S="";
// XIC bug not re copy
S1="The very next day - he started to improve"

chkStr(S1,"The very next day - he started to improve")

<<"$S1\n"

T=ssub(S1,"improve","improvise")

chkStr(T,"The very next day - he started to improvise")


<<"$T\n"

R= ssub(ssub(S1,"improve","improvase"),"vase","vuse")

chkStr(R,"The very next day - he started to improvuse")

<<"$R\n"

U= ssub(ssub(S1,"improve","improvase"),"vase",ssub("vase","a","i"))

chkStr(U,"The very next day - he started to improvise")

<<"$U\n"

R = ssub(S,"e","E",0)

<<"$R\n"

R = ssubrgx(S,"e.","E2",0)

<<"$R\n"




 W= "aaabbbcccdddxxxccceeecccfffhhh"

 T= ssub(W,"ccc","qqq",0)
 <<"$T\n"


 RI= regex(W,"ccc")

<<"$RI\n"
<<"$W\n"
 T= ssub(W,"ccc","qqq",1,10)

 <<"$T\n"


chkStage("SSUB")


// want rssub to do regex!


//========  @script ssubrgx.asl  ==============

/{
/*
ssubrgx(w1,w2,w3,{dir})
 
substitutes string w3 into w1 for  first occurrence of regex pattern w2
and returns the result.
if dir 1 (default) starts at left, -1 from right, dir = 0 global substitute.
if w3 set to "" (i.e. NULL)  delete operation (deletes occurence of w2).
if dir > 1 then that many substitutions are performed 
from the left if possible.
*/
/}






 W= "aaabbbcccdddxxxccceeecccfffhhh"
dir = 1;

<<"ORIG: $W\n"

T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"


chkStr(T,"aaabbbqqqdddxxxccceeecccfffhhh")

dir = -1
T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"

chkStr(T,"aaabbbcccdddxxxccceeeqqqfffhhh")


dir = 0
T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"

chkStr(T,"aaabbbqqqdddxxxqqqeeeqqqfffhhh")


 W= "aaabbbcccdddxxxccceeecccfffhhh"
dir = 1;
<<"////////////////////\n"
<<"ORIG: $W\n"

T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"


chkStr(T,"aaabbbqqqdddxxxccceeecccfffhhh")

dir = -1
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

chkStr(T,"aaabbbcccdddxxxccceeeqqqfffhhh")

dir = 2
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

chkStr(T,"aaabbbqqqdddxxxqqqeeecccfffhhh")

dir = 0
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

chkStr(T,"aaabbbqqqdddxxxqqqeeeqqqfffhhh")


dir = 0

 W= "aaabbbccccdd dxxxcccccccceeeccfffhhh"
<<"ORIG: $W\n"
rpat = "c+"
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

chkStr(T,"aaabbbqqqdd dxxxqqqeeeqqqfffhhh")


rpat = 'abc*'
rpat.pinfo()

<<"%V $rpat\n"


dir = 1
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

rpat = 'bbc+'
<<"%V $rpat\n"
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

rpat = 'bbc?'
<<"%V $rpat\n"
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

rpat = "xxc{2,}"
<<"%V $rpat\n"
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

rpat = "\sdx"
<<"%V $rpat\n"
T= ssubrgx(W,rpat,"SDX",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"




chkStage("SSUBRGX")



/{/*

  add examples of regex use
  
  plus substitute of regex pattern

/}*/



ok = 0

   A= "how"

<<"$A\n"
<<"$(typeof(A))\n"

   if (A @= "how") {
     <<" fine\n"
      ok = 1
   }
   else {
<<" scmp not working \n"
   }
<<"%V$ok\n"
<<"<|$A|>\n"

ok.pinfo()
A.pinfo()

//chkStr(A,"how")
chkN(1,ok)


     ok = 0
   if (A @= "wow") {
     <<" incorrecto\n"

   }
   else {
<<" scmp  working \n"
     ok  =1
   }

 tok=chkN(ok,1)

// Scmp 

// first the simple str version


w1= "maybe"

w2 = "maybe"

ok= scmp(w1,w2)

<<"%V$ok\n"

chkN(ok,1)


diff= strcmp(w1,w2)

<<"%V$diff\n"

chkN(diff,0)


w3="maybenot"

ok= scmp(w1,w3)

<<"%V$ok\n"

chkN(ok,0)

diff= strcmp(w1,w3)

<<"%V$diff\n"
if (diff != 0) {
  ok = 1
}

chkN(ok,1)




ok= scmp(w1,w3,5)

<<"%V$ok\n"

chkN(ok,1)

w4="Maybe"

ok= scmp(w1,w4)

<<"%V$ok\n"

chkN(ok,0)


ok= scmp(w1,w4,0,0)

<<"%V$ok\n"

chkN(ok,1)


s1="Now is the time for all Good men all the time"

<<"$s1\n"

s2=split(s1)

<<"$s2\n"
<<"$s2[5]\n"

rv=s2.findVal("all")

<<"$(typeof(rv)) $(Caz(rv))\n"
<<"$rv \n"

riv=s2.scmp("all")

<<"$(typeof(riv)) $(Caz(riv))\n"
<<"$riv \n"


chkStage("scmp @=")


chkOut()