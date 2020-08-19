
opendll("math")
 gx= spawnGWM()

 aw= create_gwindow(@TITLE,"PLOT",@resize,0.1,0.1,0.9,0.9)

 gwo = create_gwob(aw,"GRAPH",@resize,0.1,0.1,0.9,0.9)


 setgwob(gwo,@scales,-1.5,-1.2,1.5,1.2,@clipborder)

 plotline(gwo,0,0.5,1,0.5,"yellow")

 setgwob(gwo,@clip,0.1,0.1,0.9,0.9,@clipborder,"red")

 setgwob(gwo,@drawon,@pixmapon,@border)

 plotline(gwo,0,0.5,1,0.5,"yellow")

 plotline(gwo,0.1,0.5,0.5,0.5,"black")

 setgwob(gwo,@clipborder,"black",@plotline,0,1,1,0,BLUE)

 setgwob(gwo,@plotsymbol,0.4,0.7,"star5",0.05,"blue")
 x= -1.6
 y = 0.0
 for (i = 0; i < 30; i++) {
    x= -1.6 + i * 0.15
    y = sin(x)
<<"$i $x $y\n"
    setgwob(gwo,@plotsymbol,x,y,"star5",5,"blue")
}

setgwob(gwo,@store,@save)

setgwob(gwo,@showpixmap)

