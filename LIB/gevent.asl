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

//<<"loading gevent.asl \n"


Gevent Gev; // event type - can inspect for all event attributes

Vec<int> _WPOS( 16);
Vec<int> _MPOS( 16);

int Ev_loop = 0;
int _last_eid = -1;

float Ev_rx = 0;
float Ev_ry = 0;

int Ev_x = -15;
int Ev_y = 0;

int Ev_type = 0;
int Ev_row = -1;
int Ev_col = -1;
int Ev_button = 0;
int Ev_id = 0;
int Ev_keyc;
int Ev_woid;
int Ev_woaw;
int Ev_wid;

Svar Ev_msgwd;
Svar Ev_words;

Str Ev_name;

Str Ev_keyw = "nada";
Str Ev_keyw2 = "nada2"
Str Ev_keyw3 = "nada3"

Str Ev_msg = "";

Str Ev_value = "abc";

Str Ev_woname = "noname";

Str Ev_woval = "yyy";

Str Ev_woproc = "abc";


void eventDecode()
{
   // can get all of these in one by using ref parameters
#if ASL   
   Ev_name = Gev.getEventType(Ev_id,Ev_type,Ev_woid,Ev_woaw,Ev_button,Ev_keyc,Ev_woproc,Ev_x,Ev_y,Ev_woval);
#else
   Ev_name = Gev.getEventName();
#endif     
//<<"$_proc %V $Ev_x $Ev_y  $Ev_woid\n"

   Ev_woval = Gev.getEventWoValue();
   
//  <<"%V $Ev_woval \n"       
    _MPOS[0] = -1;
    
    Ev_wid = -1;

     if (checkTerm()) {
       Ev_keyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $Ev_msg \n"
    if (Ev_msg != "") {
    Ev_words = Split(Ev_msg);

    ewsz=Caz(Ev_words);
//<<"%V $ewsz $Ev_words\n"
  
    if (ewsz >= 1) {
    Ev_keyw = Ev_words[0];   // TBC

//<<"%V $Ev_value $Ev_msg  $Ev_keyw \n"
     Ev_value =   spat(Ev_msg,Ev_keyw,1);
//<<"%V $Ev_value \n"   
     Ev_value = eatWhiteEnds(Ev_value);
//<<"%V $Ev_value \n"
    if (ewsz >= 2) {
    Ev_keyw2 = Ev_words[1];
     if (ewsz >= 3) 
    Ev_keyw3 = Ev_words[2];
    }


//<<"proc $Ev_woproc \n"
     if (Ev_woid < 32767) {
         Ev_wid = Ev_woid;
       }
       else {
           Ev_wid = (Ev_woid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     Ev_woname = Gev.getEventWoName();
//     Ev_woproc = Gev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Gev.geteventxy(&Ev_x,&Ev_y);


    Gev.geteventrowcol(&Ev_row,&Ev_col);

//  Mouse  pos, screen pos?
// needed?
     _MPOS[2] = Ev_button;
     


    }

   }

}
//==============================

void eventWait()
{
    int ret = 1;
    
    Ev_loop++;
    Ev_keyc = 0;
    Ev_woid = -1;
    Ev_row = -1;
    Ev_col = -1;    
    Ev_woname = "";
    Ev_wovalue = "";
    Ev_msg = "";

    Ev_msg = Gev.waitForMsg();
//<<"$_proc  %V $Ev_msg\n"
     Gev.getEventRxRy(Ev_rx,Ev_ry);
     
     Ev_woid=Gev.geteventwoid();

//<<"$_proc  %V $Ev_woid $Ev_rx $Ev_ry\n"     

     eventDecode();
/*     
     if (Ev_keyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21
}
//==============================

void eventRead()
{
    
    Ev_msg = Gev.readMsg();
    Ev_loop++;
    eventDecode();
}
//==============================


//<<" %V $_include $Ev_msg\n"

//Ev_keyw.pinfo()

//<<"Loaded gapps/LIB/gevent.asl\n"

//====================================
