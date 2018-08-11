
setdebug(1,@keep,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc",);
filterFileDebug(ALLOWALL_,"ic_");


// test proc

N = GetArgI()

int k = 1

<<" START $k $N \n"


proc poo( pa )
{
// increments global k
// does calc and returns that value   
   k++;
   a= k * pa;
    for (i = 0; i < 4; i++) {
     a++
    }

<<" in $_proc %V $k $a $pa\n" 
//ttyin()
    return a 
//   return (a * 2.0)
}


proc noo()
{
   k++
   a= k * 4
<<" in $_proc %v $k $a\n"

    
    return a 
}



 poo(3);

 k = 0
 while ( k < N) {

<<" before poo call k is $k\n"
    w = k;
    y = poo(w);
<<"ln 1 after poo call \n"

 <<" poo returns $y  k is now $k\n"

 }


<<" DONE $k $N \n"
//a=iread(" ");

////  TODO/FIX /////////////
// immediate statement after proc return is not executed
// xic fails
