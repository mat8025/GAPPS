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
include "graphic.asl"

//debugON();

//=============================//

// TBF  bug global X overshadows the local class X
// TBF  xic proc class arg fails

 WCx = 2
 WCy = 3
 WCX = 4
 WCY = 5 


proc C1I2()
{

                  if (WOV3_2[LBCX_] > 0) {
                           <<"LBC \n"
	                 R1->set(IV3[WCx], IV3[WCy], WOV3_2[LTIX_], WOV3_2[LTIY_])
	                 R2->set(WOV3_2[LBCX_], WOV3_2[LBCY_], IV3[WCX], IV3[WCy])		   			 
//                         R1->Plot(RED_)
//                         R2->Plot(GREEN_)
                         R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                         R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 

                         R1->print()
			 R2->print()
			 			 
                       }

                  if (WOV3_2[LTCX_] > 0) {
                           <<"LTC \n"
	                 R1->set(IV3[WCx], IV3[WCY], WOV3_2[LBIX_], WOV3_2[LBIY_])
	                 R2->set(WOV3_2[LTCX_], WOV3_2[LTCY_], IV3[WCX], IV3[WCY])		   			 
                      //   R1->plot(RED_)
                     //    R2->plot(GREEN_)

                         R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_,1,1)
                         R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                         R1->print()
			 R2->print()
			 			 
                       }

                  if (WOV3_2[RTCX_] > 0) {
                           <<"RTC \n"
	                 R1->set(IV3[WCX], IV3[WCY], WOV3_2[RBIX_], WOV3_2[RBIY_])
	                 R2->set(WOV3_2[RTCX_], WOV3_2[RTCY_], IV3[WCx], IV3[WCY])		   			 
                     //    R1->plot(RED_)
		//	 R2->plot(GREEN_)
                         R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                         R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 			 
                         R1->print()
			 R2->print()

                       }


                  if (WOV3_2[RBCX_] > 0) {
                           <<"RBC \n"
	                 R1->set(IV3[WCX], IV3[WCy], WOV3_2[RTIX_], WOV3_2[RTIY_])
	                 R2->set(WOV3_2[RBCX_], WOV3_2[RBCY_], IV3[WCx], IV3[WCy])		   			 
                         //R1->plot(RED_)
  
                         R1->print()
			 R2->print()
                       //  R2->plot(GREEN_)
                         R1->plotwbox(vp3, IV3[WCx], IV3[WCy], RED_)
                         R2->plotwbox(vp3, IV3[WCx], IV3[WCy], GREEN_)			 			 
                       }

}

