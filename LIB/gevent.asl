/* 
 *  @script gevent.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.4 Be 6.3.79 C-Li-Au 
 *  @date 02/04/2022 09:58:26          
 *  @cdate Tue Jan 1 10:36:56 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                 
///
/// wait and catch mouse/key window events
//
//

<<"loading gevent.asl \n"


void eventDecode()
{

   // can get all of these in one by using ref parameters
   _ename = Ev.getEventType(_eid,_etype,_ewoid,_ewoaw,_ebutton,_ekeyc,_ewoproc,_ex,_ey,_ewoval);
     
//<<"$_proc %V $_ex $_ey  $_ewoid\n"

// get all below button,rx,ry via parameters to wait_for_msg
//    _ewoval = Ev.getEventWoValue();
//  <<"%V $_ewoval \n"       

  //  Ev.geteventrxy(_erx,_ery);    

//<<"$_proc  %V _erx  _ery \n"

    _ewid = -1;

     if (checkTerm()) {
       _ekeyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $_emsg \n"
    if (_emsg != "") {
    _ewords = Split(_emsg);

    ewsz=Caz(_ewords);
//<<"%V $ewsz $_ewords\n"
  
    if (ewsz >= 1) {
    _ekeyw = _ewords[0];   // TBC

//<<"%V $_evalue $_emsg  $_ekeyw \n"
     _evalue =   spat(_emsg,_ekeyw,1);
//<<"%V $_evalue \n"   
     _evalue = eatWhiteEnds(_evalue);
//<<"%V $_evalue \n"
    if (ewsz >= 2) {
    _ekeyw2 = _ewords[1];
     if (ewsz >= 3) 
    _ekeyw3 = _ewords[2];
    }


//<<"proc $_ewoproc \n"
     if (_ewoid < 32767) {
         _ewid = _ewoid;
       }
       else {
           _ewid = (_ewoid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     _ewoname = Ev.getEventWoName();
//     _ewoproc = Ev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Ev.geteventxy(&_ex,&_ey);


    Ev.geteventrowcol(&_erow,&_ecol);

//_erow.info(1); // DBG
//_ecol.info(1); // DBG
//  Mouse window pos, screen pos?

    }

   }
   // Ev.geteventrxy(_erx,_ery);    

//<<"$_proc  %V _erx  _ery \n"
}
//==============================

void eventWait()
{
    int ret = 1;
    
    _eloop++;
    _ekeyc = 0;
    _ewoid = -1;
    _erow = -1;
    _ecol = -1;    
    _ewoname = "";
    _ewovalue = "";
    _emsg = "";

    _emsg = Ev.waitForMsg();
<<"$_proc  %V $_emsg\n"
     Ev.geteventrxy(_erx,_ery);    
     Ev.geteventwoid(_ewoid);
//<<"$_proc  %V $_ewoid $_erx $_ery\n"     

     eventDecode();
/*     
     if (_ekeyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21
}
//==============================

void eventRead()
{
    
    _emsg = Ev.readMsg();
    _eloop++;
    
  
      eventDecode();
}
//==============================



gevent Ev; // event type - can inspect for all event attributes


int _eloop = 0;
int _last_eid = -1;

float _erx = 0;
float _ery = 0;

!i_erx
!p_ery


int _ex = -15;
int _ey = 0;

int _etype = 0;
int _erow = -1;
int _ecol = -1;
int _ebutton = 0;
int _eid = 0;
int _ekeyc;
int _ewoid;
int _ewoaw;
int _ewid;

svar _emsgwd;
svar _ewords;

str _ename;

Str _ekeyw = "nada";
Str _ekeyw2 = "nada2"
Str _ekeyw3 = "nada3"

str _emsg = "";

str _evalue = "abc";

Str _ewoname = "noname";

str _ewoval = "yyy";

str _ewoproc = "abc";

//<<" %V $_include $_emsg\n"

//_ekeyw.pinfo()



//====================================
