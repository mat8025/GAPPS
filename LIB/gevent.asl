/* 
 *  @script gevent.asl                                                  
 * 
 *  @comment                                                            
 *  @release Beryllium                                                  
 *  @vers 1.5 B Boron [asl 6.4.55 C-Be-Cs]                              
 *  @date 07/31/2022 07:59:31                                           
 *  @cdate Tue Jan 1 10:36:56 2019                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

///
/// wait and catch mouse/key window events
//
//

//<<"loading gevent.asl \n"


Gevent Gev; // event type - can inspect for all event attributes

Gev.pinfo();

Vec<int> _WPOS( 16);
Vec<int> _MPOS( 16);

///  Should all these  be prefix _Ev_xxx ?


int _last_eid = -1;
int ewsz = 0;

int _GEV_loop = 0;

float _GEV_rx = 0;
float _GEV_ry = 0;

int _GEV_x = -15;
int _GEV_y = 0;

int _GEV_type = 0;
int _GEV_row = -1;
int _GEV_col = -1;
int _GEV_button = 0;
int _GEV_id = 0;
int _GEV_keyc;
int _GEV_woid;
int _GEV_woaw;
int _GEV_wid;

Svar _GEV_msgwd;
Svar _GEV_words;

Str _GEV_name;

Str _GEV_keyw = "nada";
Str _GEV_keyw2 = "nada2";
Str _GEV_keyw3 = "nada3";

Str _GEV_msg = "";

Str _GEV_value = "abc";

Str _GEV_woname = "noname";

Str _GEV_woval = "yyy";

Str _GEV_woproc = "abc";







void eventDecode()
{
   // can get all of these in one by using ref parameters

/*
// needs work in scopesindex to get a GEV member
// and icode getGetmember

<<"trying  to get Gev.ebutton\n"

  abut = Gev.ebutton;

<<"%V $abut $Gev.ebutton \n"
*/

#if ASL_GEV

  _GEV_name = Gev.getEventType(_GEV_id,_GEV_type,_GEV_woid,_GEV_woaw,_GEV_button,_GEV_keyc,_GEV_woproc,_GEV_x,_GEV_y,_GEV_woval);
   
   <<"%V $_GEV_button $_GEV_keyc\n"
#else
   _GEV_name = Gev.getEventName();
   
   _GEV_button = Gev.getEventButton(); // or Gev.ebutton
<<"getting %V $_GEV_button\n"

   _GEV_keyc = Gev.getEventKey();

#endif     
//<<"$_proc %V $_GEV_x $_GEV_y  $_GEV_woid\n"

   _GEV_woval = Gev.getEventWoValue();
   
//  <<"%V $_GEV_woval \n"       
    _MPOS[0] = -1;
    
    _GEV_wid = -1;

     if (checkTerm()) {
       _GEV_keyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $_GEV_msg \n"
    if (_GEV_msg != "") {
     // split the msg into separate words
     _GEV_words.Split(_GEV_msg); 

    ewsz=_GEV_words.getSize();
//<<"%V $ewsz $_GEV_words\n"
    //pa(_GEV_msg, _GEV_words);
    if (ewsz >= 1) {
    _GEV_keyw = _GEV_words[0];   // TBC

//<<"%V $_GEV_value $_GEV_msg  $_GEV_keyw \n"
     _GEV_value =   spat(_GEV_msg,_GEV_keyw,1);
//<<"%V $_GEV_value \n"   
     _GEV_value.eatWhiteEnds();
//<<"%V $_GEV_value \n"

  if (ewsz >= 2) {
    _GEV_keyw2 = _GEV_words[1];
     if (ewsz >= 3) 
    _GEV_keyw3 = _GEV_words[2];
    }


//<<"proc $_GEV_woproc \n"
     if (_GEV_woid < 32767) {
         _GEV_wid = _GEV_woid;
       }
       else {
           _GEV_wid = (_GEV_woid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     _GEV_woname = Gev.getEventWoName();
//     _GEV_woproc = Gev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Gev.geteventxy(&_GEV_x,&_GEV_y);


    Gev.getEventRowCol(_GEV_row,_GEV_col);

//  Mouse  pos, screen pos?
// needed?
     _MPOS[2] = _GEV_button;

    }

   }

}
//==============================

void eventWait()
{
    int ret = 1;

    _GEV_loop++;
    _GEV_keyc = 0;
    _GEV_woid = -1;
    _GEV_row = -1;
    _GEV_col = -1;    
    _GEV_woname = "";
    _GEV_woval = "";
    _GEV_msg = "";
    _GEV_keyw = "";
     _GEV_msg = Gev.eventWait();
//<<"$_proc  %V $_GEV_msg\n"
     Gev.getEventRxRy(_GEV_rx,_GEV_ry);
     
     _GEV_woid=Gev.getEventWoid();

//<<"$_proc  %V $_GEV_woid $_GEV_rx $_GEV_ry\n"     

     eventDecode();
/*     
     if (_GEV_keyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21
}
//==============================

void eventRead()
{
    _GEV_msg = Gev.eventRead();
    _GEV_loop++;
    eventDecode();
}
//==============================
int getEventButton()
{

int bt;

   bt= Gev.getEventButton();


  <<"%V $bt\n"
  return bt;
}

//<<" %V $_include $_GEV_msg\n"

//====================================
