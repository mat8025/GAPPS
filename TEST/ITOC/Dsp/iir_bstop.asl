///
///  iir band pass filter
///

setdebug(1)


float D[10];
float C[10];
float B[10];
float A[10];

float AMP[501];

Cmplx cg;

iband = 4; // band stop

float fl = 1500.0

float fh = 3500.0;


int ln = 4;

D[0] = 1.0;
D[1] = 0;

C[0] = 1.0;
C[1] = 1.41421;
C[2] = 1.0;

T = 0.0001;

FLN = T* fl;

FHN = T* fh;

   err = fblt(D,C,ln,iband,FLN,FHN,B,A)

   if (err == 0) {

<<"%V$B\n"
<<"%V$A\n"
float frq;

fb=ofw("bs_mag")

   for (i = 0; i< 500; i++) {
    frq = (i * 0.5/500.0);
    cg = cgain(B,A,ln,ln, frq);
    cga = cg->abs();
    frq *=10;
 <<[fb]" $frq  $cga\n";
   }
 }
 else {
<<" %V$err\n"

 }