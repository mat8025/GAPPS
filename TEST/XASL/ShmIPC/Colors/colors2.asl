/* 
 *  @script colors2.asl                                                 
 * 
 *  @comment show color map                                             
 *  @release Boron                                                      
 *  @vers 1.7 N Nitrogen [asl 5.85 : B At]                              
 *  @date 03/10/2024 20:03:14                                           
 *  @cdate Sun Mar 22 11:05:34 2020                                     
 *  @author Mark Terry 22 11:05:34 2020                                 
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



#include "debug.asl"
#include "hv.asl"

ignoreErrors();

Pi = 4.0 * atan(1.0)

 redv = 0.5
 greenv = 0.5
 bluev = 0.5

#include "graphic"

#include "gevent"
#include "tbqrd"



    rainbow()
    
    vp = cWi("Button")
    
    sWi(_WOID,vp,_WRESIZE,wbox(0.01,0.01,0.45,0.49,0))

   titleButtonsQRD(vp);


    sWi(_WOID,vp,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_)
    sWi(_WOID,vp,_WSCALES,wbox(0,-0.2,1.5,1.5))
    sWi(_WOID,vp,_WCLIP,wbox(0.2,0.2,0.9,0.9))
    sWi(_WOID,vp,_WCLIPBORDER,BLACK_,_WREDRAW,ON_)

    vp2 = cWi("Colors");
    sWi(_WOID,vp2,_WRESIZE,wbox(0.51,0.1,0.99,0.99,0))
    sWi(_WOID,vp2,_WBHUE,WHITE_)


    txtwin = cWi("MC_INFO")
    sWi(_WOID,txtwin,_WRESIZE,wbox(0.01,0.51,0.49,0.99,0))


  rx = 0.2
  rX = 0.3

  gx = 0.4
  gX = 0.5

  bx = 0.6
  bX = 0.7

  cby = 0.1
  cbY = 0.3

  cbx = 0.1
  cbX = 0.6


  rwo=cWo(vp,WO_BV_)
  sWo(_WOID,rwo,_WNAME,"Red",_WVALUE,"$redv",_WSTYLE,"SVB")

  sWo(_WOID,rwo,_WCOLOR,RED_,_WPENHUE,"black",_WVMOVE,1)

  gwo=cWo(vp,WO_BV_)
  sWo(_WOID,gwo,_WNAME,"Green"_WRESIZE,wbox(gx,cby,gX,cbY),_WNAME,"Green",_WVALUE,"$greenv",_WVMOVE,1)

  sWo(_WOID,gwo,_WCOLOR,GREEN_,_WPENHUE,BLACK_,_WSTYLE,SVB_,_WSYMBOL,"tri")

  bwo=cWo(vp,WO_BV_)

  sWo(_WOID,bwo,_WNAME,"Blue",_WRESIZE,wbox(bx,cby,bX,cbY),_WNAME,"Blue",_WVALUE,bluev,_WVMOVE,1)

  sWo(_WOID,bwo,_WCOLOR,BLUE_,_WPENHUE,BLACK_,_WSTYLE,SVB_)


  int rgbwo[] = { rwo, gwo, bwo };

  wo_htile( rgbwo, cbx,cby,cbX,cbY,0.02)
  //sWo( rgbwo, _vmove,1, "setmsg",1 )
//  sWo( rgbwo, _vmove,1)

 // use title quit button
 // qwo=cWo(vp,"BV",_name,"QUIT?",_VALUE,"QUIT",_color,"orange",_resize,0.8,0.1,0.95,0.2,_eo)
 // sWo(qwo,_BORDER,_DRAWON,_CLIPBORDER,_FONTHUE,"black", _redraw)

  sWi(_WOID,vp,"woredrawall")

 two=cWo(txtwin,WO_TEXT_)
 sWo(_WOID,two,_WNAME,"Text",_WVALUE,"howdy",_WCOLOR,ORANGE_,_WRESIZE,wbox(0.1,0.1,0.9,0.9))

 sWo(_WOID,two,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,RED_,_WFONTHUE,BLACK_)

 sWo(_WOID,two,_WSCALES,wbox(-1,-1,1,1))

int awo[100];
k = 0


     matrix_index = 64
     index = matrix_index;

     set_gsmap(100, matrix_index);

    for (k = 0; k < 100; k++) { 
   
     // awo[k]=cWo(vp2,GRAPH_,_name,"${k}_col",_eo)
    //  awo[k]=cWo(vp2,GRAPH_);
      awo[k]=cWo(vp2,GRAPH_);
    //  <<"grid $k $index\n"
      sWo(_WOID,awo[k],_WDRAW,ON_,_WCOLOR,index,_WVALUE,k,_WNAME,"${k}_col")
      sWo(_WOID,awo[k],_WBORDER,ON_,_WCLIPBORDER,ON_);
      index++
     }

//<<"%v $awo \n"

     

     worctile(awo,0.1,0.1,0.9,0.9,10,10);
     titleVers()
     sWi(_WOID,vp,_WREDRAW,ON_)
     sWi(_WOID,vp2,_WREDRAW,ON_)


ans=ask("Screen OK?",0)
//  now loop wait for message  and print

int rgb_index = 32
float WXY[10]


   while (1) {

     eventWait()

//   redv = atof( getWoValue(rwo))
//   greenv = atof ( getWoValue(gwo))
//   bluev =  atof (getWoValue(bwo))


    WoGetRXY(gwo,WXY)

  <<" $WXY \n"

  greenv = limitval(WXY[2],0,1)

  wogetrxy(rwo,WXY)

  redv = limitval(WXY[2],0,1)

   wogetrxy(bwo,WXY)
   bluev = limitval(WXY[2],0,1)

<<"%V $redv $greenv $bluev \n"

   sWo(_WOID,rwo,_WVALUE,redv,_WUPDATE,ON_)
   sWo(_WOID,gwo,_WVALUE,greenv,_WUPDATE,ON_)
   sWo(_WOID,bwo,_WVALUE,bluev,_WUPDATE,ON_)

   setRGB(rgb_index,redv,greenv,bluev)

   color_index = getColorIndexFromRGB(redv,greenv,bluev)

   cname = getColorName(color_index) ; // image lib auto open??


   c_index = matrix_index

   setRGB(c_index++,redv,0,0)
   setRGB(c_index++,0,greenv,0)
   setRGB(c_index++,0,0,bluev)

   setRGB(c_index++,redv,greenv,bluev)
   setRGB(c_index++,redv,greenv,0)
   setRGB(c_index++,0,greenv,bluev)
   setRGB(c_index++,redv,0,bluev)

   setRGB(c_index++,1-redv,1-greenv,1-bluev)
   setRGB(c_index++,redv,1-greenv,1-bluev)

   setRGB(c_index++,1-redv,greenv,1-bluev)

   setRGB(c_index++,redv,greenv,1-bluev)

   setRGB(c_index++,1-redv,greenv,bluev)
   setRGB(c_index++,redv,1-greenv,bluev)



   rs = (Sin(redv * Pi) + 1.0) / 2.0
   bs = (Sin(bluev * Pi) + 1.0) / 2.0
   gs = (Sin(greenv * Pi) + 1.0) / 2.0
   rc = (Cos(redv * Pi) + 1.0) / 2.0
   bc = (Cos(bluev * Pi) + 1.0) / 2.0
   gc = (Cos(greenv * Pi) + 1.0) / 2.0

   setRGB(c_index++,rs,bs,gs)
   setRGB(c_index++,rs,bc,gc)
   setRGB(c_index++,rc,bc,gc)
   setRGB(c_index++,rs,bc,gs)
   setRGB(c_index++,rc,bc,gc)
   setRGB(c_index++,rs,bc,gs)
   setRGB(c_index++,rc,bs,gc)

   jdv = 1.0/9.0
   ki =   c_index;
   bv = 0.0
   bdv = 1.0/7.0

 <<"%V $GEV_woid  $rwo $gwo $bwo \n";

  woval =wogetvalue (rwo);

<<"rwo $woval \n"

  woval =wogetvalue (gwo);

<<"gwo $woval \n"
woval =wogetvalue (bwo);
<<"bwo $woval \n"

   for (rj = 0; rj < 8 ; rj++) {
   jv = 0.0
   for (j = 0; j < 10 ; j++) {
    
     if (GEV_woid == rwo) {
       setRGB(ki,redv,bv,jv)
     }
      else if(GEV_woid == gwo) {
       setRGB(ki,bv,greenv,jv)
      }
      else if (GEV_woid == bwo) {
        setRGB(ki,bv,jv,bluev)
      }

//  setRGB(ki,bv,jv,bluev);
      //<<"$ki $redv $bv $jv \n"
   ki++
   jv += jdv
   }
   bv += bdv
   }

  for(j =0;j < 100; j++) {
   sWo(_WOID, awo[j], _WREDRAW,ON_)
  
   }

   sWo(_WOID,rwo,_WVALUE,redv)
   sWo(_WOID,bwo,_WVALUE,bluev)
   sWo(_WOID,gwo,_WVALUE,greenv)

   //sWo(_WOID,two,_wclear,_texthue,"black",_textr,"$_emsg\n $cname\n%V$_ebutton \n %V3.2f$redv $greenv $bluev",-0.9,0,_eo)

  
   sleep(0.05)

  }




 exit_gs()




;