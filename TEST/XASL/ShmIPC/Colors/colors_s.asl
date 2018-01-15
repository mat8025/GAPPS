//SetDebug(1)


Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


    // oo version 

    vp= cWi("title","VP","scales",0,-0.2,1.0,1.2,"savescales",0)
    sWi(vp,@resize,0.1,0.05,0.95,0.75,0)
    sWi(vp,@clip,0.1,0.1,0.8,0.8,@drawon,@pixmapon,@redraw,@save)
    gsync()

include "tbqrd"

  titleButtonsQRD(vp);


//////////////////////////////////

proc plotCols (awod)
{
//<<" $awod \n"
  sWo(awod,"scales",0,0,1,1)
csp = 0.01
by = 0.0
ty = 0.2
bw = 0.08
bx = 0.0

bX = bw + bx
index = 32;


   for (j = 0; j < 9 ; j++) {

    //<<"PLotBox $j $index\n"
     Plot(awod,@box,bx,by,bX,ty,index++,1)
     bx = bX
     bX = bw + bx +csp
   }

by =ty
ty = 0.95

//   Plot(awod,"box",0,by,1,ty,39,1)  // no plotbox function - FIX
}

//=====================================

np = get_planes()

if ( np > 2 ) {
np = get_planes()
#rainbow()
#ff=set_gsmap(8,8)
si_pause(1)
}


//dx = 2 / 25


dx = 0.05
dy = 0.1

x0 = -0.8
y0 = 0.6
x1 = x0 + dx
y1 = y0 + dy
dw = 0.01

ns = 50
dr = 1 / ns

dg = 0
db = 0



dx = 0.01

dw = 0.05

rx = 0.7

rX = rx + dw

gx = rX + dx
gX = gx + dw

bx = gX + dx
bX = bx + dw


dy = 0.1
cby = 0.5
cbY= cby + 0.1


  pbwo=cWo(vp,@GRAPH,@resize,0.1,0.1,0.5,0.25,"name","PB",@color,0,@drawon,@pixmapon,@save)
  sWo(pbwo,"scales",-0.5,-0.5,1.5,1.5)
  sWo(pbwo,"clear","clipborder","brown","save")

<<" $pbwo \n"


  mixwo=cWo(vp,@GRAPH,@resize,0.1,0.5,0.65,0.95,"name","RGB_COL",@color,32,@drawon,@pixmapon,@save)
  sWo(mixwo,"scales",-0.5,-0.5,1.5,1.5)
  sWo(mixwo,"clear","clipborder","brown","save")



    rwo=cWo(vp,"BV",@resize,rx,cby,rX,cbY,@name,"R",@value,0.5)
    sWo(rwo,@color,"red",@penhue,BLACK_,@symbol,"tri",@style,"SVO")

//  BADNESS "setvmove",1,"redraw")

  gwo=cWo(vp,"BV",@resize,gx,cby,gX,cbY,"name","G",@value,0.5)
  sWo(gwo,@color,GREEN_,@penhue,BLACK_,@symbol,"tri",@style,"SVO")

  bwo=cWo(vp,"BV",@resize,bx,cby,bX,cbY,"name","B",@value,0.5)
  sWo(bwo,@color,BLUE_,@penhue,BLACK_,@symbol,"tri",@style,"SVO")


  int rgbwo[] = { rwo,gwo,bwo }

<<" name array %v $rgbwo \n"

//  SetGwob({rwo,gwo,bwo},"setvmove",1,"redraw")
//  can't do anonymous array 

   sWo(rgbwo,@vmove,1,@redraw)


// paintbox
    
int awo[9]
k = 0
     index = 32

     for (k = 0; k < 8; k++) { 
      awo[k]=cWo(vp,@GRAPH,"name","${k}_col","color",index)
      index++
     }

<<" $awo \n"

      wohtile(awo,0,0.2,0.1,0.75,0.3)

      sWo(awo,@clipborder,BLACK_,@redraw)

      sWi(vp,@clipborder,BLACK_,@redraw);
      
      axis(vp,3,0,1,0.1,0.05,1.5);

      axnum(vp,3,0,1,0.1,3,"3.2f");



     sWo(rgbwo,@redraw)

    // go_on = yes_no_menu("GO ON?");
      //mans = popamenu("/home/mark/.GASP/MENUS/yes_or_no.m");

      //mans = popamenu("yes_or_no.m");


      //mans = popamenu("~/.GASP/MENUS/yes_or_no.m");

     // <<"%V$mans\n"
       
     A=ofw("junk")

include "gevent"

int MI[10]


oredv = 0.0
ogreenv = 0.0
obluev = 0.0

float WXY[4];


	WXY=wogetposition(rwo)

       axis(vp,2,0,1,0.1,0.05,1.5);
       axnum(vp,2,0,1,0.1,3,"3.2f");

<<"%V $WXY \n"
int loop = 0;

while (1) {


       eventWait()


       sWo(rgbwo,@redraw)
       sWo(mixwo,@redraw)       

       WXY=wogetposition(rwo)

<<"Red  $WXY \n"



#w_file(A,"x ",WXY[1]," y ", WXY[2]," ",WXY[0],"\n")

	redv = WXY[2]

        redv = limitval(redv,0.0,1.0)

        iredv = 1.0 - redv



	WXY=wo_getposition(gwo)

<<" Green $WXY \n"

	greenv = WXY[2]

        greenv = limitval(greenv,0.0,1.0)

        igreenv = 1.0 - greenv

	WXY=WoGetPosition(bwo)

<<" Blue $WXY \n"

	bluev = WXY[2]

        bluev = limitval(bluev,0.0,1.0)

        ibluev = 1.0 - bluev


#w_file(A,"r ",r," g ", g," b ",b,"\n")

       update =0

       if (redv != oredv) update = 1
       if (greenv != ogreenv) update = 1
       if (bluev != obluev) update = 1

        if (update) {
       
        sWi(vp,@clearclip,WHITE_,@clipborder,BLACK_,@savepixmap);

        sWo(mixwo,@redraw) ;
        index = 32

	SetRGB(index++,redv,greenv,bluev)
	SetRGB(index++,redv,0,0)
	SetRGB(index++,0.0,greenv,0.0)
	SetRGB(index++,0,0,bluev)
	SetRGB(index++,redv,greenv,0.0)
	SetRGB(index++,0.0,greenv,bluev)
	SetRGB(index++,redv,0.0,bluev)
        SetRGB(index++,(1.0-redv),1.0-greenv,1.0-bluev)

//        SetRGB(index++,iredv,igreenv,ibluev)

        sWo(rwo,@value,redv)
	sWo(gwo,@value,greenv)
	sWo(bwo,@value,bluev)
	
       axis(vp,4,0,1,0.1,0.05,1.5);
       axnum(vp,4,0,1,0.1,-3,"3.2f");

//<<" %v $index \n"

//	SetRGB(767,redv,greenv,bluev)

        sWo(pbwo,"clipborder","black")

	plotCols (pbwo)

        //gsync()

        //sWo(awo,"clear")

       oredv = redv
       ogreenv = greenv
       obluev = bluev

//<<"%V $redv $greenv $bluev  $iredv $igreenv $ibluev \n"
       sWo(rgbwo,@redraw)
       }

    //si_pause(0.2)

}


 STOP!



