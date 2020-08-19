///
///  redimn
///

setdebug(1,"~step")



checkIn();

int V[20];


 V[10] = 47;

checkNum(V[0],0)
checkNum(V[10],47)
checkNum(V[19],0)

<<" vector \n"
<<"$V\n"

  V->redimn(10,2);
<<" 2D array 10,2 \n"
<<"$V\n"


  V->redimn(5,4);
<<" 2D array 5,4 \n"
<<"$V\n"



<<" vector \n"
V->redimn();
<<"$V\n"


M = V;

 redimn(M,4,5);

<<" 2D array 4,5 \n"
<<"$M\n"

 redimn(M);

<<" vec \n"
<<"$M\n"



checkNum(M[10],47)



checkOut();

