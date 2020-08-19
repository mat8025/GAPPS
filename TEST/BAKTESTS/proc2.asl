#! /usr/local/GASP/bin/spi


// test proc

N = $2

int k = 1

<<" START $k $N \n"

 a = 2
 b = 2

 y = a

<<" $y = $a \n"

proc poo(pa)
{
   
   k++
   a= k * 2
<<" in poo $_cproc %V $k $a $pa\n" 
    return a 
}


proc noo(pb)
{
   k++
   b= k * 4
<<" in noo $_cproc %V $k $b $pb\n" 
    return b 
}


proc boo(bp)
{

  z=poo(bp)
  w=noo(z)
  return w
}


 k = 1
  poo(k)

  noo(k)


  boo(k)


STOP!



 k = 0

 while ( k < N) {

<<" before proc calls $k \n"
//    z = noo(k) 
     z = noo(k) * poo(k)
//    z = noo(k) + 3 + poo(k)

 <<" after proc calls $k \n"

 <<" $k poo * noo  returns $z \n"

 }



STOP!




///////////////////////////////
// TO DOFIX
//  line after proc call not done
//  proc args
//  y = poo()
//  y = poo() + k
//  y = poo(z) 
//  y = poo(poo(z))

//  recursive call