//===================================//
proc C0I2()
{
// 0 corners  2 intersections --- one edge inside  - one visible region
                     // left
                      if ( WOV3_2[LBIX_] > 0   && WOV3_2[LTIX_] > 0) {
                      R1->set(IV3[WCx], IV3[WCy], WOV3_2[LTIX_], WOV3_2[LTIY_])
                      R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                     }
                       // RE
                      if ( WOV3_2[RBIX_] > 0 && WOV3_2[RTIX_] > 0) { 
                      R1->set(IV3[WCX], IV3[WCY], WOV3_2[RBIX_], WOV3_2[RBIY_])
                      //R1->Plot(RED_)
		      R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                     }

                      //  BE
                      if ( WOV3_2[LBIX_] > 0 &&  WOV3_2[RBIX_] > 0) {
                      R1->set(IV3[WCx], IV3[WCy], WOV3_2[RBIX_], WOV3_2[RBIY_])
                      //R1->Plot(RED_)
		      R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                     }

                      if ( WOV3_2[LTIX_] > 0 &&  WOV3_2[RTIX_] > 0) {
                      R1->set(IV3[WCX], IV3[WCY], WOV3_2[LTIX_], WOV3_2[LTIY_])
                      //R1->Plot(RED_)
		      R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                     }
}
//===============================================//
proc C0I4()
{
// 0 corners  4 intersections --- two edges inside - - two visible regions
         if (WOV3_2[LTIX_] == IV3[WCx]) {
                              R1->set(WOV3_2[LTIX_], WOV3_2[LTIY_], IV3[WCX],IV3[WCY])
                              R2->set(WOV3_2[LBIX_], WOV3_2[LBIY_], IV3[WCX],IV3[WCy])
                             //R1->plot(RED_)
			     R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                             R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
			 R1->print()
			 R2->print()
                        }

                        if (WOV3_2[LTIY_] == IV3[LTCY_]) {
                              R1->set(WOV3_2[LTIX_], WOV3_2[LTIY_], IV3[WCx],IV3[WCy])
                              R2->set(WOV3_2[RTIX_], WOV3_2[RTIY_], IV3[WCX],IV3[WCy])
                            R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                            R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
			 R1->print()
			 R2->print()
                        }
}
//===============================================//
proc C2I2()
{
<<"2C2I\n"
// 2 corners  2 intersections ---  - - three visible regions

                           if (WOV3_2[LBIY_]  == IV3[WCy]) {
                                 // top edge & corners
                              R1->set(WOV3_2[LBIX_], IV3[WCy], IV3[WCx],IV3[WCY])
                              R2->set(WOV3_2[RBIX_], WOV3_2[RTCY_], WOV3_2[LBIX_],IV3[WCY])
                              R3->set(WOV3_2[RBIX_], IV3[WCy], IV3[WCX],IV3[WCY])			      
                             R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                                                      R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                               R3->plotwbox(vp3, IV3[WCx], IV3[WCy], BLUE_)			 			     
                              }

                           if (WOV3_2[LTIY_]  == IV3[WCY]) {
                                 // bottom edge & corners - flip specs?
                              R1->set(WOV3_2[LTIX_], IV3[WCY], IV3[WCx],IV3[WCy])
                              R2->set(WOV3_2[RTIX_], WOV3_2[RBCY_], WOV3_2[LTIX_],IV3[WCy])
                              R3->set(WOV3_2[RTIX_], IV3[WCY], IV3[WCX],IV3[WCy])
			     R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                             R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                                     R3->plotwbox(vp3, IV3[WCx], IV3[WCy], BLUE_)			 			     
                              }

                           if (WOV3_2[LBIX_]  == IV3[WCx]) {
                                 // right edge & corners - flip specs?
                              R1->set(WOV3_2[LBIX_], WOV3_2[LBIY_], IV3[WCX],IV3[WCy])
                              R2->set(WOV3_2[RBCX_], WOV3_2[RBCY_], IV3[WCX],WOV3_2[LTIY_])
                              R3->set(WOV3_2[LTIX_], WOV3_2[LTIY_], IV3[WCX],IV3[WCY])
			      R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                              R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                              R3->plotwbox(vp3, IV3[WCx], IV3[WCy], BLUE_)			 
                              }


                           if (WOV3_2[RBIX_]  == IV3[WCX]) {
                                 // left edge & corners - flip specs?
                              R1->set(WOV3_2[RBIX_], WOV3_2[RBIY_], IV3[WCx],IV3[WCy])
                              R2->set(WOV3_2[LBCX_], WOV3_2[LBCY_], IV3[WCx],WOV3_2[RTIY_])
                              R3->set(WOV3_2[RTIX_], WOV3_2[RTIY_], IV3[WCx],IV3[WCY])
			       R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                               R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                               R3->plotwbox(vp3, IV3[WCx], IV3[WCy], BLUE_)			 
                              }
}
//==========================================//
proc C4I0 ()
{
// 4 corners  0 intersections ---  - -  4 visible regions
<<"4C0I\n"
                                R1->set(IV3[WCx], WOV3_2[LTCY_], IV3[WCX],IV3[WCY])
				R2->set(IV3[WCx], WOV3_2[LBCY_], IV3[WCX],IV3[WCy])
				R3->set(IV3[WCx], WOV3_2[LBCY_], WOV3_2[LBCX_],WOV3_2[LTCY_])
				R4->set(IV3[WCX], WOV3_2[RBCY_], WOV3_2[RBCX_],WOV3_2[RTCY_])
			       R1->plotwbox(vp3, IV3[WCx], IV3[WCy], TEAL_)
                               R2->plotwbox(vp3, IV3[WCx], IV3[WCy], PINK_)			 
                               R3->plotwbox(vp3, IV3[WCx], IV3[WCy], BLUE_)			 
                               R4->plotwbox(vp3, IV3[WCx], IV3[WCy], YELLOW_)			 			     			       
}

