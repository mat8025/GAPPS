///
///  Our decimation in time complex FFT script
///

#define DBPR //


//setdebug(1,"pline")

proc gsFFT (Rev, Imv, size, dir)
{
int ok = 1;
int js,kb,lb;
int inpt;
int outpt;
int n_grps;
int n_bflys;

int pair_sp =1;
int n_stages = log2(size);
int gsi = 1;

 pi2 = 6.283185307;
 xang =0.0;
 sang =0.0;
 ca;
 sa;
 //re1,re2,im1,im2;

  pair_sp = 1;
  n_grps = size/2;
  n_bflys = 1;

  //for (int i = 0; i < size; i++) {
  //  DBP("[%d] Rev %f Imv %f\n",i,Rev[i],Imv[i]);
  // }
  //DBP("\n");
  
  vBitRev(Rev,size);
  vBitRev(Imv,size);


  // for (int i = 0; i < size; i++) {
  //  DBP("[%d] Rev %f Imv %f\n",i,Rev[i],Imv[i]);
  //}

  
 for (js = 1 ; js <= n_stages ; js++) {

   inpt = 0;

     for (kb = 1 ; kb <= n_grps ; kb++) {
         sang = pi2  / (gsi*2);
	 xang = 0.0;
       for (lb = 1 ; lb <= n_bflys ; lb++) {
         ca = cos(xang);
	 sa = dir * sin(xang);
         outpt = inpt + pair_sp;
	 //	 DBP("ca %f sa %f\n",ca,sa);
         // store current for inplace stage update
   
	 re1 = Rev[inpt];
	 im1 = Imv[inpt];
	 //DBP("inpt %d outpt %d\n",inpt,outpt);
	 //DBP("re1 %f im1 %f\n",re1,im1);
         re2 = Rev[outpt];
	 im2 = Imv[outpt];
	 //DBP("re2 %f im2 %f\n",re2,im2);
	 
// apply twiddle factor W nN  e-j*2pi*n/n
// complex multiply
	 
	 re2 = (Rev[outpt]*ca - Imv[outpt]*sa);
	 im2 = (Rev[outpt]*sa + Imv[outpt]*ca);
         //DBP("Twf mul re2 %f im1 %f\n",re2,im2);
	 
// sum butterfly inputs
	 Rev[inpt] = re1 + re2 ;
	 Imv[inpt] = im1 + im2 ;

	 Rev[outpt] = re1 - re2 ;
	 Imv[outpt] = im1 - im2 ;
         //DBP("inpt %f %f\n",Rev[inpt],Imv[inpt]);
	 //DBP("outpt %f %f\n",Rev[outpt],Imv[outpt]);
         xang += sang;
         inpt++;
       }
       inpt += gsi;
    }
    gsi *= 2;
    pair_sp *= 2;
    n_grps /= 2;
    n_bflys *= 2;
    //DBP("js %d  gsi %d n_bflys %d\n",js,gsi,n_bflys);
 }
    return ok;
}
//============================================================



setdebug(-1)

//xic(0)
int N = 0;
int n = 0;
int dir = 1;

////////////////////////// PARSE ARGS /////////////////////
na = argc ();

<<"%V$na  $_clarg \n";

if (na > 1)
  {

    N = atoi (_clarg[1]);

// is it power of 2 ?
    if (N <= 0)
      {
	<<"size $N must be power of 2\n";
	exit ();
      }

    n = log2 (N);
    M = 2 ^^ n;

//<<"%V$N $n  $M\n"

    if (M != N)
      {
	<<"size $N must be power of 2\n";
	exitsi ();
      }

  }


 if (N <= 0)
  {
    <<"no size specified setting to 16\n";
    N = 16;
    n = 4;
  }


 if (na >= 3)
  {
    dir = atoi (_clarg[2]);
    <<"setting %V$dir\n"
    if (dir >= 0) {
    <<"dir has to be -1 or 1\n"
      dir = 1;
    }
    else {
      dir = -1;
    }
  }


<<"size $N pwr2 $n  dir $dir\n";

   //////////////////////////////////////////////////


  ///   Make an input Signal - Real Only
float Re[];
float Re2[];
float Im[];

int I[];
float sig[N];


 pi = 4.0*atan(1.0);
 Sf= 10.0;
 f = 1.0;
 dt = 1.0/Sf;

 sig  = fgen(N,0,2*pi*f*dt);
 
//<<"Signal pi sampling:- $sig\n";

 isig = sig;
 isig *= 0;
 sig = Sin(sig) ;  // produce a Sine Wave
 sig_sz = Caz(sig);


<<"%V$sig_sz $(typeof(sig))\n"


int nsw = log2(N);

   Re = sig;
   re_sz = Caz(Re);
<<"%V$re_sz $(typeof(Re))\n"

   Im = isig;
   im_sz = Caz(Im);

<<"%V$im_sz $(typeof(Im))\n"   


  gsFFT (Re, Im, N ,-1)

<<"Out \n"
<<"$Re\n"
<<"$Im\n"


  Re2 = Re;

re2_sz = Caz(Re2);
<<"%V$re2_sz $(typeof(Re2))\n"

//iread()

  gsFFT (Re,Im , N ,-1)

last_m_used = getMemUsed();
<<"%V$last_m_used\n"
int mleak = 0;
  int we = 0;

  for (kt = 0; kt < N ; kt++) {


   sig_sz = Caz(sig);
<<"%V$sig_sz $(typeof(sig))\n"


//<<"$sig\n"
//<<"$isig\n"

  Re= sig;
  Im= isig;

  gsFFT (Re,Im, N ,-1)
  
  m_used = getMemUsed();

  mleak = m_used - last_m_used;
  re_sz = Caz(Re);
 <<"%V$re_sz $(typeof(Re))\n"
<<"[${we}] $Re[we] $Re2[we]\n"

  I= Cmp(Re,Re2,"!=")

 <<"$kt $I[0] mem_used $m_used $last_m_used $mleak\n"
   //we = we + 1;
   we++;
   if (we == N) {
       we = 0;
   }

last_m_used = m_used

  }


<<" done $kt compares\n"

exit ();
