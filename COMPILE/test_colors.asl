/* 
 *  @script test_colors
 * 
 *  @comment show color map cpp version 
 *  @release CARBON color map 
 *  @vers 1.6 C 6.3.94 C-Li-Pu 
 *  @date 03/12/2022 11:04:28          
 *  @cdate Sun Mar 22 11:05:34 2020 
 *  @author Mark Terry 22 11:05:34 2020 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                        


//#include "debug"
//#include "hv.asl"

//ignoreErrors();

#define ASL 0
#define CPP 1


 float Pi = 4.0 * atan(1.0);

 double redv = 0.5;
 double greenv = 0.5;
 double bluev = 0.5;

//#include "graphic"
#include "gevent.h"
#include "tbqrd.asl"

void
Uac::colorWorld(Svarg * sarg)  
{
   cout << "hello testing color ops " << endl;

#include "graphic.asl"

Gevent gev;

Str woval ="xyz";
Str wovalue ="xyz";
Str namevalue ="xyz";

Str ans;
     openDll("image");

    rainbow();
    
    int vp = cWi("Button");
    // neead rsz[]


    sWi(vp,_WRESIZE,wbox(0.01,0.01,0.45,0.49,0),_WEO);

  //  sWi(vp,_WRESIZE,{0.01,0.01,0.45,0.49,0},_WEO);

   titleButtonsQRD(vp);

    float scales[] = {0,-0.2,1.5,1.5};
    float rclip[] = {0.2,0.2,0.9,0.9,0.0};
    
    sWi(vp,_WPIXMAPON,_WDRAWON,_WSAVE,_WBHUE,WHITE_,_WLAST);

    sWi(vp,_WSCALES,scales,_WEO);

   sWi(vp,_WCLIP,rclip,_WEO);
    
    sWi(vp,_WCLIPBORDER,BLACK_,_WREDRAW,_WSAVE,_WLAST);
cout << "done vp" << endl;
    int vp2 = cWi("Colors");
    
       

  sWi(vp2,_WRESIZE,wbox(0.51,0.1,0.99,0.99,0) ,_WEO);



    sWi(vp2,_WPIXMAPON,_WDRAWON,_WSAVE,_WBHUE,WHITE_,_WEO);

cout << "done vp2" << endl;

    int txtwin = cWi("MC_INFO");

    sWi(txtwin,_WRESIZE,wbox(0.01,0.51,0.49,0.99),_WEO);

   float rs,bs,gs,rc,bc,gc;
  float rx = 0.2;
  float rX = 0.3;

   float gx = 0.4;
  float gX = 0.5;

  float bx = 0.6;
  float bX = 0.7;

  float cby = 0.1;
  float cbY = 0.3;

  float cbx = 0.1;
  float cbX = 0.6;


  int rwo=cWo(vp);

 wovalue.strPrintf("%f",redv);
  sWo(rwo,_WTYPE, WO_BV,_WNAME,"Red",_WRESIZE,wbox(rx,cby,rX,cbY),  _WVALUE,wovalue.cptr(),_WSTYLE,WO_SVB,_WEO);

  sWo(rwo,_WCOLOR,RED_,_WPENHUE,BLACK_,_WVMOVE,1,_WEO);

  int gwo=cWo(vp);


  wovalue.strPrintf("%f",greenv);
  sWo(gwo,_WTYPE, WO_BV,_WNAME,"Green",_WRESIZE,wbox(gx,cby,gX,cbY),  _WVALUE,wovalue.cptr(),_WEO);

  sWo(gwo,_WCOLOR,GREEN_,_WPENHUE,BLACK_,_WSTYLE,WO_SVB,_WSYMBOL,3,_WVMOVE,1,_WEO);

  int bwo=cWo(vp);

  wovalue.strPrintf("%f",bluev);
  sWo(bwo,_WTYPE, WO_BV,_WNAME,"Blue",_WRESIZE,wbox(bx,cby,bX,cbY),_WVALUE,wovalue.cptr(),_WVMOVE,1,_WEO);

  sWo(bwo,_WCOLOR,BLUE_,_WSTYLE,WO_SVB,_WEO);


  int rgbwo[] = { rwo, gwo, bwo };
  float rbox[4] = {cbx,cby,cbX,cbY};
  
  wohtile( rgbwo, cbx,cby,cbX,cbY,3);
  
  //sWo( rgbwo, _vmove,1, "setmsg",1 )
//  sWo( rgbwo, _WVMOVE,1,_WEO);

 // use title quit button
 // qwo=cWo(vp,"BV",_name,"QUIT?",_VALUE,"QUIT",_color,"orange",_resize,0.8,0.1,0.95,0.2,_WEO);
 // sWo(qwo,_BORDER,_DRAWON,_CLIPBORDER,_FONTHUE,"black", _redraw)

 // sWi(vp,"woredrawall")

 int two=cWo("TEXT");
 
 sWo(two,_WVALUE,"howdy",_WCOLOR,ORANGE_,_WEO);

  cout << "howdy " << endl;

  sWo(two,_WBORDER,BLACK_,_WDRAWON,_WCLIPBORDER,RED_,_WFONTHUE,BLACK_, _WREDRAW,_WPIXMAPOFF,_WDRAWON,_WLAST);
 
   float scales2[5] = {-1,-1,1,1};
  sWo(two,_WSCALES,scales2,_WEO);

int awo[100];
int k = 0;


     int matrix_index = 64;
     int index = matrix_index;
     
    // setgsmap(100, matrix_index);
cout << "setting up awo " << endl;
  for (k = 0; k < 100; k++) { 
   
     // awo[k]=cWo(vp2,GRAPH_,_name,"${k}_col",_WEO);
    //  awo[k]=cWo(vp2,GRAPH_);
      awo[k]=cWo(vp2,GRAPH_);
       wovalue.strPrintf("%d",k);
       namevalue.strPrintf("%d_col",k);
       sWo(awo[k],_WDRAWON,_WCOLOR,index,_WVALUE,wovalue.cptr(),_WNAME,namevalue.cptr(),_WEO);
       sWo(awo[k],_WBORDER,BLACK_,_WDRAWON,_WCLIPBORDER,YELLOW_,_WEO);
        index++;
     }

//<<"%v $awo \n"



     worctile(awo,0.1,0.1,0.9,0.9,10,10);
     
     titleVers();
     
     sWi(vp,_WREDRAW,_WLAST);
     sWi(vp2,_WREDRAW,_WLAST);



//  now loop wait for message  and print

int rgb_index = 32;
Vec WXY(FLOAT_, 20);

int nevent = 0;
Str cname = "red";

int color_index;



 while (1) {

   gev.eventWait();
   //gev.eventRead();
   nevent++;

//   redv = atof( getWoValue(rwo))
//   greenv = atof ( getWoValue(gwo))
//   bluev =  atof (getWoValue(bwo))


   WXY= woGetPosition(gwo,4);

  //<<"$_ename $_ewoid  $WXY \n"
//cout << "WXY[2] " << WXY[2] << endl;



 greenv = WXY[2];

cout << "greenv  " << greenv << endl;

//  greenv = limitval(WXY[2],0.0,1.0);

 WXY= woGetPosition(rwo,4);


 WXY.pinfo();
 
 redv = WXY[2];

cout << "redv  " << redv << endl;

  //redv = limitval(WXY[2],0.0,1.0);

   WXY= woGetPosition(bwo);
   bluev = limitval(WXY[2],0.0,1.0);
   wovalue.strPrintf("%3.2f",redv);
   sWo(rwo,_WVALUE,wovalue.cptr(),_WUPDATE,_WEO);

   sWo(gwo,_WVALUE,wovalue.strPrintf("%3.2f",greenv),_WUPDATE,_WEO);

   sWo(bwo,_WVALUE,wovalue.strPrintf("%3.2f",bluev),_WUPDATE,_WEO);

cout << "greenv  " << greenv << endl;
cout << "bluev  " << bluev << endl;

//ans=query("?");

   setRGB(rgb_index,redv,greenv,bluev);

      cname = getColorName(2) ; // image lib auto open??

cout << "color_name " << cname << endl;

   color_index = getColorIndexFromRGB(redv,greenv,bluev,0,1024);

   cname = getColorName(color_index) ; // image lib auto open??

cout << "color_index " << color_index << " color_name " << cname << endl;
   int c_index = matrix_index;

   setRGB(c_index++,redv,0,0);
   setRGB(c_index++,0,greenv,0);
   setRGB(c_index++,0,0,bluev);

   setRGB(c_index++,redv,greenv,bluev);
   setRGB(c_index++,redv,greenv,0);
   setRGB(c_index++,0,greenv,bluev);
   setRGB(c_index++,redv,0,bluev);

   setRGB(c_index++,1-redv,1-greenv,1-bluev);
   setRGB(c_index++,redv,1-greenv,1-bluev);

   setRGB(c_index++,1-redv,greenv,1-bluev);

   setRGB(c_index++,redv,greenv,1-bluev);

   setRGB(c_index++,1-redv,greenv,bluev);
   setRGB(c_index++,redv,1-greenv,bluev);



   rs = (sin(redv * Pi) + 1.0) / 2.0;
   bs = (sin(bluev * Pi) + 1.0) / 2.0;
   gs = (sin(greenv * Pi) + 1.0) / 2.0;
   rc = (cos(redv * Pi) + 1.0) / 2.0;
   bc = (cos(bluev * Pi) + 1.0) / 2.0;
   gc = (cos(greenv * Pi) + 1.0) / 2.0;

   setRGB(c_index++,rs,bs,gs);
   setRGB(c_index++,rs,bc,gc);
   setRGB(c_index++,rc,bc,gc);
   setRGB(c_index++,rs,bc,gs);
   setRGB(c_index++,rc,bc,gc);
   setRGB(c_index++,rs,bc,gs);
   setRGB(c_index++,rc,bs,gc);

   float jdv = 1.0/9.0;
   int ki =   c_index;
   float bv = 0.0;
   float bdv = 1.0/7.0;

 //<<"%V $_ewoid  $rwo $gwo $bwo \n";

  woval =woGetValue (rwo);

cout << "rwo woval " << woval << endl;

  woval =woGetValue (gwo);

cout << "gwo woval " << woval << endl;


  woval =woGetValue (bwo);

cout << "bwo woval " << woval << endl;

cout << "gev.ewoid " <<  gev.ewoid <<" gwo " << gwo << endl;   

//ans=query("?");
//<<"bwo $woval \n"
   //redv += 0.2;
  // bluev += 0.3;
   //   greenv += 0.4;
cout << "redv  " << redv << endl;
cout << "greenv  " << greenv << endl;
cout << "bluev  " << bluev << endl;


 if (redv > 1.0) redv = 0.0;
 if (greenv > 1.0) greenv = 0.0;
 if (bluev > 1.0) bluev = 0.0;
 

   float jv;
   int ak = 0;

   for (int rj = 0; rj < 8 ; rj++) {
   jv = 0.0;
   for (int j = 0; j < 10 ; j++) {
// _ewoname _= "Red"
       //setRGB(ki,redv,bv,jv)

      // setRGB(ki,redv,bv,jv);
    
     if (gev.ewoid == rwo) {
       setRGB(ki,redv,bv,jv);
     }
      else if(gev.ewoid == gwo) {
       setRGB(ki,bv,greenv,jv);
      }
      else if (gev.ewoid == bwo) {
        setRGB(ki,bv,jv,bluev);
      }

   sWo(awo[ak++],_WREDRAW,_WEO);

//  setRGB(ki,bv,jv,bluev);
      //<<"$ki $redv $bv $jv \n"
   ki++;
   jv += jdv;
   }
   bv += bdv;
   }

  


   sWo(rwo,_WVALUE,wovalue.strPrintf("%3.2f",redv) ,_WEO);
   sWo(bwo,_WVALUE, wovalue.strPrintf("%3.2f",bluev) ,_WEO);
   sWo(gwo,_WVALUE, wovalue.strPrintf("%3.2f",greenv) ,_WEO);


 wovalue.strPrintf(" Did you see this"); 


   

cout << "txt " << wovalue << endl;

   float tx = 0.1;
   float ty = 0.5;
   sWo(two,_WCLEAR,_WTEXTR,wovalue.cptr(),&tx,&ty,0,0,RED_,_WREDRAW,_WEO);

   ty =0.6;
   
  wovalue.strPrintf("emsg <|%s|> cname <|%s|> red %f green %f blue %f",gev.emsg.cptr(),cname.cptr(), redv,greenv,bluev);

  sWo(two,_WCLEAR,_WTEXTR,wovalue.cptr(),&tx,&ty,0,0,RED_,_WREDRAW,_WEO);


   sleep(0.1);

  }



 exit(-1);
}
//==============================//

extern "C" int test_colors(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    o_uac->colorWorld(sarg);

  }