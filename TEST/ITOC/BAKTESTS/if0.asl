#/* -*- c -*- */


CheckIn()

N = GetArgI()
<<" supplied arg is [ $N ] testing for <,=, or > than 1\n"

prog = GetScript()
<<" ${prog} \n"
<<" ${prog}: \n"

#{

  Test If variations

#}



itest = 1
a = 2


//<<" $a $gt $eq $lt \n"

 gt = 0
 eq = 0
 lt = 0

 if (a > 0) {
   gt =1
 }

 CheckNum(a,2)
 CheckNum(gt,1)

<<"%V $a > 0 ? \t: $lt $eq $gt \n"
 gt = 0
 eq = 0
 lt = 0



<<" test eqv to \n"

  a = 0;
  
 if (a == 0) {
   eq = 1
  }

 CheckNum(a,0)
 CheckNum(eq,1)

 <<"%V $a == 0 ? \t: $lt $eq $gt \n"

 a--
 
 gt = 0
 eq = 0
 lt = 0

 if (a < 0) {   
   lt = 1; 
 }


 CheckNum(lt,1)

<<"%V $a < 0 ? \t: $lt $eq $gt \n"


 
 a--

 tot = gt + lt + eq

 
<<"%V $ntest $ok $bad\n"


 a =1
<<" \n"


 gt = 0
 eq = 0
 lt = 0

 if (a > 0) 
   gt =1


 CheckNum(gt,1)


<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--



 if (a == 0) 
   eq = 1

 CheckNum(eq,1)

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--

 if (a < 0)    
   lt = 1; 

 CheckNum(lt,1)

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--

 tot = gt + lt + eq

 a =1

<<"%V $ntest $ok $bad\n"
<<" \n"



 while (a > -2) {
<<" first in while \n"
 gt = 0
 eq = 0
 lt = 0
<<" before first if in while \n"
 if (a > 0) {
   gt =1
 }
<<" after first if in while \n"

 if (a == 0) {
   eq = 1
  }

 if (a < 0) {   
   lt = 1; 
 }

 tot = gt + lt + eq


<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--
<<" last st in while \n"

 }

 a = 1

<<" \n"







 while (a > -2) {

 gt = 0
 eq = 0
 lt = 0

 if (a > 0) 
   gt =1


 if (a == 0)
   eq = 1
  

 if (a < 0) 
   lt = 1
<<" missed ? \n"

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 tot = gt + lt + eq

 a--
 }



islt = 0
isgt = 0
iseq = 0
nwr = 1

N = 1 
bad = 0

  if (N > 1 ) 
      bad++    


  if (N > 1 )  CheckNum(N,0)

  if (N < 1 )  CheckNum(N,0)


  if (N == 1 )  CheckNum(N,1)




  CheckOut()

STOP!
//////////////////////////////////////////////////////////////////


