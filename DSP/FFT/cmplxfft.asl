///
///  Our decimation in time complex FFT script
///

#define DBPR //

// script version
proc cfft2 ( CS , Size ,dir)
{
//<<" $_proc $Size\n"
int js;
int n_stages;
int pair_sp =1;
int inpt;
int outpt;

int n_grps;
int n_bflys;
float ang =0.0;
float xang =0.0;
float sang =0.0;

float ca;
float sa;
float pi2;

  pi2 = 2.0 *_PI;
  pair_sp = 1;
  n_grps = Size/2;
  n_bflys = 1;
  int gsi = 1;
  int gsi2;

cmplx twf;
cmplx ri_j;
cmplx ri_k;

//<<"%V $pi2\n";
  n_stages = log2(Size);
//<<"%V$n_stages $Size\n"
  vbitrev(CS,Size);  // check vbitrev works for cmplx  -yes!



  for (js = 1 ; js <= n_stages ; js++) {
   inpt = 0;

 //  <<"%V $js\n";

     for (kb = 1 ; kb <= n_grps ; kb++) {
       
//<<"%V $kb\n"
         sang = pi2  / (gsi *2);
	 xang = 0.0;
        for (lb = 1 ; lb <= n_bflys ; lb++) {
          ca = cos(xang);
	  sa = dir * sin(xang);
	  outpt = inpt + pair_sp;

          twf->Set(ca,sa) ;

          ri_j = CS[inpt];
	  ri_k = CS[outpt];
// apply twiddle factor
          ri_k = ri_k * twf;

          CS[inpt] = ri_j + ri_k ;
	  CS[outpt] = ri_j - ri_k ;


if (inpt >= Size) {
<<"out of range $inpt\n"
}

if (outpt >= Size) {
<<"out of range $outpt\n"
}
	  
          xang += sang;
          inpt++;
	 }
	  inpt += gsi;
       }


    gsi *= 2;
    pair_sp *= 2;
    n_grps /= 2;
    n_bflys *= 2;

  }
  
}
//======================================================


//setdebug(1,"pline")


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
int I[];
float sig[N];
cmplx CSvec[N];
 
 pi = 4.0*atan(1.0);
 Sf= 10.0;
 f = 1.0;
 dt = 1.0/Sf;

 sig  = fgen(N,0,2*pi*f*dt);
 pi2 = 2.0 *pi;
 
//<<"Signal pi sampling:- $sig\n";

 isig = sig;
 isig *= 0;
 sig = Sin(sig) ;  // produce a Sine Wave

 sig_sz = Caz(sig);

<<"%V$sig_sz \n"


csv_sz = Caz(CSvec);
<<"%V$csv_sz $(typeof(CSvec))\n"


// dcmplx DCS[N];
//  <<"$CSvec\n"

/{
// fix used to work
  CS[1]->SetReal(47,79)
<<"$CS\n"
  CS[N-1]->Set(80,25)
<<"$CS\n"
/}

sig_sz = Caz(sig);
<<"%V$sig_sz $(typeof(sig))\n"

//iread();

   CSvec->setReal(sig);  // inject the signal real part - array set

csv_sz = Caz(CSvec);
<<"%V$csv_sz $(typeof(CSvec))\n"

//<<"Sine Input:$CS\n" // crash CS not known - should just warn

<<"Sine Input:$CSvec\n"

   CSvec->setImag(isig);  // inject/clear the signal imag part

<<"$CSvec\n"


int nsw = log2(N);

cmplx CStg[nsw][N];


   // cfft (CSvec, N ,-1)

   cfft2 (CSvec, N ,-1)
   

csv_sz = Caz(CSvec);
<<"%V$csv_sz $(typeof(CSvec))\n"
//iread()



   Re = CSvec->getReal()
  

re_sz = Caz(Re);
<<"%V$re_sz $(typeof(Re))\n"

csv_sz = Caz(CSvec);
<<"%V$csv_sz $(typeof(CSvec))\n"

<<"Out \n"

<<"$CSvec\n"

  Re2 = Re;

re2_sz = Caz(Re2);
<<"%V$re2_sz $(typeof(Re2))\n"

//iread()

  cfft (CSvec , N ,-1)

setdebug(-1)

last_m_used = getMemUsed();
<<"%V$last_m_used\n"
int mleak = 0;
int we = 0;
ne = N;
rne = N;

  for (kt = 0; kt < N ; kt++) {
//  for (kt = 0; kt < N ; kt += 1) {

<<"$kt \n"
//<<"$CSvec\n"
sig_sz = Caz(sig);
if (sig_sz != N) {
<<"%V$sig_sz $(typeof(sig))\n"
}
csv_sz = Caz(CSvec);
if (csv_sz != N) {
<<"%V$csv_sz $(typeof(CSvec))\n"
}

rne=CSvec->setReal(sig);  // inject the signal real part - array set
if (rne != N) {
<<"set $rne \n"
}
csv_sz = Caz(CSvec);
//<<"%V$csv_sz $(typeof(CSvec))\n"
  ne=CSvec->setImag(isig);  // inject/clear the signal imag part
if (ne != N) {
<<"set $ne \n";
}

csv_sz = Caz(CSvec);
if (csv_sz != N) {
<<"%V$csv_sz $(typeof(CSvec))\n";
}
      
  Ut = fineTime()
   cfft (CSvec, N ,-1);
 dt1 = fineTimeSince(Ut)
  Re2 = CSvec->getReal();

  re2_sz = Caz(Re2);

//  <<"%V$re2_sz $(typeof(Re2))\n";

 I= Cmp(Re,Re2,"!=");
<<"[${we}] $Re[we] $Re2[we]   $dt1\n"
 m_used = getMemUsed();

 mleak = m_used - last_m_used;

<<"$kt $I[0] mem_used $m_used $last_m_used $mleak\n"

//iread()

  we += 1;
  last_m_used = m_used
  }


<<" done $kt compares\n"

exit ();
