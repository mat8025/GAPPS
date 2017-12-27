///
///
///


Class Cevent
{

 public:
  int  id;
  int button;

};



setDebug(1,"trace");

Cevent Cev;
gevent Ev; // event type - can inspect for all event attributes


    Cev->id =   47;
    Cev->button = 3;

int id = 0;

     id = Cev->id;

<<"%V $id \n"

int b = 3;
int addr = -1;

       addr = Ev->setEventButton(b);

        rb = Ev->getEventButton();

<<"%V $b $rb $addr\n"

       addrv = Ev->getEventAddrs();

<<"%V  %u $addrv\n"


       parsv = Ev->getEventPars(addrv[0],2724);

<<"%V  $parsv\n"

       val = getNumFromMem( (addrv[0]+2724), INT_);

<<"%V $val\n"

int eid = -1;

     eid = Ev->button;

<<"%V $eid \n"

//<<"%V $Cev->id $Cev->button \n";




