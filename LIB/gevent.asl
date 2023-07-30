/* 
 *  @script gevent.asl                                                  
 * 
 *  @comment                                                            
 *  @release Oxygen                                                     
 *  @vers 1.6 C Carbon [asl 5.8 : B O]                                  
 *  @date 07/29/2023 16:19:39                                           
 *  @cdate Tue Jan 1 10:36:56 2019                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//                  

///
/// wait and catch mouse/key window events
//
//

//<<"loading gevent.asl \n"


Gevent Gev; // event type - can inspect for all event attributes

Gev.pinfo();

Vec<int> WPOS__( 16);
Vec<int> MPOS__( 16);

///  use prefix  GEV__    _GEV seen as tag arg by ASL


int _last_eid = -1;
int ewsz = 0;

int GEV__loop = 0;

float GEV__rx = -1.234;
float GEV__ry = -1.2345;

int GEV__x = -15;
int GEV__y = 0;

int GEV__type = 0;
int GEV__row = -1;
int GEV__col = -1;
int GEV__button = 0;
int GEV__id = 0;
int GEV__keyc;
int GEV__woid;
int GEV__woaw;
int GEV__wid;

Svar GEV__msgwd;
Svar GEV__words;

Str GEV__name;

Str GEV__keyw = "nada";
Str GEV__keyw2 = "nada2";
Str GEV__keyw3 = "nada3";

Str GEV__msg = "";

Str GEV__value = "abc";

Str GEV__woname = "noname";

Str GEV__woval = "yyy";

Str GEV__woproc = "abc";







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

  GEV__name = Gev.getEventType(GEV__id,GEV__type,GEV__woid,GEV__woaw,GEV__button,GEV__keyc,GEV__woproc,GEV__x,GEV__y,GEV__woval);
   
   <<"%V $GEV__button $GEV__keyc\n"
#else
   GEV__name = Gev.getEventName();
   
   GEV__button = Gev.getEventButton(); // or Gev.ebutton
<<"getting %V $GEV__button\n"

   GEV__keyc = Gev.getEventKey();

#endif     
//<<"$_proc %V $GEV__x $GEV__y  $GEV__woid\n"

   GEV__woval = Gev.getEventWoValue();
   
//  <<"%V $GEV__woval \n"       
    MPOS__[0] = -1;
    
    GEV__wid = -1;

     if (checkTerm()) {
       GEV__keyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $GEV__msg \n"
    if (GEV__msg != "") {
     // split the msg into separate words
     GEV__words.Split(GEV__msg); 

    ewsz=GEV__words.getSize();
//<<"%V $ewsz $GEV__words\n"
    //pa(GEV__msg, GEV__words);
    if (ewsz >= 1) {
    GEV__keyw = GEV__words[0];   // TBC

//<<"%V $GEV__value $GEV__msg  $GEV__keyw \n"
     GEV__value =   spat(GEV__msg,GEV__keyw,1);
//<<"%V $GEV__value \n"   
     GEV__value.eatWhiteEnds();
//<<"%V $GEV__value \n"

  if (ewsz >= 2) {
    GEV__keyw2 = GEV__words[1];
     if (ewsz >= 3) 
    GEV__keyw3 = GEV__words[2];
    }


//<<"proc $GEV__woproc \n"
     if (GEV__woid < 32767) {
         GEV__wid = GEV__woid;
       }
       else {
           GEV__wid = (GEV__woid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     GEV__woname = Gev.getEventWoName();
//     GEV__woproc = Gev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Gev.geteventxy(&GEV__x,&GEV__y);


    Gev.getEventRowCol(GEV__row,GEV__col);

//  Mouse  pos, screen pos?
// needed?
     MPOS__[2] = GEV__button;

    }

   }

}
//==============================

void eventWait()
{
    int ret = 1;

    GEV__loop++;
    GEV__keyc = 0;
    GEV__woid = -1;
    GEV__row = -1;
    GEV__col = -1;    
    GEV__woname = "";
    GEV__woval = "";
    GEV__msg = "";
    GEV__keyw = "";
     GEV__msg = Gev.eventWait();
//<<"$_proc  %V $GEV__msg\n"
    // Gev.getEventRxRy(&GEV__rx,GEV__ry); // crash
    GEV__rx = -0.004;
    GEV__ry = -0.005;
    
     Gev.getEventRxRy(GEV__rx,GEV__ry); //  SF func should process as a reference arg
     
     
     GEV__woid=Gev.getEventWoid();

<<"$_proc  %V $GEV__woid $GEV__rx $GEV__ry\n"     

     eventDecode();
/*     
     if (GEV__keyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21
}
//==============================

void eventRead()
{
    GEV__msg = Gev.eventRead();
    GEV__loop++;
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

//<<" %V $_include $GEV__msg\n"

//====================================
