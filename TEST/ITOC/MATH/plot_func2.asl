
opendll("math")
 gx= spawnGWM()

 aw= create_gwindow(@TITLE,"PLOT",@resize,0.1,0.1,0.9,0.9)

 gwo = create_gwob(aw,"GRAPH",@resize,0.1,0.1,0.9,0.9)


 setgwob(gwo,@scales,0,0,5,5,@clipborder)


 setgwob(gwo,@clip,0.1,0.1,0.6,0.9,@clipborder,"red")

 setgwob(gwo,@drawon,@pixmapon,@border)

 r = 1
 a = 2.5
 b = 1.5

 x= 0.0
 y = 0.0

 for (i = 0; i < 240; i++) {
    x +=  0.025

    rt = r * r - (x -a) * (x -a )
    if (rt >= 0) {


    yp = sqrt(rt)
    yn = -yp

<<"$i $x $yp $yn\n"

    setgwob(gwo,@plotsymbol,x,yp+b,"star",5,"blue")
    setgwob(gwo,@plotsymbol,x,yn+b,"star",5,"red")

    } 
 


}

setgwob(gwo,@store,@save)

setgwob(gwo,@showpixmap)

