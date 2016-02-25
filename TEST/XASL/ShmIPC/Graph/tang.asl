opendll("math")

float tad;
float tar
proc poo(x,z)
{
int Q
float pa


  tar = atan2(z,x) ; tad = r2d(tar) ; r = sqrt ( x*x + z * z) ;  sa = asin(z/r)

  pa = ta2quad(tad)

  sad = r2d(sa)



<<"%V $x $z $ta $tad $pa $sa $sad\n"
}

#{
proc ta2quad( qta)
{
q = 1
<<" in $qta \n"

  if ((qta > 0.0) && (qta <= 90.0)) {
    q =1
   <<"1 $q $qta > 0.0 and $qta <= 90.0 \n"
  }

  if ((qta < 0) && (qta > -90.0)) {
    q =2
   <<"2 $q $qta < 0 and $qta > -90.0 \n"
  }

  if ((qta < 0) && (qta < -90.0)) {
    q =3
   <<"3 $q $qta  $qta < 0 and $qta < -90.0 \n"
  }

  if ((qta > 0) && (qta > 90.0)) {
    q =4
   <<"4 $q $qta $qta > 0 and $qta > 90.0 \n"
  }

  return q

}
#}



proc ta2quad( qta)
{
q = 1
<<" in $qta \n"
float pa

  if (qta > 0.0) {

   if (qta <= 90.0) {
    q =1
   <<"1 $q $qta > 0.0 and $qta <= 90.0 \n"
    pa = qta
   }

    if ((qta > 90.0)) {
    q =4
   <<"4 $q $qta $qta > 0 and $qta > 90.0 \n"
    pa = qta
    }


  }

  if (qta < 0) {

    if (qta > -90.0) {
    q =2
   <<"2 $q $qta < 0 and $qta > -90.0 \n"
    pa = 360 + qta
    }

    if (qta < -90.0) {
    q =3
   <<"3 $q $qta  $qta < 0 and $qta < -90.0 \n"
    pa = 360 + qta
    }

  }

  return pa

}


proc ta2polarB( itar )
{

  xtad = r2d(itar)


  rta = 90.0 - xtad

  if (xtad < 0.0)
     xtad += 360

  if (xtad > 360)
      xtad -= 360

  return xtad
}




//  x = 1.0 ; z = 2.0

mz = 5.0
mq =4

     poo(1.0,mz)

  if ((tad > 0.0) && (tad <= 90.0)) {
    mq =1
<<"1 $mq $tad > 0.0 and $tad <= 90.0 \n"
  }

  if ((tad < 0) && (tad >= -90.0)) {
    mq =2
   <<"2 $mq $tad < 0 and $tad > -90.0 \n"
  }

  if ((tad < 0) && (tad < -90.0)) {
    mq =3
   <<"3 $mq $tad  $tad < 0 and $tad < -90.0 \n"
  }

   if ((tad > 0) && (tad > 90.0)) {
    mq =4
   <<"4 $mq $tad $tad > 0 and $tad > 90.0 \n"
  }



    btad = ta2polarB(tar)

 <<"%V $tad  $mq $tar $btad\n"
   


     poo(1.0,-mz)

  if ((tad > 0.0) && (tad <= 90.0)) {
    mq =1
 <<"1 $mq $tad > 0.0 and $tad <= 90.0 \n"
  }

  if ((tad < 0) && (tad >= -90.0)) {
    mq =2
   <<"2 $mq $tad < 0 and $tad > -90.0 \n"
  }

  if ((tad < 0) && (tad < -90.0)) {
    mq =3
   <<"3 $mq $tad  $tad < 0 and $tad < -90.0 \n"
  }

   if ((tad > 0) && (tad > 90.0)) {
    mq =4
   <<"4 $mq $tad $tad > 0 and $tad > 90.0 \n"
  }

     btad = ta2polarB(tar)

 <<"%V $tad  $mq $tar $btad\n"

     poo(-1.0,-mz)

  if ((tad > 0.0) && (tad <= 90.0)) {
    mq =1
<<"1 $mq $tad > 0.0 and $tad <= 90.0 \n"
  }

  if ((tad < 0) && (tad >= -90.0)) {
    mq =2
   <<"2 $mq $tad < 0 and $tad > -90.0 \n"
  }

  if ((tad < 0) && (tad < -90.0)) {
    mq =3
   <<"3 $mq $tad  $tad < 0 and $tad < -90.0 \n"
  }

  if ((tad > 0) && (tad > 90.0)) {
    mq =4
   <<"4 $mq $tad $tad > 0 and $tad > 90.0 \n"
  }


     btad = ta2polarB(tar)

 <<"%V $tad  $mq $tar $btad\n"

     poo(-1.0,mz)


  if ((tad > 0.0) && (tad <= 90.0)) {
    mq =1
<<"1 $mq $tad > 0.0 and $tad <= 90.0 \n"
  }

  if ((tad < 0) && (tad >= -90.0)) {
    mq =2
   <<"2 $mq $tad < 0 and $tad > -90.0 \n"
  }

  if ((tad < 0) && (tad < -90.0)) {
    mq =3
   <<"3 $mq $tad  $tad < 0 and $tad < -90.0 \n"
  }

   if ((tad > 0) && (tad > 90.0)) {
    mq =4
   <<"4 $mq $tad $tad > 0 and $tad > 90.0 \n"
  }


     btad = ta2polarB(tar)

 <<"%V $tad  $mq $tar $btad\n"


;
