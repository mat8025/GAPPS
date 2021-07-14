//%*********************************************** 
//*  @script dec-pan.asl 
//* 
//*  @comment test declare of pan 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Fri Apr 12 16:13:07 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%




#include "debug"

if (_dblevel >0) {
   debugON()
}



chkIn(_dblevel)

prec=setap(20)

<<" %v $prec \n"

 pan p = 9.0345679979e8

 pan c =  2.9979e8

 pan d = 0.05;

  z= p / c

z->pinfo()

   zfl = z->fl()
<<"%V$zfl\n"

  q = z / c

   qfl = q->fl()
<<"%V$qfl\n"


q->pinfo()

  q = z * c 

q->pinfo()

   qfl = q->fl()
<<"%V$qfl\n"

<<" $(typeof(p))  $(typeof(z)) $(typeof(q))\n"


<<"   $p $c $z \n"
<<"  %e $p $c $z \n"
<<" %V %p $p $q $c $z \n"

<<"%v  %e $q \n"

//  check within acceptable range

   int  k = 1;
   int m = 2;

<<"%V $p $q\n"

  w = k + m;

<<"%V $w \n"

  w = k + -m;

<<"%V $w \n"


  w = k - m;

<<"%V $w \n"






   pan pr = 1;
   pan qr = 2;

<<"%V $p $q\n"

prm = pr + qr;

<<"%V add $prm \n"


prm = pr * qr;

<<"%V mul $prm \n"


prm = pr - qr;

<<"%V minus $prm \n"


<<"%V$p\n"

   pfl = p->fl()
<<"%V$pfl\n"


<<"%V$q\n"
q->pinfo()

   qfl = q->fl()
<<"%V$qfl\n"



   qfl = q->fl()
<<"%V$qfl\n"

   qr = fround(q,0)

   pr = fround(p,0)


<<" %v $pr \n"
<<" %v $qr \n"

//prm1 = pr -1;


   q = q + d

<<"%V$q\n"

   qfl = q->fl()
<<"%V$qfl\n"

   qr = fround(q,0)
<<" %v $qr \n"   

   chkR(qr,pr,2)


chkOut()