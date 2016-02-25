

CheckIn()


#define C3 3


Foo = 1
proc foo()
{
<<" in $_proc foo \n"
    Foo++
}


proc testSW( wc )
{
ret = 0

<<"input to switch is $wc \n"

   switch (wc) {

    case 1:

<<"in  case 1 \n"
     foo()
     ret = 1;
     break;

    case 2:

<<"in  case 2 \n"

     ret = 2;
     break;

    case C3:

<<"in  case C3 \n"
<<"next statement in C3\n"
<<"last statement in C3\n"

     ret = C3;
     break;


    case 4:

<<"in  case 4 \n"
<<"next statement in 4\n"
<<"last statement in 4\n"
     ret = 4;
     break;

    case 5:
    case 6:

<<"in  case 6 \n"
<<"next statement in 6\n"
<<"last statement in 6\n"
     ret = 6;
     break;

    case 7:
      {
<<" in case 7 \n"
        kc = 0
        while (kc++ < wc) {
<<" in case 7 $kc\n"

        }
       CheckNum((kc-1),wc)

      ret = 7;
      }
    break;

    case 8:
      {
        kc = 2
        switch (kc) {
           case 1:
           <<" in embedded switch case 1\n"
            break;
           case 2:
           <<" in embedded switch case 2\n"
            break;
        }
      ret = 8;
      }
     break;

    default:

<<"in  default case  \n"
     ret = 1234567;
     break;
  }


<<" out of proc switch $ret \n"

    return ret
}






A = 1
C = 3
B = 2
D = 0

   while (A) {
      D++

      if (D > C)
         break;

   }

<<"%V $A $B $C $D \n"


   WC = 4

   switch (WC) {

    case 1:

<<"in  case 1 \n"

     break;

    case 2:

<<"in  case 2 \n"

     break;

    case C3:

<<"in  case C3 \n"
<<"next statement in C3\n"
<<"last statement in C3\n"

     break;


    case 4:

<<"in  case 4 \n"
<<"next statement in 4\n"
<<"last statement in 4\n"

     break;

   case 5:
<<"in  case 5 \n"

   case 6:
<<"in  case 6 \n"

   break;

   default:

<<"in  default case  \n"

     break;
  }


<<" out of switch \n"

    rc =testSW(1)

    CheckNum(rc,1)
    CheckNum(Foo,2)

    rc =testSW(79)

    CheckNum(rc,1234567)



    rc =testSW(3)

    CheckNum(rc,3)

    rc =testSW(4)

    CheckNum(rc,4)

    rc =testSW(5)

    CheckNum(rc,6)

    rc =testSW(6)

    CheckNum(rc,6)

    rc =testSW(79)

    rc =testSW(80)
<<"%V$rc\n"

    CheckNum(rc,1234567)

    rc =testSW(3)

    CheckNum(rc,3)

    rc =testSW(7)

    CheckNum(rc,7)

    rc =testSW(8)

    CheckNum(rc,8)

    CheckOut()

;
