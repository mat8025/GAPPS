/* 
 *  @script wevent.asl                                                        
 * 
 *  @comment        
 *  @release Carbon                                                           
 *  @vers 1.7 N Nitrogen [asl 6.67 : C Ho]                                    
 *  @date 02/14/2026 07:42:00                                                 
 *  @cdate Tue Jan 1 10:36:56 2019                                           
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 


//----------------<v_&_v>-------------------------//                  

///
/// wait and catch mouse/key window events
//
//





#if __CPP__
#include "gevent.h"
#endif

  Gevent Gev;  // event type - can inspect for all event attributes

//  Gev.pinfo();

  Vec<int> WPOS__( 16);
  Vec<int> MPOS__( 16);

///  use prefix  GEV_    _GEV seen as tag arg by ASL


  int _last_eid = -1;

/////////////////////////////////////
  int  ewsz = 0;
  int eloop = 0;

  float erx = -1.234;
  float ery = -1.2345;

  int ex = -15;
  int ey = 0;

  int etype = 0;
  int erow = -1;
  int ecol = -1;
  int ebutton = 0;
  int eid = 0;
  int ekeyc;
  int ewoid;
  int ewoaw;
  int ewid;

  Svar emsgwd;
  Svar ewords;

  Str ename;

  Str ekeyw = "nada";
  Str ekeyw2 = "nada2";
  Str ekeyw3 = "nada3";

  Str emsg = "";

  Str evalue = "abc";

  Str ewoname = "noname";

  Str ewoval = "yyy";

  Str ewoproc = "abc";

//////////////////////////////////////
///  use _exxx to show global event

  int _ewsz = 0;
  int _eloop = 0;

  float _erx = -1.234;
  float _ery = -1.2345;

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

  Svar _emsgwd;
  Svar _ewords;

  Str _ename;

  Str _ekeyw = "nada";
  Str _ekeyw2 = "nada2";
  Str _ekeyw3 = "nada3";

  Str _emsg = "";

  Str _evalue = "abc";

  Str _ewoname = "noname";

  Str _ewoval = "yyy";

  Str _ewoproc = "abc";

//////////////////////////////////////
  int GCL_init = 1
  int GCR_init = 1
  
/////////////////////////////////////////////////////////////

void copy_evars()
{


  ewsz = _ewsz;
  eloop = _eloop ;

  erx = _erx ;
  ery = _ery ;

  ex =_ex ;
  ey =  _ey;

  etype = _etype;
  erow = _erow ;
  ecol = _ecol ;
  ebuttton = _ebutton ;
  eid = _eid ;
  ekeyc = _ekeyc;
  ewoid = _ewoid;
  ewoaw = _ewoaw;

  ewid = _ewid;

  emsgwd = _emsgwd;

  ewords = _ewords;

  ename = _ename;

  ekeyw =  _ekeyw;
  ekeyw2  =  _ekeyw2;
  ekeyw3 = _ekeyw3;

  emsg = _emsg ;

  evalue = _evalue ;

  ewoname = _ewoname ;

  ewoval = _ewoval 

  ewoproc = _ewoproc ;

}


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

#if ASLGEV_

  _ename = Gev.getEventparameters   (_eid,_etype,_ewoid,_ewoaw,_ebutton,_ekeyc,_ewoproc,_ex,_ey,_ewoval);
   
   <<"ASLGEV %V $_ename $_etype $_ebutton $_ekeyc\n"
#else

      _etype = Gev.getEventType();

      _ename = Gev.getEventName();
   
      _ebutton = Gev.getEventButton();  // or Gev.ebutton

cprintf("getting   _ebutton %d _ename %S\n",_ebutton,_ename) ;

      _ekeyc = Gev.getEventKey();

#endif     
//<<"$_proc %V $_ex $_ey  $_ewoid\n"

      _ewoval = Gev.getEventWoValue();
   
//  <<"%V $_ewoval \n"       
      MPOS__[0] = -1;
    
      _ewid = -1;

      if  (checkTerm())  {
          _ekeyw =  "EXIT_ON_WIN_INTRP";
      }
      else  {
//  <<"$_proc %V $_emsg \n"
          if  (_emsg != "")  {
     // split the msg into separate words
              _ewords.split(_emsg);

              _ewsz = _ewords.getSize();
//<<"%V $_ewsz $_ewords\n"
    //pa(_emsg, _ewords);
              if  (_ewsz >= 1)  {
                  _ekeyw = _ewords[0];  // TBC

//<<"%V $_evalue $_emsg  $_ekeyw \n"
                  _evalue =   spat(_emsg,_ekeyw,1);
//<<"%V $_evalue \n"   
                  _evalue.eatWhiteEnds();
//<<"%V $_evalue \n"

                  if  (_ewsz >= 2)  {
                      _ekeyw2 = _ewords[1];
                      if  (_ewsz >= 3)                      _ekeyw3 = _ewords[2];
                  }


//<<"proc $_ewoproc \n"
                  if  (_ewoid < 32767)  {
                      _ewid = _ewoid;
                  }
                  else  {
                      _ewid = (_ewoid & 0xFFFF0000) >> 16 ;
		      }
              }
    
              _ewoname = Gev.getEventWoName();
	      
              _ewoproc = Gev.getEventWoProc();
  
//  Motion _event -- will have 1 or more 'event' readings
//  read these into array or rxy and _erow-col

  //  Gev.geteventxy(&_ex,&_ey);


              Gev.getEventRowCol(_erow,_ecol);

//  Mouse  pos, screen pos?
// needed?
              MPOS__[2] = _ebutton;

          }

      }
       copy_evars();
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
      _ename = "xx";
      _ewoval = "";
      _emsg = "";
      _ekeyw = "";
      _emsg = Gev.eventWait();
//<<"$_proc  %V $_emsg\n"
    // Gev.getEventRxRy(&_erx,_ery); // crash
      _erx = -0.004;
      _ery = -0.005;
    
      Gev.getEventRxRy(_erx,_ery);  //  SF func should process as a reference arg
     
     
      _ewoid=Gev.getEventWoid();

      cprintf("%s    _ewoid %d  _erx %f  _ery %f\n",__FUNCTION__,_ewoid,_erx,_ery)      ;

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
      _emsg = Gev.eventRead();
      _eloop++;
      eventDecode();
  }
//==============================
  int getEventButton()
  {

      int bt;

      bt= Gev.getEventButton();

      return bt;
  }

//<<" %V $_include $_emsg\n"

//====================================


  
