/* 
 *  @script minof.asl 
 * 
 *  @comment Test Minof SF 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.3 C-Li-Li]                                
 *  @date Wed Dec 30 22:27:13 2020 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

chkIn()

a = 5
b = 4
c = 3
d= 8

e= minof(a,b,c,d)

chkN(e,c)
<<"minof %V$a $b $c $d $e\n"

e= maxof(a,b,c,d)

chkN(e,d)

<<"maxof %V$a $b $c $d $e\n"

chkOut()