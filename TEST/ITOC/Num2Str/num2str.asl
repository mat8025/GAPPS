/* 
 *  @script num2str.asl 
 * 
 *  @comment Test Str and scpy 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.3 C-Li-Li]                                 
 *  @date Wed Dec 30 22:53:16 2020 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///
///

chkIn()

k = 371;
   Str s = "$k";

<<"$k $s\n"
char cv[4];

     scpy(cv,s);
     <<" $cv[0] $cv[1] $cv[2]\n"

      a = cv[0] -48;
       b  = cv[1] -48;
       c  = cv[2] -48;

<<" $a $b $c\n"

a->info(1)

chkN(a,3)
chkN(b,7)
chkN(c,1)

chkOut()