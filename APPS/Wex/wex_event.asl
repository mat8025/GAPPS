

#if GEV_LOCAL
int _last_eid = -1; 
Vec<int> WPOS__( 16); 
Vec<int> MPOS__( 16); 

int GEV_loop = 0; 
 
float GEV_rx = -1.234; 
float GEV_ry = -1.2345; 
 
int GEV_x = -15; 
int GEV_y = 0; 
 
int GEV_type = 0; 
int GEV_row = -1; 
int GEV_col = -1; 
int GEV_button = 0; 
int GEV_id = 0; 
int GEV_keyc; 
int GEV_woid; 
int GEV_woaw; 
int GEV_wid; 
 
Svar GEV_msgwd; 
Svar GEV_words; 
 
Str GEV_name; 
 
Str GEV_keyw = "nada"; 
Str GEV_keyw2 = "nada2"; 
Str GEV_keyw3 = "nada3"; 
 
Str GEV_msg = ""; 
 
 
Str GEV_value = "abc"; 
 
Str GEV_woname = "noname"; 
 
Str GEV_woval = "yyy"; 
 
Str GEV_woproc = "abc"; 
 
 
 
int eventDecode () 
{ 
 
 
   GEV_name = Gev.getEventName(); 
    
   GEV_button = Gev.getEventButton(); // or Gev.ebutton 
 
   GEV_keyc = Gev.getEventKey(); 
 
 
   GEV_woval = Gev.getEventWoValue(); 
    
 
    MPOS__[0] = -1; 
     
    GEV_wid = -1; 
 
     if (checkTerm()) { 
       GEV_keyw =  "EXIT_ON_WIN_INTRP"; 
    } 
    else { 
//  <<"$_proc %V $GEV_msg \n" 
    if (GEV_msg != "") { 
     // split the msg into separate words 
     GEV_words.Split(GEV_msg);  
 
    ewsz=GEV_words.getSize(); 
//<<"%V $ewsz $GEV_words\n" 
    //pa(GEV_msg, GEV_words); 
    if (ewsz >= 1) { 
    GEV_keyw = GEV_words[0];   // TBC 
 
//<<"%V $GEV_value $GEV_msg  $GEV_keyw \n" 
     GEV_value =   spat(GEV_msg,GEV_keyw,1); 
//<<"%V $GEV_value \n"    
     GEV_value.eatWhiteEnds(); 
//<<"%V $GEV_value \n" 
 
  if (ewsz >= 2) { 
    GEV_keyw2 = GEV_words[1]; 
     if (ewsz >= 3)  
    GEV_keyw3 = GEV_words[2]; 
    } 
 
 
//<<"proc $GEV_woproc \n" 
     if (GEV_woid < 32767) { 
         GEV_wid = GEV_woid; 
       } 
       else { 
           GEV_wid = (GEV_woid & 0xFFFF0000) >> 16 ;   
     } 
    } 
     
     GEV_woname = Gev.getEventWoName(); 
 
//     GEV_woproc = Gev.getEventWoProc(); 
   
//  Motion event -- will have 1 or more 'event' readings 
//  read these into array or rxy and erow-col 
 
  //  Gev.geteventxy(&GEV_x,&GEV_y); 
 
 
    Gev.getEventRowCol(GEV_row,GEV_col); 
 
//  Mouse  pos, screen pos? 
// needed? 
     MPOS__[2] = GEV_button; 
   } 
  } 
} 
 
//=END_PROC===========================// 
 
void eventWait() 
{ 
    int ret = 1; 
 
    GEV_loop++; 
    GEV_keyc = 0; 
    GEV_woid = -1; 
    GEV_row = -1; 
    GEV_col = -1;     
    GEV_woname = ""; 
    GEV_woval = ""; 
    GEV_msg = ""; 
    GEV_keyw = ""; 
    GEV_msg = Gev.eventWait(); 
 
    GEV_rx = -0.004; 
    GEV_ry = -0.005; 
     
     Gev.getEventRxRy(GEV_rx,GEV_ry); //  SF func should process as a reference arg 
      
      
     GEV_woid=Gev.getEventWoid(); 
 
<<" %V $GEV_button $GEV_keyw $GEV_woid $GEV_rx $GEV_ry\n"      
 
     eventDecode(); 
/*      
     if (GEV_keyw == "EXIT_ON_WIN_INTRP") { 
      
       ret = 0; 
        <<"exit on WIN_INTRP ? $ret\n" 
     } 
*/      
 
} 

void eventRead() 
{ 
    GEV_msg = Gev.eventRead(); 
    GEV_loop++; 
    eventDecode(); 
} 

//=END_PROC===========================// 
 
#endif
