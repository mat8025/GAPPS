///
///  test Urand function
///

/{/*


R=Urand(n,seed)

returns a vector of n numbers in the range 0 to 1.0  -- 
if seed is zero the time function is used as a seed
 

/}*/

CheckIn();

R=Urand(10,7);

<<"$R\n"


R=Urand(10,0);


<<"$R\n"
// no float sort

F=QuickSort(R)

<<"$F\n"


B=BubbleSort(R)

<<"$B\n"


T=Sort(R*1000);


<<"$T\n"

<<" VecSubSet //////\n"
float V[20];

<<"$V\n"


 V[5:10] = Urand(6,0)

<<"$V\n"

 V[15:18] = Urand(10,0)

<<"$V\n"

checkNum(V[0],0,EQU_);

<<"$V[15] $(GT_)\n"

checkNum(V[15],0.0,GT_);

CheckOut()

exit()
