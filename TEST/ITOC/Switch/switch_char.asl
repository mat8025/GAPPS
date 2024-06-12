

chkIn()
#define BLUE 4

k = RED_
<<"$k  RED   is $(RED_) \n"

chkN(k,2)

k = BLUE
<<"$k  BLUE   is $(BLUE) \n"

chkN(k,4)

proc WC (char c)
{

   switch (c) {

      case 'A':
           <<"A we  have %c$c %d$c\n";
      break;

      case 'B':
           printf("B we  have %c %d\n",c, c);
           <<"B we  have %c$c %d$c\n"
      break;


      case 'C':
           printf("C we  have %c %d\n",c, c);
      break;

      default:
        // FIXME  printf("Default we  have %c %d\n",c, c);
           <<"Default we  have %c $c %d $c\n";

      break;

   }

}



char  sc = 'B'

<<" %V$sc\n"


   for (sc =  'M'; sc <= 'Z' ; sc++) {

     <<"%d $sc %c$sc\n"


   }


   WC(sc-1)

   WC('A')


   WC('M')




   for (sc = 'A' ; sc <= 'M' ; sc++) {

     WC(sc)

  //   <<"%V$sc \n"

   }


 chkN(sc,'N')


chkOut()

