//%*********************************************** 
//*  @script win.asl 
//* 
//*  @comment test win create and placement 
//*  @release CARBON 
//*  @vers 1.10 Ne Neon                                                    
//*  @date Wed Mar 25 12:00:09 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
// a  basic window
// create and size to screen


include "debug.asl"
include "hv.asl"
include "graphic.asl"
include "gevent.asl"

//debugON();

    draw_win = 1;
    vp = cWi(@title,"BasicWindow")

    sWi(vp,@pixmapon,@drawon,@save,@bhue,PINK_,@resize,0.1,0.1,0.5,0.5)
    sWi(vp,@clip,0.25,0.25,0.9,0.9)

    sWi(vp,@scales,-1,-1,1,1)

// setup a clip area (wo 0) inside of window

    sWi(vp,@clearclip,RED_,@clipborder,BLUE_);
    
    titleButtonsQRD(vp);





 txtwo=cWo(vp,"TEXT",@name,"Text",@value,"howdy",@color,ORANGE_,@resize,0.2,0.01,0.9,0.2)
 sWo(txtwo,@border,@drawon,@clipborder,@fonthue,"black",@pixmapoff)
 sWo(txtwo,@scales,0,0,1,1)
 sWo(txtwo,@help," Mouse & Key Info ")


 bsketchwo=cWo(vp,"GRAPH",@name,"sketch",@color,YELLOW_,@resize,0.01,0.15,0.14,0.2)
 sWo(bsketchwo,@border,@drawon,@clipborder,@fonthue,"red", @redraw)
 sWo(bsketchwo,@clip,0.1,0.15,0.95,0.85,@bhue,"lime")
 sWo(bsketchwo,@scales,-1,-1,1,1)

// show border
// draw lines within clip area

  plotline(vp,0,0,1,1,"blue")
 plotline(vp,0,1,1,0,"red")

   axnum(vp,1)
   axnum(vp,2)

   sWi(vp,@store)


   titleVers();
   
       vp2 = cWi(@title,"Window_2")
    sWi(vp2,@pixmapoff,@drawon,@save,@store,@bhue,BROWN_,@resize,0.61,0.1,0.9,0.5)

       vp3 = cWi(@title,"TopRightWindow_3")
    sWi(vp3,@pixmapoff,@drawon,@save,@bhue,GREEN_,@resize,0.61,0.51,0.9,0.9)

       vp4 = cWi(@title,"TopLeftWindow_4")
    sWi(vp4,@pixmapoff,@drawon,@save,@store,@bhue,RED_,@resize,0.21,0.51,0.41,0.9)

    sWi(vp2,@scales,-1,-1,1,1)
    sWi(vp3,@scales,-1,-1,1,1)
    sWi({vp2,vp3,vp4},@clip,0.1,0.1,0.9,0.9)
    sWi(vp,@clip,0.35,0.25,0.9,0.9)

    cx = 0.2
    cX = 0.8
    cy = 0.2
    cY = 0.8

    int vpo[] = {vp4,vp3,vp2};
   
    sWi(vpo,@clip,cx,cy,cX,cY);

/{
    sWi(vp2,@clip,cx,cy,cX,cY);
    sWi(vp3,@clip,cx,cy,cX,cY);
    sWi(vp4,@clip,cx,cy,cX,cY);
/}

