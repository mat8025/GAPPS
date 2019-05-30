///
///  test if argN is an armstrong number
///

proc getArmN (char  cna[])
{
int psum = 0;
//<<"%V $cna[::] \n"
     cn = cna - 48;
<<"%V $cn[0:np-1:]\n"
    psum = 0;
      
      for (i=0; i < np ;i++) {
  //     <<"$i $cn[i]\n"
        psum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<" %V $psum\n"
      return psum;
}
//=========================


str Ns = _clarg[1];

N = atoi(Ns)


 np = slen(Ns);

char cnum[np+1];

scpy(cnum,Ns);

 if (cnum[0] @= '0' ) {
   <<" not valid num $Ns\n"
   exit()
 }

if (cnum[0] @= '-' ) {
   <<" not valid num $Ns\n"
   exit()
 }

<<"using $N $Ns as a $np digit number to test\n"




int pw[10];

<<" $np powers 0 to 9\n"
      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
	    <<"<$i>$pw[i] \n"
      }

<<"//////////////\n"


sum =getArmN(cnum);


<<" is $sum == to $N ?\n"

if (sum == N) {
<<" Yes $N is Armstrong (Narcissitic) number\n"
}
else {
<<" No $N not Armstrong - try another!\n"
}






exit()

 