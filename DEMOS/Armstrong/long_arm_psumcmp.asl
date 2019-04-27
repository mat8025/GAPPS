sdb(1,@~pline)

#define ASK ans=iread("carry on: ");

proc pk_found()
{
      Anum[na] = pk;
      na++;
      <<"FOUND!!! $na $pk   $psum\n"
}
//====================
int nums_checked = 0;
proc checklastp( m)
{
nums_checked++;
  int ret =0;

        if (pk < pm1sum) {
             ret = -2;
        }
	else {
        psum = pm1sum + pw[m];

        if (pk < psum) {
            ret = -1;
        }
        else if (pk > psum) {
            ret = 1;
        }	
//         else {
//              pk_found()
//         }
	 }


<<"%V $pk $m $psum $pm1sum $pw[m] $ret\n"	 


return ret;
}
//====================

proc getArmN (char  cna[])
{

psum = 0;
//<<"%V $cna[::] \n"  // BUG
     cn = cna - 48;
     
//<<"%V $cn[::]\n"

psum = 0;
      
      for (i=0; i < np ;i++) {
       <<"<$i> %V $cn[i]\n"
        psum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<" %V $psum\n"
      return psum;
}
//=======================

proc sofar()
{
fname = "ArmstrongL_${np}_sofar"

A=ofw(fname)

u2 =utime();
secs = u2-u1;

<<[A]"/{/*\n"
<<[A]"Armstrong Sofar $pk $np \n"
<<[A]"there are $na Armstrong $np place numbers took $secs  secs\n "
 for (i=0; i< na; i++) {
  <<[A]"$(i+1)  $Anum[i]\n"
 }
<<[A]"/}*/\n "
cf(A)
}
//=======================


//setdebug(1,@pline)

long Anum[100];

long sum = 0;
long psum = 0;
long pm1sum = 0;

int np =  atoi (_clarg[1])
//int np = 4;
long totn=0;

char nv[20];
char nvm[np];

 nvm = 48;


//long ks = (1 * 10^(np-1));

long ks;
long endnum;

float secs = 0.0;


ks = (1 * 10^(np-1));

<<"%V $ks \n"

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }


<<"%V $totn\n"




T = FineTime()
u1 = utime()
na= 0;

last_ut = u1;


long pw[10];  //TBF

int val = 0;

            val = 2^np;

sz =Caz(val);
<<"%V $val $sz\n"
            val = 3^np;
<<"%V $val\n"


      for (i=0; i < 10 ;i++) {
            val = i^np;
            pw[i] = i^np ;
	    <<"<$i> %V $val $pw[i] \n"
      }


<<"%V$totn \n"
// make begin

//long begin =1;

long begin;
 begin =1;

 for (i=0; i < (np-1) ;i++) {
    begin *= 10;
 }

<<"search begins @ $begin\n"

//ASK

long maxn = 0;
long diff;
int ip = 1;
long jp =0;


int k = 9;



long sumover;

maxn = 0;

//setdebug(1,@step)



while (jp < (np-1)) {
<<"%V $jp\n"
  ip = 1;

  while (1) {

    maxn += pw[k];   // long += ?

<<"%V $jp $k $maxn $pw[k] \n"

   if (maxn > totn) {
      maxn -= pw[k];
      break;
   }


    nvm[jp] = k+48;    // long k + 48 ---> nvm[jp] - does not work TBF

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

//   ASK
}




nvm[np-1] += 1;  // FIXED  -XIC VERS??

//nvm[np-1] = 48+k+2;

<<"%s $nvm\n"
sumover =getArmN(nvm)

<<"$sumover > $totn\n"



<<"%V $nvm\n"

//endnum = atol("0000456")

<<"%V $endnum \n"
<<" %s $nvm \n"

endnum = atol(nvm)

//<<" so do ArmNumbers from $begin to %s $nvm %d $endnum\n"

if (endnum > totn) {
  endnum = totn;
}


if (argc() >2) { 
 begin = atol (_clarg[2])
}

if (argc() >3) {
endnum = atol(_clarg[3])
}

if (endnum > totn) {
  endnum = totn;
}

<<" so do ArmNumbers from $begin to  $endnum\n"



str s="123";
last_Mu = memused();
// reset ks - to last session


    long j= 0;


  //checkMemory(1);
   sdb(-1,@~pline)

 pk=begin;
 // should be @ xxx0

 carry =1;
pinc = 10;
	 last_skip_pk = pk;
	 endnum = 200;
while  (pk <= endnum) {



        pm1sum = 0;
        ipk = pk;
        // this is power sum - minus the last place
        s="$pk"
        scpy(nv,s);
        nv -= 48;

//<<"%V$pk  $np \n"

         for (i=0; i < (np-1) ;i++) {
//	 <<"$i $nv[i] $pw[nv[i]] \n"
              pm1sum += pw[nv[i]]; // get the nth pwr of the  ith place digit
	 }
 <<"%V $pk $pm1sum  \n"     

// test xxx5,xxx6 -xxx9 .. xxx4...      
         psum = 0;
         // pk -- xxx5
	   pk += 5;
           rv = checklastp(5);

           if (rv != -2) {
              pinc = 10;

           if (rv== 0) {
               pk_found();
	    
           }

            if (rv > 0) {


	       jj=6
           while (jj <10) {
	     pk++;
	     rv = checklastp(jj);

           if (rv== 0) {
               pk_found();
	    
	       break;
           }

                if ( rv < 0) {
                    // found or no arm in this decade
		    break;
               }
	       jj++;
	     }
         }
	 else if (rv < 0) {
           jj=4;
           while (jj >=0) {
             pk--;
	     rv = checklastp(jj);

           if (rv== 0) {
               pk_found();
	    
	       break;
           }
             if ( rv > 0) {
                    // found or no arm in this decade
		    break;
             }
	     jj--;
           }
         }
        }
	else {
       // ipk += 50;
         pinc = (10-nv[np-2]) * 10
	 <<"setting%V $pk $pinc\n"
/{	 
ans= iread("$last_skip_pk next $ipk + nv[np-2] $pinc ??")
     if (!(ans @="")) { 
<<"setting pinc to $ans\n"
         pinc = atoi(ans)
     }
/}     
	 last_skip_pk = pk;
       }
	
        pk = ipk+pinc;


    }
    

u2 =utime();
secs = u2-u1;

fname = "ArmstrongLS_${np}_nums"

A=ofw(fname)

<<[A]"/{/*\n"
<<[A]"Armstrong $np\n"
<<[A]"there are $na Armstrong $np numbers took $secs  secs\n "
<<"there are $na Armstrong $np numbers took $secs  secs\n "
 for (i=0; i< na; i++) {
  <<[A]"$(i+1)  $Anum[i]\n"
  <<"$(i+1)  $Anum[i]\n"
 }
<<[A]"/}*/\n "
cf(A)
<<"%V $nums_checked  $endnum\n"