//%*********************************************** 
//*  @script fastx.asl 
//* 
//*  @comment test mods to speedup XIC 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.95 C-He-Am]                               
//*  @date Thu Dec 10 13:08:09 2020 
//*  @cdate Thu Dec 10 13:08:09 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
///#include "debug"
//debugON()

/// need some mods to speed up XIC

//sdb(1,@pline,@trace)


    int a;
a->info(1)
      a = 61;

a->info(1)

     a++;
<<"%V$a\n"

     a--;
<<"%V$a\n"

     a += 7;

<<"%V$a\n"

    
int i = 0;

i->info(1);

    for (i= 0; i < 5; i++) {
<<"%V$i $a\n"
    a--;
   }

    a= 0;

   while (a <5 ) {
   a++;
<<"while %V$a\n"
  }

N=5
   a =0;
   while (a <N ) {
   a++;
<<"while %V$a\n"
  }

    long c;
    c->info(1)
    c = 16;
    c->info(1)
<<"%V $c howmuch?\n"





    short b;
b->info(1)    
    long d;
d->info(1)    

      a = 61;

a->info(1)
      b = 75;

b->info(1)
d->info(1)
      d = 26;
d->info(1)
c->info(1);

    c = b + a - d ;

<<"%V $c = $a +$b - $d \n"







    float x;
    double y;

      x= 61.2;
      y = 75.456;

    z = x +y;

<<"%V $z = $x +$y\n"


      short m = 14567;
      long l = 123456789;

//<<"$(typeof(m))  $(typeof(l))\n"

      n = m + l;

 nt=typeof(n)
 mt= typeof(m)
  lt= typeof(m)

<<"%V $nt  $mt $lt \n"

<<"%V $n = $m +$l\n"

// wil use XIC code - 
    for (i = 0; i < 3; i++) {

      c = a + b - d + 7;

<<"%V $i  $c = $a +$b - $d \n"
      a++;


     }
a->info(1);


 int  vec[10];

    for (i= 0; i< 10; i++) {

       vec[i] = a*i;


    }


<<"%V $vec\n"

<<"%V $(typeof(n))  $(typeof(m))  $(typeof(l))\n"


<<"%V Nes $(getNes())\n"
<<"%V Ndbs $(getNdbs())\n"



<<"   Nfastx $(getNfastx())    \n";

exit()

//<<"   Nfastx $(getNfastx())    \n"  /// error xic/pic


