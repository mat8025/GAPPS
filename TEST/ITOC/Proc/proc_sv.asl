#! /usr/local/GASP/bin/asl

// test proc shadow variable

na = Caz(_clarg)

<<"%v $na \n"

<<" START $_clargs $N \n"

N = _clargs[1]

M = _clargs[2]

// BUG  should print all array
<<"%v $_clarg \n"

//<<" START $_clargs[*] $N $M\n"

<<" START $_clargs[1:-1] $N $M\n"




proc poo(n)
{
// increments global k
// does calc and returns that value   
float b

  //int i = 0;
  int i;

  int p= 0;
  for (i = n ; i < 2*n ; i++) {

     k++
     p++
<<" $_proc %I $k $i $p\n" 

  }

  return k
}



// create and set global k
 k = 1
//  creates global i

 for (i = 0; i < N ; i++) {


<<" before poo call %I $i $k\n"


    m = poo(i+1)



<<"after poo %I $i $k $m \n"


     k = i

 }


<<" DONE $k $N \n"





;

////  TODO/FIX /////////////
// does not move to statement after proc call
// immediate statement after proc return is not executed
// .exe fails
