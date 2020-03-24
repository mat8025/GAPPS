//%*********************************************** 
//*  @script colors2.asl 
//* 
//*  @comment show color map 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Sun Mar 22 11:08:30 2020 
//*  @cdate Sun Mar 22 11:05:34 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "gevent.asl"
include "debug"
include "hv.asl"

setdebug(0)

Pi = 4.0 * atan(1.0)

 redv = 0.5
 greenv = 0.5
 bluev = 0.5

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


include "tbqrd"



    rainbow()
    
    vp = cWi(@title,"Button",@resize,0.01,0.01,0.45,0.49,0)

   titleButtonsQRD(vp);


    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_)
    sWi(vp,"scales",0,-0.2,1.5,1.5)
    sWi(vp,"clip",0.2,0.2,0.9,0.9)
    sWi(vp,@clipborder,BLACK_,@redraw,@save)

    vp2 = cWi(@title,"Colors","resize",0.51,0.1,0.99,0.99,0)
    sWi(vp2,@pixmapon,@drawon,@save,@bhue,"white")


    txtwin = cWi("title","MC_INFO","resize",0.01,0.51,0.49,0.99,0)


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


  rwo=cWo(vp,"BV",@name,"Red",@value,"$redv",@style,"SVB")

  sWo(rwo,@color,RED_,@penhue,"black",@vmove,1)

  gwo=cWo(vp,"BV",@name,"Green"@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,"$greenv")

  sWo(gwo,@color,GREEN_,@penhue,"black",@style,"SVB",@symbol,"tri")

  bwo=cWo(vp,"BV",@name,"Blue",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  sWo(bwo,@color,BLUE_,@penhue,"black",@style,"SVB")


  int rgbwo[] = { rwo, gwo, bwo }

  wo_htile( rgbwo, cbx,cby,cbX,cbY,0.02)
  //sWo( rgbwo, @vmove,1, "setmsg",1 )
  sWo( rgbwo, @vmove,1)

  qwo=cWo(vp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,0.8,0.1,0.95,0.2)

  sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

  sWi(vp,"woredrawall")

 two=cWo(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.1,0.9,0.9)

 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@pixmapon,@drawon)

 sWo(two,@scales,-1,-1,1,1)

int awo[100]
k = 0

     matrix_index = 64
     index = matrix_index;
     for (k = 0; k < 100; k++) { 
   
      awo[k]=cWo(vp2,GRAPH_,@name,"${k}_col")
   
      sWo(awo[k],@drawon,@color,index,@value,k)
       index++
     }

//<<"%v $awo \n"

     sWo(awo,@BORDER,@DRAWON,@CLIPBORDER)

     worctile(awo,0.1,0.1,0.9,0.9,10,10)
     titleVers()
     sWi(vp,@redraw)
     sWi(vp2,@redraw)



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

   sWo(rwo,@value,"%3.2f$redv",@update)
   sWo(gwo,@value,"%3.2f$greenv",@update)
   sWo(bwo,@value,"%3.2f$bluev",@update)

   setRGB(rgb_index,redv,greenv,bluev)

   color_index = getColorIndexFromRGB(redv,greenv,bluev)

   cname = getColorName(color_index)


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

 
   for (rj = 0; rj < 8 ; rj++) {
   jv = 0.0
   for (j = 0; j < 10 ; j++) {
// _ewoname @= "Red"
       //setRGB(ki,redv,bv,jv)
     if (_ewoid == rwo) {
       setRGB(ki,redv,bv,jv)
     }
      elif (_ewoid == gwo) {
       setRGB(ki,bv,greenv,jv)
      }
      elif (_ewoid == bwo) {
        setRGB(ki,bv,jv,bluev)
      }

      //<<"$ki $redv $bv $jv \n"
   ki++
   jv += jdv
   }
   bv += bdv
   }

  
   sWo(awo,@redraw)

   sWo(rwo,@VALUE,redv)
   sWo(bwo,@VALUE,bluev)
   sWo(gwo,@VALUE,greenv)

   sWo(two,@clear,@texthue,"black",@textr,"$_emsg\n $cname\n%V$_ebutton \n %V3.2f$redv $greenv $bluev",-0.9,0)

   if (_ewoid == qwo) {
        break;
   }

   sleep(0.05)

  }




 exit_gs()




;