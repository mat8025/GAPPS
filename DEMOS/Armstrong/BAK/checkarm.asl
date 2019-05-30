///
///  generate armstrong numbers
///

proc getArmN (char  cna[])
{
long pasum = 0;
<<"%V $cna[::] \n"
     cn = cna - 48;
<<"%V $cn[::]\n"
    pasum = 0;
      
      for (i=0; i < np ;i++) {
       <<"$i $cn[i]\n"
        pasum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<" %V $pasum\n"
      return pasum;
}
//==========================



long Anum[100];

long sum = 0;
long psum = 0;

int np =  atoi (_clarg[1])
ulong totn=0;

char nv[20];
char nvm[np];
 nvm = 48;
 
long ks = 1 * 10^(np-1);


long pw[10];

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
	    <<"<$i>$pw[i] \n"
      }



      for (i=0; i < np ;i++) {

            totn += 9*10^i ;
      <<"<$i> $totn \n"
      }
<<"%V $totn \n"


ks= 1000;

//ks = atoi (_clarg[1])
//kstep = atoi (_clarg[2])
//endnum = ks + kstep;

//<<" from $ks to $totn\n";



T = FineTime()
u1 = utime()
na= 0;



<<"%V$totn \n"
// make begin

begin =1
for (i=0; i < (np-1) ;i++) {
begin *= 10;
}

<<"%V $begin \n";




long maxn = 0;
int ip = 1;
int jp =0; // [] 0...9

int k = 9;

while (jp < (np-1)) {
ip = 1;
  while (1) {

   maxn += pw[k];
<<"%V $k $maxn $pw[k] \n"
   if (maxn > totn) {
     maxn -= pw[k];
     break;
  }

  nvm[jp] = k+48;

<<"%V $k $nvm  $jp $nvm[jp]\n"

  ip++;
  jp++;
   if (jp == np) {
    break;
   } 
 }

diff = maxn-totn;

<<"%V $k $ip $maxn $totn  $diff\n"

   sumsofar =getArmN(nvm);
   
  <<"%V $k $sumsofar < $totn\n"

   k--;
   // ans=iread()
}


nvm[np-1] += 1;  // FIXED  -XIC VERS??



//nvm[np-1] = 48+k+2;

long endnum;
long sumover;


<<"%s $nvm\n"
sumover =getArmN(nvm)
<<"$sumover > $totn\n"


endnum = atoi(nvm)
<<" so do ArmNUmbers from $begin to %s $nvm %d $endnum\n"



if (endnum > totn) {
  endnum = totn;
}




str s="123";
last_Mu = memused();
// reset ks - to last session

    j= 0;
  //checkMemory(1);

   for (k=begin; k<= endnum; k++) {


     if ((j % 200) == 0) {
           Mu= memused();

	  // dumpmemtable();
	   <<"<$j>  %V $k  $Mu \n"
            if ((Mu[0]) > 50000) {
<<"too much mem used $Mu\n"
            break;
           }
	   
            for (i=0; i< na; i++) {
             <<"found $(i+1)  $Anum[i]\n"
            }

	   
      }

     j++;;
    //<<"$k\t      \r"
   // <<"%V $mu\n"
  //    ans= iread();
   //   last_mu = mu;
      psum = 0;
      s="$k"
      scpy(nv,s);
      nv -= 48;
      
      for (i=0; i < np ;i++) {
      
         psum += pw[nv[i]]; // get the nth pwr of the  ith place digit
         if (psum > k) {
     // <<"$psum > $k\n";
           break;
	 }
      }
      
      if (k == psum) {
      Anum[na] = k;
      na++;
      <<"$na $k   $psum\n"
      }
      
    }



dt=FineTimeSince(T);

<<"between $ks  and $k "

u2 =utime();

float secs = u2-u1;
if (secs <=100) {
 secs = dt/1000000.0;
}

<<"there are $na armstrong $np numbers took %V $secs\n "
 for (i=0; i< na ; i++) {
  <<"$(i+1)  $Anum[i]\n"
 }






fname = "Armstrong_${np}_nums"

A=ofw(fname)

<<[A]"/{/*\n"
<<[A]"Armstrong $np\n"
<<[A]"there are $na Armstrong $np numbers took $secs  secs\n "
 for (i=0; i< na; i++) {
  <<[A]"$(i+1)  $Anum[i]\n"
 }
<<[A]"/}*/\n "
cf(A)

///////////////////////

/{/*
Armstrong 1
there are 9 Armstrong 1 numbers 0,1,2,3,4,5,6,7,8,9
 /}*/

/{/*
Armstrong 2
there are 0 Armstrong 2 numbers took 0.007702  secs
 /}*/
 

/{/*
Armstrong 3
there are 4 Armstrong 3 numbers took 0.536666  secs
 1   153
2  370
3  371
4  407
/}*/
 


/{/*
Armstrong 4
there are 3 Armstrong 4 numbers took 5.891107  secs
 1   1634
2  8208
3  9474
/}*/





// Armstrong 5
// 54748
// 92727
// 93084

// Armstrong 6
// 548834     XeRaSe

// Armstrong 7
// 1741725
// 4210818
// 9800817
// 9926315

// Armstong 8
// 24678050
// 24678051
// 88593477


