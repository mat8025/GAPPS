//%*********************************************** 
//*  @script gevent.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Wed May  1 12:05:43 2019 
//*  @cdate Tue Jan  1 10:36:56 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
/// wait and catch mouse/key window events
//
//




proc eventDecode()
{

   // can get all of these in one by using ref parameters
   _ename = Ev->getEventType(_eid,_etype,_ewoid,_ewoaw,_ebutton,_ekeyc,_ewoproc,_ex,_ey,_ewoval);
     
//<<"%V $_ex $_ey\n"

// get all below button,rx,ry via parameters to wait_for_msg
//    _ewoval = Ev->getEventWoValue();
//  <<"%V $_ewoval \n"       


    _ewid = -1;

     if (checkTerm()) {
       _ekeyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//    <<"%V $_emsg \n"
    if (!(_emsg @= "")) {
    _ewords = Split(_emsg);

    ewsz=Caz(_ewords);
//<<"%V $ewsz $_ewords\n"
  
    if(ewsz > 1) {
    _ekeyw = _ewords[2];

//<<"%V $_evalue $_emsg  $_ekeyw \n"
     _evalue =   spat(_emsg,_ekeyw,1);
//<<"%V $_evalue \n"   
     _evalue = eatWhiteEnds(_evalue);
//<<"%V $_evalue \n"
    _ekeyw2 = _ewords[3];

    _ekeyw3 = _ewords[4];
    


//<<"proc $_ewoproc \n"
     if (_ewoid < 32767) {
         _ewid = _ewoid;
       }
       else {
           _ewid = (_ewoid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     _ewoname = Ev->getEventWoName();
//     _ewoproc = Ev->getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Ev->geteventxy(&_ex,&_ey);
    Ev->geteventrxy(&_erx,&_ery);    


    Ev->geteventrowcol(&_erow,&_ecol);

//_erow->info(1); // DBG
//_ecol->info(1); // DBG
//  Mouse window pos, screen pos?

    }

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
    _ewoname = "";
    _ewovalue = "";    
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



gevent Ev; // event type - can inspect for all event attributes


int _eloop = 0;
int _last_evid = -1;

float _erx = 0;
float _ery = 0;

int _ex = -15;
int _ey = 0;

int _etype = 0;
int _erow = -1;
int _ecol = -1;
int _ebutton;
int _eid;
int _ekeyc;
int _ewoid;
int _ewoaw;
int _ewid;

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

//<<" %V $_include $_evalue\n"

//====================================
