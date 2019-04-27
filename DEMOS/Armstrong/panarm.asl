//%*********************************************** 
//*  @script panarm.asl 
//* 
//*  @comment find Armstrong numbers pan version 
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Thu Apr 18 07:06:11 2019 
//*  @cdate 1/5/2017 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

sdb(-1)

float secs;

#define ASK ans=iread("carry on: ");

proc getArmN (char  cna[])
{

psum = 0;
<<[C]"%V $cna[::] \n"
     cn = cna - 48;
     
//<<[C]"%V $cn[::]\n"

psum = 0;
      
      for (i=0; i < np ;i++) {
       <<[C]"<$i> %V $cn[i]\n"
        psum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<[C]" %V $psum\n"
      return psum;
}
//=======================
int last_na = 0;   // 
proc sofar()
{
static int last_sna = 0;   // BUG?
<<[C]"sofar %V $na $last_na $last_sna $Anum[last_na]\n"
fname = "ArmstrongP_${np}_sofar"

if (na > last_na) {
  num_name = "ArmstrongP_${np}_$Anum[last_na]"
  B= ofw(num_name);
  i = last_na;
  <<[B]"$(i+1) $begin $secs  $Anum[i]\n"
  cf(B)
  last_na = na;
  last_sna = na;  
}

A=ofw(fname)

u2 =utime();
secs = u2-u1;
num_name = ""
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




sdb(-1)

	  mypid = getAslPid();



pan Anum[100];

pan sum = 0;
pan psum = 0;

int np =  atoi (_clarg[1]);
pan totn=0;

char nv[20];
char nvm[np];
 nvm = 48;

	  C= ofw("P_np_${np}_${mypid}.log")

//pan ks = (1 * 10^(np-1));
pan ks;

ks = (1 * 10^(np-1));

<<[C]"%V $ks \n"

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }


<<[C]"%V $totn\n"




T = FineTime()
u1 = utime()
na= 0;

last_ut = u1;

pan pw[10];  //TBF
//long pw[10];  //TBF

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
	    <<[C]"<$i>$pw[i] \n"
      }

<<[C]"%V$totn \n"
// make begin

//pan begin =1;
pan begin;
begin =1;

 for (i=0; i < (np-1) ;i++) {
    begin *= 10;
    begin += 1;
}

    begin += 1;

<<[C]"%V $begin\n"
//ans=iread();

<<[C]"search begins @ $begin\n"

//ASK

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

<<[C]"%V $k $maxn $pw[k] \n"

   if (maxn > totn) {
     maxn -= pw[k];
      break;
   }


    nvm[jp] = k+48;    // pan k + 48 ---> nvm[jp] - does not work TBF

<<[C]"%V $k $nvm  $jp $nvm[jp]\n"

     ip++;
     jp++;

     if (jp == np) {
       break;
     }

   }

diff = maxn-totn;

<<[C]"%V $k $ip $maxn $totn  $diff\n"

    sumsofar =getArmN(nvm)

   <<[C]"$k $sumsofar < $totn\n"
   k--;
   //ans=iread()
}




nvm[np-1] += 1;  // FIXED  -XIC VERS??

//nvm[np-1] = 48+k+2;

<<[C]"%s $nvm\n"
sumover =getArmN(nvm)

<<[C]"$sumover > $totn\n"



pan endnum;

<<[C]"%V $nvm\n"

endnum = atop("0000456")

<<[C]"%V $endnum \n"
<<[C]" %s $nvm \n"
endnum = atop(nvm)



//<<" so do ArmNumbers from $begin to %s $nvm %d $endnum\n"


if (endnum > totn) {
  endnum = totn;
}

if (argc() >2) { 
 begin = atop (_clarg[2])
}

if (argc() >3) {
endnum = atop(_clarg[3])
}

if (endnum > totn) {
  endnum = totn;
}

if (begin > endnum) {
<<"%V $begin > $endnum \n"
  exit()
}



