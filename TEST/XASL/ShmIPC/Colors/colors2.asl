/* 
 *  @script colors2.asl 
 * 
 *  @comment show color map 
 *  @release CARBON color map 
 *  @vers 1.6 C 6.3.94 C-Li-Pu 
 *  @date 03/12/2022 11:04:28          
 *  @cdate Sun Mar 22 11:05:34 2020 
 *  @author Mark Terry 22 11:05:34 2020 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                        


#include "debug"
#include "hv.asl"

ignoreErrors();

Pi = 4.0 * atan(1.0)

 redv = 0.5
 greenv = 0.5
 bluev = 0.5

#include "graphic"

#include "gevent"
//#include "tbqrd"



    rainbow()
    
    vp = cWi(_title,"Button")
    sWi(vp,_resize,0.01,0.01,0.45,0.49,0,_eo)

   titleButtonsQRD(vp);


    sWi(vp,_pixmapon,_drawon,_save,_bhue,WHITE_)
    sWi(vp,"scales",0,-0.2,1.5,1.5,_eo)
    sWi(vp,"clip",0.2,0.2,0.9,0.9,_eo)
    sWi(vp,_clipborder,BLACK_,_redraw,_save)

    vp2 = cWi(_title,"Colors");
    sWi(vp2,"resize",0.51,0.1,0.99,0.99,0,_eo)
    sWi(vp2,_pixmapon,_drawon,_save,_bhue,"white")


    txtwin = cWi("title","MC_INFO","resize",0.01,0.51,0.49,0.99,0,_eo)


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


  rwo=cWo(vp,"BV",_name,"Red",_value,"$redv",_style,"SVB")

  sWo(rwo,_color,RED_,_penhue,"black",_vmove,1,_eo)

  gwo=cWo(vp,"BV",_name,"Green"_resize,gx,cby,gX,cbY,_NAME,"Green",_VALUE,"$greenv",_eo)

  sWo(gwo,_color,GREEN_,_penhue,"black",_style,"SVB",_symbol,"tri",_eo)

  bwo=cWo(vp,"BV",_name,"Blue",_resize,bx,cby,bX,cbY,_NAME,"Blue",_VALUE,bluev,_eo)

  sWo(bwo,_color,BLUE_,_penhue,"black",_style,"SVB",_eo)


  int rgbwo[] = { rwo, gwo, bwo }

  wo_htile( rgbwo, cbx,cby,cbX,cbY,0.02)
  //sWo( rgbwo, _vmove,1, "setmsg",1 )
  sWo( rgbwo, _vmove,1,_eo)

 // use title quit button
 // qwo=cWo(vp,"BV",_name,"QUIT?",_VALUE,"QUIT",_color,"orange",_resize,0.8,0.1,0.95,0.2,_eo)
 // sWo(qwo,_BORDER,_DRAWON,_CLIPBORDER,_FONTHUE,"black", _redraw)

  sWi(vp,"woredrawall")

 two=cWo(txtwin,"TEXT",_name,"Text",_VALUE,"howdy",_color,"orange",_resize_fr,0.1,0.1,0.9,0.9,_eo)

 sWo(two,_BORDER,_DRAWON,_CLIPBORDER,_FONTHUE,BLACK_, _redraw,_pixmapon,_drawon)

 sWo(two,_scales,-1,-1,1,1,_eo)

int awo[100];
k = 0


     matrix_index = 64
     index = matrix_index;
set_gsmap(100, matrix_index);
    for (k = 0; k < 100; k++) { 
   
     // awo[k]=cWo(vp2,GRAPH_,_name,"${k}_col",_eo)
    //  awo[k]=cWo(vp2,GRAPH_);
      awo[k]=cWo(vp2,GRAPH_);
   
      sWo(awo[k],_type,GRAPH_,_drawon,_color,index,_value,k,_name,"${k}_col",_eo)
       index++
     }

//<<"%v $awo \n"

     sWo(awo,_BORDER,_DRAWON,_CLIPBORDER)

     worctile(awo,0.1,0.1,0.9,0.9,10,10);
     titleVers()
     sWi(vp,_redraw)
     sWi(vp2,_redraw)



//  now loop wait for message  and print

int rgb_index = 32
float WXY[]


   while (1) {

     eventWait()

//   redv = atof( getWoValue(rwo))
//   greenv = atof ( getWoValue(gwo))
//   bluev =  atof (getWoValue(bwo))


   WXY= WoGetPosition(gwo)

  <<"$_ename $_ewoid  $WXY \n"

  greenv = limitval(WXY[2],0,1)
  WXY= wogetposition(rwo)
  redv = limitval(WXY[2],0,1)

   WXY= wogetposition(bwo)
   bluev = limitval(WXY[2],0,1)

   sWo(rwo,_value,"%3.2f$redv",_update,_eo)
   sWo(gwo,_value,"%3.2f$greenv",_update)
   sWo(bwo,_value,"%3.2f$bluev",_update)

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

 <<"%V $_ewoid  $rwo $gwo $bwo \n";

  woval =wogetvalue (rwo);

<<"rwo $woval \n"

  woval =wogetvalue (gwo);

<<"gwo $woval \n"
woval =wogetvalue (bwo);
<<"bwo $woval \n"

   for (rj = 0; rj < 8 ; rj++) {
   jv = 0.0
   for (j = 0; j < 10 ; j++) {
// _ewoname _= "Red"
       //setRGB(ki,redv,bv,jv)

    
    
     if (_ewoid == rwo) {
       setRGB(ki,redv,bv,jv)
     }
      else if(_ewoid == gwo) {
       setRGB(ki,bv,greenv,jv)
      }
      else if (_ewoid == bwo) {
        setRGB(ki,bv,jv,bluev)
      }

//  setRGB(ki,bv,jv,bluev);
      //<<"$ki $redv $bv $jv \n"
   ki++
   jv += jdv
   }
   bv += bdv
   }

  
   sWo(awo,_redraw)

   sWo(rwo,_VALUE,redv,_eo)
   sWo(bwo,_VALUE,bluev,_eo)
   sWo(gwo,_VALUE,greenv,_eo)

   sWo(two,_clear,_texthue,"black",_textr,"$_emsg\n $cname\n%V$_ebutton \n %V3.2f$redv $greenv $bluev",-0.9,0,_eo)

  
   sleep(0.05)

  }




 exit_gs()




;