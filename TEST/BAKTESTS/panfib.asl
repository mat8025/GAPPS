
pan a = 1; 
pan b = 0; 

ulong al = 1
ulong bl = 0
ulong tl



pan P[500]

uint L[500]



L[1] = 77
//<<" $L \n"

icompile(0)
//<<"$a $b \n"


for (i=0; i<2000; i++) {

//  P[i] = b
//  L[i] = bl

//  <<"$i $b  $bl\n";  
  <<"$i $b \n";  

  tl = al
  t= a ; 

  al = al + bl
  a = a +b;

  bl = tl
  b = t;

}

stop!

  if (P[20] == L[20]) {
<<" ulong -- pan  OK20\n"
<<" $P[20] $L[20]\n"
  }


stop!

<<" $P[50] $L[50]\n"