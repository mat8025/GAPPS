/* 
 *  @script ifunc.asl 
 * 
 *  @comment test indirect call of a func () 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.23 C-Li-V]                                 
 *  @date Thu Feb 18 12:06:13 2021 
 *  @cdate 1/1/2011 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///
///

 chkIn (_dblevel)



 y = sin(0.7)


 fname="_sin" ; // use _name to have asl lookup name as SFunction
                        // no leading _   then asl  will look up Proc
			

 z=$fname(0.7)

<<"%V $y $z\n"

chkR(z,y)

 x = 0.5
 y = cos(x)

 fname="_cos" ; // use _name to have asl lookup name as SFunction
                        // no leading _   then asl  will look up Proc
			

 z=$fname(x)

chkR(z,y)

chkOut(); exit();
