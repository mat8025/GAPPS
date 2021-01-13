/* 
 *  @script rowzoom.asl 
 * 
 *  @comment test rowzoom SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Tue Jan 12 19:59:04 2021 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


// test rowZoom  func
// zoom each row to a new size --- interpolate or spline values 

chkIn(_dblevel)

R = vgen(FLOAT_,12, 0,1)

R->redimn(3,4)

<<"$R\n"

NR = rowZoom(R,6,0)

<<"$NR\n"


NR = rowZoom(R,6,1)

<<"$NR\n"

nd=Cab(NR)

<<"$nd\n"

chkN(nd[1],6)


NR = colZoom(R,6,0)

<<"$NR\n"

nd=Cab(NR)

<<"$nd\n"

chkN(nd[0],6)


chkOut()