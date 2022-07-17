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
    sWo(wo1,_WLINE,wline,_WEO);
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

//   int vok= sWi(vp,_WRESIZE,0.1,0.2,0.5,0.5,-1,_WHUE,YELLOW_,_WPIXMAPDRAWON,_WDRAWON,_WREDRAW);

   sWi(vp,_WTITLE,"PLOT_OBJECTS",_WRESIZE,rsz,_WHUE,YELLOW,_WBHUE,WHITE_,
                   _WPIXMAPON,_WDRAWON,_WCLEAR,_WREDRAW,_WEO);





//ans=query("see window?");

      rsz[3] = 0.8;
      sWi(vp,_WHUE,MAGENTA_,_WRESIZE,rsz,_WREDRAW,_WEO);


//ans=query("see window?");

/// create a window obj

      int wo1 = cWo(vp);

cout << "wo1 " << wo1 << endl;


      int wok = sWo(wo1,_WTYPE,WO_GRAPH,_WVISIBLE,_WDRAWON,_WRESIZE,rsz,_WFHUE,YELLOW_,_WBHUE,WHITE_,_WCLIPBORDER,RED,_WBORDER,BLACK,_WCLEAR,_WREDRAW,_WEO);
            rsz[3]= 0.9;
//ans=query("see wob?");
    float wline[5] = {0.1,0.1,0.5,0.6,(float) BLUE_};
wok = sWo(wo1,_WRESIZE,rsz,_WHUE,ORANGE_,_WBHUE,PINK_,_WCLIPBORDER,RED,_WCLEAR,_WLINE,wline,_WDRAWON,_WREDRAW,_WEO);
            rsz[2] = 0.9;
//ans=query("see wob?");

wok = sWo(wo1,_WLINE,wline,_WEO);
//ans=query("see line?");
   sWi(vp,_WHUE,BLACK_,_WRESIZE,rsz,_WREDRAW,_WEO);
   wline[4] = RED_;
   wline[3] = 0.8;
   wok = sWo(wo1,_WLINE,wline,_WEO);

///  draw some lines
   drawLines(wo1,wline);
//ans=query("did we see all?");


 int txtwin = cWi("Info_text_window");


  sWi(txtwin,_WPIXMAPOFF,_WDRAWON,_WSAVE,_WBHUE,WHITE_,_WSTICKY,0,_WEO);

    float clipbox[6] = {0.1,0.2,0.9,0.9,0.0,-1234.50};
    int vp1 = cWi("Buttons1");


    sWi(vp,_WPIXMAPON,_WDRAWON,_WSAVE,_WBHUE,WHITE_,_WEO);


    sWi(vp,_WCLIP,clipbox,_WEO);

//ans=query("did we see buttons?");




    int vp2 = cWi("Buttons2");




    sWi(vp2,_WPIXMAPON,_WDRAWOFF,_WSAVE,_WBHUE,PINK_,_WEO);
//ans=query("doing a bad WGM ");
  sWi(vp2,_WCLIP,_WCLIP,clipbox,_WEO); // can we guard against bad arg ? without crashing yes!
//ans=query("bad WGM ");
    sWi(vp2,_WCLIP,clipbox,_WEO);

//ans=query("did we see buttons?");

int fswins[5] =  {txtwin,vp1,vp2,vp,-1};

cout << "fswins " << fswins << endl;


// list   ?
    


    wrctile(fswins, 0.05,0.05,0.95,0.95, 2, 2) ;
    int wwi;
    for (int i=0;i<4;i++) {
      wwi = fswins[i];
      sWi(wwi, _WREDRAW, _WSAVE);
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

sWo(hwo,_WNAME, "ENGINE",_WVALUE,"ON" ,_WCOLOR,RED_,_WRESIZE,worsz,_WFLUSH);

 sWo(hwo,_WBORDER,_WDRAWON,_WCLIPBORDER,RED_,_WSTYLE,WO_SVR,_WFLUSH);
 //sWo(hwo,@fonthue,_WHITE_, @STYLE,SVR_)
 sWo(hwo,_WFHUE,RED_,_WBHUE,GREEN_,_WREDRAW,_WFLUSH);
 //sWo(hwo,@clipbhue,MAGENTA_);


 int rwo=cWo(vp2, WO_BUTTON_STATE);
   float fworsz[6] = {bx,by,bX,bY,0.0};

sWo(rwo,_WNAME,"FRUIT",_WCOLOR,YELLOW_,_WRESIZE,fworsz,_WFLUSH);
 sWo(rwo,_WCSV,"mango,cherry,apple,banana,orange,Peach,pear",_WFLUSH);

 sWo(rwo,_WBORDER,_WDRAWON,_WCLIPBORDER,BLUE_,_WFONTHUE,RED_,_WSTYLE,WO_SVR,_WREDRAW ,_WFLUSH);
 //sWo(rwo,WFHUE,ORANGE_,WCLIPBHUE,"steelblue",WFLUSH); // check to see if we can spot INT versus char*

sWo(rwo,_WFHUE,ORANGE_,_WCLIPBHUE,BLUE_,_WFLUSH); // check to see if we can spot INT versus char*



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






