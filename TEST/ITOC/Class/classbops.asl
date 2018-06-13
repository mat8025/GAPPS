///
///  bops for class variables
///

setdebug(1,@~pline,@keep,@~trace,@~soe)

CheckIn()

 a = 1.0;
 b = 2.0;
 c = 0.2;

 float my;
 float  v = 2.1;
<<"%V $v\n"

   ok=CheckFNum(v,2.1);

 for (i = 0 ; i < 4 ; i++) {

    my = (b - c)/2.0 + (c + a) 

   <<"[${i}] %V $b $c  $my \n"

   b += 0.1

   ok=CheckFNum(my,v,5)
<<"%V$ok  $my $v \n"
   v += 0.05
 }

<<"%V $b $c  $my \n"
//////////////////////////////////////////////////////

Class Point 
{

 float x;
 float y;


 CMF set(a,b)
  {
      x = a;
      y = b;
      <<"Setting %V $a $b $x $y \n"
  }

 CMF getx()
  {
  <<"getting $x $_cobj \n"
     return x;
  }

 CMF gety()
  {
    <<"getting $y  $_cobj  \n"
     return y;
  }

 CMF  mul(a)
  {
      float tmp;
      tmp = (a * x)
      return tmp
  }

  CMF Print()
  {
    <<"%V $x,$y %i $x,$y\n"
  }
  
}
////////////////////////////////////////////

 Point A;
 Point B;
 Point C;
 Point D;

 B->set(2.2,0.123);
 A->set(0.15, 0.2);

<<"%V $A->x $A->y \n"

<<" A->Print() \n"
 A->Print()
 
 ok=CheckFNum(A[0]->x,0.15,5)
 ok=CheckFNum(A[0]->y,0.2,5)


<<" B->Print() \n"
 B->Print()




<<"%V $B->x $B->y \n"

 
ok=CheckFNum(B->x,2.2,5)
ok=CheckFNum(B->y,0.123,5)





C->set(1.1,0.2)

<<"%V $C->x $C->y \n"



 wx = A->getx();

 ok=CheckFNum(wx,0.15,5)

 A->set(47, 79);
 
 A->Print()

 B->set(83, 65);
 A->Print()
 B->Print()

 D->x = B->x;

checkNum(D->x,83)

 D->Print()

 D->y = A->y;

checkNum(D->y,79)



 D->Print()
  

checkNum(D->y,A->y)




<<" 1/////////////////\n"

<<"%V$ok x  $wx 0.15\n"

  wy = A->gety()
<<"%V $wy $A->gety()\n"


   ok=CheckFNum(wy,79,5)
<<"%Vok y $wy 79\n"

<<" 2/////////////////\n"


A->Print();
B->Print();

  ax = A->getx();
  <<"A %V $ax \n"
 CheckFNum(ax,47,5);
  ay = A->gety();
  <<"A %V $ay \n"  
       CheckFNum(ay,79,5)

A->Print();



bx = B->getx();
   CheckFNum(bx,83,5)
  by = B->gety();
   CheckFNum(by,65,5)
   axy = A->getx() + A->gety()
   CheckFNum(axy,(ax+ay),5)
   bxy = B->getx() + B->gety()
   CheckFNum(bxy,(bx+by),5);
   
   z2 = A->x + B->y

   z = A->getx() + B->gety()
  
<<"%V $ax $ay $axy $bx $by  $bxy $z2 $z\n"


   CheckFNum(z2,(ax+by),5)

   CheckFNum(z,(ax+by),5)

<<"%V $z $wx $wy \n"

  z = A->getx() * A->gety()

<<"%V $z $wx $wy \n"

    my = B->y

<<"%V $B->y  $my \n"

    my = B->y - C->y;

     ok=CheckFNum(my,(65-0.2),4)
<<"%V$ok $B->y - $C->y =  $my \n"


    my = ((B->y - C->y)/2.0) + C->y 

<<"%V $B->y $C->y  $my \n"

     ok=CheckFNum(my,32.6,4)
<<"%V$ok $my 1.1\n"

 //setdebug(1,"step")

 Point P[3];

 checkProgress(" 4")
  v  = 1.3



//  ws = nsc(20,'\')   // escaped ' ??
//<<"$ws\n"

//  <<"$(nsc(20,'\'))\n"


 for (i = 0; i < 4 ; i++) {

<<"%V $i $v \n"
     my = ((B->y + C->y)/2.0) + C->y 


    ok=CheckFNum(my,v,6)
 checkProgress(" for $i")
<<"%V$ok $i $my $v\n"
     B->y += 0.2

     v += 0.1
  }

//<<"$(nsc(20,'/'))\n"



    CheckNum(i,4)

checkProgress("$i  i == 4 ");

    v = B->gety()
<<" $v\n"
  v1 = C->y;
<<" $v1\n"  
  v -= C->y

<<" $v\n"

checkProgress();

checkProgress("  v xx C->y ");

checkProgress("  v -= C->y ");



    my = B->gety() - C->y
<<"%V$ok $my $v\n"
    ok=CheckFNum(my,v,5)

    v = A->getx()
    v *= 2
    my = A->mul(2)

<<" %V $A->x $my $v \n"

   CheckNum(my,v)

    u = B->getx()
    u *= 3
    my = B->mul(3)

<<" %V $B->x $my $u \n"

   CheckFNum(my,u,6)

   float w = v + u

   my = A->mul(2) + B->mul(3)

<<" %V $w $my $v $u \n"

   CheckFNum(my,w,6)



<<" %V $A->x $B->x \n"

   my = A->mul(B->x)

<<" %V $my $A->x $B->x \n"

   CheckFNum(my,0.3,6)

   my = A->mul(B->x) + B->mul(A->x)



   ok=CheckFNum(my,0.6,6)
<<"%V$ok  $my == 0.6 $A->x $B->x \n"
   my = Sin(0.5)

<<"Sin  %V $my \n"

  v = my * A->x 

  my = A->mul( Sin(0.5) )


  <<"%V$my $A->x  $v \n"

   CheckFNum(my,v,5)



//FIXME   my = A->mul( Sin(0.5) )
//<<" %V $my $A->x  \n"


  my = A->mul( Sin(0.5) )


  <<"%V$my $A->x  \n"


   CheckOut()

exit()

   my = A->mul( B->getx() )

<<" %V $my $A->x $B->x \n"

 //      CheckNum(my,0.3)





;



/// TBD ///////////
/// still have to check this  gives correct answer  for
///
//  A->x     - done
//  A->getx() - done
//  A->mul(z) - done
//  A->getx() + B->getx() + ...
//  A->add( B->gety(), C->gety())  ...
//  A->x->z ....
//  ...


