/* 
 *  @script rowzoom.asl                                                 
 * 
 *  @comment test rowzoom SF                                            
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.28 : C Ni]                              
 *  @date 06/12/2024 18:09:56                                           
 *  @cdate 1/1/2007                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

// test rowZoom  func
// zoom each row to a new size --- interpolate or spline values 

   chkIn();

   R = vgen(FLOAT_,12, 0,1);

   R.redimn(3,4);

   <<"$R\n";

   NR = rowZoom(R,6,0);

   <<"$NR\n";

   NR = rowZoom(R,6,1);

   <<"$NR\n";

   nd=Cab(NR);

   <<"$nd\n";

   chkN(nd[1],6);

   NR = colZoom(R,6,0);

   <<"$NR\n";

   nd=Cab(NR);

   <<"$nd\n";

   chkN(nd[0],6);

   chkOut();

//==============\_(^-^)_/==================//
