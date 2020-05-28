


// test proc

N = 3

int k = 3

<<" START $k $N \n"

 a = 2

proc poo(c)
{

   ep = c

<<" arg in $_cproc %V $c $ep\n"

   a= c * 2

   c++

<<" in poo $_cproc %V $c $a\n" 

    return a 
}




// line after def proc not seen??


 k = 1

<<" %v $k \n"

 while ( k < N) {

<<" before poo call $k \n"

    z = poo(k) 

<<" after poo call $k \n"

    k++

 <<" $k poo  returns $z \n"

 }

 k = 0
 x = 1

 while ( k < N) {

<<" before poo call %V $x \n"

    z = poo(&x) 

<<" after poo call %V $x \n"

    k++

 <<" $k poo  returns $z \n"

 }


STOP!




///////////////////////////////
// TO DOFIX
//  line after proc call not done
//  y = poo(z) 
//  y = poo(poo(z))

//  recursive call