//============================================//
class Rect
{

 public:
  int x;
  int y;
  int XR;
  int Y;
  int rwid;

  cmf setWid(id)
  {
       rwid = id;
  }
  
  cmf set(xi,yi,Xi,Yi)
  {
  // order xi,Xi
  // ordr yi Yy
//  <<"%V $xi $yi $Xi $Yi \n"
// <<"%V $x $y $XR $Y \n"
  if (xi < Xi) {
    x=xi;
    XR=Xi;
  }
  else {
    x=Xi
    XR=xi
  }

  if (yi < Yi) {
    y= yi;
    Y = Yi;
  }
  else {
    y=Yi;
    Y=yi
  }

 <<"%V $x $y $XR $Y \n"

  }

  cmf print()
  {

   <<"Rect:$rwid %V $x $y $XR $Y \n"

  }

  cmf Plot( hue)
  {
  <<"plot %V  $rwid $x $y $XR $Y \n"
    scrnBox(x, y, XR, Y, hue,1)
  }
  
  cmf plotwbox( wvp, ox, oy, hue)
  {

    xp = x - ox;
    yp = y -oy;
    Xp = XR -ox;
    Yp = Y - oy;
<<"plot %V  $rwid $wvp $ox $oy $xp $yp $Xp $Yp $hue \n"
     // clash with cmf?? --- needs to check args -calls cmf plot -- 
      plot(wvp,@wbox, xp, yp, Xp, Yp, hue,1,1)
   // sWo(wvp,@wbox, xp, yp, Xp, Yp, hue,1,1)

}
  
  // same name as class - is the constructor
  cmf Rect()
  {
   x=0;
   XR= 0;
   y= 0;
   Y= 0;
   rwid = -1;
  }

};


//=============================//

proc WinIntersect(Rect vpA,Rect vpB)
{

  overlap = 1;

       
          if (vpA->x > vpB->X) {
	    overlap = 0;
	  }
	  else if (vpB->x > vpA->X) {
	    overlap = 0;
	  }
	  else if (vpA->y > vpB->Y) {
	    overlap = 0;
	  }
	  else if (vpB->y > vpA->Y) {
	    overlap = 0;
	  }
vpA->print()

   <<"$_proc %V $overlap \n"
          return overlap;
}
//=============================//


/{
vpR2->set(IV2[1],IV2[2],IV2[3],IV2[4])
vpR2x= IV2[1]
vpR2y= IV2[2]
vpR2X= IV2[3]
vpR2Y= IV2[4]
/}

/{
vpR3->set(IV3[1],IV3[2],IV3[3],IV3[4])

vpR3x= IV3[1]
vpR3y= IV3[2]
vpR3X= IV3[3]
vpR3Y= IV3[4]
/}


