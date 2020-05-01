//%*********************************************** 
//*  @script scut.asl 
//* 
//*  @comment test scut function 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Fri Apr 17 22:20:06 2020 
 
//*  @cdate Fri Apr 17 22:10:11 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


/{/*
ws=scut(w1,nc)
cuts n chars from head or tail ( if n is negative) of the string w1,
and returns result to string ws.
/}*/


checkIn()

str w1 = "Je le sais bien"

ws1= scut(w1,3)

<<"$ws1\n"

checkStr(ws1,"le sais bien")

ws2= scut(w1,-4)

<<"$ws2\n"

checkStr(ws2,"Je le sais ")

str w2 = "";

checkStr(w2,"")

ws3=scut(w1,30)

<<"$ws3\n"

checkStr(ws3,"")

len = slen(w1)

<<"len of <|$w1|> is $len \n"

len = slen(ws3)

<<"len of <|$ws3|> is $len \n"

checkNum(len,0)

checkOut()

