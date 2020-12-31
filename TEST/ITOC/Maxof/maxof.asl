/* 
 *  @script maxof.asl 
 * 
 *  @comment Test Maxof SF 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.2 C-Li-He]                                
 *  @date Wed Dec 30 22:21:25 2020 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

chkIn()

a = 47
b = 79

c = maxof(a,b)

<<"$a $b $c\n"
chkN(c,b)

e = 4.56
f = 7.38
d = maxof(e,f)

chkN(d,f)

<<"max $e $f $d\n"

e = 4.566666
f = 4.566665
d = maxof(e,f)

<<"max $e $f $d\n"


e = 4.56
f = 7.38
d = minof(e,f)

<<"min $e $f $d\n"

chkOut()