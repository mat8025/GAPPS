/* 
 *  @script opxeq.asl 
 * 
 *  @comment test sel op += *= ++ 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.11 C-Li-Na] 
 *  @date Sun Jan 17 10:29:34 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///
///


chkIn()
int n = 3;

    m = 4;

    n += m;

<<"%V $n $m \n"
 chkN(m,4)

!im
 
 chkN(n,7)

!in


    n -= m

<<"%V $n $m \n"
!in


 chkN(m,4)
 chkN(n,3)
    n -= m

<<"%V $n $m \n"

// chkR(n,-1,6)

    n += m
 chkN(n,3)
<<"%V $n $m \n"

    n += m
 chkN(n,7)
<<"%V $n $m \n"



  s = 0.00001

  x = 3481.0

  z = x

  s *= x


<<" $s $x $z \n"




    n += m

<<"%V $n $m \n"

    n -= m

<<"%V $n $m \n"

    n -= m

<<"%V $n $m \n"

!in

int k = 45

k->info(1)

<<" $k \n"

   k++
!ik

<<" $k \n"

   ++k 
!ik

<<" $k \n"

   ++k++ 

<<" $k \n"

k->info(1)

   n = 5;
!in

   k /= n;  // k should stay int type!

k->info(1)

<<" $k $n\n"
 chkN(k,9)

n->info(1)
chkR(n,5.0)


chkOut()