proc checkCoverage()
{
/////////////////////////////////////////////////////////////////////////////////////////////////
         coveredbyA = 1;
	 <<"A NWI 2x>X ? $vpR2->x > $vpR3->X \n"


         if (vpR2->x > vpR3->X) {
  <<"A NWI 2x>X $vpR2->x > $vpR3->X \n"
            coveredbyA = 0;
	  }
	  else if (vpR3->x > vpR2->X) {
  <<"A NWI 3x>X $vpR3->x > $vpR2->X \n"	  
	    coveredbyA = 0;
	  }
	  else if (vpR2->y > vpR3->Y) {
  <<"A NWI 2y>Y $vpR2->y > $vpR3->Y \n"
            coveredbyA = 0;
	  }
	  else if (vpR3->y > vpR2->Y) {
  <<"A NWI 3y>Y $vpR3->y > $vpR2->Y \n"	  
	    coveredbyA = 0;
	  }
	  
<<" vp2 intersects vp3 ? %V $coveredbyA \n"
/////////////////////////////////////////////////////////////


           complete =0;
           if ((vpR2->x <= vpR3->x) && (vpR2->X >= vpR3->X)) {
             if ((vpR2->y <= vpR3->y) && (vpR2->Y >= vpR3->Y)) {
               complete =1;
               if (IV3[14]) {
                 <<"vp2 completely covers vp3\n"
               }
	       else {
                 <<"vp3 is completely inside of vp2\n"
               }
             }
           }


           if (!complete) {
           if ((vpR2->x >= vpR3->x) && (vpR2->X <= vpR3->X)) {
             if ((vpR2->y >= vpR3->y) && (vpR2->Y <= vpR3->Y)) {
               complete =1;
                 if (IV2[14]) {
                  <<"vp3 completely covers vp2\n"
                 }
		 else {
                    <<"vp2 is completely inside of vp3\n"
                 }
		 
                 }
           }
          }

	  corner_in = 0;
          if (!complete) {

              if ((vpR2->x > vpR3->x) && (vpR2->x < vpR3->X)\
	           && (vpR2->y > vpR3->y) && (vpR2->y < vpR3->Y)) {
<<"vp2 LB corner in vp3 \n"
                  corner_in++;
                }

              if ((vpR2->x > vpR3->x) && (vpR2->x < vpR3->X)\
	           && (vpR2->Y > vpR3->y) && (vpR2->Y < vpR3->Y)) {
<<"vp2 LT corner in vp3 \n"
                  corner_in++;
                }
		
              if ((vpR2->X > vpR3->x) && (vpR2->X < vpR3->X)\
	           && (vpR2->y > vpR3->y) && (vpR2->y < vpR3->Y)) {
<<"vp2 RB corner in vp3 \n"
                  corner_in++;
                }

              if ((vpR2->X > vpR3->x) && (vpR2->X < vpR3->X)\
	           && (vpR2->Y > vpR3->y) && (vpR2->Y < vpR3->Y)) {
<<"vp2 RT corner in vp3 \n"
                  corner_in++;
                }

          <<"%V $corner_in \n"

         }



         complete =0;
    
           if ((vpR2->x <= vpR4->x) && (vpR2->X >= vpR4->X)) {
             if ((vpR2->y <= vpR4->y) && (vpR2->Y >= vpR4->Y)) {
               complete =1;
               if (IV3[15]) {
                 <<"vp2 completely covers vp4\n"
               }
	       else {
                   <<"vp4 is completely inside of vp2\n"
               }
             }
           }
}
//======================================//

proc sBox(int ivb[])
{
     scrnBox(ivb[1]-5,ivb[4]-5,ivb[1]+10,ivb[4]+5,RED_,0)
     scrnBox(ivb[3]-5,ivb[4]-5,ivb[3]+10,ivb[4]+5,BLUE_,0)
     scrnBox(ivb[3]-5,ivb[2]-5,ivb[3]+10,ivb[2]+5,GREEN_,0)
     scrnBox(ivb[1]-5,ivb[2]-5,ivb[1]+10,ivb[2]+5,YELLOW_,0)          
}
//======================================//

//i_read("paint boxes?")
/{
scrnLine(0,0,500,500,GREEN_)

 scrnBox(200,200,500,500,BLUE_)


//i_read("see box?")


 scrnBox(500,400,700,600,YELLOW_,1)

 scrnBox(600,0,700,300,LILAC_,1)

 scrnBox(750,50,800,300,RED_,0)
/}

   vp = cWi(@title,"BasicWindow")

    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_,@resize,0.05,0.5,0.45,0.9)
    sWi(vp,@clip,0.25,0.25,0.9,0.9)

    sWi(vp,@scales,-1,-1,1,1)

