///
///  biln   - using analog coeefs to design iir filter
///           via biln transformation
///
///           example second order bessel function
///



 // cutoff 1khz SF 10kHz
setdebug(1);

float B[10];
float A[10];


int ln = 2;

float D[10];
float C[10];


D[0] = 0.10560;

  <<"%V$D\n"

C[0] =  0.10560;
C[1] =  0.45950;
C[2] =  1.0;

  <<"%V$C\n"


    err= biln(D,C,ln,B,A);

<<"error ? $err\n"

  <<"%V$B\n"

  <<"%V$A\n"



