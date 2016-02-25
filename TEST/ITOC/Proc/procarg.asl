setdebug(1)



proc sumarg(a, b)
{
   c = a+ b

  <<" %V$a + $b = $c \n"

  return c
}

proc ReadPulseFile( pfname)
{
<<" %i $pfname \n"
 len =0
 len = slen(pfname)

<<"%I $pfname $len\n"

<<" $_proc $pfname \n"

 return len
}

proc poo (vstr)
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

proc foo(vstr)
{
<<" $_proc $vstr \n"
  mstr = split(vstr)
  s = mstr[0]
  m = mstr[1]
<<"  $s $m\n"
}
//------------------------------

CheckIn()


 I = Igen(10,0,1)


<<"$I \n"

 tot =   sumarg(I[1],I[2])

<<"%V$tot \n"

  CheckNum(tot,3)



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

  ok = CheckStr(ssa,psa)

<<"test 1 $ok\n"

   ok =CheckStr(sen[0],psa)

<<"test 2 $ok\n"

   ok = CheckStr(sen[0],"the")

<<"test 3 $ok\n"

   ok = CheckStr(sen[3],"gobbledegook")

<<"test 4 $ok\n"
<<"craash  $sen\n"

   poo(sen)



   A=ofr("../Proc/procarg.asl")

   if (A == -1) {
     A=ofr("procarg.asl")
   }

   k = 0;

 while (k < 100) {
   nwr = sen->Read(A)
   if (nwr > 0) {
<<"$nwr $k $sen[0] $sen[1] $sen[2] $sen[3]\n"
  //  sen->split()
  poo(sen)
//  foo(sen)
   }
   
  k++
  
 }

<<" done loop %i $k \n"

    CheckOut()


