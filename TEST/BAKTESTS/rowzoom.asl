// test rowZoom  func
// zoom each row to a new size --- interpolate or spline values 



R = vgen(FLOAT_,12, 0,1)

R->redimn(3,4)

<<"$R\n"

NR = rowZoom(R,6,0)

<<"$NR\n"


NR = rowZoom(R,6,1)

<<"$NR\n"


NR = colZoom(R,6,0)

<<"$NR\n"