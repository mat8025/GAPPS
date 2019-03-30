//%*********************************************** 
//*  @script ssub.asl 
//* 
//*  @comment test Ssub func 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 29 14:23:41 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/{/*
ssub
ssub(w1,w2,w3,{dir})
substitutes string w3 into w1 for  first occurrence of w2 returns the result.
if dir 1 (default) starts at left, -1 from right, dir = 0 global substitute.
if w3 set to "" (i.e. NULL)  delete operation (deletes occurence of w2).
if dir > 1 then that many substitutions are performed from the left if possible.
/}*/





Checkin()

S="The very next day - he started to improve"

CheckStr(S,"The very next day - he started to improve")

<<"$S\n"

T=ssub(S,"improve","improvise")

CheckStr(T,"The very next day - he started to improvise")


<<"$T\n"

R= ssub(ssub(S,"improve","improvase"),"vase","vuse")

CheckStr(R,"The very next day - he started to improvuse")

<<"$R\n"



U= ssub(ssub(S,"improve","improvase"),"vase",ssub("vase","a","i"))

CheckStr(U,"The very next day - he started to improvise")

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


CheckOut()


// want rssub to do regex!