///  translation of out C cmpx fft routine
///

#define DBPR  //
proc sfft (rl, im, size, fwd)
{
  int nmul = 0;
  int stage;
  int i;
  int  ibfly;
  int  ipt;
  int  j;
  int  jj;
  int  jjj;
  int  j1;
  int  j2;

  int np;
  int  p2;
  int  lix;
  int  lmx;


 float ang;
 float  xang;
 float  c;
 float  s;
 float  t1;
 float  t2;

  float pi2 = 6.283185307
  //float alog2 = 0.6931471806;
  float fwd_dir;

  if (fwd == 1)
    fwd_dir = 1.0;
  else
    fwd_dir = -1.0;

  float rx;
  float ix;

  // Determine transform size */

  np = size;
  //p2 =  (0.5 + (log ( np)) / alog2);
  p2 = log2(size);
  psize = pow(2,p2)
  xang = pi2 /  np;
  lmx = np;
DBPR<<"%V$np $p2 $psize $xang $lmx\n"


//<<"%V$i $j rlsz $(Caz(rl)) imsz $(Caz(im))\n"
DBPR<<"$p2 stages \n"

  // Compute each stage of the transform 

//
// do bit rev here or after?
//
//


  for (i = 0; i < p2; i++)
    {
      stage = i+1;
      lix = lmx;
      lmx = lmx / 2;
      ang = 0.0;



DBPR<<"stage $stage  j $j rlsz $(Caz(rl)) imsz $(Caz(im))\n"
DBPR<<"%V$lix  $lmx\n"
//ans=iread("for stage $stage \n")

      // Compute for each butterfly */

      for (ibfly = 0; ibfly < lmx; ibfly++)
	{

        //ans = iread("for butterfly $ibfly")
//<<"%V$ibfly rlsz $(Caz(rl)) imsz $(Caz(im))\n"

	  c = cos (ang);
	  s = fwd_dir * sin (ang);
DBPR<<"$ibfly %V$ang $c $s\n"
	  ang += xang;

	  // Compute for each point */
            for (ipt = lix; ipt <= np; ipt += lix)
	    {
	    //ans = iread("for pt $ipt")
sz = Caz(rl)
//<<"%V$sz\n"
//<<"%V$ipt rlsz $(Caz(rl)) imsz $(Caz(im))\n"

	      j1 = ipt - lix + ibfly;
	      j2 = j1 + lmx;
DBPR<<"%V$ipt  $j1 $j2\n"
//              rx = rl[j1];
//              ix = im[j1];

//<<"$ipt %V$j1 $j2 $rx $ix \n"

	      // Butterfly calculation */
	      t1 = rl[j1] - rl[j2];
	      t2 = im[j1] - im[j2];
//<<"%V$t1 $t2\n"	      
//<<"%I$rl\n"
//<<"$rl\n"
sz = Caz(rl)
//<<"%V$sz\n"

//<<"%V$ipt rlsz $(Caz(rl)) imsz $(Caz(im))\n"
//<<" $rl[j2]  $im[j2] \n"
//<<"%V$t1 $t2\n"

	      rl[j1] = rl[j1] + rl[j2];
	      im[j1] = im[j1] + im[j2];

DBPR<<"$rl[j1]  $im[j1]\n"
//sz = Caz(rl)
//<<"%V$sz\n"
	      rl[j2] = c * t1 + s * t2;
	      im[j2] = c * t2 - s * t1;
              nmul += 4;
DBPR<<"$rl[j2]  $im[j2]\n"

//sz = Caz(rl)
//<<"%V$sz\n"


	    }
sz = Caz(rl)
//<<"%V$sz\n"
//<<"%V$i $j rlsz $(Caz(rl)) imsz $(Caz(im))\n"

	}
DBPR<<"stage $(i+1) nmul $nmul Out\n"

DBPR<<"$rl[::] \n"

DBPR<<"$im[::] \n"

      xang *= 2.0 ;
DBPR<<"\n"
 }

//<<"B4 bitrev %V$i $j rlsz $(Caz(rl)) imsz $(Caz(im))\n"
  // Bit reversal  */

  vbitrev(rl,np)
  vbitrev(im,np)

  j = 0;
  jj = np / 2;

/{
  for (i = 0; i < (np - 1); i++)
    {
      if (i < j)
	{
//<<"%V$i $j rlsz $(Caz(rl)) imsz $(Caz(im))\n"

//          vswop(rl,i,j)
//          vswop(im,i,j)

	  t1 = rl[j];
	  t2 = im[j];
	  rl[j] = rl[i];
	  im[j] = im[i];
	  rl[i] = t1;
	  im[i] = t2;

	}
      jjj = jj;
      while (jjj < (j + 1))
	{
          j -= jjj;
          jjj /= 2;
	}
      j += jjj;
    }
/}
  return p2;
}

