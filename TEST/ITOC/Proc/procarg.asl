/* 
 *  @script procarg.asl 
 * 
 *  @comment test some usage of proc args 
 *  @release CARBON 
 *  @vers 1.7 N Nitrogen [asl 6.3.11 C-Li-Na] 
 *  @date Sun Jan 17 11:08:15 2021 
 *  @cdate Sat May 9 14:53:10 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                        
<|Use_=
Demo  of proc arc scalar;
///////////////////////
|>


#include "debug.asl"


if (_dblevel >0) {
   debugON()
      <<"$Use_\n"   
}


chkIn(_dblevel)



real sumarg(real a, real b)
{
   c = a+ b

  <<" %V$a + $b = $c \n"

  return c
}

proc ReadPulseFile(str pfname)
{
<<" %i $pfname \n"
 len =0
 len = slen(pfname)

<<"%I $pfname $len\n"

<<" $_proc $pfname \n"

 return len
}



proc soo (svar vstr)
{

<<"$_proc $vstr \n"
<<"$vstr[0] $vstr[1] \n"
 mstr = split(vstr)

  s = mstr[0]
  m = mstr[1]
//   s = vstr[0]
//   m = vstr[1]

<<"%V$s $m\n"
}
//------------------------------


proc soo (str vstr)
{

<<"$_proc $vstr \n"
<<"$vstr[0] $vstr[1] \n"
 mstr = split(vstr)

  s = mstr[0]
  m = mstr[1]
//   s = vstr[0]
//   m = vstr[1]

<<"%V$s $m\n"
}
//------------------------------

proc Foo(str vstr)
{
<<" $_proc $vstr \n"
  mstr = split(vstr)
  s = mstr[0]
  m = mstr[1]
<<"  $s $m\n"
}
//------------------------------




 I = Igen(10,0,1)


I->info(1)

<<"$I \n"

 tot =   sumarg(I[1],I[2])

<<"%V$tot \n"

  chkN(tot,3)



 x = 3
 y = 7
 z= sumarg( x,y)

<<" $x + $y = $z \n"


fname= "procarg.asl"
<<" %V$fname \n"

k=ReadPulseFile(fname)

<<" %v$k \n"



//ttyin()

 sen = Split("the message was gobbledegook")

<<"$sen \n"

<<"sen $(typeof(sen)) \n"

//FIX <<" %i $sen \n"
<<"$sen \n"
<<"$sen[0] \n"

psa = "the"

ssa = sen[0]

<<"ssa $(typeof(ssa)) $ssa \n"

  ok = chkStr(ssa,psa)

<<"test 1 $ok\n"

   ok =chkStr(sen[0],psa)

<<"test 2 $ok\n"

   ok = chkStr(sen[0],"the")

<<"test 3 $ok\n"

   ok = chkStr(sen[3],"gobbledegook")

<<"test 4 $ok\n"
<<"craash  $sen\n"





   A=ofr("procarg.asl")

   if (A == -1) {
     A=ofr("procarg.asl")
   }

   k = 0;

 while (k < 100) {
   nwr = sen->ReadWords(A)
   if (nwr > 0) {
<<"$nwr $k $sen[0] $sen[1] $sen[2] $sen[3]\n"
  //  sen->split()
    soo(sen)
//  Foo(sen)
   }
   
  k++
  
 }

   soo("Once upon a time")


<<" done loop %i $k \n"

    chkOut()


