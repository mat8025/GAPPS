///
///  iir high pass filter
///

setdebug(1)


float D[4];
float C[4];
float B[4];
float A[4];

float AMP[501];

Cmplx cg;

iband = 2;

float fl = 3500.0

float fh = 0.0;


int ln = 2;

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
fb=ofw("hp_mag")
    for (i = 0; i< 500; i++) {
    frq = (i * 0.5/500.0);
    cg = cgain(B,A,ln,ln, frq);
    cga = cg->abs();
 <<[fb]" $frq  $cga\n";
   }
    }