str s="123";
last_Mu = memused();
// reset ks - to last session

pan j= 1;


//pan last_j= 1;

pan last_j ;


double etc;

nums = 1000;

pk = begin;
N_report = 5000;
if (np < 7) {
  nums = 100;
  N_report = 2000;
}
else {
   nums = 1000;
}

if (np >=10) {
  N_report = 100000;
}



<<" finding ArmNumbers from $begin to $endnum  $pk  $(date())\n"
<<[C]" finding ArmNumbers from $begin to  $endnum  $(date())\n"

long nums_chkd;
pan pnums;

pnums = nums;
double pc_done;
pan num2dO = endnum -pk;
int kloop = 0;
pan last_pk;

last_pk = pk;

last_j = j;


//j->info(1);
//last_j->info(1);
long jj = 0;
last_jj = jj;
while  ( pk <= endnum) {


     if (kloop >= N_report) {
             kloop = 0;

//<<"%V $secs   \n"	     
           u3 =utime();
	   
	   if ((u3- last_ut) >= 20) {
	   
	     dt=FineTimeSince(T,1);
	     secs = dt/1000000.0;
             etc = (endnum-pk)/ (1.0*N_report) * secs/360.0;
              days = etc/24.0;
              pc_done = Fround(((j/num2dO) *100.0),4);

              nums_chkd = jj - last_jj;
              last_jj = jj;
	      
//       last_pk = pk;
//               last_j->info(1)
	       
        //       last_j = j;

//               j->info(1)
//<<"<$j> $pk $nums_chkd found $na  took $secs secs $pc_done pc  $etc hrs \r"
//              fflush(1)
//<<"<$j> $pk  found $na  took $secs secs $pc_done pc  $etc hrs \r"	     

<<[C]"<$j> $pk $nums_chkd found $na  took $secs secs $pc_done pc  $etc hrs "

//<<"<$j> $pk found $na  took $secs secs %6.2f $etc hrs $days days "
// <<"$pk $Anum[0] ETC %6.2f$how_long \n"

            if (na > 0) {
             <<[C]"found $na  @ "
	     for (i=0;i<na;i++) {
	     <<[C]" $Anum[i] "
	     }
	     <<[C]"\n"
            }
	    else {
             <<[C]"\n"
            }
	    fflush(C);
	    last_ut = u3;
	    }

        }
//<<"\r"

    //<<"$k\t      \r"
   // <<"%V $mu\n"
  //    ans= iread();
   //   last_mu = mu;


      psum= isarmstrong("$pk",nums)
     
      if ( psum > 0) {
 //<<"$pk isarm? $psum \n"
// ans=iread(">");
      j += (psum-pk);
      kloop += (psum-pk);
      pk = psum;
      Anum[na] = pk;
      na++;
      <<[C]"$na $pk   $psum\n"
  //    <<"$na $pk   $psum\n"
      sofar()
      pk++;
    //  <<"$na $pk   $psum\n"
      }
      else {
      pk = pk +nums;
      jj += nums;
      //j += nums;
      j =  j + pnums;
 //     j->info(1)
      kloop += nums;
      }
  

//<<"%V $j $pk $na  %6.2f $pc_done\r"      

}





<<[C]"between $ks  and $k "

u2 =utime();


secs = u2-u1;


<<[C]"there are $na armstrong $np numbers took %V $secs\n "
 for (i=0; i< na ; i++) {
  <<[C]"$(i+1)  $Anum[i]\n"
 }

cf(C)
//============================//

<<"there are $na armstrong $np numbers took %V $secs\n "
 for (i=0; i< na ; i++) {
  <<"$(i+1)  $Anum[i]\n"
 }



fname = "ArmstrongP_${np}_nums"

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

// Armstrong 8
// 24678050
// 24678051
// 88593477

// Armstrong 9
// 146511208
// 472335975
// 534494836
// 912985153 

// Armstrong 10
// 1465511208
// 4679307774

// Armstrong 11

