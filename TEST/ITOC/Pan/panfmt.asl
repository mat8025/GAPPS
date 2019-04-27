

pan a = 1.2
pan c = 2.4;

<<"%V $a $c \n"



double b = a;  // TBF

double d;

 d= a;




<<" $a\n"

<<" %p $a\n"

<<" $b\n"
<<" $d\n"

<<" %6.2f$b\n"
<<" %6.2f$d\n"

d= 1.2;

 for (j= 0; j < 10; j++) {

    a += d;
 
 <<"$j $a \n"
a->info(1)
 }

<<"///////////\n"

 for (j= 0; j < 10; j++) {

    c += a;
 
 <<"$j $c \n"
c->info(1)

 }


pan e =11.6690693556612037397

e->info(1)
<<"%V$e\n"
f= Fround(e,1)

f->info(1)
<<"%V$f\n"
d=f


d->info(1)
<<"%V%6.2f$d\n"

 pan stagenum
 pan endnum;


 endnum = 1000000
 stagenum =  12547
 
 
   double pcdone = 0.0;
  pan pcd;



    pcd = stagenum/endnum * 100.0 ;
  pcd->info(1)
  pcdone = Fround(pcd,2);

  pcdone->info(1)

<<"%V %6.2f $pcdone \n"