///
///  generate armstrong numbers
///

//setdebug(0,@keep,@trace)

proc getArmN (char  cna[])
{

psum = 0;
<<"%V $cna[::] \n"
     cn = cna - 48;
     
<<"%V $cn[::]\n"

psum = 0;
      
      for (i=0; i < np ;i++) {
       <<"<$i> %V $cn[i]\n"
        psum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<" %V $psum\n"
      return psum;
}
//=======================
//setdebug(1,@pline)

pan Anum[100];

pan sum = 0;
pan psum = 0;

int np =  atoi (_clarg[1])
pan totn=0;

char nv[20];
char nvm[np];
 nvm = 48;


//pan ks = (1 * 10^(np-1));
pan ks;

ks = (1 * 10^^(np-1));

<<"%V $ks \n"

      for (i=0; i < np ;i++) {
            totn += 9*10^^i ;
      }


<<"%V $totn\n"

exit()


T = FineTime()
u1 = utime()
na= 0;

last_ut = u1;

//pan pw[10];  //TBF
long pw[10];  //TBF

      for (i=0; i < 10 ;i++) {
            pw[i] = i^^np ;
	    <<"<$i>$pw[i] \n"
      }

<<"%V$totn \n"
// make begin

//pan begin =1;
pan begin;
begin =1;

 for (i=0; i < (np-1) ;i++) {
    begin *= 10;
 }

<<"%V $begin\n"
//ans=iread();

pan maxn = 0;
pan diff;
int ip = 1;
int jp =0

///pan k = 9; // [] 0...9
int k = 9;



pan sumover;

maxn = 0;

//setdebug(1,@step)

while (jp < (np-1)) {

  ip = 1;

  while (1) {

    maxn += pw[k];   // pan += ?

<<"%V $k $maxn $pw[k] \n"

   if (maxn > totn) {
     maxn -= pw[k];
      break;
   }


    nvm[jp] = k+48;    // pan k + 48 ---> nvm[jp] - does not work TBF

<<"%V $k $nvm  $jp $nvm[jp]\n"

     ip++;
     jp++;

     if (jp == np) {
       break;
     }

   }

diff = maxn-totn;

<<"%V $k $ip $maxn $totn  $diff\n"

    sumsofar =getArmN(nvm)

   <<"$k $sumsofar < $totn\n"
   k--;
   //ans=iread()
}




nvm[np-1] += 1;  // FIXED  -XIC VERS??

//nvm[np-1] = 48+k+2;

<<"%s $nvm\n"
sumover =getArmN(nvm)

<<"$sumover > $totn\n"



pan endnum;

<<"%V $nvm\n"

endnum = atop("0000456")

<<"%V $endnum \n"
<<" %s $nvm \n"
endnum = atop(nvm)

<<" so do ArmNUmbers from $begin to %s $nvm %d $endnum\n"



if (endnum > totn) {
  endnum = totn;
}


str s="123";
last_Mu = memused();
// reset ks - to last session

    int  j= 0;

   //long j= 0;


checkMemory(0); // 1 - track memory use


pan pk;

   for (pk=begin; pk<= endnum; pk++) {


//   <<"$j  $pk \n"
   
     if (j++ == 200)  {  //  faster than pan mod
           j = 0;
           Mu= memused();
	   
           u3 = utime();
	   
	  // dumpmemtable();
	 //  <<"<$j> $k  $Mu took $(u3-last_ut) secs \n"
	   <<"<$j> $pk   memuse $Mu[0] took $(u3-last_ut) secs \n"
	    <<"memuse $Mu\n"
/{
          if ((Mu[0]) > 50000) {
<<"too much mem used $Mu\n"
            break;
           }
/}

            for (i=0; i< na; i++) {
             <<"found $(i+1)  $Anum[i]\n"
            }
            last_ut = u3;
	   
      }



      psum = 0;

      s="$pk"

      scpy(nv,s);

      nv -= 48;
      
      for (i=0; i < np ;i++) {
      
         psum += pw[nv[i]]; // get the nth pwr of the  ith place digit
         if (psum > pk) {
     // <<"$psum > $k\n";
           break;
	 }
      }
      
      if (pk == psum) {
      Anum[na] = pk;
      na++;
      <<"$na $pk   $psum\n"
      }
      
    }



dt=FineTimeSince(T);

<<"between $ks  and $pk "

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