// setup a clip area (wo 0) inside of window

    sWi(vp,@clearclip,"red",@clipborder,"blue");
    
    titleButtonsQRD(vp);


 txtwo=cWo(vp,"TEXT",@name,"Text",@value,"howdy",@color,ORANGE_,@resize,0.2,0.01,0.9,0.9)
 sWo(txtwo,@border,@drawoff,@clipborder,@fonthue,"black",@pixmapon,@save,@savepixmap)
 sWo(txtwo,@scales,0,0,1,1,@clip,0.1,0.2,0.9,0.95)
 sWo(txtwo,@help," Mouse & Key Info ")



     sWi(vp,@store)
 
      vp2 = cWi(@title,"vp2")
    sWi(vp2,@pixmapon,@drawoff,@save,@store,@bhue,BROWN_,@resize,0.61,0.1,0.9,0.5)

       vp3 = cWi(@title,"vp3")
       sWi(vp3,@pixmapon,@drawon,@save,@savepixmap@bhue,GREEN_,@resize,0.61,0.51,0.9,0.9)
       sWi(vp3,@clip,0.1,0.2,0.9,0.8,@scales,0,0,1,1, @clearclip,YELLOW_,@redraw)

       vp4 = cWi(@title,"vp4")
    sWi(vp4,@pixmapon,@drawoff,@save,@store,@bhue,YELLOW_,@resize,0.1,0.1,0.41,0.49,@redraw)

   int vpo[] = {vp2,vp3,vp4};

    cx = 0.2
    cX = 0.8
    cy = 0.2
    cY = 0.8

   sWi(vpo,@clip,cx,cy,cX,cY);



   gwo2=cWo(vp2,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo2,@clip,cx,cy,cX,cY)
    sWo(gwo2,@scales,0,0,1,1, @save,@savepixmap,@redraw,@drawoff,@pixmapon)
    // why both save and savepixmap needed ?

    gwo3=cWo(vp3,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo3,@clip,cx,cy,cX,cY)
    sWo(gwo3,@scales,0,0,1,1, @save,@savepixmap,@redraw,@drawoff,@pixmapon)

    gwo4=cWo(vp4,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"PIC",@color,WHITE_)
    sWo(gwo4,@clip,cx,cy,cX,cY)
    sWo(gwo4,@scales,0,0,1,1,@save, @savepixmap,@redraw,@drawoff,@pixmapon)
    
 int gwo[] = {gwo2,gwo3,gwo4};

        sWo(gwo,@redraw)
	
int IV[30];
int IV2[30];
int IV3[30];
int IV4[30];

wid=wgetcoors(vp,IV);

<<"<$vp> $IV\n"
Rect vpR2;
vpR2->setWid(vp2)
vpR2->print()

Rect vpR3;

vpR3->set(0,0,10,10)
vpR3->setWid(vp3)

vpR3->print()




Rect vpR4;
vpR4->set(0,0,10,10)
vpR4->setWid(vp4)

vpR4->print()


vpR2x=0;
vpR2y=0;
vpR2X=0;
vpR2Y=0;


vpR3x=0;
vpR3y=0;
vpR3X=0;
vpR3Y=0;

vpR4x=0;
vpR4y=0;
vpR4X=0;
vpR4Y=0;

Rect R1
Rect R2
Rect R3
Rect R4


  R1->setWid(1)
  R2->setWid(2)
  R3->setWid(3)
  R4->setWid(4)



 wo_plot = 0;
 win_plot = 1; 
  
 sWi(vp,@redraw)

 kpress = 0;

