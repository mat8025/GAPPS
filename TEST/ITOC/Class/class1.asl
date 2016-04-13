// test class

CheckIn()

float Freq  = 16000

 FFTSZ = 256

 wlen = FFTSZ

 ut = utime()

<<"%V$ut $(utime()) \n"

Class Timekeeper 
 {
  public:

   float skipsig ;
   float rsecs ;

   float dsecs;

   float hrti;
   float last_t;
   float syncsecs ;
   float lags;
   float catchup;

  CMF Timekeeper()
    {

     skipsig = 0.0
     rsecs = 0.0;
     dsecs = 0.0;
     syncsecs = 0.0;
     last_t = 0.0;

     hrti = 1.0/Freq * (2 * wlen)

  <<"%V $hrti $rsecs \n"

    //ir= iread()
    }
   

  CMF update()
   {

   dt=FineTimeSince(T)


   dsecs = dt /1000000.0

<<"%I $T $dt $dsecs \n"



<<"%V $T $dt $dsecs $rsecs\n"


   //ir=iread()


   rsecs += 0.04 

//   ir=iread("->")

   syncsecs = last_t + hrti

   lags = syncsecs - dsecs   
   catchup = (dsecs - syncsecs)

   if (catchup > 1.2) {
     skipsig += catchup
   }

   hl = dsecs - last_t
   last_t = dsecs

   }

  CMF print()
   {
    <<"%I $rsecs $dsecs $lags $catchup $skipsig $Freq $Gdt\n"
    <<"%V $rsecs $dsecs $lags $catchup $skipsig $Freq $Gdt\n"
   }


 }
//=====================

  proc wtime( is)
  {

   <<"%I $is \n"

  }


   T=FineTime()

<<"%V $T \n"

   Gdt=fineTimeSince(T)


 Timekeeper Tim
 

 Tim->print()


   Tim->update()

 <<" $Tim->rsecs \n"

 Tim->print()


   wtime(Tim->rsecs )

     Tim->rsecs = 1.0




   ok=CheckFNum(Tim->rsecs, 1.0,3)

<<"%V$ok $Tim->rsecs == 1.0 ? $(CheckFNum(Tim->rsecs, 1.0,3))\n"	

     Tim->rsecs = 1.04

<<" $Tim->rsecs \n"

   ok=CheckFNum(Tim->rsecs, 1.04,3)

<<"%V$ok $Tim->rsecs == 1.04 ? \n"

\\<<"////////////////////\n"

  for (j = 0; j < 5; j++) {

    Tim->update()

    sleep(Urand()+0.5)

    <<"%V$j $Tim->rsecs $(utime()) $Tim->dsecs \n"

    Tim->print()
  }


   ok=CheckFNum(Tim->rsecs, 1.240, 4)
<<"%V$ok $Tim->rsecs == 1.24 ? <|$(CheckFNum(Tim->rsecs, 1.240, 4))|>\n"

   CheckOut()


STOP!