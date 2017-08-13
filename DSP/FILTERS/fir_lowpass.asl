///
/// fir_lowpass
///
setdebug(1);

/{/*
C-DESIGN FIR LOWPASS FILTER USING RECTANGULAR WINDOW.
      DIMENSION B(0:20),A(1),AMP(0:500)
      COMPLEX SPGAIN
      DATA FC/200./,T/.001/,L/20/,IWNDO/1/,A/0./
      FCN=FC*T
      CALL SPFIRL(L,FCN,IWNDO,B,IERROR)
      IF(IERROR.NE.0) THEN
        PRINT *,' ERROR RETURNED = ',IERROR
        STOP
      ENDIF
      DO 1 I=0,500
        AMP(I)=ABS(SPGAIN(B,A,L,1,I*.5/500.))
    1 CONTINUE
      CALL PFILE2(0.,1.,AMP,501,1,'P0801A')
      PRINT 100,(N,B(N),N+7,B(N+7),N+14,B(N+14),N=0,6)
100   FORMAT(' N     B(N)        N     B(N)        N      B(N)'/
     +       (I2,F10.5,I8,F10.5,I8,F10.5))
      END
/}*/

int L = 60;

float B[L+1];
float A[1];

float AMP[500];

float FC = 2000.0;

//float T = 0.001; // 1K
float Sf = 16000.0; // 16K 
float T = 1.0/Sf; 

int Wndo = 1; // 1 Rec, 2 TapRec, 3 Tri, 4 Hanning, 5 Hamming, 6 Blackman

svar Wname[] = { "Rec","TapRec","Tri","Hanning" ,"Hamming","Blackman", }


A[0] = 0.0;

float Fcn = FC*T;


     Wndo = _clarg[1];
     if (Wndo < 1 || Wndo > 6) {
         Wndo = 1;
     }




    err = firl(L,Fcn,Wndo,B);


<<"%V$err\n";

<<"$(Caz(B))\n";
n = 10;
<<" %6.4f%($n,\s,\,,\n)$B\n"




Cmplx cg;

        //AMP(I)=ABS(SPGAIN(B,A,L,1,I*.5/500.))
float frq = 0;




// bug single element expansion puts unwanted space
// fb=ofw("firl_${Wname[Wndo-1]}_mag")

wn= Wname[Wndo-1];

fb=ofw("firl_${wn}_ip")
n = 1;
<<[fb]" %6.4f%($n,\s,\,,\n)$B\n"

cf(fb);

fb=ofw("firl_${wn}_mag")

float ma;
float cga;

 for (i = 0; i< 500; i++) {
     frq = (i * 0.5/500.0);
     cg = cgain(B,A,L,1, frq);
     cga = cg->abs();
     ma = cga;
 //<<[fb]" $frq,  $cga\n";
      frq *= Sf;
<<[fb]" $frq,  $cga\n";

//<<" $frq,  $cga\n";
    AMP[i] = cga;

   }

 fflush(1 );
 fflush(fb);
 




n = 10
//<<" %6.4f%($n,\s,\,,\n)$AMP\n"

//<<"$ma $(typeof(ma)) $(typeof(cga)) $(Cab(cga))\n"


<<"$AMP[499] $(typeof(AMP)) $(Cab(AMP))\n"
