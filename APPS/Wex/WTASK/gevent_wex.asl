/* 
 *  @script gevent_wex.asl 
 * 
 *  @comment process GWM events  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 5.18 : B Ar]                                   
 *  @date 08/20/2023 18:59:45 
 *  @cdate 08/20/2023 18:59:45 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2023
 * 
 */ 
//-----------------<v_&_v>------------------------//

////



Gevent Gev ;

Vec<int> WPOS__( 16);
Vec<int> MPOS__( 16);
int _last_eid = -1;

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


int eventDecode ()
{

   int ewsz;
   GEV__name = Gev.getEventName();
   
   GEV__button = Gev.getEventButton(); // or Gev.ebutton

   GEV__keyc = Gev.getEventKey();


   GEV__woval = Gev.getEventWoValue();
   

    MPOS__[0] = -1;
    
    GEV__wid = -1;

     if (checkTerm()) {
       GEV__keyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $GEV__msg \n"
    if (GEV__msg != "") {
     // split the msg into separate words
     GEV__words.split(GEV__msg); 

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

//=END_PROC===========================//

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

    GEV__rx = -0.004;
    GEV__ry = -0.005;
    
     Gev.getEventRxRy(GEV__rx,GEV__ry); //  SF func should process as a reference arg
     
     
     GEV__woid=Gev.getEventWoid();

//<<" %V $GEV__button $GEV__keyw $GEV__woid $GEV__rx $GEV__ry\n"     

     eventDecode();
/*     
     if (GEV__keyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     

}
//=END_PROC===========================//





void eventRead()
{
    GEV__msg = Gev.eventRead();
    GEV__loop++;
    eventDecode();
}
//==============================



///----------(^-^)----------\\\
