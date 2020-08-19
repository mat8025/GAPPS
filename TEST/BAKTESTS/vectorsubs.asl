#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

opendll("math")

SetDEbug(0)

int Dbvlen = 2
float Vsky[]

  SKYR = Fgen(300,0,1)

  Redimn(SKYR,10,30)

  nrecs = 10

  Vsky = SKYR[0:nrecs-1][5:27:2]

 <<" %V $( Cab(Vsky))  $( Caz(Vsky))  \n"

<<" %r $Vsky \n"


CLASS bd
{

public:

  float y[10];
  float x[10];
  int wri

  CMF Setx(val)
  {
     x = val
     y = val * val
<<"%v $x \n"
<<"%v $y \n"

  }

}

CLASS tv
{

public:

  float timev[]
  float vsky[]
  float z[]
  int wri
  int x

 CMF wrt(wr)
 {
  
<<" in wrt $wr\n"
  wri = wr
 <<" in wrt $wri\n"
  k = timev[wr]

  <<"$wr $k \n"

 }

 CMF settv( iv)
 {

    timev = Fgen(10,iv,1)

// <<" in itv \n"

 <<"%v $( Cab(timev)) \n"

  <<" $timev \n"
//    timev = Sin(timev)
//  <<" $timev \n"

  z = 5

  vsky = SKYR[0:nrecs-1][5:27:2]
 <<" %v $( Cab(vsky))  $( Caz(vsky))  \n"


 }


CMF GetTimev() 
 {
 <<" %v \n $timev[0:Dbvlen] \n"
<<" $(Cab(timev)) \n"
   stc = timev
<<"%v $(Cab(stc)) \n"

   svc = vsky
<<"%v $(Cab(svc)) \n"
   return stc
 }



 CMF GetCol( wc) 
 {
   sc = vsky[*][wc]
   return sc
 }

 CMF tv() 
 {
  <<" cons for tv \n"
 }

}


 tv rtv
 tv ctv

 for (j = 0; j < 3; j++) {

     rtv->x = 7

     ctv->x = j + 1

  y =  rtv->x * ctv->x

<<"%v $y \n"
 }



 tv atv[4]

 for (j = 0; j < 3; j++) {

     atv[0]->x = 7

     atv[1]->x = j + 1


  y =  atv[0]->x * atv[1]->x

<<"%v $y \n"

 }

STOP("DONE \n")

 k = 1

 atv[k]->settv(y)


  for (j = 0 ; j < 3 ; j++) {

   atv[j]->settv(j)

 }

  for (j = 0 ; j < 3 ; j++) {

   XV = atv[j]->GetTimev()

<<"%v $(Cab(XV)) \n"
<<"%v $XV \n"

 }


STOP("DONE \n")



 <<"%v $atv[0]->timev \n"
<<"%v $(Cab(atv[0]->timev)) \n"





STOP("DONE \n")

 <<"%v $(Cab(atv[0]->vsky)) \n"

   DV = atv[0]->vsky[*][0]


<<"%v $(Cab( DV)) \n"
<<"  $DV \n"

   DV = atv[0]->vsky[*][1]


<<"%v $(Cab( DV)) \n"
<<"  $DV \n"



STOP!
//  V = atv->vsky[0][0]


//  V = atv[0]->vsky

    V = atv[0]->GetCol(0)

<<"%v $(Cab( V)) \n"

  T = V[*][0]
<<"%v $(Cab( T)) \n"

<<" $T \n"
 






STOP!





 bd abd













 abd->Setx(10)




<<"%v $abd->x \n"



 abd->Setx(12)

<<"%v $abd->y \n"

  Z = abd->y + atv->timev

<<" $Z \n"



 tv rtv
 rtv->settv()

<<"%v $rtv->timev \n"


<<"%v $atv->timev \n"

    atv->timev = 7

<<"%v $atv->timev \n"

 atv->settv()

<<"%v $atv->timev \n"

<<"%v $atv->z \n"



<<"%v $abd->y \n"

  Y = atv->timev + abd->x


<<"%v $Y \n"


STOP("DONE\n")



Red = Igen(20,0,1)



<<" %r $Red \n"

for (j = 0; j < 3; j++) {

 Red[j] = 30

<<" %r $Red \n"

}

Red = Igen(20,0,1)
col = Red[10]

Redimn(Red,4,5)
<<" $Red \n"
<<" $col \n"
for (j = 0; j < 3; j++) {

 col = Red[j][2] 

<<" $col $Red[j][2] \n"

}

 tv atv[6]
// tv atv

 for (j = 1; j < 5; j++) {
   atv[j]->settv()

 }

STOP("DONE \n")

<<" tying to wrt \n"

 for (j = 1; j < 7; j++) {

   atv->wrt(j)

 }



STOP("DONE \n")


  start = 1
  end = 6

<<" $Red \n"


 InRed = Red[ start : end+5] 






<<" $InRed \n"

 SeeRed = Red[ start : 6+end] 

<<" $SeeRed \n"

<<" DONE \n"
STOP!
