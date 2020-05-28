#! /usr/local/GASP/bin/asl
#/* -*- c -*- */



<<" $0 $1 \n"
    //A=ofr("${1}.asl")
A=ofr("cmfarg.asl")

proc sumarg(a, b)
{
   c = a+ b

<<" $a + $b = $c \n"

  return c
}


proc ReadPulseFile( pfname)
{

 len =0
 len = slen(pfname)

<<" %I $pfname $len\n"

<<" $_cproc $pfname \n"

 return len

}


proc poo ( vstr)
{

<<" %I $_cproc $vstr \n"

  s = vstr[0]
  m = vstr[1]
<<" %I $s $m\n"

}

CLASS coo {

 svar w1
 svar w2

CMF poo ( vstr)
 {

<<" %I $_cproc $_cobj $vstr \n"

  w1 = vstr[0]
  w2 = vstr[1]
<<" %I $w1 $w2\n"
<<" \n <$w1> <$w2> \n"

 }

 CMF coo()
 {

  w1 = "mark"
  w2 = "terry"  
 <<" constructor %I $_cobj setting  $w1  $w2\n"


 }

}


 x = 3
 y = 7
 z= sumarg( x,y)

<<" $x + $y = $z \n"

fname= "junk"

k=ReadPulseFile(fname)

<<" %v $k \n"


 coo   ob[3]


 sen = Split("the message was gobbledygook")

<<" %i $sen \n"

 poo(sen)

   k = 0
   j = 0
 while (k < 10) {
   nwr = sen->Read(A)
   if (nwr > 0) {
<<" %I $k $j $sen \n"

   ob[j]->poo(sen)
   j++
     if (j ==3) {
        j = 0
     }
   }
  k++
  
 }

<<" done loop %i $k \n"

   STOP("DONE ! \n")
