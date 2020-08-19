//%*********************************************** 
//*  @script C6.asl 
//* 
//*  @comment carbon testing 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Feb  5 18:24:47 2019 
//*  @cdate Tue Feb  5 18:24:47 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  Carbon testing
///

include "debug.asl"
debugON()
//filterFileDebug(REJECT_,"ic_wic","ic_pic","state_e");
setDebug(1,@trace,@keep,@pline);


checkIn()
float a = 28.82;

checkFnum(a,28.82)

a->info(1)

<<"%V $a \n"

b = a



b->info(1)

checkFnum(b,28.82)


c = a * 2

checkFnum(c,57.64)

c->info(1)

d = c -a

checkFnum(d,28.82)

a = 2
b = 3
c = 4
d = 5

e = a + b * c

checkFnum(e,14)

e = (a + b) * c

checkFnum(e,20)

f = (a + b) * (c + d) 

checkFnum(f,45)

g = (d + b) * a / c

checkFnum(g,4)

checkOut()
exit()






str S;

S->info(1)

S=a->info(1)
<<"%V $S\n"

S->info(1)

T=a->info(1)
<<"%V $T\n"

T->info(1)
<<"%V $T\n"



a->info(1)


<<"%V $a \n"


a->info(1)

b->info(1)

//<<"%V $a $b \n"

//float c = 1.2345;
//c->info()




<<"%V $a $b $c\n"


b = a * 2

<<"%V $a $b \n"

b->info(1)


<<"%V $a $b \n"
exit()
//<<"%V $a $(typeof(a))\n"

 b = 37;

<<"%V $a $b\n"

 c = a + b;

<<"%V $a $b  $c\n"

d = 3.142;

<<"%V $d\n"



e = a + b;

<<"%V $e\n"

e->info(1)


int c2 = 81;

<<"%V $c2\n"






 c2= a + b;
 
<<"%V $a + $b =  $c2\n"


  y = sin(1.0)

<<"%V $y\n"


exit()

