// test for vpc plot function

/{
 vpc - (woid, array,  cmapi, x, y, direction)
 plot a pixelstrip of points  where each color is the element value. Parameter cmapi is index into the 
 color map  -- array is type CHAR so each pixel is a color referenced by cmapi plus array value (256 colors) 
 The start pixel is at an initial coordinate x,y in clip window ( 0,0 is lower left hand corner of drawing area)
 The parameter direction determines whether vector is plotted up (1) ,down (-1),left->right (0) , right->left (2) from intial x,y location.
/}

// need warnings if overide pre-built-defines

#define VUP 1
#define VDOWN -1
#define VLR 0
#define VRL 2


 up = VUP
 down = VDOWN

<<"%V$up $down \n"

enum colors  {   
              BLACK, 
              WHITE,
              RED,               // rainbow plus
              ORANGE,
              YELLOW,
              GREEN,
              BLUE,
              INDIGO,
              VIOLET,
              SILVER = 47,
}






 green  = GREEN
 red = RED
 blue = BLUE

<<"%V$red $green $blue \n"



OpenDll("plot")   // open plot library



Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()  // spawn graphic viewer if none connected --- might want to do a socket version of this
     }


    vp = CreateGwindow(@title,"VPC_TEST",@resize,0.05,0.01,0.8,0.90,0)
    SetGwindow(vp,@pixmapon,@drawoff,@save,@bhue,"white")

    cx = 0.1
    cX = 0.7
    cy = 0.2
    cY = 0.8

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    gwo=CreateGWOB(vp,@GRAPH,@resize,0.05,0.1,0.80,0.95,@name,"VPC WOB",@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    sx = -3
    sX = 3.0
    sy = -3
    sY = 3.0



 setgwob(gwo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawon)  // will want to test just draw and pixmapdraw
    // FIXIT no pixmap draw
//   setgwob(gwo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawoff)  // will want to test just draw and pixmapdraw

/{
    plot(gwo,@line,-2,-2,2,2,"blue",@line,-2,2,2,-2,"red")

    plot(gwo,@box,-1,-1,1,1,"red",1.0)

    plot(gwo,@circle,0,0,1)

    plot(gwo,@ellipse,0,0,0.7,0.3)
    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)
/}
    SetGwob(gwo,@savepixmap,@showpixmap)
    setGwob(gwo,@clipborder,GREEN)

     I = getwoclip(gwo)
     nxp = I[5]
     nyp = I[6]

char CA[nyp]
char CB[nyp]
char CC[nxp]


     CB = RED


     for (i= 0 ; i < nyp; i++) {
        if (i < (nyp/2)) {
          CA[i] = green
        }
        else {
          CA[i] = blue
        }
     }

     for (i= 0 ; i < nxp; i++) {
        if (i < (nxp/2)) {
          CC[i] = colors->enumValueFromName("YELLOW")
        }
        else {
          CC[i]  = colors->enumValueFromName("INDIGO")
        }
     }



     cmapi = 0
     ix = 0
     iy = 0
     direction = 1


<<"$(VUP) $VDOWN $VLR $VRL \n"
<<"%V$nxp $nyp \n"


     iy = 0

     // we start from upper-left corner

     for (ix = 0 ; ix < nxp/2 ; ix++) {

        vpc(gwo, CA,  cmapi, ix, iy,  VDOWN)
     }



     iy = nyp
     for (ix = nxp/2 ; ix < nxp ; ix++) {

        vpc(gwo, CB,  cmapi, ix, iy,  VUP)
     }



     ix = 0
     iy = 0
     for (iy = 0 ; iy < nyp ; iy++) {

        vpc(gwo, CC,  cmapi, ix, iy,  VLR)
     }

     ix = nxp-1
     iy = 0
     for (iy = 0 ; iy < nyp ; iy++) {

        vpc(gwo, CC,  cmapi, ix, iy,  VRL)
     }



     SetGwob(gwo,@savepixmap,@showpixmap)

    exit()

float Pts[128]
float Spts[128]
float Dpts[128]

       x = -3
       y = -3.0

       sx = -3
       sy = -3
       for (i =0 ; i < 128; i+= 2) {

        Pts[i] = x
        Pts[i+1] = y
         x += 0.05
         y += 0.04

        Spts[i] = sx 
        Spts[i+1] = sin(sx)

        Dpts[i] = sx 
        Dpts[i+1] = sin(sx) + 0.5

        sx += 0.1


       }

<<"$Pts \n"


include "event"

Event E     // use asl event class to process any messages

  while (1) {


      E->waitForMsg()

       if (! (E->keyw @= "NO_MSG")) {

           if (E->button == LEFT) {
           
           pan("left",gwo,5)
           }
           else if (E->button == RIGHT) {
            pan("right",gwo,5)
           }

           else if (E->button == 2) {
           zoom("out",gwo,5)
           }

           else if (E->button == 4) {
           zoom("in",gwo,5)
           }

           else if (E->button == 5) {
           zoom("out",gwo,5)
           }

           
          redraw_po();

       }


  }


  stop!