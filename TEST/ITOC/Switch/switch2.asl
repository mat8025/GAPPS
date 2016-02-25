
CheckIn()


proc foo (char wc)
{

int ret = -1

<<"in $_proc %V$wc %c$wc $(typeof(wc))\n"

   switch (wc) {

    case 'a':

  <<"in  case a \n"
     ret = 'a'
     break;

    case 'b':

  <<"in  case b \n"
     ret = 'b'
     break;

    case 'd':

  <<"in  case d \n"
     ret = 'd'
     break;


    case 'e':

  <<"in  case e \n"
     ret = 'e'
     break;


    case '\t':

 <<"in  case tab \n"

     ret = '\t'

     break;

    case '\s':

 <<"in  case space \n"

     break;

    case 19:

      // dup switch if use 9 --- which is correct

 <<"in  case tab 9 \n"

     break;

    case '3':

 <<"in  case 3 \n"

     break;

    case '\'':

 <<"in  case ' \n"

     break;

    case ':':

 <<"in  case : \n"

     break;



    default:
 <<"default case $wc \n"
     ret = -1;
     break;


  }

  return ret
}

<<" after switch \n"




   rn = foo('a')



  if (!CheckNum('a',rn)) {
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