//  add some window objects

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

  win_pm = 0;
  p2 = 0;

    gwo2=cWo(vp2,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo2,@clip,cx,cy,cX,cY)
    sWo(gwo2,@scales,0,0,1,1, @save,@savepixmap,@redraw,@drawon,@pixmapoff)
    // why both save and savepixmap needed ?

    gwo3=cWo(vp3,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo3,@clip,cx,cy,cX,cY)
    sWo(gwo3,@scales,0,0,1,1, @save,@savepixmap,@redraw,@drawon,@pixmapoff)

    gwo4=cWo(vp4,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo4,@clip,cx,cy,cX,cY)
    sWo(gwo4,@scales,0,0,1,1,@save, @savepixmap,@redraw,@drawoff,@pixmapoff)
 int gwo[] = {gwo2,gwo3,gwo4};


              Plot(vp2,@line,0.5,1,0.5,0,RED_)
              Plot(vp2,@line,0,0.5,1,0.5,RED_)
              Plot(vp2,@box,0,0,1,1,PINK_,1)
              Plot(vp3,@line,0.5,1,0.5,0,BLUE_)
              Plot(vp3,@line,0,0.5,1,0.5,YELLOW_)
              Plot(vp4,@line,0.5,0,0.5,1,MAGENTA_)
	      Plot(vp4,@line,0,0.5,1,0.5,MAGENTA_)
              Plot(vp4,@box,0,0,1,1,BROWN_,1)

              Plot(vp4,@line,0.5,1,0.5,0,BLUE_)
              Plot(vp4,@line,0,0.5,1,0.5,YELLOW_)

   kpress = 0;
   
    while (1) { 
       
       eventWait();


   titleMsg("$_emsg $_eloop $_ewoid  $_ewid $_ebutton $_etype $(PRESS_)\n");

  <<"$_emsg $_eloop $_ewoid  $_ewid $_ebutton $_etype $(PRESS_)\n"


 // if ( (_ebutton > 0) && (_etype == 2)) {
  if ( _ebutton > 0) {
   <<"PRESS button $_ebutton $_ewoid $_etype\n"
       sWo(txtwo,@clear)
       sWo(txtwo,@textr,"$_emsg",0.1,0.8)
       sWi(vp,@tmsg,"Hey buddy $_eloop");
       sWo(txtwo,@textr,"%V$_ebutton",0.1,0.7)
       sWo(txtwo,@textr,"%V$_erx $_ery",0.1,0.5)
//       sWo(txtwo,@textr,"%V6.2f$Rinfo[0:5]",0.1,0.3)

       sWo(txtwo,@redraw)
     //  sWi(vpo,@redraw)
       


       if (scmp(_emsgwd[1],"SELECT",6)) {
         RS=selectreal(vp)
        <<"%V$RS\n"
         sWo(txtwo,@textr,"%V6.2f$RS",0.1,0.2)
       }

     //  if (_ewoid == qwo) {
     //      break;
     //  }


      if (_ewid == vp) {
<<"$kpress\n"
      if ( (kpress %2) ==0) { 
      // sWi(vp3,@push)

     if (draw_win) {

            // sWi(vpo,@clip,cx,cy,cX,cY);
//sWi(vp3,@title,"TopLeftWindow_3")
    
      //        sWi(vpo,@clearpixmap)
	     // sWi(vpo,@showpixmap)	      
        if (win_pm)
             sWo(vpo,@clearpixmap)
	      
	      sWi(vp4,@clear)
//	      sWi(vp3,@clear)

            //  sWo(vp2,@clear,WHITE_);
              Plot(vp2,@line,0.5,1,0.5,0,RED_)
              Plot(vp2,@line,0,0.5,1,0.5,RED_)
              Plot(vp2,@box,0,0,1,1,PINK_,1)
              Plot(vp3,@line,0.5,1,0.5,0,YELLOW_)
              Plot(vp3,@line,0,0.5,1,0.5,YELLOW_)
              Plot(vp4,@line,0.5,0,0.5,1,MAGENTA_)
	      Plot(vp4,@line,0,0.5,1,0.5,MAGENTA_)

        if (win_pm)
              sWo(vpo,@showpixmap)
            //  sWi(vpo,@showpixmap)	      
	      //sWi(vp3,@showpixmap)
	    //  sWi(vp4,@showpixmap)
       <<"push $vp2\n"
      }
      else {
              
              sWo(gwo,@clearpixmap,@clear)
	      //sWo(gwo3,@clearpixmap)
	      //sWo(gwo4,@clearpixmap)
	      
              Plot(gwo2,@line,0.5,1,0.5,0,BLUE_)
              Plot(gwo2,@line,0,0.5,1,0.5,BLUE_)
	      
              Plot(gwo3,@line,0.5,1,0.5,0,RED_)
              Plot(gwo3,@line,0,0.5,1,0.5,RED_)

              Plot(gwo4,@line,0.5,0,0.5,1,MAGENTA_)
	      Plot(gwo4,@line,0,0.5,1,0.5,MAGENTA_)
             // sWo(gwo,@showpixmap)

          }
 //sWi(vp3,@pop)
      }
      else {
      //sWi(vp3,@pop)

         if (draw_win) {
            if (win_pm)
	       sWo(vpo,@clearpixmap)
	       sWo(vp2,@clear,BLACK_);
	 if (p2) {	 
              Plot(vp2,@line,0,0,1,1,MAGENTA_)
	       Plot(vp2,@line,0,1,1,0,MAGENTA_)
	       Plot(vp2,@box,0,0,1,1,LILAC_,1)
               Plot(vp3,@line,0,0,1,1,RED_)
               Plot(vp3,@line,0,1,1,0,RED_)
	       Plot(vp4,@line,0,0,1,1,CYAN_)
	       Plot(vp4,@line,0,1,1,0,CYAN_)
         }
	         if (win_pm)
	       sWo(vpo,@showpixmap)
	    
            // sWi(vp3,@showpixmap)
	   //  sWi(vp4,@showpixmap)
       }
       else {
       
             sWo(gwo,@clear)
              Plot(gwo2,@line,0,0,0.5,0.5,BLUE_)
              Plot(gwo2,@line,0.5,0.5,1,1,RED_)	      
              Plot(gwo2,@line,0,1,0.5,0.5,YELLOW_)
              Plot(gwo2,@line,0.5,0.5,1,0,GREEN_)	      
	      
              Plot(gwo3,@line,0,0,1,1,RED_)
              Plot(gwo3,@line,0,1,1,0,RED_)
             // Plot(vp2,@line,0,0,1,1,MAGENTA_)
	     // Plot(vp2,@line,0,1,1,0,MAGENTA_)
	       Plot(gwo4,@line,0,0,1,1,CYAN_)
	      Plot(gwo4,@line,0,1,1,0,CYAN_)
           //  sWo(gwo,@showpixmap)
                           <<"pop $vp2\n"
	 }     
       //sWi(vp3,@push)       
     }
     kpress++;
     }
  }

 }


exit_gs()


/////////////////////////////////////////////////////////
/{/*

  control window - select window for push/pop

  each cycle draw into windows - using pixmap  big X into clip

  refresh those areas (rectangles into pixmap) that are visble

  check wob draw 

  check border/clip border draw correct visibility

  check window focus 


  

/}*/