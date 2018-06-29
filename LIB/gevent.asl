///
/// gevent.asl 1.3 
/// wait and catch mouse/key window events
//
//

Class Cevent
{

 public:
  int  id;
  int button;
  int row;
  int col;
};


proc eventDecode()
{

// get all below button,rx,ry via parameters to wait_for_msg
    _ewoval = Ev->getEventWoValue();
    

    if (checkTerm()) {
       _ekeyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
    
    _ewords = Split(_emsg);

    _ekeyw = _ewords[2];

<<"%V $_evalue $_emsg  $_ekeyw \n"
     _evalue =   spat(_emsg,_ekeyw,1);
<<"%V $_evalue \n"   
     _evalue = eatWhiteEnds(_evalue);
<<"%V $_evalue \n"
    _ekeyw2 = _ewords[3];

    _ekeyw3 = _ewords[4];
    
   // can get all of these in one by using ref parameters
     _ename = Ev->getEventType(_eid,_etype,_ewoid,_ewoaw,_ebutton,_ekeyc,_ewoproc);

//<<"proc $_ewoproc \n"

    Cev->id = _eid;
    Cev->button = _ebutton;

    
     _ewoname = Ev->getEventWoName();
//     _ewoproc = Ev->getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

    Ev->geteventrxy(&_erx,&_ery);
    
    Ev->geteventrowcol(&_erow,&_ecol);

   _erow->info(1); // DBG
   _ecol->info(1); // DBG
  
    Cev->row = _erow;
    Cev->col = _ecol;    

   }
   


}
//==============================

proc eventWait()
{
    
    _eloop++;
    _ekeyc = 0;
    _ewoid = -1;
    _erow = -1;
    _ecol = -1;    
    _emsg = Ev->waitForMsg();

  
    eventDecode();

}
//==============================

proc eventRead()
{
    
    _emsg = Ev->readMsg();
    _eloop++;
    
  
      eventDecode();
}
//==============================

Cevent Cev;

gevent Ev; // event type - can inspect for all event attributes


int _eloop = 0;
int _last_evid = -1;

float _erx = 0;
float _ery = 0;
int _etype = 0;
int _erow = -1;
int _ecol = -1;
int _ebutton;
int _eid;
int _ekeyc;
int _ewoid;
int _ewoaw;

svar _emsgwd;
svar _ewords;

str _ename;

str _ekeyw = "nada";
str _ekeyw2 = "nada2"
str _ekeyw3 = "nada3"

str _emsg = "xyz";

str _evalue = "abc";

str _ewoname = "";

str _ewoval = "yyy";

str _ewoproc = "abc";

<<" loaded gevent processor $_evalue\n"

//====================================
