///
///  Nitrogen  derived siv types   test
///

filterFileDebug(REJECT_,"ic_wic","ic_pic","state_e","tokget");
setDebug(1,@trace,@keep,@pline);

float a = 28.82;

a->info(1)

<<"%V $a \n"

b = a

b->info(1)

c = a * 2

c->info(1)

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

