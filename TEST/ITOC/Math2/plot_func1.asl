
//opendll("math")
 gx= spawnGWM()

 aw= create_gwindow(@TITLE,"PLOT",@resize,0.1,0.2,0.9,0.9)
 gwo = create_gwob(aw,"GRAPH",@resize,0.1,0.2,0.9,0.9)

 setgwob(gwo,@scales,-1.2,-4.5,5.5,8,@clipborder)

 setgwob(gwo,@clip,0.1,0.1,0.6,0.9,@clipborder,"red")

 setgwob(gwo,@drawon,@pixmapon,@border)


 x= -1.0
 y = 0.0

 for (i = 0; i < 60; i++) {
    x +=  0.1
    y = 1/3.0 * (x * x * x) -2 * x * x + 3 * x + 1
<<"$i $x $y\n"
    setgwob(gwo,@plotsymbol,x,y,"tri",5,"blue")
}

setgwob(gwo,@store,@save)

setgwob(gwo,@showpixmap)

