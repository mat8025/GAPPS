//////// axnum.asl ////////////////////

setdebug(0)

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


// need some labels --- and font manipulation

Pi = 4.0 atan(1.0);


 x_label = "Freq (Khz)"
 y_label = "Magnitude"

    txtw = CreateGwindow("title","MC_INFO","resize",0.01,0.76,0.75,0.99,0)

//    sWi(txtw,@pixmapon,@drawon,@save,@bhue,"white",@sticky,1)
    sWi(txtw,@pixmapon,@drawon,@save,@bhue,"white",@sticky,0)


    two=createGWOB(txtw,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.5,0.9,0.9)

    sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff)
    sWo(two,@SCALES,0,0,1,1)

    qwo=createGWOB(txtw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"teal",@resize,0.7,0.1,0.9,0.3)

    sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)


    vp = CreateGwindow(@title,"GRAPH_XY",@resize,0.01,0.01,0.9,0.75,0)

    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")



    sWi(vp,"clip",0.2,0.2,0.9,0.9)
    sWi(vp,@bhue,"white",@clipborder,"black",@redraw,@save)

    grwo=createGWOB(vp,"GRAPH",@name,"pic",@color,"yellow",@resize,0.1,0.1,0.9,0.9)
    sWo(grwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"red", )
    sWo(grwo,@bhue,"teal",@fhue,"red",@clipbhue,"skyblue",@clipfhue,"brown",@FONTHUE,"green")
    sWo(grwo,@SCALES,-2,-20,2,20)
    sWo(grwo,@clip,0.2,0.2,0.8,0.8)

    setgwin(txtw,@redraw)
    setgwin(vp,@redraw)


//  now loop wait for message  and print

proc checkEvents()
{
//   Mf = Split(msg)
   <<"msg $msg \n"
  // E->getEventState(evs)
   kloop++;
   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
<<"%V$Woname $Woid \n"
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()

   Woval = getWoValue(Woid)
<<"%V$Woval \n"
   button = E->getEventButton()
   keyc = E->getEventKey()
   keyw = E->getEventKeyW()

  
sWo(two,@clear,@texthue,"black",@textr,"%V$Woid\n$Woname\n $button\n $keyc\n $keyw\n$Woval",-0.9,0.3)

   if (Woid == qwo) {
    exit_gs()
   }
}
//----------------------------------------------

Svar msg

E =1 // event handle

int evs[20];

button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0
keyc = ""
keyw = ""

int kloop =0


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


   sWo(grwo,@clear,"skyblue",@clearclip,"teal");







   while (1) {

     msg = E->waitForMsg()

     <<"%V$kloop  $msg \n"
     checkEvents()
     sWi(vp,@clear)


     sWo(grwo,@clear)

   xp = Sin(ang)
   yp = Cos(ang)

   ang += ten_deg


//   sWo(grwo,@clear,"skyblue",@clearclip,"magenta")

   sWo(grwo,@line,0,0,xp,yp)

   RP = wogetrscales(grwo)

   rx = RP[1];
   rZ = RP[3]
   rX = RP[3]
   ry = RP[2]
   rY = RP[4]

   sWo(grwo,@fonthue,BLACK_,@FONT,"small");

   //axnum(grwo,1,rx,rX,dx, xfoff, "g")
   axnum(grwo,1)
   axnum(grwo,-1)

   axnum(grwo,3,rx,rX,dx, xfoff, "g")

   axnum(grwo,2,ry,rY,dy, yfoff, "g")

   axnum(grwo,4,ry,rY,dy, yfoff, "g")

   sWo(grwo,@fonthue,"green") 

   //axnum(grwo,1,rx,rX,dx, -xfoff, "g")

   axnum(grwo,3,rx,rX,dx, -xfoff, "g")

   axnum(grwo,2,ry,rY,dy, -yfoff, "g")

   axnum(grwo,4,ry,rY,dy, -yfoff, "g")

   sWo(grwo,@border,@clipborder)


    sWo(grwo,@FONT,"medium");
    Axlabel(grwo,1,x_label,0.5,2,BLACK_,2)

    Axlabel(grwo,2,y_label,0.6,2,BLACK_,1,90)

   sWo(two,@clear,@textr,"$msg $rx $ry $rX $rY $dx $dy $ang ",0.1,0.8)
   sWo(two,@clear,@textr,"%V6.2f$xp $yp  ",0.01,0.6)

  }


 exit_gs()
