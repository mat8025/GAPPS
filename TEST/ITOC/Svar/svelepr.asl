//%*********************************************** 
//*  @script svelepr.asl 
//* 
//*  @comment test svar print  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Thu Mar  7 23:43:14 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

 include "debug.asl"; 
  
  debugON();
  setdebug(1,@pline,@~trace,@~showresults,1);


CheckIn()

//kd=!!"rm -f goal1"
//<<"%V$kd \n"

!!"rm -f goal1"

Svar W;


W[0] = "hey  "


<<"%v $W[0] \n"

 W[1] = "mark"

<<"%v $W[1] \n"

<<"%v $W[0] \n"

 W[2] = "can"

<<" $W \n"

 W[3] = "you"


<<"%v $W[0] \n"

 W[4] = "make"

 W[5] = "your"

 W[6] = "goal"

 W[7] = "weight"

// W[8] = "?"

<<"W $W[0:-1] \n"
<<" mat print\n"
<<[1]"%(5,<<|+=+\s,\s,\s>>\n)$W[::] \n"
<<"%(5,<<|\s,\s,\s>>\n)$W[::] \n"
<<[1]"8%(3,<<|:\s,\s,\s>>\n)$W[::] \n"
<<"7%(3,<<|:\s,\s,\s>>\n)$W[::] \n"
<<"-----------------------\n"
<<"-----------------------\n"

<<" more mat print\n"
<<"T%(4,HA,\s,\n)$W"



//sleep(1)

goal_fn = "goal1"

rsz=fstat(goal_fn,"size")
<<"\nfile size $rsz \n"


A=ofw(goal_fn)
<<" %V$A\n"
if (A == -1) {
<<"error write file open\n")
 exit()
}
<<" file handle $A\n"
<<[A]"%(4,,\s,\n) $W"
fprintf(A,"%(4,,\s,\n) $W")
<<[A]"\n whats going on\n"
fprintf(A,"via fprintf\n")
fflush(A);
cf(A)



//sleep(1)

rsz=fstat(goal_fn,"size")
<<"\nfile size $rsz \n"
if (rsz ==0) {

sleep(5);
}

rsz=fstat("goal1","size")
<<"\nfile size $rsz \n"

B=ofr(goal_fn)

if (B == -1) {
 <<"error read file open\n")
 exit()
}

// FIXME -- should not need explicit svar declare
//svar V;

 V=readfile(B)

<<" file read as:-\n"
<<"$V \n"


<<"------------- \n"
<<"V is  $(typeof(V)) \n"


<<"just first line: $V[0] \n"
<<"second $V[1] \n"
<<"third $V[2] \n"



// FIXME -- should not need explicit svar declare split should deliver svar
//svar Z
<<"V is $V[0:1:]\n"
<<"___________\n"
Z= "$V"

Z->split()

<<"Z= $Z \n"

<<"Z[0] $Z[0] \n"
<<"Z[1] $Z[1] \n"
<<"Z[2] $Z[2] \n"
<<"Z[3] $Z[3] \n"
<<"%V$Z[4] \n"



CheckStr("hey",Z[0]);

CheckStr("make",Z[4]);

<<"$Z[4] \n"

cf(A)

CheckOut()

