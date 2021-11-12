///
///
///

openDll("uac")

//proc getArmN (char  cna[])
proc getArmN (char  cna)
{
Pan psum = 0;
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

N = atop(Ns)


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




Pan pw[10];

<<" $np powers 0 to 9\n"
      for (i=0; i < 10 ;i++) {
            pw[i] = i^^np ;
	    <<"<$i>$pw[i] \n"
      }

<<"//////////////\n"


sum =getArmN(cnum);


<<" is $sum == to $N   $(sum - N)?\n"

if (sum == N) {
<<" Yes $N is Armstrong (Nacissitic) number\n"
}
else {
<<" No $N not Armstrong - try another!\n"
}


  Pan pk = N

  ret=isarmstrong (Ns,10);

<<"$ret  %d $ret  $pk\n"

/*

there are 9 Armstrong 1 numbers 
 0,1,2,3,4,5,6,7,8,9

there are 0 Armstrong 2 numbers took 0.007702  secs


there are 4 Armstrong 3 numbers took 0.536666  secs

   153
   370
   371
   407

there are 3 Armstrong 4 numbers took 5.891107  secs
   1634
   8208
   9474


there are 3 Armstrong 5 numbers
1 54748
2 92727
3 93084

there is 1  Armstrong 6 numbers
 548834    

// XeRaSe

there are 4 Armstrong 7 numbers
 1741725
 4210818
 9800817
 9926315

there are 3  Armstrong 8 numbers
 24678050
 24678051
 88593477

there are 4 Armstrong 9 numbers
   146511208
   472335975
   534494836
   912985153 

there are 1   Armstrong 10 numbers
   4679307774


there are 2?   Armstrong 11 numbers
  32164049650
  32164049651



*/