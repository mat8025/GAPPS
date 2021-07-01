
///
///
///
include "debug"

debugON()
sdb(1,@pline,@trace)

int a;
int b;
int c;
int d;
int e;
float f;
double g;
int h;
int i;
int j;

tot_secs = 0.0;
k = 1
//for (k= 0; k <100; k++) {
T=fineTime()

  a = 1;
  b = 2;
  c = 3;
  d = 4;
  e = 5;
  f =  6.0;
  g = 7.0;
  h = 8;
  i =  8*9;
  j = 40 * 75 * 4
  
dt= FineTimeSince(T)

<<"$a $b $c $d $e $f $g $h $i $j\n"

secs = dt/1000000.0

<<"took $dt  $secs\n"
tot_secs += secs;
//}


<<"$tot_secs $(tot_secs/k)\n"