//%*********************************************** 
//*  @script switch.asl 
//* 
//*  @comment test switch 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sun Apr 26 21:22:22 2020 
//*  @cdate Mon Apr  8 09:07:32 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
chkIn(_dblevel)



#define C3 3


Foo = 1
proc goo()
{
<<" in $_proc goo \n"
    Foo++
}


proc testSW(int wc )
{
ret = 0

<<"input to switch is $wc \n"

   switch (wc) {


    case -1:  // -1

<<"in  case -1 \n"
     goo()
     ret = -1;

     break;

// alerts to missing :     case 0 34
//    case 0 34 // bad
     case 0:
<<"in  case 0 \n"
     goo()
     ret = 0;

     break;

  //BUG  case (0+1): // no constant expression!!
//BUG does not alert fo following code    case 1:  x+5
     case 1: // 1
<<"in  case 1 \n"
     goo()
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
       chkN((kc-1),wc) // no ;

      ret = 7;
      }
    break;

    case 8:
      {
        kc = 2 ; // here we are
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

// BUG    default: // no trailing comment

// BUG is not ignoring trailing commnet   default:  // this is the default
    default:
    // x=2;
     ret = 1234567;
<<"in $wc default case $ret \n"
     break;
  }


<<" out of proc switch $ret \n"

    return ret
}

//=====================




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

    chkN(rc,1)

    rc =testSW(79)

    chkN(rc,1234567)



    rc =testSW(3)

    chkN(rc,3)

    rc =testSW(4)

    chkN(rc,4)

    rc =testSW(5)

    chkN(rc,6)

    rc =testSW(6)

    chkN(rc,6)

    rc =testSW(79)

    rc =testSW(80)
<<"%V$rc\n"

    chkN(rc,1234567)

    rc =testSW(3)

    chkN(rc,3)

    rc =testSW(7)

    chkN(rc,7)

    rc =testSW(8)

    chkN(rc,8)

    rc =testSW(-1)

    chkN(rc,-1)

    rc =testSW(0)

    chkN(rc,0)

//======================================//


//%*********************************************** 
//*  @script switch2.asl 
//* 
//*  @comment test switch syntax
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Apr  8 09:07:32 2019 
//*  @cdate Mon Apr  8 09:07:32 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///







proc foo (double wc)
{
<<"in $_proc %V$wc  int version!\n"
ret = -3
    return ret;
}
//======================================//
//proc foo (char wc)
proc foo (int wc)
{

int ret = -2;

//<<"in $_proc %V$wc %c$wc $(typeof(wc))\n"

<<"in $_proc %V$wc %c$wc \n"


   switch (wc) {

    case 'a':
  <<"in  case a \n"
     ret = 'a';
     break;

    case 'b':
  <<"in  case b \n"
     ret = 'b';
     break;

    case 'd':
  <<"in  case d \n"
     ret = 'd';
     break;

    case 'e':
  <<"in  case e \n"
     ret = 'e';
     break;


    case '\t':
 <<"in  case tab \n"
     ret = '\t';
     break;

    case '\s':

 <<"in  case space \n";
      ret =32;
     break;

    case 19:

      // dup switch if use 9 --- which is correct

 <<"in  case tab 9 \n"
      ret = 9;
     break;

    case '3':

 <<"in  case 3 \n"

       ret = '3';
     break;

    case '\'':

 <<"in  case ' \n"
                   ret = '\'';
     break;

    case ':':
 <<"in  case <:> \n"
       ret = ':';
<<"case returns $ret %c $ret\n"       
     break;

    default:
 <<"default case $wc \n"
     ret = -1;
     break;
  }
  
<<"IN $wc %c$wc \n"
<<"switch returns $ret  %c $ret\n"

  return ret
}

<<" after switch \n"

//setDebug(1,"step")

char ca = ':';

   rn = foo(ca)

<<"%V$rn\n"

  pf=chkN(rn,':');



   rn = foo(':')

<<"%V$rn\n"

  pf=chkN(rn,':');

<<"%V$rn $pf\n"


   rn = foo(':')

<<"%V$rn\n"

  pf=chkN(rn,':');

<<"%V$rn $pf\n"




  c = '\s'

<<"%V$c  %d$c %c$c\n"

  foo(c)



ci = 'a';

<<" %V$ci %c$ci $(typeof(ci))\n"


   rn = foo(ci)

<<"%V$rn\n"

  chkN(rn,'a');



   rn = foo(97)

<<"%V$rn\n"

  chkN(rn,'a');







  pf=chkN('a',rn);

<<"%V$rn $pf\n"





  if (!chkN('a',rn)) {
<<"Fail 1\n"
  }




   rn = foo('X')

<<"%V$rn \n"

   c= '\''
<<"%V$c %d$c %c$c %x$c %o$c\n"

    rn = foo(c)

<<"%V$rn \n"

    rn = foo(':')

<<"%V$rn \n"


//   FIXME
//   rn = foo('\'')




   rn = foo('b')



 if (!chkN('b',rn)) {
<<"FAIL  $(checkTests()) \n"
 }


  c = 'd'


   foo(c)



   rn = foo('e')


  c = '\s'

<<"%V$c  %d$c %c$c\n"

  foo(c)


  c = '\t'

<<"%V$c  %d$c %c$c\n"

  rn = foo(c)


// FIXME
// chkN('\t',rn)


/{
   oc = chkN(9,rn)
<<"%V$oc \n"

   if ( !oc ) {
<<"FAIL 3 \n"
   }
/}


   if (!chkN(9,rn)) {
<<"%V$rn \n"
<<"FAIL  %2.0f$(checkTests()) \n"

   }

//  chkN(9,8)

  c= ';'

  foo(c)
 
<<"%V$c  %d$c %c$c\n"


  c= '\''

  foo(c)
 
<<"%V$c  %d$c %c$c\n"




chkOut()


