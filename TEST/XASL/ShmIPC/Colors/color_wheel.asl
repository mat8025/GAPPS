//%*********************************************** 
//*  @script color_wheel.asl 
//* 
//*  @comment show color map via a wheel 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Sun Mar 22 11:08:30 2020 
//*  @cdate Sun Mar 22 11:05:34 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


#include "debug"
#include "hv.asl"

openDll("image")

ignoreErrors();

Pi = 4.0 * atan(1.0)


//////////////////////////////////////////

   Np = 10;

   NF = Np * 4;

  float PV[12][NF];

    /// outer ring

    float outer_rad  = 2.5;
    float inner_rad  = 2.0;

   float ang = 0.0;



   float da = 30.0/ Np;
   
     dar= d2r(ang)


    <<"$ang $dar \n"

    int k = 0;
    int i;

     ang2 = ang;

  for (j= 0; j < 12; j++) {
<<"///////////// Outer //////\n"
     k= 0;
      ang = ang2;
     for (i = 0; i < Np; i++) {

            dar= d2r(ang)
            x= outer_rad * sin(dar);
	    y= outer_rad * cos(dar);
    <<"$i $k $ang $x $y \n"
            PV[j][k++] = x;
	    PV[j][k++] = y;
            ang += da
       }

          ang2 = ang ;

<<"///////////// Inner //////\n"
           ang -= da
     for ( i = 0; i < Np; i++) {

            dar= d2r(ang)
            x= inner_rad * sin(dar);
	    y= inner_rad * cos(dar);
    <<"$i $k $ang $x $y \n"
            PV[j][k++] = x;
	    PV[j][k++] = y;
            ang -= da
        }
    }
<<"///////////////////////\n"


<<"%(2,\t, ,\n )$PV[0]\n"
<<"///////////////////////\n"

	  PV0 = PV[0][::]
<<"PV0   \n"
<<"%(2,\t, ,\n )$PV0\n"

	  PV1 = PV[1][::]
<<"PV1   \n"
<<"%(2,\t, ,\n )$PV1\n"

	  PV2 = PV[2][::]
<<"PV2   \n"
<<"%(2,\t, ,\n )$PV2\n"






////////////////////////////////////////////////////////



 rainbow();
 redv = 0.5
 greenv = 0.5
 bluev = 0.5




sleep(1)
<<"\n"

HT=getRGBfromHTMLname("yellowgreen")

<<"yellowgreen $HT   %x $HT[4]\n"


HT=getRGBfromHTMLname("cyan")

<<"cyan $HT   %x $HT[4]\n"


HT=getRGBfromHTMLname("rosybrown")

<<"rose $HT   %x $HT[4]\n"

HT=getRGBfromHTMLname("azure")

<<"azure $HT   %x $HT[4]\n"


// Complementary Colors

<<"Complementary Colors \n"

int CC[12]
kc= 0;
ci = getcolorindexfromname("yellow")
<<"yellow $ci \n"
CC[kc++] = ci


cname = "yelloworange";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
cname = "orange";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
cname = "orangered";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
cname = "red";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci

cname = "redviolet";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci

cname = "violet";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
cname = "blueviolet";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
cname = "blue";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci

cname = "bluegreen";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci

cname = "green";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci

cname = "yellowgreen";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci



<<"$CC\n"


 rainbow();

#include "graphic"
#include "gevent"


// how to draw wheel  with twelve sections ?
 vp = cWi(_title,"COLOR_WHEEL",_resize,0.05,0.01,0.5,0.9,0,_eo);
  
  sWi(vp,_pixmapon,_drawon,_save,_savepixmap,_bhue,WHITE_);
  
  titleButtonsQRD(vp);
  titleVers();

  cx = 0.1;
  cX = 0.9;
  cy = 0.2;
  cY = 0.95;
  
    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily
  
  daname = "WHEEL";
  
  gwo= cWo(vp,_GRAPH,_name,"GL",_color,WHITE_);
  
  sWo(gwo,_clip,cx,cy,cX,cY, _drawon, _resize,0.05,0.1,0.99,0.95,_eo);

 // scales 
    sx = -3
    sX = 3.0
    sy = -3
    sY = 3.0

  sWo(gwo,_scales, sx, sy, sX, sY,_save, _savepixmap,_redraw,_pixmapon,_drawon)

  sWi(vp,_redraw)


  int kp = 0;
  int col = 1000;
  int co = 0;
  while (1) {


          sWo(gwo,_drawon)

          sWo(gwo,_clearpixmap,_pixmapon,_savepixmap)

          sWo(gwo,_clear,_border,BLUE_,_clipborder,RED_,_eo)

          plot(gwo,_circle,0,0,2,YELLOW_,0)

          plot(gwo,_circle,0,0,2.5, RED_,0)

          plot(gwo,_box,-0.5,-0.5,0.5,0.5,LILAC_,1.0)

	  for (kp = 0; kp < 12; kp++) {

          PX = PV[kp][::]
	  co = ((kp + _eloop) % 12)
          col = CC[co]	  
          plot(gwo,_poly,PX,col,1);

         }
         <<"%V $col\n"



       //  sWi(vp,_redraw);
         sWo(gwo, _showpixmap)

         eventWait();

         titleMsg("%V $_ekeyw  $_ebutton $_eloop")

  }


exit()