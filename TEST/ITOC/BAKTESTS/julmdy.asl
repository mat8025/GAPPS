/////////////////////////////////////////////////////////////////
/{
from Jean Meeus in "Astronomical Formulae for Calculators" 
it works for any positive Julian date.

   1. Add .5 to the JD and let Z = integer part of (JD+.5) and F the
      fractional part F = (JD+.5)-Z

   2. If Z < 2299161, take A = Z

      If Z >= 2299161, calculate alpha = INT((Z-1867216.25)/36524.25)
      and A = Z + 1 + alpha - INT(alpha/4).

   3. Then calculate:

         B = A + 1524
         C = INT( (B-122.1)/365.25)
         D = INT( 365.25*C )
         E = INT( (B-D)/30.6001 )

The day of the month dd (with decimals) is:
 
     dd = B - D - INT(30.6001*E) + F 

The month number mm is:

     mm = E - 1, if E < 13.5
or
     mm = E - 13, if E > 13.5

The year yyyy is:

     yyyy = C - 4716   if m > 2.5
or
     yyyy = C - 4715   if m < 2.5


An example from Meeus' book is for JD = 2436116.31

     JD + 0.5 = 2436116.81, so

         Z = 2436116

         F = 0.81

     alpha = INT((2436116 - 1867216.25)/36524.25 ) = 15

         A = 2436116 + 1 + 15 - INT(15/4) = 2436129

Then
         B = 2437653
         C = 6673
         D = 2437313
         E = 11

So, dd = 4.81, mm = E-1 = 10, and yyyy = C-4716 = 1957, so the date
is:

     Oct 4.81, 1957
/}


double JD


na = argc()
 for (i = 0; i <= na ;i++) {
<<"$i $_argv[i] $_clarg[i] \n"
 }



ja = _argv[1]

    JD = atof(_argv[1])

<<"%V$ja $JD  $_argv[1] $_argv[2]\n"
 
//   1. Add .5 to the JD and let Z = integer part of (JD+.5) and F the
//      fractional part F = (JD+.5)-Z

int Z
       Z = (JD + 0.5)

double F
       F= (JD + 0.5) - Z
<<"%V$Z $F \n"


//   2. If Z < 2299161, take A = Z
//      If Z >= 2299161, calculate alpha = INT((Z-1867216.25)/36524.25)
//      and A = Z + 1 + alpha - INT(alpha/4).

// int32 , long

int A
int alpha = 0

     If (Z < 2299161)
       A = Z
     Else {
         alpha = Trunc((Z-1867216.25)/36524.25)         
         A = Z + 1 + alpha - Trunc(alpha/4)
     }

<<"%V$A $alpha \n"


//  3. Then calculate:
int C
int D
int E


// FIX needed  E = Trunc(1.5)  --- should create E as an int!

         B = A + 1524
         C = Trunc( (B-122.1)/365.25)
         D = Trunc( 365.25*C )
         E = Trunc( (B-D)/30.6001 )


<<"%V$B $C $D $E \n"
<<"%V$(typeof(B)) $(typeof(C)) $(typeof(D)) $(typeof(E))\n"

  dd = B - D - Trunc(30.6001 * E) + F 

<<"%V$dd \n"

  if (E < 13.5)
     mm = E -1
  else
     mm = E -13

<<"%V$mm \n"

   if (mm > 2.5) {
      yyyy = C - 4716
   }
   else {
      yyyy = C - 4715
   }


<<"%V$yyyy \n"


  mdy = julmdy(ja)

<<"%V$ja   is $mdy \n"