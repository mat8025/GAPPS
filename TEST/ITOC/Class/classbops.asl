// bops for class variables

setdebug(1,"pline","prun")

CheckIn()

 a = 1.0
 b = 2.0
 c = 0.2

 float my

// FIXME XIC float v= 2.1

 v = 2.1

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
 float y


 CMF set(a,b)
  {
      x = a
      y = b
  }

 CMF getx()
  {
     return x
     
  }

 CMF gety()
  {
     return y
  }

 CMF  mul(a)
  {
      float tmp
      tmp = (a * x)
      return tmp
  }



}
////////////////////////////////////////////

 Point A
 Point B
 Point C


 A->set(0.15,0.2)
 B->set(2.0,2)
 C->set(1,0.2)



<<"%V $A->x $A->y \n"
<<"%V $B->x $B->y \n"
<<"%V $C->x $C->y \n"


 wx = A->getx()


 ok=CheckFNum(wx,0.15,5)

<<" 1/////////////////\n"

<<"%V$ok x  $wx 0.15\n"

  wy = A->gety()



   ok=CheckFNum(wy,0.2,5)
<<"%Vok y $wy 0.2\n"

<<" 2/////////////////\n"

  z = A->getx() + B->gety()

   CheckFNum(z,2.15,5)

<<"%V $z $wx $wy \n"

  z = A->getx() * A->gety()

<<"%V $z $wx $wy \n"

    my = B->y

<<"%V $B->y  $my \n"

    my = B->y - C->y

     ok=CheckFNum(my,1.8,6)
<<"%V$ok $B->y - $C->y =  $my \n"


    my = ((B->y - C->y)/2.0) + C->y 

<<"%V $B->y $C->y  $my \n"

     ok=CheckFNum(my,1.1,6)
<<"%V$ok $my 1.1\n"

 //setdebug(1,"step")


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


    v = B->gety()
    v -= C->y

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

stop!

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


