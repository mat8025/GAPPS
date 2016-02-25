//////// axnum.asl ////////////////////

setdebug(0)

OpenDll("math")

 Pi = 4.0 atan(1.0)



    txtw = CreateGwindow("title","MC_INFO","resize",0.01,0.76,0.75,0.99,0)

//    SetGwindow(txtw,@pixmapon,@drawon,@save,@bhue,"white",@sticky,1)
    SetGwindow(txtw,@pixmapon,@drawon,@save,@bhue,"white",@sticky,0)


    two=createGWOB(txtw,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.5,0.9,0.9)

    setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff)
    setgwob(two,@SCALES,0,0,1,1)

    qwo=createGWOB(txtw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"teal",@resize,0.7,0.1,0.9,0.3)

    setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)


    vp = CreateGwindow(@title,"GRAPH_XY",@resize,0.01,0.01,0.9,0.75,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")



    SetGwindow(vp,"clip",0.2,0.2,0.9,0.9)
    SetGwindow(vp,@bhue,"white",@clipborder,"black",@redraw,@save)

    grwo=createGWOB(vp,"GRAPH",@name,"pic",@color,"yellow",@resize,0.1,0.1,0.9,0.9)
    setgwob(grwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"red", )
    setgwob(grwo,@bhue,"teal",@fhue,"red",@clipbhue,"skyblue",@clipfhue,"brown",@FONTHUE,"green")
    setgwob(grwo,@SCALES,-2,-20,2,20)
    setgwob(grwo,@clip,0.2,0.2,0.8,0.8)

    setgwin(txtw,@redraw)
    setgwin(vp,@redraw)


//  now loop wait for message  and print

int Minfo[]
float Rinfo[]

xp = 0.1
yp = 0.5
dx = 1.0
dy = 5.0

xfoff = 1.0   // font offset relative to axis

yfoff = 3.0   //  string offset relative to y axis -- neg means inside clip

ang = 0.0;

   ten_deg = Pi / 180.0 * 10;


   setGwob(grwo,@clear,"skyblue",@clearclip,"teal")

   while (1) {


   msg = MessageWait(Minfo,Rinfo)

//<<"$msg  $Minfo  $Rinfo \n"

<<"%v $msg \n"

<<"%v $Minfo  \n"

<<"%v $Rinfo \n"


   xp = Sin(ang)
   yp = Cos(ang)

   ang += ten_deg
//   setGwob(grwo,@clear,"skyblue",@clearclip,"magenta")
   setGwob(grwo,@plotline,0,0,xp,yp)

   RP = wogetrscales(grwo)
   rx = RP[1]
   rZ = PR[3]
   rX = RP[3]
   ry = RP[2]
   rY = RP[4]

   setGwob(grwo,@fonthue,"red") 

   //axnum(grwo,1,rx,rX,dx, xfoff, "g")
     axnum(grwo,1)
     axnum(grwo,-1)

   axnum(grwo,3,rx,rX,dx, xfoff, "g")

   axnum(grwo,2,ry,rY,dy, yfoff, "g")

   axnum(grwo,4,ry,rY,dy, yfoff, "g")

   setGwob(grwo,@fonthue,"green") 

   //axnum(grwo,1,rx,rX,dx, -xfoff, "g")

   axnum(grwo,3,rx,rX,dx, -xfoff, "g")

   axnum(grwo,2,ry,rY,dy, -yfoff, "g")

   axnum(grwo,4,ry,rY,dy, -yfoff, "g")

   setGwob(grwo,@border,@clipborder)

   setgwob(two,@clear,@textr,"$msg $rx $ry $rX $rY $dx $dy $ang ",0.1,0.8)
   setgwob(two,@clear,@textr,"%V6.2f$Rinfo ",0.01,0.6)

   if (scmp(msg,"QUIT",4)) {
       break
   }

  }


 exit_gs()
