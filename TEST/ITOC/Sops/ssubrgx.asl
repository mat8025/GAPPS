//%*********************************************** 
//*  @script ssubrgx.asl 
//* 
//*  @comment test Ssubrgx func 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 29 14:23:41 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///


// want  ssub to do regex!
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


checkIn()



 W= "aaabbbcccdddxxxccceeecccfffhhh"
dir = 1;

<<"ORIG: $W\n"

T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"


checkStr(T,"aaabbbqqqdddxxxccceeecccfffhhh")

dir = -1
T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"

checkStr(T,"aaabbbcccdddxxxccceeeqqqfffhhh")


dir = 0
T= ssub(W,"ccc","qqq",dir)
<<"SSUB(dir $dir): $T\n"

checkStr(T,"aaabbbqqqdddxxxqqqeeeqqqfffhhh")


 W= "aaabbbcccdddxxxccceeecccfffhhh"
dir = 1;
<<"////////////////////\n"
<<"ORIG: $W\n"

T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"


checkStr(T,"aaabbbqqqdddxxxccceeecccfffhhh")

dir = -1
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

checkStr(T,"aaabbbcccdddxxxccceeeqqqfffhhh")

dir = 2
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

checkStr(T,"aaabbbqqqdddxxxqqqeeecccfffhhh")

dir = 0
T= ssubrgx(W,"ccc","qqq",dir)
<<"SSUBRGX(dir $dir): $T\n"

checkStr(T,"aaabbbqqqdddxxxqqqeeeqqqfffhhh")


dir = 0

 W= "aaabbbccccdd dxxxcccccccceeeccfffhhh"
<<"ORIG: $W\n"
rpat = "c+"
T= ssubrgx(W,rpat,"qqq",dir)
<<"SSUBRGX(dir $dir) (%v $rpat ): $T\n"

checkStr(T,"aaabbbqqqdd dxxxqqqeeeqqqfffhhh")

checkOut() ; exit();

rpat = 'abc*'
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




CheckOut()


/{
/*
  add examples of regex use
  
  plus substitute of regex pattern


*/
/}