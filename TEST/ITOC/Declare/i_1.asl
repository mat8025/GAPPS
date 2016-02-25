# Sat Mar 27 11:27:10 2010
X=spawngwm()
aw=createGW()
N = 100
XV= vgen(FLOAT_,N,0,0.1)
//YV= vgen(FLOAT_,10,0,1)
wid=createGwob(aw,@GRAPH,@resize,0.1,0.1,0.9,0.9,@clip,0.1,0.1,0.9,0.9,@clipborder)
setGwob(wid,@scales,0,-1,(N * 0.1),1)
// 393217
# drawXY,wid,XV,YV) == 393217

YV = sin(XV)

drawXY(wid,XV,YV)
// 393217
