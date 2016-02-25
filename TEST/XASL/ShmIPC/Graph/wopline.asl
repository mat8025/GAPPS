SetDebug(1)

opendll("math")

Graphic = CheckGwm()

<<" %v $Graphic \n"
spawn_it = 1


 if (Graphic) {
   spawn_it = 0;
 }

<<" %v $spawn_it \n"

     if (spawn_it) {
     X=spawngwm()
     spawn_it  = 0;
     }


pi = 4.0 * atan(1.0)

// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = CreateGwindow("title","PLOTLINE",@resize,0.05,0.01,0.99,0.95,0)
    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.1
    cY = 0.9

    gwo=CreateGWOB(vp,"GRAPH",@resize,0.1,0.1,0.95,0.95,@name,"LP",@color,"white")

//    setgwob(gwo,"clip",cx,cy,cX,cY)

    setgwob(gwo,@clip,cx,cy,cX,cY)

//    setgwob(gwo,"scales",0,0,1,1, "save","redraw","drawon","pixmapon")
    setgwob(gwo,@scales,0,0,1,1)

    setgwob(gwo,@redraw,@drawon,@pixmapon)
    setgwob(gwo,@clipborder,"red")
//    setgwob(gwo,@bhue,"orange",@clear,@clipborder,"red")
    setgwob(gwo,@bhue,"pink",@clear)
    setgwob(gwo,@bhue,"orange",@clearclip)
    setgwob(@clipborder,"blue")
    setgwob(gwo,@plotline,0,0,1,1)


    setgwob(gwo,@plotline,0,1,1,0,"blue")
    setgwob(gwo,@plotline,0.5,0,0.5,1,"green")






////////////////////////////// PLINE ////////////////////////////////////////



   stop!

  setgwob(gwo,@hue,"red",@plotline,0,0,1,1,"green")
  setgwob(gwo,@hue,"red",@plotline,0.2,0,1,0.9,"orange")

  setgwob(gwo,@clipborder,"black",@plotline,0,1,1,0,"blue")


     plotline(vp,0,0,1,1,"red")
     plotline(vp,0,1,1,0,"blue")



STOP!


