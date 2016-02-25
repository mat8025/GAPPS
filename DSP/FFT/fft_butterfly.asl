////  show  butterfly  for FFT radix 2  /////

#define DBPR  <<
//#define DBPR  ~!

proc sbitrev( ival, n)
{
int I[n]
int j;

     k = 1
     for (j = 0; j < n ; j++) {
        b = (ival & k);
        k = ( k << 1);
        I[j] = !(b ==0);
     }

     I->reverse()

     c = 0;
     k = 1;
     for (j = 0; j < n ; j++) {
       if (I[j] == 1) {
         c = c + k
       }
         k = (k << 1)
     }
     return c;
}
/////////////////////////////////////////

 na = argc()

<<"%V$na  $_clarg \n"

 N = atoi (_clarg[1])

 if (N <= 0) {
 <<"no N specified setting to 16\n"
  N= 16
 // exitsi()

 }
// is it power of 2 ?

 int n = log2(N)

 M = 2^^n

<<"%V$N $n  $M\n"

 if (M != N) {

<<"not power of 2\n"

  exitsi()

 }
///////////////////////////////////////////////


// set up the complex Re Im vectors

float Re[N];
float Im[N];

float ReI[N];
float ImI[N];


 pi = 4.0*atan(1.0);
 Sf= 10.0;
 f = 1.0;
 dt = 1.0/Sf;

 sig  = fgen(N,0,2*pi*f*dt)
 pi2 = 2.0 *pi;
<<"Signal pi sampling:- $sig\n"

 Re = sin(sig);
 Im = fgen(N,0,0.00001)
 Im = 0
<<"In \n"

<<"%V$Re\n"
<<"%V$Im\n"



/// then how many stages


///  draw pairs


int n_stages = log2(N)

float ReStg[n_stages][N]
float ImStg[n_stages][N]


int pair_sp =1;
int inpt;
int outpt;
//<<"%V$n_stages $n_bflys\n"
int n_grps;
int n_bflys;
float ang =0.0;
float xang =0.0;
float sang =0.0;

float ca;
float sa;

  pair_sp = 1;
  n_grps = N/2;
  n_bflys = 1;
  int gsi = 1;

// we are doing decimation in time
// so we do the bitrev shuffle at
// the start

  ReI = Re
  ImI = Im
  vbitrev(Re,N)
  vbitrev(Im,N)
  <<"BitRev input arrays\n"
<<"%V$Re\n"
<<"%V$Im\n"


cmplx twf;
cmplx ri_j;
cmplx ri_k;

int dir = 1;

