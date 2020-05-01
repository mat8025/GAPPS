//%*********************************************** 
//*  @script call_gen.asl 
//* 
//*  @comment test generic args 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr 16 11:32:54 2020 
//*  @cdate Thu Apr 16 11:32:54 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

proc quit()
{
ans=iread();
if (ans @= "q") {
  exit();
 } 

}


#define ASK quit()

//#define ASK ;
 // should allow redefine  --- TBF
////

checkIn()

 str sA;

 sA->info(1)

 sA= "hey"

 sA->info(1)

<<"%V $sA  \n"

 //ans=iread(":?")

 str sB= "61"
 str sC= "62"
 str sD= "63"
 str sE= "64"

<<"%V $sA $sB $sC $sD $sE \n"

 sB->info(1)

<<"%V $sB  \n"



 svar S = Split("arg0 arg1 arg2 arg3")

<<"%V $sA $sB \n"

<<"$S\n"

sA->info(1)




S->info(1)

gen gA = "silver"
gA->info(1)

gen gB = "gold"
gB->info(1)


<<"%V $gA $gB \n"



res = 46
//<<" $res $(pt(res))\n"

proc horse (str a, str b)
{
<<"$_proc    vers str  $a  str $b \n";

   a->info(1)
   b->info(1)
 str a1 = a;
 str b1 = b;

<<"%V $a1 $b1 \n"
    myret = 40;
    return myret;
}
<<"horse ( str, str) defined\n"
//==========================//

proc horse (gen a, gen b)
{
<<"$_proc    vers str  $a  str $b \n";

   a->info(1)
   b->info(1)
 str a1 = a;
 str b1 = b;

<<"%V $a1 $b1 \n"
    myret = 77;
    return myret;
}
<<"horse ( str, str) defined\n"
//==========================//


proc cart (str a, str b)
{
<<"$_proc  str 2 vers  $a  $b\n";

 str a1 = a;
 str b1 = b;

<<"%V $a1 $b1 \n"
//  a and b  are now prog arg refs
    hr=horse(a1,b1)
//<<" %v $hr\n"   
   return 80;
}
//==========================//
<<"cart str str defined\n"


proc cart (str a)
{
<<"$_proc  str 1 vers  $a  \n";

 str a1 = a;


<<"%V $a1  \n"

   return 16;
}
//==========================//
<<"cart (str )  defined\n"




proc cart (gen a, gen b)
{
<<"$_proc  gen vers $a  $b\n";

 str a1 = a;
 str b1 = b;


<<"%V $a1 $b1 \n"
   horse(a1,b1)
   
   return 78;
}

<<"cart (gen, gen) defined\n"


//========================//

S=procedures()

<<"%(1,,,\n)$S\n"

S->info(1)

res = 46
<<" $res $(ptname(res))\n"
 res=cart(sA);
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"

if (!checkNum(res,16)) 
ASK

res=cart(sB);
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"
if (!checkNum(res,16))
ASK


 res=cart(sC);
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"
if (!checkNum(res,16))
ASK


 res=cart(sD);
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"
if (!checkNum(res,16))

ASK

 res=cart(sD,sE);
 res->info(1);
<<"cart(s,s) returned $res $(pt(res))\n"
if (!checkNum(res,80))

ASK

 res=cart(sE);
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"
if (!checkNum(res,16))
 ASK

res=cart(sA,sE);
 res->info(1);
<<"cart(s,s) returned $res $(pt(res))\n"
if (!checkNum(res,80))
   ASK



 res=cart("aidemoi");
 res->info(1);
<<"cart(\"aidemoi\") returned $res $(pt(res))\n"
if (!checkNum(res,16))
ASK
exit()
 res=cart("74");
 res->info(1);
<<"cart(sA) returned $res $(pt(res))\n"
if (!checkNum(res,16))
ASK




res=horse(sA,sB);
res->info(1);
<<"1 horse(sA,sB) returned $res $(pt(res))\n"
if (!checkNum(res,40))

ASK


res=horse(sA,sB);
res->info(1);
<<"2 horse(s,s) returned $res $(pt(res))\n"

if (!checkNum(res,40))

ASK



res=horse(sC,sE);
res->info(1);
<<"2 horse(s,s) returned $res $(pt(res))\n"
if (!checkNum(res,40))
ASK


res=horse(sC,1);
res->info(1);
<<"2 horse(sB,i) returned $res $(pt(res))\n"
if (!checkNum(res,40))
ASK




res= cart(sA,sB);
<<"cart(sA,sB) returned $res $(pt(res))\n"
if (!checkNum(res,80))
ASK




 int k = 4
 int m = 7;

<<"%V $gA $gB \n"
<<"%V $k $m \n"

res =cart(sA,7);
<<"cart(sA,7) returned $res $(pt(res))\n"
if (!checkNum(res,80))
ASK

res  =horse (sA, 74)
<<"3 horse(sA,sB) returned $res $(pt(res))\n"
if (!checkNum(res,40))
<<"%V $gA $gB \n"
ASK




 
<<"%V $gA $gB \n"
gA->info(1)
ASK
  res = cart(gA,gB)
<<"cart(gA,gB) $gA $gB returned $res $(pt(res))\n"
if (!checkNum(res,78))
ASK


 //res = cart(k,m)
//<<"cart(k,m) returned $res $(pt(res))\n"
//if (!checkNum(res,78)
<<"%V $gA $gB \n"

  res = cart(gA,m)
<<"cart(gA,m) $gA returned $res $(pt(res))\n"
if (!checkNum(res,78))




res = 46
<<" $res $(pt(res))\n"


<<"%V $gA $gB \n"
  res = horse(gA,gB)
<<"horse(gA,gB) $gA $gB returned $res $(pt(res))\n"
if (!checkNum(res,77))
ASK
<<"%V $gA $gB \n"


gA->info(1)
gB->info(1)

checkOut()

exit()
