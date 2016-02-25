// a  basic window

// create and size to screen


    vp = CreateGwindow(@title,"BasicWindow")

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")
    SetGwindow(vp,@clip,0.15,0.25,0.9,0.9)

    SetGwindow(vp,@scales,-1,-1,1,1)

// setup a clip area (wo 0) inside of window

    SetGwindow(vp,@clearclip,"red",@clipborder,"blue")


 qwo=createGWOB(vp,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize_fr,0.01,0.01,0.14,0.1)
 setgwob(qwo,@help," click to quit")
 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 selwo=createGWOB(vp,"BN",@name,"SELECT",@VALUE,"SELECT",@color,"blue",@resize_fr,0.01,0.8,0.14,0.9)
 setgwob(selwo,@help," click to select box")
 setgwob(selwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)


 two=createGWOB(vp,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize,0.2,0.01,0.9,0.2)
 setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black","pixmapoff")
 setgwob(two,@SCALES,0,0,1,1)
 setgwob(two,@help," Mouse & Key Info ")


 bsketchwo=createGWOB(vp,"GRAPH",@name,"sketch",@color,"yellow",@resize,0.01,0.15,0.14,0.2)
 setgwob(bsketchwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red", @redraw)
 setgwob(bsketchwo,@clip,0.1,0.15,0.95,0.85,@bue,"lime")
 setgwob(bsketchwo,@SCALES,-1,-1,1,1)



// show border

// draw lines within clip area

   plotline(vp,0,0,1,1,"blue")
   plotline(vp,0,1,1,0,"red")

   axnum(vp,1)
   axnum(vp,2)

//  add some window objects
    SetGwindow(vp,@clip,0.15,0.25,0.9,0.9)

int Minfo[]
float Rinfo[]


    while (1) { 


       msg = messageWait(Minfo,Rinfo)

       msgw = split(msg)

       setgwob(two,@redraw)
       setgwob(two,@textr,"$msg",0.1,0.8)
       setgwob(two,@textr,"%V$Minfo[0:5]",0.1,0.7)
       setgwob(two,@textr,"%V$Minfo[6:10]",0.1,0.5)
       setgwob(two,@textr,"%V6.2f$Rinfo[0:5]",0.1,0.3)


       if (scmp(msgw[1],"QUIT",4)) {
         break
       }

       if (scmp(msgw[1],"SELECT",6)) {
         RS=selectreal(vp)
        <<"%V$RS\n"
  setgwob(two,@textr,"%V6.2f$RS",0.1,0.2)
       }




    }


exit_gs()
