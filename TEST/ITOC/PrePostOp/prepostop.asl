/* 
 *  @script prepostop.asl 
 * 
 *  @comment test a++ ++a ops 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.58 C-Li-Ce] 
 *  @date 11/08/2021 14:28:28          
 *  @cdate Wed May 13 11:09:50 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                       
<|Use_ =
   demo pre post incr
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn();

   db_ask = 0;
   db_allow = 0;


   int Foo(int a,int b)
   {

     <<"%V$a $b\n";

     c= a + b;

     <<"sum %V$c \n";

     return c;

     }
//======================================//



   k = 0;

   <<"%v $k \n";

   k++;

   <<"%v $k \n";

   chkN(k,1);

   k--;

   <<"%v $k \n";

   chkN(k,0);


   ++k;

   <<"%v $k \n";

   chkN(k,1);


   ++k++;

   <<"%v $k \n";

   chkN(k,3);

   k = 2;
   
   --k--;

   <<"%v $k \n";

   chkN(k,0);


   int VA[3] = {1,2,3};

   VA.pinfo();

   k = 0;

   k.pinfo();

   A= vgen(INT_,10,0,1);

   A.pinfo();

   <<"$A\n";

   A[0] = 47;

   A[1] = 79;

   A[2] = 80;

   A[3] = 14;

   <<"$A\n";

   b = A[k];

   <<"0th ele is $b\n";

   chkN(b,47);

   b= A[k++];

   <<"0th ele is still $b\n";

   chkN(b,47);

   <<"%V$k\n";

   b = A[k];

   <<"1st ele is $b \n";

   chkN(b,79);

   b= A[k++];

   <<"1st ele is $b \n";

   chkN(b,79);

   <<"%V$k\n";

   b= A[k++];

   <<"2nd ele $b \n";

   chkN(b,80);

   <<"%V$k\n";

   k++;

   b= A[k++];

   <<"4th ele $b \n";

   chkN(b,4);

   <<"%V$k\n";

   b= A[k--];

   <<"%V$b \n";

   chkN(b,5);

   <<"%V$k\n";

   b= A[--k];

   <<"%V$b \n";

   chkN(b,14);

   <<"%V$k\n";

   chkN(k,3);

   b= A[++k--];

   <<"%V$b \n";

   <<"%V$k\n";

   chkN(k,3);

   chkN(b,4);

   int e = ++k ;

   <<"%V$e $k \n";

   int w = --k ;

   <<"%V$w $k \n";

   chkN(e,4);

   chkN(w,3);

   int Gc;



   double x0 = -10.0;

   <<"%v $x0 \n";

   chkR(x0,-10);

   x0++;

   chkR(x0,-9);

   k = 3;

   m = 2;



   n = k + m;

chkN(n,5);




    chkN(k,3);
    chkN(m,2);    

   n = k++ ;
   
    chkN(n,3);
    chkN(k,4);

     n = k++ + m;

   <<"%V $n $k $m \n";

   chkN(n,6);
 allowDB("spe_exp,opera,rdp",db_allow)
   n = k++ + m++;

   <<"%V $n $k $m \n";

    chkN(n,7);

    chkN(k,6);
    chkN(m,3);    

//chkOut(1)

   k = 2;

   m = 2;

n.pinfo()

   n = --k + --m;

n.pinfo()

   chkN(n,2);

   <<"%V $n = $k + $m \n";

chkN(k,1);
chkN(m,1);


   <<"b4foo %V $k $m \n";

   r=Foo(k++,m++);

   <<"%V $k $m \n";

   chkN(k,2);

   chkN(m,2);

   chkN(r,2);



   <<"b4foo %V $k $m \n";

   r = Foo(++k,++m);

   <<"%V $k $m $r\n";

   chkN(k,3);

   chkN(m,3);

   chkN(r,6);

   AV = vgen(INT_,10,0,1);

   AV.pinfo();

   <<"%V$AV\n";

   chkN(AV[1],1);

  

     AV.pinfo()
    

     AV++;   // TBF not incr array


   AV.pinfo()

ans=ask("AV correct?",db_ask)



   chkN(AV[1],2);

    ++AV

   AV.pinfo()

  chkN(AV[1],3);


ans=ask("AV correct?",db_ask)


   BV = ++AV ; // this should increment all elements in the vector;

   <<"after ++ $AV\n";

   BV.pinfo();

   <<"%V $BV\n";

   chkN(BV[1],4);

   <<"%V $BV\n";

   <<"%V $AV\n";

ans=ask("AV == BV correct?",db_ask)


   BV= 67;

   BV.pinfo()
   

   chkN(BV[1],67);
   

   BV = AV

   BV.pinfo()

 allowDB("spe_,opera,rdp",db_allow)

   BV = AV++ ; // should increment all elements in the vector after assignment
                      // BV should be preincr 


   <<"after  AV ++\n";

   AV.pinfo()

   BV.pinfo()

ans=ask("AV == BV correct?",db_ask)

   chkN(AV[1],5);

   chkN(BV[1],4);

   <<"%V $AV\n";

   <<"%V $BV\n";

   <<"%V $BV[2]\n";

   chkOut(1);