//<<"%V$twf\n"
//twf->Set(47,79.0)

 for (js = 1 ; js <= n_stages ; js++) {

DBPR"%V $n_grps $n_bflys \n"
     inpt = 0

     for (kb = 1 ; kb <= n_grps ; kb++) {
         sang = pi2  / (gsi*2);
	 xang = 0.0;
       for (lb = 1 ; lb <= n_bflys ; lb++) {
         ang = pi2 * (lb-1) / (gsi*2) 
         ca = cos(xang);
	 sa = dir * sin(xang);
         outpt = inpt + pair_sp;
 DBPR"%V$Re\n"
 DBPR"%V$Im\n"
// sz= Caz(Re)
// DBPR"%V$sz\n"
DBPR"%V$dir $xang $ca $sa\n"

         twf->Set(ca,sa) 

DBPR"%V$twf\n"
         // store current for inplace stage update
DBPR"$inpt  $Re[inpt] $Im[inpt]\n"
DBPR"$outpt  $Re[outpt] $Im[outpt]\n"

         ri_j->Set(Re[inpt],Im[inpt]);
         ri_k->Set(Re[outpt],Im[outpt]);
           

DBPR"%V$ri_j\n"
DBPR"%V$ri_k\n"

// apply twiddle factor
         ri_k = ri_k * twf;
DBPR"mul by twf %V$ri_k\n"	 
         // sum bfly inputs

       // Re[inpt] += ri_k->getReal()
      //  Im[inpt] += ri_k->getImag ()

         ri_jr = ri_j->getReal()
	 ri_ji = ri_j->getImag()

         ri_kr = ri_k->getReal()
	 ri_ki = ri_k->getImag()


         //Re[inpt] = ri_j->getReal()  + ri_k->getReal()
	 //Im[inpt] = ri_j->getImag() + ri_k->getImag ()

	 Re[inpt] = ri_jr + ri_kr ;
	 Im[inpt] = ri_ji + ri_ki ;


DBPR"next stage [${inpt}]  $Re[inpt] $Im[inpt]\n"	 
 DBPR"%V$Re\n"
 DBPR"%V$Im\n"
 sz= Caz(Re)
 DBPR"%V$sz\n"

//
//	 Re[outpt] -= ri_j->getReal()
//	 Im[outpt] -= ri_j->getImag ()

DBPR"%V$ri_j\n"	 
DBPR"%V$ri_k\n"	 

	 //Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????

	 Re[outpt] = ri_jr - ri_kr ;
	 Im[outpt] = ri_ji - ri_ki ;


 DBPR"next stage [${outpt}]  $Re[outpt] $Im[outpt]\n"
 DBPR"%V$Re\n"
 DBPR"%V$Im\n"
 sz= Caz(Re)
 DBPR"%V$sz\n"


DBPR"Stage $js i_grpg $kb  i_bfly $lb $pair_sp ip_op $inpt --> $outpt $outpt --> $inpt" 
DBPR" W$(lb-1)/$(gsi*2) ang $ang xang $xang  $ca $sa\n"

         xang += sang;
         inpt++;
       }
       DBPR"\n"
       inpt += gsi;
      // iread()
    }
    DBPR"\n"
    gsi *= 2;
    pair_sp *= 2;
    n_grps /= 2;
    n_bflys *= 2;

DBPR"%V$Re\n"
DBPR"%V$Im\n"
 
   ReStg[js-1][::] = Re
   ImStg[js-1][::] = Im
DBPR"%V$dir\n"
}


 <<"%V$Re\n"
 <<"%V$Im\n"

//  vbitrev(Re,N)
//  vbitrev(Im,N)
//  <<"BitRev input arrays\n"
// <<"%V$Re\n"
// <<"%V$Im\n"
////////////// Window ///////////////////
 Graphic = CheckGwm()

 if (!Graphic) {
   exit()
 }

 aw = cWi(@title,"BUTTERFLY_DEMO",@resize,0.01,0.01,0.99,0.99)
 sWi(aw,@hue,BLUE,@bhue,WHITE,@drawon,@pixmapon)


// wob

     bflywo = cWo(aw,@graph,@penhue,RED,@name,"butterfly")

     sWo(bflywo,@resize,0.01,0.01,0.99,0.99)

     sWo(bflywo,@clip,0.1,0.1,0.9,0.95,@drawon,@save,@savepixmap)

     sWo(bflywo,@scales,0,0,1.0,1.0)

     sWi(aw,@redraw)

     naw=wkeep(aw)

     sWo(bflywo,@border,@redraw)
// lines

    gy = 0.96 // use this ratio of drawing area
    goy = (1-gy)/2
 
    float dy = 0.96/ N
    dx = 0.96 / n_stages 

///////////  label stages ///////////////////////
    x = dx/2
    for (i = 1; i <= n_stages ; i++ ) {
         Text(bflywo,"Stage_$i",x, 1.0,TEXT_AXIS_TOP)
         x += dx
    }

///////////////////////////////////////////////////
///////////  label input /////////////////////////
/// label bit-reversed input  e.g for 4  0,1,2,3  bitrev 00,10,01,11  x(0),x(2),x(1),x(3)
/// for 8 0,1,2,3,4,5,6,7  000, 100, 010, 110, 001, 101, 011, 111 --
/// --- x(0), x(4),x(2),x(6),x(1),x(5),x(3),x(7)

    int bri = 0;
     y =  1-goy;
	
    for (i = 0; i < N ; i++ ) {
        bri = bitrev(i,n_stages)

        Text(bflywo,"Re[${bri}] $ReI[bri]", y, 9.0,TEXT_AXIS_LEFT)
        Text(bflywo,"Im[${bri}] $ImI[bri]", y-dy/6, 9.0,TEXT_AXIS_LEFT)	
        y -= dy
    }
/{
     y =  1-goy;

    for (i = 0; i < N ; i++ ) {
        bri = bitrev(i,n_stages)
        Text(bflywo,"x($bri)", y, 3.0,TEXT_AXIS_LEFT)
        y -= dy
    }
/}
//////////////////////////////////////////////////////////

