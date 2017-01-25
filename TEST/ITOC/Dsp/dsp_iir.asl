///
///  iir filter
///

// Wrapper    S&D's spac function
// FILTERS N-POINT DATA SEQUENCE X AND RETURNS OUTPUT IN Y 
// TRANSFER FUNCTION COEFFICIENTS ARE IN ARRAYS B AND A 
//             B(0)+B(1)*Z**(-1)+........+B(LB)*Z**(-LB) 
//      H(Z) = ----------------------------------------- 
//                1+A(1)*Z**(-1)+.......+A(LA)*Z**(-LA) 
// PX RETAINS PAST VALUES OF INPUT X */
// PY RETAINS PAST VALUES OF OUTPUT Y */
// IERROR=0     NO ERRORS DETECTED */
//        1     OUTPUT EXCEEDS 1.E10 */


// set up arrays


float X[100];
float Y[100];

float B[] = { 0.001836, 0.007344, 0.011016, 0.007344, 0.001836 };

float A[] = { -3.0544, 3.8291, -2.2925, 0.55075 };

<<"$B\n"


<<"$A\n"


    X = 1.0;
    Y = 0.0;

   // lb = 5; // TBC
    lb = 4;
    la = 4;

int nin = 100;

<<"$X\n"

<<"$Y\n"




  ok = iirFilter(B,lb,A,la,X,nin,Y);


<<"$Y\n"

fh=ofw("fop")

<<[fh]"$Y"

cf(fh)




