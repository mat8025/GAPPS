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
   Ev_name = Ev.getEventType(Ev_id,Ev_type,Ev_woid,Ev_woaw,Ev_button,Ev_keyc,Ev_woproc,Ev_x,Ev_y,Ev_woval);
     
//<<"$_proc %V $Ev_x $Ev_y  $Ev_woid\n"

  Ev_woval = Ev.getEventWoValue();
  <<"%V $Ev_woval \n"       

  //  Ev.geteventrxy(Ev_rx,Ev_ry);    

//<<"$_proc  %V Ev_rx  Ev_ry \n"

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
    
     Ev_woname = Ev.getEventWoName();
//     Ev_woproc = Ev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Ev.geteventxy(&Ev_x,&Ev_y);


    Ev.geteventrowcol(&Ev_row,&Ev_col);

//Ev_row.info(1); // DBG
//Ev_col.info(1); // DBG
//  Mouse window pos, screen pos?

    }

   }
   // Ev.geteventrxy(Ev_rx,Ev_ry);    

//<<"$_proc  %V Ev_rx  Ev_ry \n"
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

    Ev_msg = Ev.waitForMsg();
//<<"$_proc  %V $Ev_msg\n"
     Ev.geteventrxy(Ev_rx,Ev_ry);    
     Ev_woid=Ev.geteventwoid();

<<"$_proc  %V $Ev_woid $Ev_rx $Ev_ry\n"     

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
    
    Ev_msg = Ev.readMsg();
    Ev_loop++;
    
  
      eventDecode();
}
//==============================



Gevent Ev; // event type - can inspect for all event attributes


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

svar Ev_msgwd;
svar Ev_words;

str Ev_name;

Str Ev_keyw = "nada";
Str Ev_keyw2 = "nada2"
Str Ev_keyw3 = "nada3"

str Ev_msg = "";

str Ev_value = "abc";

Str Ev_woname = "noname";

str Ev_woval = "yyy";

str Ev_woproc = "abc";

//<<" %V $_include $Ev_msg\n"

//Ev_keyw.pinfo()



//====================================
