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
        XS=spawngwm()
       if (XS <= 0) {
         <<"spawn failed !\n"
	 exit();
       }
       <<"asl pid $XS ?\n"
     }

wait(3)

//=============================//

// TBF  bug global X overshadows the local class X
// TBF  xic proc class arg fails

Class Rect
{

 public:
  int x;
  int y;
  int X;
  int Y;
  int rwid;

  CMF setWid(id)
  {
       rwid = id;
  }
  CMF set(xi,yi,Xi,Yi)
  {
    x=xi;
    y=yi;
    X=Xi;
    Y=Yi;    
  }

  CMF print()
  {

   <<"Rect:$rwid %V $x $y $X $Y \n"

  }

  // same name as class - is the construtor
  CMF Rect()
  {
   x=0;
   X= -1;
   y= 0;
   Y= -1;
   rwid = -1;
  }

};


//=============================//

proc wintersect(Rect vpA,Rect vpB)
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

vpR2x=0;
vpR2y=0;
vpR2X=0;
vpR2Y=0;


vpR3x=0;
vpR3y=0;
vpR3X=0;
vpR3Y=0;





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

wid=wgetcoors(vp2,IV2);
<<"<$vp2> $IV2\n"

     scrnBox(IV2[1]-5,IV2[4]-5,IV2[1]+10,IV2[4]+5,RED_,0)
     scrnBox(IV2[3]-5,IV2[4]-5,IV2[3]+10,IV2[4]+5,BLUE_,0)
     scrnBox(IV2[3]-5,IV2[2]-5,IV2[3]+10,IV2[2]+5,GREEN_,0)
     scrnBox(IV2[1]-5,IV2[2]-5,IV2[1]+10,IV2[2]+5,YELLOW_,0)

vpR2->set(IV2[1],IV2[2],IV2[3],IV2[4])

vpR2x= IV2[1]
vpR2y= IV2[2]
vpR2X= IV2[3]
vpR2Y= IV2[4]




wid=wgetcoors(vp3,IV3);
<<"<$vp3> $IV3\n"

     scrnBox(IV3[1]-5,IV3[4]-5,IV3[1]+10,IV3[4]+5,RED_,0)
     scrnBox(IV3[3]-5,IV3[4]-5,IV3[3]+10,IV3[4]+5,BLUE_,0)
     scrnBox(IV3[3]-5,IV3[2]-5,IV3[3]+10,IV3[2]+5,GREEN_,0)
     scrnBox(IV3[1]-5,IV3[2]-5,IV3[1]+10,IV3[2]+5,YELLOW_,0)          

vpR3->set(IV3[1],IV3[2],IV3[3],IV3[4])

vpR3x= IV3[1]
vpR3y= IV3[2]
vpR3X= IV3[3]
vpR3Y= IV3[4]

wid=wgetcoors(vp4,IV4);
<<"<$vp4> $IV4\n"

     scrnBox(IV4[1]-5,IV4[4]-5,IV4[1]+10,IV4[4]+5,RED_,0)
     scrnBox(IV4[3]-5,IV4[4]-5,IV4[3]+10,IV4[4]+5,BLUE_,0)
     scrnBox(IV4[3]-5,IV4[2]-5,IV4[3]+10,IV4[2]+5,GREEN_,0)
     scrnBox(IV4[1]-5,IV4[2]-5,IV4[1]+10,IV4[2]+5,YELLOW_,0)          

//   vp3 cover? vp2

       vpR2->print()
       vpR3->print()       

//         ovl = wintersect(vpR3,vpR2)
//<<"win2 win3 intersect? ! vp2 intersects vp3 ? $ovl \n"	  

     if (IV2[14] ) {

      <<"win$vp2  is covered!\n"

     }

     if ( IV3[14]) {

      <<" win$vp3 is covered!\n"

     }

/{/*
         coveredbyB = 1;

    //<<"%V $vpR2x  $vpR3X \n"
   // <<"%V $vpR2y  $vpR3Y \n"
       
          if (vpR2x > vpR3X) {
  <<"B NWI  2x>X $vpR2x > $vpR3X \n"
            coveredbyB = 0;
	  }
	  else if (vpR3x > vpR2X) {
  <<"B NWI 3x>X $vpR3x > $vpR2X \n"	  
	    coveredbyB = 0;
	  }
	  else if (vpR2y > vpR3Y) {
  <<"B NWI  2y>Y $vpR2y > $vpR3Y \n"
            coveredbyB = 0;
	  }
	  else if (vpR3y > vpR2Y) {
  <<"B NWI  3y>Y $vpR3y > $vpR2Y \n"	  
	    coveredbyB = 0;
	  }
	  
<<"win$vp2 win$vp3 intersect? ! vp2 intersects vp3 ? %V $coveredbyB \n"
/}*/
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
	  
<<"win$vp2 win$vp3 intersect? ! vp2 intersects vp3 ? %V $coveredbyA \n"
/////////////////////////////////////////////////////////////


           complete =0;
           if ((vpR2->x <= vpR3->x) && (vpR2->X >= vpR3->X)) {
             if ((vpR2->y <= vpR3->y) && (vpR2->Y >= vpR3->Y)) {
               complete =1;
               if (IV3[14]) {
                 <<"Win$vp2 completely covers Win$vp3\n"
               }
	       else {
                   <<"Win$vp3 is completely inside of Win$vp2\n"
               }
             }
           }
           if (!complete) {
           if ((vpR2->x >= vpR3->x) && (vpR2->X <= vpR3->X)) {
             if ((vpR2->y >= vpR3->y) && (vpR2->Y <= vpR3->Y)) {
               complete =1;
                 if (IV2[14]) {
                  <<"Win$vp3 completely covers Win$vp2\n"
                 }
		 else {
                    <<"Win$vp2 is completely inside of Win$vp3\n"
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