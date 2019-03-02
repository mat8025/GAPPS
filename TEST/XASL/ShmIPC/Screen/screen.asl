//%*********************************************** 
//*  @script screen.asl 
//* 
//*  @comment test screen draw funcs 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Mon Feb 25 13:56:22 2019 
//*  @cdate Mon Feb 25 13:56:22 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"
include "gevent.asl"
include "hv.asl"
include "tbqrd";
debugON();

   Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
       if (X <= 0) {
         <<"spawn failed !\n"
	 exit();
       }
       <<"asl pid $X ?\n"
     }

wait(3)

//i_read("paint boxes?")
 scrnLine(0,0,500,500,GREEN_)

 scrnBox(200,200,500,500,BLUE_)


//i_read("see box?")


 scrnBox(500,400,700,600,YELLOW_,1)


scrnBox(600,0,700,300,LILAC_,1)

scrnBox(750,50,800,300,RED_,0)

   vp = cWi(@title,"BasicWindow")

    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_,@resize,0.1,0.1,0.5,0.5)
    sWi(vp,@clip,0.25,0.25,0.9,0.9)

    sWi(vp,@scales,-1,-1,1,1)

// setup a clip area (wo 0) inside of window

    sWi(vp,@clearclip,"red",@clipborder,"blue");
    
    titleButtonsQRD(vp);

      vp2 = cWi(@title,"LeftWindow_2")
    sWi(vp2,@pixmapon,@drawoff,@save,@store,@bhue,BROWN_,@resize,0.61,0.1,0.9,0.5)

       vp3 = cWi(@title,"TopLeftWindow_3")
    sWi(vp3,@pixmapon,@drawoff,@save,@bhue,GREEN_,@resize,0.61,0.51,0.9,0.9)


       vp4 = cWi(@title,"TopRightWindow_4")
    sWi(vp4,@pixmapon,@drawoff,@save,@bhue,YELLOW_,@resize,0.61,0.51,0.9,0.9,1)

int IV[30];

wid=wgetcoors(vp,IV);

<<"<$vp> $IV\n"

while (1) {

          //Ev->waitForMsg()
       eventWait();
<<"%V $_emsg $_etype $_ebutton $_ewoname $_ewid $_ewoid  $(PRESS_)\n"

      wid=wgetcoors(vp,IV);
<<"<$vp> $IV\n"

     scrnBox(IV[1]-5,IV[4]-5,IV[1]+10,IV[4]+5,RED_,0)
     scrnBox(IV[3]-5,IV[4]-5,IV[3]+10,IV[4]+5,BLUE_,0)
     scrnBox(IV[3]-5,IV[2]-5,IV[3]+10,IV[2]+5,GREEN_,0)
     scrnBox(IV[1]-5,IV[2]-5,IV[1]+10,IV[2]+5,YELLOW_,0)          

wid=wgetcoors(vp2,IV);
<<"<$vp2> $IV\n"

     scrnBox(IV[1]-5,IV[4]-5,IV[1]+10,IV[4]+5,RED_,0)
     scrnBox(IV[3]-5,IV[4]-5,IV[3]+10,IV[4]+5,BLUE_,0)
     scrnBox(IV[3]-5,IV[2]-5,IV[3]+10,IV[2]+5,GREEN_,0)
     scrnBox(IV[1]-5,IV[2]-5,IV[1]+10,IV[2]+5,YELLOW_,0)

wid=wgetcoors(vp3,IV);
<<"<$vp3> $IV\n"

     scrnBox(IV[1]-5,IV[4]-5,IV[1]+10,IV[4]+5,RED_,0)
     scrnBox(IV[3]-5,IV[4]-5,IV[3]+10,IV[4]+5,BLUE_,0)
     scrnBox(IV[3]-5,IV[2]-5,IV[3]+10,IV[2]+5,GREEN_,0)
     scrnBox(IV[1]-5,IV[2]-5,IV[1]+10,IV[2]+5,YELLOW_,0)          

wid=wgetcoors(vp4,IV);
<<"<$vp4> $IV\n"

     scrnBox(IV[1]-5,IV[4]-5,IV[1]+10,IV[4]+5,RED_,0)
     scrnBox(IV[3]-5,IV[4]-5,IV[3]+10,IV[4]+5,BLUE_,0)
     scrnBox(IV[3]-5,IV[2]-5,IV[3]+10,IV[2]+5,GREEN_,0)
     scrnBox(IV[1]-5,IV[2]-5,IV[1]+10,IV[2]+5,YELLOW_,0)          

   
}