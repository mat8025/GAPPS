/* 
 *  @script color_wheel.asl                                             
 * 
 *  @comment show color map via a wheel                                 
 *  @release Boron                                                      
 *  @vers 1.6 C Carbon [asl 5.86 : B Rn]                                
 *  @date 03/11/2024 00:45:39                                           
 *  @cdate Sun Mar 22 11:05:34 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 




#include "debug"
#include "hv.asl"




openDll("image")

ignoreErrors();

Pi = 4.0 * atan(1.0)

#include "graphic"
#include "gevent"
#include "tbqrd"
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


//    <<"$ang $dar \n"

    int k = 0;
    int i;

     ang2 = ang;

  for (j= 0; j < 12; j++) {
//<<"///////////// Outer //////\n"
     k= 0;
      ang = ang2;
     for (i = 0; i < Np; i++) {

            dar= d2r(ang)
            x= outer_rad * sin(dar);
	    y= outer_rad * cos(dar);
    //<<"$i $k $ang $x $y \n"
            PV[j][k++] = x;
	    PV[j][k++] = y;
            ang += da
       }

          ang2 = ang ;

//<<"///////////// Inner //////\n"
           ang -= da
     for ( i = 0; i < Np; i++) {

            dar= d2r(ang)
            x= inner_rad * sin(dar);
	    y= inner_rad * cos(dar);
  //  <<"$i $k $ang $x $y \n"
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

CC[kc++] = ci
<<"yellow $ci $CC[0]\n"

cname = "yelloworange";
ci = getcolorindexfromname(cname)
<<"$cname $ci \n"
CC[kc++] = ci
<<"yelloworange $ci $CC[1]\n"
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


 ans=ask("CC?",0)


 rainbow();



// how to draw wheel  with twelve sections ?
 vp = cWi("COLOR_WHEEL")
 sWi(_WOID,vp,_WRESIZE,wbox(0.05,0.01,0.5,0.9,0);
  
  sWi(_WOID,vp,_WPIXMAP,ON_,_WSAVEPIXMAP,ON,_WBHUE,WHITE_);
  
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
  
  gwo= cWo(vp,_GRAPH)


  
  sWo(_WOID,gwo,_WCLIP,wbox(cx,cy,cX,cY), _WDRAW,ON_, _WRESIZE,wbox(0.05,0.1,0.99,0.95),   _WNAME,"GL",_WCOLOR,WHITE_);

 // scales 
    sx = -3
    sX = 3.0
    sy = -3
    sY = 3.0

  sWo(_WOID,gwo,_WSCALES, wbox(sx, sy, sX, sY),_WSAVE,ON_ ,_WSAVEPIXMAP,ON_,_WREDRAW,ON_,_WPIXMAP,ON_)

  sWi(_WOID,vp,_WREDRAW,1)

  ans=ask("Screen OK",0)
  
  int kp = 0;
  int col = 1000;
  int co = 0;
  int eloop = 0;
  while (1) {


          //sWo(gwo,_drawon)

          sWo(_WOID,gwo,_WCLEARPIXMAP,ON_,_WPIXMAP,1,_WSAVEPIXMAP,1)

          sWo(_WOID,gwo,_WCLEAR,1,_WBORDER,BLUE_,_WCLIPBORDER,RED_)

          plot(gwo,_WCIRCLE,0,0,2,YELLOW_,0)

          plot(gwo,_WCIRCLE,0,0,2.5, RED_,0)

          plot(gwo,_WBOX,-0.5,-0.5,0.5,0.5,LILAC_,1.0)

	  for (kp = 0; kp < 12; kp++) {

          PX = PV[kp][::]
	  co = ((kp + eloop) % 12)
          col = CC[co]	  
          plot(gwo,_WPOLY,PX,col,1);
        // <<"%V $kp $co $eloop $col\n"
//	 <<" $PX\n"
         }




       //  sWi(vp,_redraw);
         sWo(_WOID,gwo, _WSHOWPIXMAP,1)

         eventWait();

         eloop++;
	 
      //   titleMsg("%V $GEV_keyw  $GEV_button $eloop")

  }


exit_gs()