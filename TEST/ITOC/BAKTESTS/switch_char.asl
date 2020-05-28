


#define BLUE 4

k = RED
<<"$k  RED   is $(RED) \n"


k = BLUE
<<"$k  BLUE   is $(BLUE) \n"



proc WC (c)
{

   switch (c) {

      case 'A':
           printf("A we  have %c %d\n",c,c);
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
           <<"Default we  have %c$c %d$c\n";

      break;

   }

}



char  sc = 'B'

<<" %V$sc\n"


   for (sc =  'T'; sc <= 'Z' ; sc++) {

     <<"%d$sc %c$sc\n"


   }




;





   WC(sc)

   WC('A')


   WC('M')




   for (sc = 'A' ; sc <= 'M' ; sc++) {

     WC(sc)

     <<"%V$sc \n"

   }




