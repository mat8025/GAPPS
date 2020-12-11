//%*********************************************** 
//*  @script bops-timing.asl 
//* 
//*  @comment test basic ops  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Thu Mar  7 23:24:30 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


//include "debug"
//debugON();
//sdb(1,@~trace,@~pline,@keep)


/// get measures on icode speed - which is too slow
#define N 1000

int Vec[N];


int Ptest(int val)
{
   <<"$_proc $val\n"
   int d = 0;
   for (j=0;j< 4;j++) {
     d += val;
   <<"%V $d $val\n";  
   }
   <<"$_proc $d\n"
   return d;
}

int a = 1;
int b = 1;
int c = 1;
int e;
int m;
a->info(1);
b->info(1);
c->info(1);
e->info(1);

e = a + b + c; 

<<"$e $a + $b + $c \n";





int i;


T=FineTime();

<<" $_script\n"

for (i=0;i< 4; i++) {
 e= a + b;

 a++;
 b--;
<<"$e = $a + $b \n"
}


   m= Ptest(c);

<<"%V $c $m\n"

  m= Ptest(e);

<<"%V $e $m\n"

  m= Ptest(a);

<<"%V $a  $m\n"

<<"Nes $(getNes())\n"
<<"Ndbs $(getNdbs())\n"



     for (i = 0; i < N ; i++) {
           c = a * b;
	   Vec[i] =c;
	   a++;
	   b++;

     }


   e= Ptest(c);

<<"%V $a $b $c $e $Vec[N-1]\n"



<<"%V $c $e $m\n"

  dt= fineTimeSince(T,1)
  secs = dt/1000000.0;
<<"took $secs\n"

<<"Nes $(getNes())\n"
<<"Ndbs $(getNdbs())\n"

