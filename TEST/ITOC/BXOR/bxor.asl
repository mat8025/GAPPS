/* 
 *  @script bxor.asl 
 * 
 *  @comment test BXOR -- also ^^ for pow 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 12:40:53 2021 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 




chkIn(_dblevel)

int a = 4

d = a ^ 4

<<"%V$a $d \n"

chkN(d,0)
int b = 2

c = ( a ^ b)

<<"$a ^ $b = $c \n"

<<"%o$a $b $c \n"


<<" but we can use ^^ for exp?\n"


f = ( a ^^ b)


<<"POW $a ^^ $b = $f \n"
chkR(f,16.0)

a = 6;
b=  7;

e = ( a ^ b)

chkN(e,1)
<<"BXOR $a ^ $b = $e \n"

chkOut()