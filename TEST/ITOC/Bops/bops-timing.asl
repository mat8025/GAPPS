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


include "debug"

debugON();

sdb(0,@~trace,@~pline,@keep)

/// get measures on icode speed - which is too slow
#define N 1000

int Vec[N];


int a = 1;
int b = 1;
int c = 1

int i;
sdb(0,@~trace,@~pline,@keep)
T=FineTime();

     for (i = 0; i < N ; i++) {
           c = a * b;
	   Vec[i] =c;
	   a++;
	   b++;

     }

<<"%V $a $b $c $Vec[N-1]\n"

  dt= fineTimeSince(T,1)
  secs = dt/1000000.0;
<<"took $secs\n"

<<"Nes $(getNes())\n"
<<"Ndbs $(getNdbs())\n"

