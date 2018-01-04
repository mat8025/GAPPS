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

};


proc eventDecode()
{

// get all below button,rx,ry via parameters to wait_for_msg
    _ewoval = Ev->getEventWoValue();
    ev_woval = _ewoval;
    
//    <<"$ev_kloop %V$ev_msg $ev_woval\n"
    if (checkTerm()) {
       _ekeyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
    
    _ewords = Split(_emsg);
    ev_words = _ewords;

    _ekeyw = _ewords[2];
    _ekeyw2 =_ ewords[3];
   // can get all of these in one by using ref parameters
     _ename = Ev->getEventType(_eid,_etype,_ewoid,_ewoaw,_ebutton,_ekeyc);

//  these will be obsoleted
//  use _exxx vars instead
    ev_type = _ename;
    ev_id = _eid;
    ev_woid = _ewoid;
    ev_woaw = _ewoaw;
    ev_button = _ebutton;
    ev_keyc = _ekeyc;


    Cev->id = _eid;
    Cev->button = _ebutton;;
    
    _ewoname = Ev->getEventWoName();
        ev_woname = _ewoname;
    _ewoproc = Ev->getEventWoProc();
        ev_woproc = _ewoproc;


//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

    Ev->geteventrxy(&_erx,&_ery);

    ev_rx = _erx;
    ev_ry = _ery;
    
    Ev->geteventrowcol(&_erow,&_ecol);

    ev_row = _erow;
    ev_col = _ecol;


   }
//<<"%V$ev_keyc $ev_button $ev_id $ev_woid $ev_woname $ev_woval\n"
//<<"%V $ev_keyw $ev_woproc $ev_row $ev_col $ev_rx $ev_ry\n"

}
//==============================

proc eventWait()
{
    
    _eloop++;
     _ewoid = -1;
    _erow = -1;
    _ecol = -1;    
    _emsg = Ev->waitForMsg();
    
    ev_kloop++;
    ev_woid = -1;
    ev_row = -1;
    ev_msg = _emsg

    //<<"$ev_kloop %V$ev_msg \n"
    eventDecode();

}
//==============================

proc eventRead()
{
    
    _emsg = Ev->readMsg();
    _eloop++;
    
      ev_msg = _emsg
      ev_kloop++;
      eventDecode();
}
//==============================

Cevent Cev;
gevent Ev; // event type - can inspect for all event attributes

int ev_kloop = 0;
int last_evid = -1;
int do_evloop = 1;

float ev_rx = 0;
float ev_ry = 0;
int etype = 0;
int ev_row = -1;
int ev_col = -1;
int ev_button;
int ev_id;
int ev_keyc;
int ev_woid;
int ev_woaw;

svar ev_msgwd;
svar ev_words;

str ev_type;
str ev_keyw;
str ev_keyw2;
str ev_msg = "xyz";

//str ev_woname = "";
//str ev_woval = "";

str ev_woname = "xxx";

str ev_woval = "yyy";

ev_woproc = "";


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
str _ekeyw;
str _ekeyw2;
str _emsg = "xyz";

//str ev_woname = "";
//str ev_woval = "";

str _ewoname = "xxx";

str _ewoval = "yyy";

str _ewoproc = "";

<<" loaded gevent processor \n"

//====================================
