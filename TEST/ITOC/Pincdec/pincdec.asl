/* 
 *  @script pincdec.asl 
 * 
 *  @comment test readline inc op ++ 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.3 C-Li-Li]                                 
 *  @date Thu Dec 31 08:37:16 2020 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///
///

chkIn()
int tl = 0;
int ml = 0;

//setdebug(1,"trace");

wc =!!"wc pincdec.asl"
<<"$wc \n"
A=ofr("pincdec.asl")

<<"%V$A\n";

int n= 0;
while (1) {



   S= readline(A);

   if (feof(A)) {
       break;
   }

   a=tl++;

   
   ml--;
   <<"$a $tl $ml $n\t:: $S\n"
   n += 1;



 }




words=split(wc)
<<"$wc \n"
<<"$words[0]\n"
k=atoi(words[0])

<<"%V$tl $k\n";
chkN(tl,k)

chkOut()