/// label Frequency output  0,1,2,3,4, ...
/{
   y =  1-goy
    for (i = 0; i < N ; i++ ) {
        Text(bflywo,"Re[${i}] $Re[i]", y, 8.0,TEXT_AXIS_RIGHT)
        Text(bflywo,"Im[${i}] $Im[i]", y-dy/6, 8.0,TEXT_AXIS_RIGHT)	
        //Text(bflywo,"F($i)", y, 1.0,TEXT_AXIS_RIGHT)
             y -= dy
    }
/}
    y =  1-goy

    for (i = 0; i < N ; i++ ) {

     plot(bflywo,@line,0,y,1,y,BLUE)

     y -= dy
<<"$i $y \n"
    // sWo(bflywo,@showpixmap)
    }

//////////////////////////////////////////////////////////
float dxs
float dxsa
    y =  1-goy
    x = dx/4
    dxs = x * 3
    dxsa = x * 2.4
    dxsri = x * 2.55

/////////   BUTTERFLIES   ////////////////////////////////

// how many stage 1 butterflies ?

  for (j = 1 ; j <= n_stages ; j++) {

      nos = j
      p2 = 2^^nos
      nbfis = N / p2


      nlib = p2
      ntbl = nlib/2

<<"%V$j $nbfis $nlib $ntbl $x $n_stages\n"

      ty =  1 - goy

    for (i = 0; i < nbfis ; i++ ) {

      y = ty - (i * (nlib*dy)) 

      // top lines
      for (k = 0 ; k < ntbl ; k++) {
       plot(bflywo,@arrow,x,y,x+dxsa,y-(nlib/2*dy),1.0,BLUE)
       y -= dy
      }

      // bottom lines
      y = ty - (i* (nlib*dy)) - (dy *ntbl)
      for (k = 0 ; k < ntbl ; k++) {
          plot(bflywo,@arrow,x,y,x+dxsa,y+(nlib/2*dy),1.0,RED)
          Text(bflywo,"W$k/$p2",x+(-dxs/10),y)
          Text(bflywo,"-1",x+(3*dxs/4),y-dy/4)
          y -= dy
      }


      // compute 
      // each butterfly
      // two inputs
      // -- straight thru
      // -- mul by twiddle factor
      // top output  = top_input + Twf * bot_input
      // bot output  = top_input - Twf * bot_input

      // show Re,Im
      y =  1-goy
      for (k = 0; k < N ; k++ ) {
        Text(bflywo,"Re[${k}] $ReStg[j-1][k]",x+dxsri, y)
        Text(bflywo,"Im[${k}] $ImStg[j-1][k]",x+dxsri, y-dy/6)	
        y -= dy
      }


//<<"$i $y \n"
    }
          x += dx  
 }


/////////////////////////////////////
/// for each stage do the butterflies
/// now label the twiddle factors
///  finally  produce the eqn's

  gflush()
  sleep(3)



////////////////////////////////////////////////////////////////////
//  current
//  ? imag sign diff


// 4 via script dec in time 
// Re 2.489898 -0.951057 -0.587785 -0.951057
// Im 0.000000 -0.363271 0.000000 0.363271

// 8 via script dec in time 
// Re 1.538841 -1.517155 0.224514 0.341585 0.363271 0.341585 0.224514 -1.517155
// Im 0.000000 3.299466 0.587785 0.221782 0.000000 -0.221782 -0.587785 -3.299466


/// compare with C fft lib

// 4 via sfft/and C function
// Re 2.489898 -0.951057 -0.587785 -0.951057
// Im 0.000000 0.363271 0.000000 -0.363271



// 8 via sfft op
// Re 1.538841 -1.517155 0.224514 0.341585 0.363271 0.341585 0.224514 -1.517155
// Im 0.000000 -3.299466 -0.587785 -0.221782 0.000000 0.221782 0.587785 3.299466


// fwd direction ??
// Re 1.538841 -1.517155 0.224514 0.341585 0.363271 0.341585 0.224514 -1.517155
// Im 0.000000 -3.299466 -0.587785 -0.221782 0.000000 0.221782 0.587785 3.299466