//--------------------------------------------------------------
int fdir = 1 
int N = 8

 na = argc()
<<"%V$na  $_clarg \n"
 if (na > 1) {
 N = atoi (_clarg[1])
 if (N >=2 && N <=256) {
<<"$N \n"
 }
 else {
<<" N $N too big for print vectors\n"
 <<" use N= 16\n:
   N = 16
 }
  if (na > 2) {

   fdir = atoi(_clarg[2])
<<" direction of fft $fdir\n"

  }

 }

float Re[N];
float Im[N];
 fscale = 1.0/N;
 pi = 4.0*atan(1.0);
 Sf= 10.0;
 f = 1.0;
 dt = 1.0/Sf;

 sig  = fgen(N,0,2*pi*f*dt)

<<"Signal:- $sig\n"

 Re = sin(sig);
 Im = 0;
<<"In \n"
<<"$Re\n"
<<"$Im\n"
  Ut = fineTime()
  fft (Re, Im, N, fdir);
  dt1 = fineTimeSince(Ut)

<<" library fft ---------------------------------------\n"
<<"Out \n"
<<"$Re\n"
<<"$Im\n"
<<"%V$dt1\n"
<<"----------------------------------------------------\n"
<<" now inverse ! -------------------------------------\n"
 fft (Re, Im, N, -fdir);
<<"Out \n"
<<"$Re\n"
<<"$Im\n"
<<" scale it by 1/N\n"
  Re *= fscale;
  Im *= fscale;
<<"$Re\n"
<<"$Im\n"
<<" library dit fft ---------------------------------------\n"
 Re = sin(sig);
 Im = 0;
<<"In \n"
<<"$Re\n"
<<"$Im\n"
  Ut = fineTime()
  fftdit (Re, Im, N, -1*fdir);
  dt1 = fineTimeSince(Ut)

<<"Out \n"
<<"$Re\n"
<<"$Im\n"
<<"%V$dt1\n"
<<"----------------------------------------------------\n"

<<" now inverse ! -------------------------------------\n"

  fftdit (Re, Im, N, fdir);

<<"Out \n"
<<"$Re\n"
<<"$Im\n"

<<" scale it by 1/N\n"
  Re *= fscale;
  Im *= fscale;
<<"$Re\n"
<<"$Im\n"
<<"----------------------------------------------------\n"


//goon=iread("script version->")

 Re = sin(sig);
 Im = 0;
<<"In \n"
<<"$Re\n"
<<"$Im\n"
  Ut = fineTime()

  sfft (Re, Im, N, fdir);

  dt2 = fineTimeSince(Ut)
<<" script fft ---------------------------------------\n"
<<"Out \n"
<<"$Re\n"
<<"$Im\n"
<<"%V$dt2\n"
float Re2[];

   Re2 = Re;

  for (kt =0 ; kt < 20; kt++) {

   Re = sin(sig);
    Im = 0;

   sfft (Re, Im, N, fdir);

   I= Cmp(Re,Re2,"!=")

<<"$kt $I[0]\n"


  }