while (1) {



       eventWait();
//sWo(txtwo,@clearpixmap)
     // sWi(vp,@redraw)
   sWi(vp3,@clearpixmap,@clipborder,BLACK_,@clear,YELLOW_)
   sWi(vp2,@clearpixmap,@clipborder,BLACK_,@clear,ORANGE_)
   sWi(vp4,@clearpixmap,@clipborder,BLACK_,@clear,GREEN_)
   sWi(vp4,@showpixmap)
   
<<"%V $_emsg $_etype $_ebutton $_ewoname $_ewid $_ewoid  $(PRESS_)\n"
//sWo(txtwo,@clearpixmap)
sWo(txtwo,@textr,"%V $_emsg $_etype $_ebutton $_ewoname $_ewid $_ewoid  $(PRESS_)",0.1,0.5)

//sWo(txtwo,@print,"$_erx $_ery \n");

// wprint(txtwo,"%V $_emsg $_etype $_ebutton $_ewoname $_ewid $_ewoid  $(PRESS_)")

      IV=wgetcoors(vp);
	      
<<"<$vp> $IV\n"

   // sBox(IV)

     IV2=wgetcoors(vp2);



   //   sBox(IV2)

     IV3=wgetcoors(vp3);
<<"<$vp3> $IV3\n"

  //    sBox(IV3)

      IV4=wgetcoors(vp4);
<<"<$vp4> $IV4\n"


  //    sBox(IV4)

//   vp3 cover? vp2
//       vpR2->print()
//       vpR3->print()       



     if (IV2[15] ) {

sWo(txtwo,@print,"vp2 is covered\n")
      <<"vp2  is covered!\n"

     }

     if ( IV3[15]) {
  sWo(txtwo,@print,"vp3 is covered\n")
      <<" vp3 is covered!\n"
     }

     if ( IV4[15]) {
      <<" vp4 is covered!\n"
     }


      WOV2_3 = wgetoverlap(vp2,vp3)
<<"2ov3 $WOV2_3 \n"

    WOV3_2 = wgetoverlap(vp3,vp2)
<<"3ov2 $WOV3_2 \n"

      WOV2_4 = wgetoverlap(vp2,vp4)
<<"2ov4 $WOV2_4 \n"

      WOV4_2 = wgetoverlap(vp4,vp2)
<<"4ov2 $WOV4_2 \n"


      WOV3_4 = wgetoverlap(vp3,vp4)
<<"3ov4 $WOV3_4 \n"

      WOV4_3 = wgetoverlap(vp4,vp3)
<<"4ov3 $WOV4_3 \n"












// 1 corner 2 intersections --- (must be 2 intersections)

<<"<$vp2> $IV2\n"
<<"<$vp3> $IV3\n"

              if ( WOV3_2[0] == 1  && WOV3_2[1] == 2) {
                       // 2 vis rectangles

                      C1I2()
	      
               }
/////////////////////////////////////////////////////////////////////////////////////////////////////////
                  if ( WOV3_2[0] == 0  && WOV3_2[1] == 2) {  // 0C2I

                       C0I2();

                   }

//=================================================//

                  if ( WOV3_2[0] == 0  && WOV3_2[1] == 4) {  // 0C4I

// 0 corners  4 intersections --- two edges inside - - two visible regions
                       C0I4();

                    }


                  if ( WOV3_2[0] == 2  && WOV3_2[1] == 2) {// 2C2I

                        C2I2()

                    }

                  if ( (WOV3_2[0] == 4)  && (WOV3_2[1] <= 0)) { // C4I0
// 4 corners  0 intersections ---  - -  4 visible regions
                        C4I0()
                    }


// visible regions are known
// communicate to XGS -- restore inmage to visible regions

       eventWait();               
	       
	    
	       
	     
	     if ( (kpress %2) ==0) { 

             if (wo_plot) {
              sWo(gwo,@clearpixmap)
              Plot(gwo2,@line,0.5,1,0.5,0,BLUE_)
              Plot(gwo2,@line,0,0.5,1,0.5,BLUE_)
              Plot(gwo4,@line,0.5,0,0.5,1,MAGENTA_)
	      Plot(gwo4,@line,0,0.5,1,0.5,MAGENTA_)
	      Plot(txtwo,@line,0.5,0,0.5,1,MAGENTA_)
	      Plot(txtwo,@line,0,0.5,1,0.5,MAGENTA_)
              sWo(gwo,@showpixmap)
//              Plot(gwo3,@line,0.5,1,0.5,0,RED_)
//              Plot(gwo3,@line,0,0.5,1,0.5,RED_)
             }

             if (win_plot) {

              Plot(vp2,@line,0.5,1,0.5,0,GREEN_)
              Plot(vp2,@line,0,0.5,1,0.5,RED_)

              Plot(vp3,@line,0.5,1,0.5,0,GREEN_)
              Plot(vp3,@line,0,0.5,1,0.5,RED_)

              Plot(vp4,@line,0.5,1,0.5,0,GREEN_)
              Plot(vp4,@line,0,0.5,1,0.5,RED_)
            }


              }
	       
	       else {

             if (wo_plot) {
              Plot(gwo2,@line,0,0,0.5,0.5,BLUE_)
              Plot(gwo2,@line,0.5,0.5,1,1,RED_)	      
              Plot(gwo2,@line,0,1,0.5,0.5,YELLOW_)
              Plot(gwo2,@line,0.5,0.5,1,0,GREEN_)	      
              Plot(gwo4,@line,0,0,1,1,CYAN_)
	      Plot(gwo4,@line,0,1,1,0,CYAN_)

              Plot(txtwo,@line,0,0,1,1,RED_)
              Plot(txtwo,@line,0,1,1,0,RED_)
              sWo(gwo,@showpixmap)
              }

             if (win_plot) {
              Plot(vp2,@line,0,0,1,1,RED_)
              Plot(vp2,@line,0,1,1,0,PINK_)
              Plot(vp3,@line,0,0,1,1,RED_)
              Plot(vp3,@line,0,1,1,0,PINK_)
              Plot(vp4,@line,0,0,1,1,RED_)
              Plot(vp4,@line,0,1,1,0,PINK_)	      	      
             }



	
            
               }
          //    sWo(txtwo,@showpixmap)

	  sWi(vp3,@showpixmap)
	  sWi(vp2,@showpixmap)
	  sWi(vp4,@showpixmap)	  	  


kpress++

sWo(txtwo,@showpixmap)
gflush()
//       eventWait();
sWo(txtwo,@scrollclip,DOWN_,20)
//   Plot(txtwo,@line,0.5,0,0.5,1,ORANGE_)
//	      Plot(txtwo,@line,0,0.5,1,0.5,PURPLE_)


}




