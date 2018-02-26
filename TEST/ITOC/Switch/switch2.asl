///
///
///
setdebug(1,"~pline","~trace","~stderr");
FilterDebug(0)
proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }

}

#define  ASK ask();
//#define  ASK ;


CheckIn()

#define ASK ;

proc foo (char wc)
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

   rn = foo(':')

<<"%V$rn\n"

  pf=checkNum(rn,':');

<<"%V$rn $pf\n"


   rn = foo(':')

<<"%V$rn\n"

  pf=checkNum(rn,':');

<<"%V$rn $pf\n"



ASK
  c = '\s'

<<"%V$c  %d$c %c$c\n"

  foo(c)



ci = 'a';

<<" %V$ci %c$ci $(typeof(ci))\n"


   rn = foo(ci)

<<"%V$rn\n"

  checkNum(rn,'a');

ASK

   rn = foo(97)

<<"%V$rn\n"

  checkNum(rn,'a');

ASK





  pf=checkNum('a',rn);

<<"%V$rn $pf\n"





  if (!CheckNum('a',rn)) {
<<"Fail 1\n"
  }

ASK


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



 if (!CheckNum('b',rn)) {
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
// CheckNum('\t',rn)


/{
   oc = CheckNum(9,rn)
<<"%V$oc \n"

   if ( !oc ) {
<<"FAIL 3 \n"
   }
/}


   if (!CheckNum(9,rn)) {
<<"%V$rn \n"
<<"FAIL  %2.0f$(checkTests()) \n"

   }

//  CheckNum(9,8)

  c= ';'

  foo(c)
 
<<"%V$c  %d$c %c$c\n"


  c= '\''

  foo(c)
 
<<"%V$c  %d$c %c$c\n"

  CheckOut()

;