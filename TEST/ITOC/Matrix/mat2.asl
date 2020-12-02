include "debug"
debugON()
sdb(1,@pline)

v= 76;
<<"%V $v\n"

int V[3] = {1,2,3};

   V->info(1)

<<"$V\n"

exit()



   V2 = V;

   V2->info(1)

<<"$V2\n"

Siv E;

E->info(1);

Siv D(INT_, 2, 2, 3);



D->info(1)

 D[0][::] = V

<<"$D\n"

V[1] =77

 D[1][::] = V
<<"$V\n"
<<"$D\n"
D->info(1)

exit()






int A[2][3] = { 3,1,2, 2,1,3 };



<<" $A\n"
nb= Cab(A)

<<"%V$nb \n"

//int B[3][2] ={ {1,2}, {3, 1}, {2, 3}};

int B[3][2] ={ 1,2, 3, 1, 2, 3};

<<"\n"
<<"$B\n"


nb= Cab(B)

<<"%V$nb \n"
A->info(1)
B->info(1)

 C = A * B

<<" $C \n"

nb= Cab(C)

<<"%V$nb \n"



exit()


//int A[] = { 3,1,2, 2,1,3 }

//A->redimn(2,3)

<<"$A \n"


int B[] ={ 1,2, 3, 1, 2, 3}

B->redimn(3,2)
 
<<" $B \n"





<<"%(2,, ,\n)$C\n"

 D = B * A


<<"%(3,, ,\n)$D\n"
