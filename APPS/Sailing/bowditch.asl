///
///    Bowditch
///

///  Ship's course  SC   - TVMDC - to true

float SC = 0;

///  1st bearing (M)  => true

float B1M =  0;

///  2nd bearing (M)  => true

float B2M =  0;

//  local variation

float   V= 14;   // west


float D = 0.0;   // deviation for ship  course


float bdr =1.0 // bowditch ratio/factor

//

 B1M = 45;
 B2M=  45;

 na = argc();

 SC = atof(_clarg[1])

 V= atof(_clarg[2])

 D= atof(_clarg[3])

 B1M = atof(_clarg[4])

 B2M = atof(_clarg[5])



  SCT = SC -D -V;
  if (SCT < 0) {
    SCT += 360;
  }

    if (SCT >= 360) {
    SCT -= 360;
  } 



 <<"%V $SC $SCT $V $D $B1M $B2M \n"

  B1T = B1M-V;
  if (B1T < 0) {
    B1T += 360;
  }

    if (B1T >= 360) {
    B1T -= 360;
  }   

  B2T = B2M-V;

  if (B2T < 0) {
    B2T += 360;
  }

    if (B2T >= 360) {
    B2T -= 360;
  }   


  D1 = fabs(SCT-B1T)

  if (D1 > 180) {
        D1  = 360 -D1;
  }


  D2 = fabs(SCT-B2T)

  if (D2 > 180) {
        D2 = 360 -D2
  }


 <<"%V $SC $SCT $V $D $B1M $B2M  $B1T $B2T $D1 $D2\n"


  bdr = sin(d2r(D1)) / sin (d2r(180- (D1+(180-D2))));


<<"%V $SC $B1M $B2M   $bdr \n"


/*
 r6 =  ( B1+B2 -180)
  r7 =  ( (B1+B2) -180)

  r8 =  ( 180 - (B1+B2) )

chkN( r8, 90)

   r90 = d2r(90.0);

chkN(r90,1.570796)

  r9 = d2r( (B1) )

    r12 = d2r( (B1*2) )

  r10 = d2r(  (B1+B2) )

  r11 = d2r(  ( 180-(B1+B2) ))

    r14 = d2r( (B1*cos(d2r(45))) )

  r15 = d2r(  ( 180 - (B1 + B2) ))

chkN(r11,r15)

chkN( (2 + 2), (8 /2))



    r13 = d2r( (B1+2) )
  
<<"%V $B1 $B2 $r6 $r7 $r8 $r9  $r90\n"

<<"%V $r10 $r11  $r12 $r13 $r14 $r15\n"
chkOut()
exit(-1)
*/