# Wed Aug 14 22:45:29 2013
xw = spawngwm()
vp = cwi(@title,"PLOT")
wo1=cwo(vp,@title,"PLOT",@resize,0.1,0.1,0.9,0.9)
swo(wo1,@redraw)
// 1
swo(wo1,@scales,0,-2,10*_PI,2)
// 1
dx = _PI/10.0
XV=vgen(FLOAT_,100,0,dx)
YV= sin(XV)
al=cgl(wo1,@type_XY,XV,YV,@color,GREEN,@ltype,"line")
swo(wo1,@pixmapon,@drawon,@savepixmap)
// 1
dgl(al)
// -1
<<"$XV\n"
<<"$YV\n"
swo(wo1,@showpixmap)
// 1
swo(wo1,@clear)
// 1
swo(wo1,@showpixmap)
// 1
YV= sin(XV+dx)
swo(wo1,@clear)
// 1
drawgline(al)
// 1
swo(wo1,@drawoff)
// 1
swo(wo1,@clear)
// 1
drawgline(al)
// 1
swo(wo1,@showpixmap)
// 1
YV= sin(XV+2*dx)
drawgline(al)
// 1
swo(wo1,@showpixmap)
// 1
swo(wo1,@clearpixmap)
// 1
swo(wo1,@showpixmap)
// 1
for (i = 0; i < 100; i++) { swo(wo1,@clearpixmap) ; YV = sin(XV + i*dx); drawgline(al); swo(wo1,@showpixmap);}
// 0
for (i = 0; i < 100; i++) { swo(wo1,@clearpixmap) ; YV = sin(XV + i*dx); drawgline(al); swo(wo1,@showpixmap);}
// 0
ZV = XV
swo(wo1,@scales,-2,-2,2,2)
// 1
for (i = 0; i < 1000; i++) { a= exp(i*0.001) -1; swo(wo1,@clearpixmap) ; YV = a * sin(ZV + i*2*dx); XV= sin(ZV+i*dx) ;drawgline(al); swo(wo1,@showpixmap);}
// 0

