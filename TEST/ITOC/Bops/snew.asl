/* 
 *  @script snew.asl 
 * 
 *  @comment test some basic ops 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Thu Feb  4 20:13:04 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"

  
     
     chkIn(); 
     
//prog= GetScript()
     
     float fn=2.71828;
     <<"%V$fn\n"; 
     chkR(fn,2.71828); 
     
     int d= 7;
     
     e = -6; 
     
     
     chkN(d,7); 
     chkN(e,-6); 
     
     int b = 79;
     
     chkN(b,79); 
     
     b = d * e;
     
     <<"%V$b\n"; 
     
     chkN(b,-42);
     
     
     b++;
     
     
     <<"%V$b\n"; 
     
     chkN(b,-41);
     
     
     na = argc(); 
     
     if (na >= 1) {
       for (i = 0; i < argc() ; i++) {
         <<"arg [${i}] $_clarg[i] \n"; 
         }
       }
     <<"args listed\n"; 
     
     
     
     
     
     
     
     
//    chkOut()
//    exit()
     
//a = 2 + 2
     int a = 2 + 2; 
     <<"%V$a\n"; 
     
     chkN(a,4); 
     
     b = 7 * 6; 
     
     <<"%V$b\n"; 
     
     chkN(b,42); 
     
     
     c= a * b; 
     
     chkN(c,(4*42)); 
     
     <<"$c $a $b \n"; 
     
     
     z = Sin(0.9); 
     
     <<" %v $z \n"; 
     
     
     x = Cos(0.9); 
     
     <<" %v $z $x \n"; 
     
//   test some basics -- before using testsuite  
     
     
     
     int k=4;
     
     
     <<"%V $k \n"; 
     
     chkN(k,4); 
     
     int k1 = 47; 
     
     <<"%V $k1 \n"; 
     
     chkN(k1,47); 
     
     
     float y = 3.2; 
     
     <<"%V $y \n"; 
     
     chkR(y,3.2,6); 
     
     a = 2 + 2; 
     
     <<"%v $a \n"; 
//     chkN(a,4)
     
     sal = 40 * 75 * 4; 
     
     <<"%v $sal \n"; 
     
     chkN(sal,12000); 
     
     
     int n = 1; 
     
     <<"%V $n \n"; 
     
     chkN(n,1); 
     
     
     n++; 
     
     chkN(n,2); 
     
     
     ++n; 
     
     chkN(n,3); 
     
     <<"%V $n \n"; 
     
     z = n++ + 1; 
     <<"%V $z \n"; 
     
     chkN(n,4); 
     
     chkN(z,4); 
     
     <<"%v $n \n"; 
     
     z = ++n + 1; 
     <<"%V $z \n"; 
     
     chkN(z,6); 
     
     <<"%V $n \n"; 
     
     ++n++; 
     
     <<"%V $n \n"; 
     
     chkN(n,7); 
     
     
     
     
     N = 24; 
     
     k = 2; 
     ok =0; 
     if (k <= N) {
       <<" $k  <= $N \n"; 
       ok = 1; 
       <<" <= op  working!\n"; 
       }
     else {
       <<" <= op not working! %V$k\n"; 
       }
     
     chkN(1,ok); 
     
     ok = 0; 
     k = 25; 
     
     if (k >= N) {
       <<" $k  >= $N \n"; 
       ok = 1; 
       <<" >= op  working!\n"; 
       }
     else {
       <<" >= op not working! %V$k\n"; 
       }
     
     
     chkN(1,ok); 
     
     ok = 0; 
     
     if (k != N) {
       <<" $k  != $N \n"; 
       ok = 1; 
       <<" != op  working!\n"; 
       }
     else {
       <<" != op not working! %V$k\n"; 
       }
     
     chkN(1,ok); 
     
     
     float fa = 1;
     float fb = 2.3;
     float fc = 4.8;
     
     chkR(fb,2.3); 
     <<"%V$fa $fb $fc\n"; 
     fb++; 
     chkR(fb,3.3); 
     
     <<"%V$fa $fb $fc\n"; 
     
     int h = -4;
     
     <<"%V$h\n"; 
     
     chkN(h,-4);
     
     float q=-7;<<"$q\n"; 
     
     chkR(q,-7);
     
     int sum = 0;
     double mi = 1;
     N = 10;
  
     for (k = 0; k < N; k++) {
       
       sum += k;
       mi *= k;
       <<"%V $k $sum $mi \n"; 
       }
     
     <<"%V $sum  $k  $(k*N/2) $mi\n"; 
     
     
     chkOut(); 
     
//float ok = 47.2
//<<"$ok \n"
     
     
