#! /usr/local/GASP/bin/spi
# test object arrays

//<<" $Y[*] \n"


// check it runs a constructor - it does


<<"  NOW DEFINING OBJECT \n"

CLASS vec {

public:
  float Y[]

  float z = 67

//  float fv

 CMF set (k,fval)
 {

  <<" $_cproc $k $fval $(typeof(fval)) $(Caz(fval))\n"

       Y[k] = fval
 
//  <<" $Y \n"

//<<" $_cproc %v $z $fval\n"

w = fval

       z = w  
<<"$_cproc %v $z $fval $w\n"


<<" %V $k $z  $(Caz(Y)) \n"

 }

 CMF get ( int k)
 {
  // <<" $_cproc $k $z \n"

 //<<" %v $Y \n"

    w = Y[k]     

    //z = Z[k]     

//  <<" $_cproc %V $k $z  $(Caz(z)) \n"

// <<" $_cproc %V  $z  $(Caz(z)) \n"

// <<" $_cproc   $k $z \n"

       return w
 }

 CMF printY()
 {

//   <<" %v $Y[0;9] \n"
    sz = Caz(Y)
    dmn = Cab(Y)
    <<" %v $sz $dmn  %v $Y[*] \n"

 }

 CMF printz()
 {
    <<" %v $z \n"
 }


 CMF vec() {
    Y[10] = 1
 }

}




//<<" $Y[*] \n"

<<"  NOW DECLARING OBJECT \n"

   vec VO[3]

   VO[0]->set(22, 96.0)

   YV = VO[0]->Y

    sz = Caz(YV)
    dmn = Cab(YV)
    <<" %v $sz $dmn  %v $YV[*] \n"


   VO[0]->printY()

   YV = VO[0]->Y

    sz = Caz(YV)
    dmn = Cab(YV)
    <<" %v $sz $dmn  %v $YV[*] \n"


   VO[1]->set(16, 69.0)

   VO[1]->printY()


   vec V

//<<" $Y[*] \n"

   V->set(1, 11.0)

   V->printY()

//<<" $Y[*] \n"

   V->set(0, -99.0)

   V->set(3, 69.0)
   V->set(4, 44.0)

   V->set(2, 22.0)

   V->set(8, 88.0)

   i = 7

   V->set(i, 76.0)

   V->set(5, 55.0)

   V->set(9, 99.0)
   V->set(6, 66.0)

   V->set(99, 696.0)

<<" do v->print \n"

   V->printY()


   V->printz()

//<<" %v $z \n"

   f = V->get(2)

<<" %v $f \n"

   f = V->get(3)

<<" %v $f \n"

    for (i = 0; i < 10 ; i++) {
       f = V->get(i)
       <<"  [ $i ]  $f \n"

    }


   VO[0]->set(44, 96.0)

   VO[0]->printY()

   VO[1]->set(11, 69.0)

   VO[1]->printY()

   VO[2]->set(3, 23.0)

   VO[2]->printY()

       k = 4

       for (i = 0; i < 3 ; i++) {
        
           for (k = 0; k < 20 ; k++) {
            VO[i]->set(k, 2.0 * k )
           }

          VO[i]->set(99, 969)

          VO[i]->printY()
       }


STOP!

#{

float Z[10]

 aval = 96.0

  Z[7] = aval


float y

  Z[2] = 1234

  Z[3] = 4567


   y = Z[7]


<<" $y $(Caz(y))\n"



//<<" $Z \n"




proc GetVec (k) 
{
 float ys
 float zs

 zs = Z[k]

 ys = zs

 return ys

}


  f= GetVec(2)

<<" $f \n"

<<" $Z \n"


#}
