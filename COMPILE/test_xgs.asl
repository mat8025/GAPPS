/* 
 *  @script test_xgs.asl  
 * 
 *  @comment test cpp interface to xgs directives
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  
///


#define ASL 0
#define CPP 1


#if CPP

 //opendll("plot");

#include "gevent.h"



void drawLines(int wo1,float wline[])
 {
  for (int i= 0; i <10; i++) {
    wline[0] += 0.1;
    wline[1] += 0.1;
    sWo(wo1,WLINE,wline,EO);
    xsleep(0.1); // not pausing ?
//ans=query("see line resized?");    
// getclick();
   }
 };


void
Uac::xgsWorld(Svarg * sarg)  
{
   cout << "hello testing xgs ops " << endl;
#endif
float f= 88.0;
int i= 4;
printf("float f = %f\n",f);
char c;
char cv[32] = "hi char str";

 Str s = "hello Str";
cout << "s= " << s << endl;
#if ASL
<<"%V $s %s $cv\n";
#endif

/// launch xgs
#include "graphic.asl"

Gevent gev;


Str ans;

    rainbow();



  //  vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.99,0.95)
/// create a window
  int vp = cWi("PLOT_STUFF");
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")
cout << "vp " << vp << endl;
     float x0= 0.1;
     float y0 =0.1;
     float x1 = 0.5;
     float y1 = 0.7;

      float rsz[5] = {0.1,0.1,0.5,0.6,0.0};

     int ws = 0; //which screen 0,7 -1 is current

//   int vok= sWi(vp,WRESIZE,0.1,0.2,0.5,0.5,-1,WHUE,YELLOW_,WPIXMAPDRAWON,WDRAWON,WREDRAW);

   int vok= sWi(vp,WTITLE,"PLOT_OBJECTS",WRESIZE,rsz,WHUE,YELLOW,WBHUE,WHITE_,
                   WPIXMAPON,WDRAWON,WCLEAR,WREDRAW,EO);

cout << "vok " << vok << endl;



//ans=query("see window?");

      rsz[3] = 0.8;
      vok =sWi(vp,WHUE,MAGENTA_,WRESIZE,rsz,WREDRAW,EO);


//ans=query("see window?");

/// create a window obj

      int wo1 = cWo(vp);

cout << "wo1 " << wo1 << endl;


      int wok = sWo(wo1,WTYPE,WO_GRAPH,WVISIBLE,WDRAWON,WRESIZE,rsz,WFHUE,YELLOW_,WBHUE,WHITE_,WCLIPBORDER,RED,
      WBORDER,BLACK,WCLEAR,WREDRAW,EO);
            rsz[3]= 0.9;
//ans=query("see wob?");
    float wline[5] = {0.1,0.1,0.5,0.6,(float) BLUE_};
wok = sWo(wo1,WRESIZE,rsz,WHUE,ORANGE_,WBHUE,PINK_,WCLIPBORDER,RED,WCLEAR,WLINE,wline,WDRAWON,WREDRAW,EO);
            rsz[2] = 0.9;
//ans=query("see wob?");

wok = sWo(wo1,WLINE,wline,EO);
//ans=query("see line?");
    vok=  sWi(vp,WHUE,BLACK_,WRESIZE,rsz,WREDRAW,EO);
   wline[4] = RED_;
   wline[3] = 0.8;
   wok = sWo(wo1,WLINE,wline,EO);

///  draw some lines
   drawLines(wo1,wline);
//ans=query("did we see all?");


 int txtwin = cWi("Info_text_window");


  sWi(txtwin,WPIXMAPOFF,WDRAWON,WSAVE,WBHUE,WHITE_,WSTICKY,0,EO);

    float clipbox[6] = {0.1,0.2,0.9,0.9,0.0,-1234.50};
    int vp1 = cWi("Buttons1");


    sWi(vp,WPIXMAPON,WDRAWON,WSAVE,WBHUE,WHITE_,0);


    sWi(vp,WCLIP,clipbox,EO);

//ans=query("did we see buttons?");




    int vp2 = cWi("Buttons2");



    sWi(vp2,WPIXMAPON,WDRAWOFF,WSAVE,WBHUE,PINK_,EO);
//ans=query("doing a bad WGM ");
  sWi(vp2,WCLIP,WCLIP,clipbox,EO); // can we guard against bad arg ? without crashing yes!
//ans=query("bad WGM ");
    sWi(vp2,WCLIP,clipbox,EO);

//ans=query("did we see buttons?");

int fswins[5] =  {txtwin,vp1,vp2,vp,-1};

cout << "fswins " << fswins << endl;


// list   ?
    


    wrctile(fswins, 0.05,0.05,0.95,0.95, 2, 2) ;
    int wwi;
    for (int i=0;i<4;i++) {
      wwi = fswins[i];
      sWi(wwi, WREDRAW, WSAVE);
   }
   //

   drawLines(wo1,wline);

/////////////////////////////////////////////////////////


 float  bx = 0.1;
 float bX = 0.4;
 float yht = 0.2;
 float ypad = 0.05;

 float bY = 0.95;
 float by = bY - yht;
	      float worsz[6] = {bx,by,bX,bY,0.0};
//ans=query("did we see wrc wins?");

  int hwo=cWo(vp,WO_BUTTON_ONOFF);

sWo(hwo,WNAME, "ENGINE", WVALUE,"ON" ,WCOLOR,RED_,WRESIZE,worsz,WFLUSH);

 sWo(hwo,WBORDER,WDRAWON,WCLIPBORDER,RED_,WSTYLE,WO_SVR,WFLUSH);
 //sWo(hwo,@fonthue,WHITE_, @STYLE,SVR_)
 sWo(hwo,WFHUE,RED_,WBHUE,GREEN_,WREDRAW,WFLUSH);
 //sWo(hwo,@clipbhue,MAGENTA_);


 int rwo=cWo(vp2, WO_BUTTON_STATE);
   float fworsz[6] = {bx,by,bX,bY,0.0};

sWo(rwo,WNAME,"FRUIT",WCOLOR,YELLOW_,WRESIZE,fworsz,WFLUSH);
 sWo(rwo,WCSV,"mango,cherry,apple,banana,orange,Peach,pear",WFLUSH);

 sWo(rwo,WBORDER,WDRAWON,WCLIPBORDER,BLUE_,WFONTHUE,RED_,WSTYLE,WO_SVR, WREDRAW ,WFLUSH);
 //sWo(rwo,WFHUE,ORANGE_,WCLIPBHUE,"steelblue",WFLUSH); // check to see if we can spot INT versus char*

sWo(rwo,WFHUE,ORANGE_,WCLIPBHUE,BLUE_,WFLUSH); // check to see if we can spot INT versus char*



ans=query("did we see wob -CSV  button?");



ans=query("looking for events ?");
int nevent = 0;
while (1) {
   gev.eventWait();
   nevent++;
   printf("nevent %d button %d\n",nevent,gev.ebutton);
}


 exitXGS();

#if CPP
printf("str s = %s\n",s.cptr());
}
//==============================//

 extern "C" int test_xgs(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    o_uac->xgsWorld(sarg);

  }
#endif  


//================================//






