SetDebug(1)


OpenDLL("math")

    // oo version 

    vp= CreateGwindow("title","VP","scales",0,0,1.0,1.5,"savescales",0)
    SetGwindow(vp,"resize",0.1,0.05,0.95,0.75,0)
    SetGwindow(vp,"clip",0.1,0.1,0.8,0.3,"drawon","pixmapon","redraw","save")
    gsync()

sleep(2)


proc plotCols (awod)
{
<<" $awod \n"
  setgwob(awod,"scales",0,0,1,1)

by = 0.0
ty = 0.1
bw = 0.06
bx = 0.0
index = 32
bX = bw + bx
#{
   for (j = 0; j < 9 ; j++) {
     PlotBox(awod,bx,by,bX,ty,index++,1)
     bx = bX
     bX = bw + bx
   }
#}
by =ty
ty = 0.95

     PlotBox(awod,0,by,1,ty,39,1)


}

np = get_planes()

if ( np > 2 ) {
np = get_planes()
#rainbow()
#ff=set_gsmap(8,8)
si_pause(1)
}


dx = 2 / 25
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



dx = .03
rx = 0.75
rX = rx + dx

gx = rX + dx
gX = gx + dx

bx = gX + dx
bX = bx + dx


dy = 0.1
cby = 0.1
cbY= cby + dy


  pbwo=CreateGWOB(vp,"GRAPH","resize",0,0.1,0.4,0.7,0.9,"name","PB","color","white","drawon","pixmapon","save")

  setgwob(pbwo,"scales",0,0,1,1)
  setgwob(pbwo,"clear","clipborder","brown","save")

<<" $pbwo \n"

//  pbwo=CreateGWOB(vp,"GRAPH",{<resize,0,bx,cby,bX,cbY>,<name,"PB">,<color,"white">,drawon})



  rwo=CreateGWOB(vp,"BV","resize",0,rx,cby,rX,cbY,"name","R")
  setGWOB(rwo,"color","red","penhue","black","symbol","tri","style","SVO")

//  BADNESS "setvmove",1,"redraw")

  gwo=CreateGWOB(vp,"BV","resize",0,gx,cby,gX,cbY,"name","G")
  setGWOB(gwo,"color","green","penhue","black","symbol","tri","style","SVO")

  bwo=CreateGWOB(vp,"BV","resize",0,bx,cby,bX,cbY,"name","B")
  setGWOB(bwo,"color","blue","penhue","black","symbol","tri","style","SVO")


  int rgbwo[] = { rwo,gwo,bwo }

<<" name array %v $rgbwo \n"

//  SetGwob({rwo,gwo,bwo},"setvmove",1,"redraw")
//  can't do anonymous array 

  //SetGwob(rgbwo,"setvmove",1,"redraw")


// paintbox
    
int awo[9]
k = 0
     index = 32

     for (k = 0; k < 8; k++) { 
      awo[k]=CreateGWOB(vp,"GRAPH","name","${k}_col","color",index)
      index++
     }

<<" $awo \n"




      wohtile(awo,0,0.2,0.1,0.75,0.3)

      setgwob(awo,"clipborder","red","redraw")


      axis(vp,2,0,1,0.1,0.05,1.5)
      axnum(vp,2,0,1,0.1,3,"3.2f")


     A=ofw("junk")


int MI[10]


oredv = 0.0
ogreenv = 0.0
obluev = 0.0

float WXY[4]


	WXY=wogetposition(rwo)

<<"%v $WXY \n"



while (1) {


	WXY=wogetposition(rwo)

<<" $WXY \n"

#w_file(A,"x ",WXY[1]," y ", WXY[2]," ",WXY[0],"\n")

	redv = WXY[2]

        redv = limitval(redv,0.0,1.0)

        iredv = 1.0 - redv

<<" $WXY \n"

	WXY=wo_getposition(gwo)


<<" $WXY \n"

	greenv = WXY[2]

        greenv = limitval(greenv,0.0,1.0)

        igreenv = 1.0 - greenv


	WXY=WoGetPosition(bwo)

	bluev = WXY[2]


        bluev = limitval(bluev,0.0,1.0)


        ibluev = 1.0 - bluev


#w_file(A,"r ",r," g ", g," b ",b,"\n")

       update =0

       if (redv != oredv) update = 1
       if (greenv != ogreenv) update = 1
       if (bluev != obluev) update = 1

        if (update) {
        
        index = 32

	SetRGB(index++,redv,0,0)
	SetRGB(index++,0.0,greenv,0.0)
	SetRGB(index++,0,0,bluev)
	SetRGB(index++,redv,greenv,0.0)
	SetRGB(index++,0.0,greenv,bluev)
	SetRGB(index++,redv,0.0,bluev)
        SetRGB(index++,(1.0-redv),1.0-greenv,1.0-bluev)

//        SetRGB(index++,iredv,igreenv,ibluev)

	SetRGB(index++,redv,greenv,bluev)

//<<" %v $index \n"

	SetRGB(767,redv,greenv,bluev)

        Setgwob(pbwo,"clipborder","black")

	plotCols (pbwo)

        gsync()

        SetGwob(awo,"clear")

       oredv = redv
       ogreenv = greenv
       obluev = bluev

//<<"%V $redv $greenv $bluev  $iredv $igreenv $ibluev \n"

       }
        si_pause(1.0)

}




 STOP!




////////////////////////////////////////////////////

par_menu = "rgb"
value = table_menu(par_menu)   	    

while ( value == 1) {
 r= get_menu_value(par_menu,"red")
 b= get_menu_value(par_menu,"blue")
 g= get_menu_value(par_menu,"green")
 SetRGB(5,r,g,b)
 value = table_menu(par_menu)   	    
}


si_pause(3)

rainbow()

STOP!
