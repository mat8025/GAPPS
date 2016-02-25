
//  test if and or not

CheckIn()

CheckIn()





int a = 1
int b = 2

proc poo()
{
 plop = 0

  if (a > 0 ) {
    <<" ($a > 0)  \n"
    plop = 1
  }
  else {
   <<" NOT ($a > 0 ) \n"
  }


CheckTrue(plop)

   return plop


}



proc poo2()
{
 plop = 0

 int a = 2
 int b = 3

  if ((a > 0) && (b > 2)) {
    <<" ($a > 0 && $b > 2) \n"
    plop = 1
  }
  else {
   <<" NOT ($a > 0 && $b > 2) \n"
  }


  CheckTrue(plop)

  return plop
}



lop = 0

  if (a > 0 ) {
    <<" ($a > 0)  \n"
    lop = 1
  }
  else {
   <<" NOT ($a > 0 ) \n"
  }


CheckTrue(lop)

///////////////////////////////////////////////
lop = 0

  if ((a > 0) && (b > 2)) {
    <<" ($a > 0 && $b > 2) \n"

  }
  else {
   <<" NOT ($a > 0 && $b > 2) \n"
    lop = 1
  }


CheckTrue(lop)

///////////////////////////////////////////////////////

///////////////////////////////////////////////
lop = 0

  if (!((a > 0) && (b > 2))) {
    <<" !(($a > 0 && $b > 2)) \n"
    lop = 1
  }
  else {
   <<" NOT !(($a > 0 && $b > 2)) \n"

  }


CheckTrue(lop)

///////////////////////////////////////////////////////




  lop = 0

  if ((a > 0) && (b > 1)) {
    <<" ($a > 0 && $b > 1) \n"
    lop = 1
  }
  else {
   <<" NOT ($a > 0 && $b > 1) \n"
  }


CheckTrue(lop)

///////////////////////////////////////////
  lop = 0

  if ( (b > 2) || (a > 0) ) {
    <<" ($b > 2 || $a > 0) \n"
    lop = 1
  }
  else {
   <<" NOT ($b > 2 || $a > 0) \n"
  }


CheckTrue(lop)

/////////////////////////////////////////


lop = 0

  if ( (a > 0) && (b > 1)) {
    <<" ($a > 0 && $b > 1) \n"
    lop = 1
  }
  else {
   <<" NOT ($a > 0 && $b > 1) \n"
  }


CheckTrue(lop)

a = 0
b = 0

  if (( a == 0) || (b > 1)) {
    <<" ($a ==  0 || $b > 1) \n"
    lop = 1
  }
  else {
   <<" NOT ($a == 0 || $b > 1) \n"
  }

CheckTrue(lop)
a =1
b = 2
  if ( (a == 0) || (b > 1)) {
    <<" ($a ==  0 || $b > 1) \n"
    lop = 1
  }
  else {
   <<" NOT ($a == 0 || $b > 1) \n"
  }

CheckTrue(lop)


b = 0
  if ( (a == 0) || (b > 1)) {
    <<" ($a ==  0 || $b > 1) \n"

  }
  else {
   <<" NOT ($a == 0 || $b > 1) \n"
    lop = 1
  }


CheckTrue(lop)

///////////////////////////////////

a = 1
b = 2
c = 3

 lop = 0

  if ( (a == 1) && (b > 1) && (c == 3)) {
    <<" ($a == 1) && ($b > 1) && ($c == 3) \n" 
    lop = 1
  }
  else {
   <<" NOT ($a == 1) && ($b > 1) && ($c == 3)) \n" 
  }


CheckTrue(lop)
////////////////////////////////////////////////////
 lop = 0

  if ( (a == 0) || (b > 3) || (c == 3)) {
    <<" ($a == 0) || ($b > 3) || ($c == 3) \n" 
    lop = 1
  }
  else {
       <<" NOT ($a == 0) || ($b > 3) || ($c == 3)) \n"  
  }

CheckTrue(lop)
//////////////////////////////////////////////////////

d = 4
 lop = 0
  if ( (a == 1) && (b > 1) && (c == 3) && (d == 4)) {
    <<" ($a == 1) && ($b > 1) && ($c == 3) && (d == 4)\n" 
    lop = 1
  }
  else {
   <<" NOT ($a == 1) && ($b > 1) && ($c == 3) && ( d == 4)) \n" 
  }
CheckTrue(lop)


///////////////////////////////////
d = 3
 lop = 0
  if ( (a == 1) && (b > 1) && (c == 3) && (d == 4)) {
    <<" ($a == 1) && ($b > 1) && ($c == 3) && ($d == 4)\n" 

  }
  else {
   <<" NOT ($a == 1) && ($b > 1) && ($c == 3) && ( $d == 4)) \n" 
    lop = 1
  }
CheckTrue(lop)


///////////////////////////////////

d = 3
 lop = 0
  if ( (a == 0) || (b > 8) || (c == 1) || (d == 3)) {
   <<" ($a == 0) || ($b > 8) || ($c == 1) || ($d == 3) \n"
    lop = 1
  }
  else {
   <<" NOT ($a == 0) || ($b > 8) || ($c == 1) || ($d == 3) \n"
  }

CheckTrue(lop)


///////////////////////////////////


c= 0

while (c < 5) {
c++
b = 0
 if (c < 4) {

  if ( (a == 0) || (b > 1)) {
    <<" ($a ==  0 || $b > 1) \n"

  }
  else {
   <<" NOT ($a == 0 || $b > 1) \n"
    lop = 1
  }


CheckTrue(lop)
}
}


poo()

poo2()


#{
//  want to have use of AND OR XOR  ? NOT

lop = 0
  if ( (a > 0) AND (b > 1)) {
    <<" ($a > 0 and $b > 1) \n"
    lop = 1
  }
  else {
   <<" NOT ($a > 0 AND $b > 1) \n"
  }
#}







CheckOut()



STOP!