/////////////// class xic ref broke -- TBF
/{/*

  if (vpR2->x > vpR3->X) {
  <<"NWI $vpR2->x > $vpR3->X \n"
            coveredbyB = 0;
	  }
	  else if (vpR3->x > vpR2->X) {
  <<"NWI $vpR3->x > $vpR2->X \n"	  
	    coveredbyB = 0;
	  }
	  else if (vpR2->y > vpR3->Y) {
  <<"NWI $vpR2->y > $vpR3->Y \n"
            coveredbyB = 0;
	  }
	  else if (vpR3->y > vpR2->Y) {
  <<"NWI $vpR3->y > $vpR2->Y \n"	  
	    coveredbyB = 0;
	  }
	  
<<"win$vp2 win$vp3 intersect? ! vp2 intersects vp3 ? $coveredbyB \n"

           if ((vpR2->x <= vpR3->x) && (vpR2->X >= vpR3->X)) {
             if ((vpR2->y <= vpR3->y) && (vpR2->Y >= vpR3->Y)) {
<<"Win$vp2 completely covers Win$vp3\n"
             }
           }

           if ((vpR2->x >= vpR3->x) && (vpR2->X <= vpR3->X)) {
             if ((vpR2->y >= vpR3->y) && (vpR2->Y <= vpR3->Y)) {
<<"Win$vp3 completely covers Win$vp2\n"
             }
           }

/}*/