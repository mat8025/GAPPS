///
/// test event type
///

//envdebug()

setdebug(1,"trace")

Class Sevent
{

 public:
  float a;
  float b;
  
CMF set (x,y)
 {
  a= x;
  b= y;
 }




}

Sevent aev;

aev->set(3,4);


b= aev->a;

<<"%V$b  $aev->a\n";



gevent E;

E->setevent();

//wid = E->woid;
   wid = E->getEventWoid();
<<"%V $wid\n"



exit()

<<" $(typeof(E))\n"

<<" $(sizeof(E))\n"
include "gevent"
 while (1) {
   sleep (1);
   //eventWait()
   <<" now parse event \n"
   E->setevent();
   wid = E->getEventWoid();

}

