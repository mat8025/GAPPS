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

///  use prefix  GEV_    _GEV seen as tag arg by ASL


int _last_eid = -1;
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

  ename = Gev.getEventparameters   (eid,etype,ewoid,ewoaw,ebutton,ekeyc,ewoproc,ex,ey,ewoval);
   
   <<"ASLGEV %V $ename $etype $ebutton $ekeyc\n"
#else
   ename = Gev.getEventName();
   
   ebutton = Gev.getEventButton(); // or Gev.ebutton
<<"getting %V $ebutton\n"

   ekeyc = Gev.getEventKey();

#endif     
//<<"$_proc %V $ex $ey  $ewoid\n"

   ewoval = Gev.getEventWoValue();
   
//  <<"%V $ewoval \n"       
    MPOS__[0] = -1;
    
    ewid = -1;

     if (checkTerm()) {
       ekeyw =  "EXIT_ON_WIN_INTRP";
    }
    else {
//  <<"$_proc %V $emsg \n"
    if (emsg != "") {
     // split the msg into separate words
     ewords.Split(emsg); 

    ewsz=ewords.getSize();
//<<"%V $ewsz $ewords\n"
    //pa(emsg, ewords);
    if (ewsz >= 1) {
    ekeyw = ewords[0];   // TBC

//<<"%V $evalue $emsg  $ekeyw \n"
     evalue =   spat(emsg,ekeyw,1);
//<<"%V $evalue \n"   
     evalue.eatWhiteEnds();
//<<"%V $evalue \n"

  if (ewsz >= 2) {
    ekeyw2 = ewords[1];
     if (ewsz >= 3) 
    ekeyw3 = ewords[2];
    }


//<<"proc $ewoproc \n"
     if (ewoid < 32767) {
         ewid = ewoid;
       }
       else {
           ewid = (ewoid & 0xFFFF0000) >> 16 ;  
     }
    }
    
     ewoname = Gev.getEventWoName();
//     ewoproc = Gev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

  //  Gev.geteventxy(&ex,&ey);


    Gev.getEventRowCol(erow,ecol);

//  Mouse  pos, screen pos?
// needed?
     MPOS__[2] = ebutton;

    }

   }

}
//==============================

void eventWait()
{
    int ret = 1;

    eloop++;
    ekeyc = 0;
    ewoid = -1;
    erow = -1;
    ecol = -1;    
    ewoname = "";
    ewoval = "";
    emsg = "";
    ekeyw = "";
     emsg = Gev.eventWait();
//<<"$_proc  %V $emsg\n"
    // Gev.getEventRxRy(&erx,ery); // crash
    erx = -0.004;
    ery = -0.005;
    
     Gev.getEventRxRy(erx,ery); //  SF func should process as a reference arg
     
     
     ewoid=Gev.getEventWoid();

<<"$_proc  %V $ewoid $erx $ery\n"     

     eventDecode();
/*     
     if (ekeyw == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21
}
//==============================

void eventRead()
{
    emsg = Gev.eventRead();
    eloop++;
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

//<<" %V $_include $emsg\n"

//====================================
