// a  basic window
// create and size to screen

   Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

    vp = cWi(@title,"BasicWindow")

    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_)
    sWi(vp,@clip,0.15,0.25,0.9,0.9)

    sWi(vp,@scales,-1,-1,1,1)

// setup a clip area (wo 0) inside of window

    sWi(vp,@clearclip,"red",@clipborder,"blue")

 qwo=cWo(vp,"BN",@name,"QUIT?",@value,"QUIT",@color,"orange",@resize_fr,0.01,0.01,0.14,0.1)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@border,@drawon,@clipborder,@fonthue,BLACK_, @redraw)

 selwo=cWo(vp,"BN",@name,"SELECT",@value,"SELECT",@color,"blue",@resize_fr,0.01,0.8,0.14,0.9)
 sWo(selwo,@help," click to select box")
 sWo(selwo,@BORDER,@DRAWON,@clipborder,@fonthue,BLACK_, @redraw)


 two=cWo(vp,"TEXT",@name,"Text",@value,"howdy",@color,"orange",@resize,0.2,0.01,0.9,0.2)
 sWo(two,@border,@drawon,@clipborder,@fonthue,"black",@pixmapoff)
 sWo(two,@scales,0,0,1,1)
 sWo(two,@help," Mouse & Key Info ")


 bsketchwo=cWo(vp,"GRAPH",@name,"sketch",@color,"yellow",@resize,0.01,0.15,0.14,0.2)
 sWo(bsketchwo,@border,@drawon,@clipborder,@fonthue,"red", @redraw)
 sWo(bsketchwo,@clip,0.1,0.15,0.95,0.85,@bhue,"lime")
 sWo(bsketchwo,@scales,-1,-1,1,1)

// show border
// draw lines within clip area

  // plotline(vp,0,0,1,1,"blue")
 //  plotline(vp,0,1,1,0,"red")

   axnum(vp,1)
   axnum(vp,2)



//  add some window objects
    sWi(vp,@clip,0.15,0.25,0.9,0.9)

include "gevent.asl"


    while (1) { 
       
       eventWait();


       sWo(two,@redraw)
       sWo(two,@textr,"$ev_msg",0.1,0.8)
       sWi(vp,@tmsg,"Hey buddy $ev_kloop");
       sWo(two,@textr,"%V$ev_button",0.1,0.7)
       sWo(two,@textr,"%V$ev_rx $ev_ry",0.1,0.5)
//       sWo(two,@textr,"%V6.2f$Rinfo[0:5]",0.1,0.3)


       if (scmp(ev_msgwd[1],"QUIT",4)) {
         break
       }

       if (scmp(ev_msgwd[1],"SELECT",6)) {
         RS=selectreal(vp)
        <<"%V$RS\n"
         sWo(two,@textr,"%V6.2f$RS",0.1,0.2)
       }

       if (ev_woid == qwo) {
           break;
       }
    }


exit_gs()
